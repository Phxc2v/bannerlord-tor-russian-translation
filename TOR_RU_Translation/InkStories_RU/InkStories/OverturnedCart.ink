//Global story tags
# title: Дорожное Происшествие
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
                    ~InjuryText1 = "невредим"
                -1:
                    ~InjuryText1 = "легко ранен"
                -2:
                    ~InjuryText1 = "тяжело ранен"
            }

        VAR InjuryText2 = ""
            {InjuryRoll:
                -0:
                    ~InjuryText2 = "просит"
                -1:
                    ~InjuryText2 = "умоляет"
                -2:
                    ~InjuryText2 = "задыхаясь, хрипит"
            }

        VAR InjuryText3 = ""
            {InjuryRoll:
                -0:
                    ~InjuryText3 = "встаёт на ноги"
                -1:
                    ~InjuryText3 = "с трудом поднимается"
                -2:
                    ~InjuryText3 = "лежит, пытаясь не умереть"
            }

        VAR InjuryText4 = ""
            {InjuryRoll:
                -0:
                    ~InjuryText4 = ""
                -1:
                    ~InjuryText4 = "впадает в уныние, понимая, что он останется калекой по меньшей мере на какое-то время"
                -2:
                    ~InjuryText4 = "умирает"
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
                    ~Profession = "торговец"
                -1:
                    ~Profession = "крестьянин"
                -2:
                    ~Profession = "кузнец"
            }

        VAR RewardText = ""
            {ProfessionRoll:
                -0:
                    ~RewardText = "500 золотых"
                -1:
                    ~RewardText = "5 зерна"
                -2:
                    ~RewardText = "2 стальных слитка"
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
    *[Продолжить путь] Вы решаете не обращать внимания на перевернувшуюся повозку и продолжить свой путь. ->END

===Approach===

    Вы подходите к повозке и находите человека, застрявшего под ней. Когда он видит вас, он кричит о помощи. #STR_Approach1
    Вы замечаете, что человек, зажатый под повозкой, {InjuryText1}. #STR_Approach2
    Когда вы подходите ближе, он {InjuryText2}: «Пожалуйста, помогите мне». #STR_Approach3
    Что вы сделаете? #STR_Approach4
    ->choices
    
    =choices
        *[Спросите, чем он сможет помочь вам в обмен на вашу помощь] #STR_RewardForHelp0
            Вы спрашиваете мужчину, чем он может вам помочь. #STR_RewardForHelp1
            Мужчина отвечает: «Я всего лишь скромный {Profession} из поселения {Settlement}, я не смогу дать вам иной награды, кроме своей благодарности.» #STR_RewardForHelp2
            Помолчав, он добавляет: «Я дружен с {Notable}, и замолвлю за вас доброе слово.» #STR_RewardForHelp3
            Пока он говорит, вы не можете не заметить, что в телеге всё ещё есть груз. #STR_RewardForHelp4
            ~HasAsked = true
            ->choices
        
            *{not HasAsked}[Помоги ему (Милосердие++)]
                Ты решаешь помочь ему. #STR_HelpNoReward1
                ~ AddTraitInfluence("Mercy", 160)
                ->AfterLift
                
            *{HasAsked}[Помочь ему (+Отношения с {Notable}, Милосердие+)]
                Ты решаешь помочь ему. #STR_HelpRelation1
                ~ AddTraitInfluence("Mercy", 80)
                ~ NotableChange = true
                ->AfterLift
        
            *{HasAsked}[Вымогать у него награду (Милосердие-)]
                Вы заявляете {Profession}'у, что ему не стоит быть таким скромным. Он явно человек не без средств и легко может выделить {RewardText} в качестве компенсации за помощь. #STR_HelpExtort1
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
                Одним быстрым движением вы убиваете мужчину и приступаете к его поднятию в виде скелета. Ваш отряд предпринимает попытку и {RaiseDeadSkillCheckTest: преуспевает | терпит неудачу}.#STR_HelpNecromancerSummon
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
    Ваш отряд снимает повозку с мужчины, и он {InjuryText3}. #STR_AfterLiftMedicine1

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
                        
                *{LoreOfLifeInParty}[Излечить его магией {SpellcraftSkillCheckText}]
                    Маг из вашей партии призывает ветры Гиран, чтобы залечить раны человека. #STR_AfterLiftMagic
                        {SpellcraftSkillCheckTest: ->Success | ->Fail}
                    
        =Success
            Ваше лечение увенчалось успехом, и теперь человеку станет лучше. #STR_AfterLiftHealSuccess
                ~ BonusRoll = RANDOM(0,100)
                ->Reward
            
        =Fail
            Ваше лечение не удаётся, и мужчина {InjuryText4}. #STR_AfterLiftHealFail
                {InjuryRoll:
                    -2:
                        ~ ManAlive = false
                }
            ->Reward
            
===Reward===

    {ManAlive:->LiveReward|->DeadReward}

    =LiveReward
        Будучи спасённым, мужчина {HasExtorted: нехотя} благодарит вас за помощь{HasExtorted:  и отдаёт обещанную награду}.#STR_RewardAlive1
        {NotableChange: Собирая свои вещи, он говорит: «Я расскажу {Notable} о ваших подвигах, как только вернусь домой.»#STR_RewardAliveNotable}
        {HasExtorted == false && BonusRoll >=50: Задержавшись на мгновение, мужчина говорит: «Я знаю, что сказал, будто у меня ничего нет, но прошу, возьмите это ({RewardText}). Это меньшее, что я могу сделать за вашу доброту.»#STR_RewardAliveChance}
        
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
                Ваш отряд предпринимает попытку и {RaiseDeadSkillCheckTest: преуспевает | терпит неудачу}. #STR_RewardRiseDead2

                {RaiseDeadSkillCheckTest:
                    -true: Тело мужчины встаёт на ноги и, шатаясь, уходит, чтобы присоединиться к остальным войскам вашего отряда. #STR_RewardDeadRiseDeadSuccess
                        ~ ChangePartyTroopCount("tor_vc_skeleton",1)
                }
                ->DeadReward
            *[Двигайтесь дальше (уйти)]
                Вы решаете, что настало время двигаться дальше и продолжить свой путь. #STR_RewardDeadLeave
                ->END
