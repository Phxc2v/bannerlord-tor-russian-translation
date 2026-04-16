//Global story tags
# title: Roadside Accident
# frequency: Common
# development: false
# illustration: cart_accident

INCLUDE include.ink

        VAR InjuryDifficulty = 2
            {InjuryRoll:
                -1: 
                    ~InjuryDifficulty = 100
                -2: 
                    ~InjuryDifficulty = 250
            }
        
        VAR Settlement = ""
            ~ Settlement = GetNearestSettlement("town")
                
        VAR Notable = ""
            ~ Notable = GetRandomNotableFromSpecificSettlement(Settlement)
                
        VAR NotableChange = false
                
        VAR PartyCanRaiseDead = false
            ~ PartyCanRaiseDead = PartyHasNecromancer(false)
                
        VAR RaiseDeadSkillCheckText = ""
            ~ RaiseDeadSkillCheckText = print_party_skill_chance("Spellcraft", 25)
                
        VAR RaiseDeadSkillCheckTest = false
            ~ RaiseDeadSkillCheckTest = perform_party_skill_check("Spellcraft", 25)
                
        VAR MedicineSkillCheckText = ""
            ~ MedicineSkillCheckText = print_party_skill_chance("Medicine", InjuryDifficulty)
                
        VAR MedicineSkillCheckTest = false
            ~ MedicineSkillCheckTest = perform_party_skill_check("Medicine", InjuryDifficulty)
                
        VAR SpellcraftSkillCheckText = ""
            ~ SpellcraftSkillCheckText = print_party_skill_chance("Spellcraft", InjuryDifficulty)
                
        VAR SpellcraftSkillCheckTest = false
            ~ SpellcraftSkillCheckTest = perform_party_skill_check("Spellcraft", InjuryDifficulty)
                
        VAR LoreOfLifeInParty = false
                ~ LoreOfLifeInParty = DoesPartyKnowSchoolOfMagic(false, "LoreOfLife")

        VAR InjuryRoll = 2
            ~ InjuryRoll = RANDOM(0,2)
            
        VAR InjuryText1 = ""
            {InjuryRoll:
                -0: 
                    ~InjuryText1 = "uninjured"
                -1: 
                    ~InjuryText1 = "mildly injured"
                -2: 
                    ~InjuryText1 = "severely injured"
            }
        
        VAR InjuryText2 = ""
            {InjuryRoll:
                -0: 
                    ~InjuryText2 = "asks"
                -1: 
                    ~InjuryText2 = "begs"
                -2: 
                    ~InjuryText2 = "gasps"
            }
        
        VAR InjuryText3 = ""
            {InjuryRoll:
                -0: 
                    ~InjuryText3 = "gets up"
                -1: 
                    ~InjuryText3 = "barely gets up"
                -2: 
                    ~InjuryText3 = "lays there trying not to die"
            }
            
        VAR InjuryText4 = ""
            {InjuryRoll:
                -0: 
                    ~InjuryText4 = ""
                -1: 
                    ~InjuryText4 = "seems to get a bit depressed knowing that he will be crippled for at least some time"
                -2: 
                    ~InjuryText4 = "dies"
            }
    
        VAR HorsesAround = 0
            ~HorsesAround = RANDOM(0,1)

        //Ask for info
        VAR HasAsked = false
        
        //Profession of the stuck man
        VAR ProfessionRoll = 0
            ~ ProfessionRoll = RANDOM(0,2)
            
        VAR Profession = ""
            {ProfessionRoll:
                -0: 
                    ~Profession = "merchant"
                -1: 
                    ~Profession = "farmer"
                -2: 
                    ~Profession = "blacksmith"
            }
        
        VAR RewardText = ""
            {ProfessionRoll:
                -0: 
                    ~RewardText = "500 gold"
                -1: 
                    ~RewardText = "5 grain"
                -2: 
                    ~RewardText = "2 steel ingots"
            }

        VAR HasExtorted = false
        
        //Bonus Reward
        VAR BonusRoll = 0

        VAR ManAlive = true
        
         ~ SetTextVariable("HorsesAround",HorsesAround)
        ~ SetTextVariable("InjuryText1",InjuryText1)
        ~ SetTextVariable("InjuryText2",InjuryText2)
        ~ SetTextVariable("InjuryText3",InjuryText3)
        ~ SetTextVariable("InjuryText4",InjuryText4)
        
        ~ SetTextVariable("Profession",Profession)
        ~ SetTextVariable("Settlement",Settlement)
        ~ SetTextVariable("Notable",Notable)
        ~ SetTextVariable("RewardText",RewardText)
        
        ~ SetTextVariable("RaiseDeadSkillCheckText",RaiseDeadSkillCheckText)
         
        ~ SetTextVariable("HasExtorted1",HasExtorted)
        ~ SetTextVariable("HasExtorted2",HasExtorted)
        

