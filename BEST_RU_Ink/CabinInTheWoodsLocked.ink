//Global story tags
# title: Хижина в Лесу
# frequency: Common
# development: false
# illustration: roadpoint2


//Important Irregular Characters
    //| (Vertical Bar)

//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES

    //Restrictions

    //Triggers:
        //While Travelling on the campaign map
        //After clearing a random bandit camp
        //Quests:
            //Bandit Bounty quest

    //Main: Party comes across a locked cabin. They must find a way in.

INCLUDE include.ink

//Variables setup

        VAR PartyRogueryCheckText = 0
        VAR PartyRogueryCheckTest = 0
        VAR PartySpellcraftCheckText = 0
        VAR PartySpellcraftCheckTest = 0
        VAR PartyEngineeringCheckText = 0
        VAR PartyEngineeringCheckTest = 0
        VAR PartyCanCastSpell = false
        VAR PartyVigorCheckText = ""
        VAR PartyVigorCheckTest = 0

    VAR LockQuality = 0
        ~ LockQuality = RANDOM(1,3)

    VAR LockDifficulty = 0
        ~ LockDifficulty = LockQuality * 50

    VAR LockText = ""
        {
            - LockQuality == 1:
                ~ LockText = "слабый"
            - LockQuality == 2:
                ~ LockText = "средний"
            - LockQuality == 3:
                ~ LockText = "крепкий"
        }

    ~ SetTextVariable("LockText",LockQuality)

    VAR DoorQuality = 0
        ~ DoorQuality = RANDOM(1,3)

    VAR DoorDifficulty = 0
        ~ DoorDifficulty = DoorQuality * 50

    VAR DoorText = ""
        {
            - DoorQuality == 1:
                ~ DoorText = "ветхая"
            - DoorQuality == 2:
                ~ DoorText = "обычная"
            - DoorQuality == 3:
                ~ DoorText = "крепкая"
        }

    ~ SetTextVariable("DoorText",DoorQuality)
    //Reward
        VAR RewardRoll = 0
           ~ RewardRoll = RANDOM(0,2)

        VAR RewardText = ""
            {
                - RewardRoll == 0:
                    ~ RewardText = "5 зерна"
                - RewardRoll == 1:
                    ~ RewardText = "2 стальных слитка"
                - RewardRoll == 2:
                    ~ RewardText = "500 золотых"
            }

    ~ SetTextVariable("RewardText",RewardRoll)

 //Variable Update: Update any variables before story start
    ~ PartyRogueryCheckText = print_party_skill_chance("Roguery", LockDifficulty)
    ~ PartyRogueryCheckTest = perform_party_skill_check("Roguery", LockDifficulty)

    ~ PartySpellcraftCheckText = print_party_skill_chance("Spellcraft", DoorDifficulty)
    ~ PartySpellcraftCheckTest = perform_party_skill_check("Spellcraft", DoorDifficulty)

    ~ PartyEngineeringCheckText = print_party_skill_chance("Engineering", LockDifficulty)
    ~ PartyEngineeringCheckTest = perform_party_skill_check("Engineering", LockDifficulty)

    ~ PartyVigorCheckText = print_party_attribute_chance("Vigor", DoorDifficulty / 30)
    ~ PartyVigorCheckTest = perform_party_attribute_check("Vigor", DoorDifficulty / 30)


-> Start

===Start===
Ваш отряд путешествует через лес, когда вы обнаруживаете хижину. #STR_Start1

    *[Подойти к хижине]->Approach
    *[Продолжить путь (Уйти)]Вы решаете, что сейчас лучше двигаться дальше.->END

===Approach===

По мере приближения к хижине вы замечаете, что она плотно заколочена досками. Единственная дверь кажется намертво запертой. Осматривая её, вы видите, что сама дверь {DoorText}, а замок на ней {LockText}. #STR_Approach1
->choice1

    =choice1
    Что сделает ваш отряд?
    *[Постучать в дверь]Вы стучите, но никто не отвечает.->Approach.choice1

    //Pick the lock (Roguery)
        *[Вскрыть замок {PartyRogueryCheckText}]
            Лучший плут вашего отряда пытается вскрыть замок.
            {PartyRogueryCheckTest: Вашему отряду удаётся вскрыть замок. ->Inside | Вашему отряду не удаётся вскрыть замок. ->Approach.choice1}

    //Disassemble the Lock (Engineering)
        *[Разобрать замок {PartyEngineeringCheckText}]
            Лучший инженер вашего отряда пытается разобрать замок.
            {PartyEngineeringCheckTest: С помощью лучших инструментов — отвёрток, зубил и кувалды — ваш инженер мастерски разбирает замок. Разборка настолько «тщательная», что собрать замок обратно уже невозможно. ->Inside | Вашему отряду не удаётся разобрать замок. ->Approach.choice1}

    //Blow up the door (Spellcraft)
        *{PartyCanCastSpell == true}[Взорвать дверь магией {PartySpellcraftCheckText}]
            Лучший маг вашего отряда пытается взорвать дверь магией.
            {PartySpellcraftCheckTest: Ваш отряд начисто срывает дверь с петель. ->Inside | Вашему отряду не удаётся взорвать дверь. ->Approach.choice1}

    //Break down the door (Vigor)
        *[Выломать дверь {PartyVigorCheckText}]
            Сильнейший член вашего отряда пытается выломать дверь.
            {PartyVigorCheckTest: Ваш отряд вышибает дверь начисто с петель. ->Inside | Вашему отряду не удаётся выломать дверь. ->Approach.choice1}

    *[Идти дальше (Уйти)]Вы решаете, что сейчас лучше двигаться дальше.->END

===Inside===

Ваш отряд проникает в хижину и обнаруживает, что кто-то — или что-то — запас здесь припасы. #STR_Inside1
->choice2

    =choice2
        *[Забрать припасы ({RewardText})]
            Вы забираете {RewardText} и добавляете к своим запасам, прежде чем продолжить путь.
            {RewardRoll:
                -0:
                    ~ GiveItem("grain",5)
                -1:
                    ~ GiveItem("ironIngot4", 2)
                -2:
                    ~ GiveGold(500)
            }
            ->END

        *[Уйти]Вы решаете оставить припасы и отправляетесь в путь.->END