-> Start

===Start===
    Пока ваша группа движется вперёд, вы замечаете повозку вдали. #STR_Start1
    Подойдя ближе, вы видите, что она сломалась и перевернулась. #STR_Start2
    {HorsesAround: Вы также можете заметить несколько лошадей, пасущихся на траве в соседнем поле; по всей видимости, именно они тянули повозку до происшествия. #STR_StartHorse}

    *[Подойдите к повозке]->Approach
    *[Продолжайте путь] You decide to ignore the overturned cart and continue your journey. ->END

===Approach===

    Вы подходите к повозке и находите человека, застрявшего под ней. Когда он видит вас, он кричит о помощи. #STR_Approach1
    You notice that the man trapped under the cart is {InjuryText1}. #STR_Approach2
    As you get close he {InjuryText2} to you, "Please help me".  #STR_Approach3
    Что вы сделаете? #STR_Approach4
    ->choices
    
    =choices
        *[Спросите, чем он сможет помочь вам в обмен на вашу помощь] #STR_RewardForHelp0
            Вы спрашиваете мужчину, чем он может вам помочь. #STR_RewardForHelp1
            The man replies, "I am just a simple {Profession} from {Settlement}, I cannot give you a reward other than my thanks." #STR_RewardForHelp2
            After a moment he says, "I am a friend of {Notable} and I will put in a good word for you." #STR_RewardForHelp3
            Пока он говорит, вы не можете не заметить, что в телеге всё ещё есть груз. #STR_RewardForHelp4
            ~HasAsked = true
            ->choices
        
            *{not HasAsked}[Помоги ему (Милосердие++)]
                Ты решаешь помочь ему. #STR_HelpNoReward1
                ~ AddTraitInfluence("Mercy", 160)
                ->AfterLift
                
            *{HasAsked}[Помоги ему (+Отношения с {Знаменитость}, Милосертие+)]
                Ты решаешь помочь ему. #STR_HelpRelation1
                ~ AddTraitInfluence("Mercy", 80)
                ~ NotableChange = true
                ->AfterLift
        
            *{HasAsked}[Вымоги у него награду (Милосердие-)]
                You tell the {Profession} that he shouldn't be so modest. He is clearly a man of some means and can easily spare {RewardText} as compensation for the assistance. #STR_HelpExtort1
                Мужчина, поверив, что у него нет иного выбора, соглашается. #STR_HelpExtort2
                ~ AddTraitInfluence("Mercy", -80)
                ~ HasExtorted = true
                ->AfterLift
            
            *{HasAsked && HorsesAround}[Требуйте одного из коней (Милосердие-)]
                Вы говорите, что он явно не способен управлять двумя лошадьми и поэтому должен быть согласен отдать вам одну в качестве оплаты. #STR_HelpExtortHorse1
                Мужчина, видя, что у него нет иного выбора, соглашается. #STR_HelpExtortHorse2
                ~ AddTraitInfluence("Mercy", -80)
                ~ HasExtorted = true
                ~ SetTextVariable("HasExtorted1",HasExtorted)
                ~ SetTextVariable("HasExtorted2",HasExtorted)
                ->AfterLift
        
            *{HorsesAround}[Возьмите лошадей и уходите (Милосердие--)]
                Вы решаете, что вместо того чтобы помогать мужчине, лучше пойти и приручить двух лошадей, которые явно являются дикими лошадьми, у которых никогда не было предыдущего владельца — это абсолютно законно. #STR_HelpTakeHorse1
                После того как вы овладеете лошадьми и начнёте уходить, вы услышите крики запертого мужчины, молящего вас вернуться и помочь, которые затихают вдали. #STR_HelpTakeHorse1
                ~ AddTraitInfluence("Mercy", -160)
                ~ GiveItem("old_horse",2)
                ->END
                
        //Necromancer option
            *{PartyCanRaiseDead}[Убейте мужчину, поднимите его труп в виде скелета, {HorsesAround: возьмите лошадей,} и обыщите его телегу (Милосердие---) {print_party_skill_chance("Spellcraft", 25)}]
                Вам приходит в голову гениальная идея. Поскольку мужчина явно бесполезен как возчик телеги, возможно, он найдёт своё применение, став одним из ваших нежитных подчинённых. #STR_HelpNecromancer1
                In one swift motion you kill the man and go about raising him as a skeleton. Your party makes an attempt and {RaiseDeadSkillCheckTest: succeeds | fails }.#STR_HelpNecromancerSummon
                {RaiseDeadSkillCheckTest: -> raiseSucceed | -> raiseFail}
    
    =raiseSucceed
    Успев оживить мёртвого, вы решаете отпраздновать это, взяв все его вещи. #STR_HelpNecromancerSuccess
        {ProfessionRoll:
            -0: 
                ~GiveGold(500)
            -1: 
                ~GiveItem("grain", 5)
            -2: 
                ~GiveItem("ironIngot4", 2)
        }
        {HorsesAround: {GiveItem("old_horse",2)}}
        ~ ChangePartyTroopCount("tor_vc_skeleton",1)
        -> END
    
    =raiseFail
    Не сумев оживить мёртвого, вы решаете взять все его вещи в качестве компенсации за потраченное впустую время. #STR_HelpNecromancerFail
        {ProfessionRoll:
            -0: 
                ~GiveGold(500)
            -1: 
                ~GiveItem("grain", 5)
            -2: 
                ~GiveItem("ironIngot4", 2)
        }
        {HorsesAround: {GiveItem("old_horse",2)}}
        -> END

===AfterLift===
    Your party lifts the cart off the man and he {InjuryText3}. #STR_AfterLiftMedicine1

    //Is Injured?
        {InjuryRoll:
            -0:     ->Reward
            -else:  ->Injury
        }

        =Injury
            Как вы будете лечить его рану? #STR_AfterLiftMedicine2
                *[Лечите его лекарством {MedicineSkillCheckText}]
                    Ваш лучший врач приступает к работе, пытаясь привести человека в порядок. #STR_AfterLiftMedicine
                        {MedicineSkillCheckTest: ->Success | ->Fail}
                        
                *{LoreOfLifeInParty}[Treat him with magic {SpellcraftSkillCheckText}]
                    Маг из вашей партии призывает ветры Гиран, чтобы залечить раны человека. #STR_AfterLiftMagic
                        {SpellcraftSkillCheckTest: ->Success | ->Fail}
                    
        =Success
            Ваше лечение увенчалось успехом, и теперь человеку станет лучше. #STR_AfterLiftHealSuccess
                ~ BonusRoll = RANDOM(0,100)
                ->Reward
            
        =Fail
            Your treatment fails and the man {InjuryText4}. #STR_AfterLiftHealFail
                {InjuryRoll:
                    -2:
                        ~ ManAlive = false
                }
            ->Reward
            
===Reward===

    {ManAlive:->LiveReward|->DeadReward}

    =LiveReward
        Having been saved, the man {HasExtorted: begrudgingly} thanks you for your help{HasExtorted: and gives you the promised reward }.#STR_RewardAlive1 
        {NotableChange: As he starts gathering his things he says, "I will tell {Notable} за ваши подвиги, как только я вернусь домой."#STR_RewardAliveNotable} 
        {HasExtorted == false && BonusRoll >=50: The man pausing for a moment says, "I know I said I didn't have much but please take this ({RewardText}). It's the least I can do for your kindness."#STR_RewardAliveChance} 
        
        {HasExtorted || (not HasExtorted && BonusRoll >=50):
            -true:
                {ProfessionRoll:
                    -0: 
                        ~GiveGold(500)
                    -1: 
                        ~GiveItem("grain", 5)
                    -2: 
                        ~GiveItem("ironIngot4", 2)
                }
        }
        {NotableChange: {ChangeRelations(Notable, 5)}}
        ->END
        
    =DeadReward
        Что сделает ваша группа следующим? #STR_RewardDead1 
            *[Похоронить мужчину (Милосердие+)]
                Вы решаете похоронить мужчину, надеясь, что он обретет покой. #STR_RewardDeadBury 
                {AddTraitInfluence("Mercy", 160)}
                ->DeadReward
            *[Лутуйте тележку {HorsesAround: и возьмите лошадей} ({RewardText}{HorsesAround:, +2 коня ранга 0})]
                Теперь, когда мужчина скончался, ему явно больше не понадобятся припасы. #STR_RewardDeadLoot 
                {ProfessionRoll:
                    -0: 
                        ~GiveGold(500)
                    -1: 
                        ~GiveItem("grain", 5)
                    -2: 
                        ~GiveItem("ironIngot4", 2)
                }
                {HorsesAround: {GiveItem("old_horse",2)}}
                ->DeadReward
            *{PartyCanRaiseDead}[Возродите его в виде скелета (+1 скелет){RaiseDeadSkillCheckText}]
                Поскольку мёртвому человеку тело больше не нужно, вы решаете возродить его как скелет. #STR_RewardDeadRiseDead 
                Your party makes an attempt and {RaiseDeadSkillCheckTest: succeeds| fails}. #STR_RewardRiseDead2
                
                {RaiseDeadSkillCheckTest:
                    -истина: Тело мужчины встает на ноги и шатаясь уходит, чтобы присоединиться к остальным войскам вашего войска. #STR_RewardDeadRiseDeadSuccess
                        ~ ChangePartyTroopCount("tor_vc_skeleton",1)
                }
                ->DeadReward
            *[Двигайтесь дальше (уйти)]
                Вы решаете, что настало время двигаться дальше и продолжить свой путь. #STR_RewardDeadLeave
                ->END
