//Global story tags
# title: Луг
# frequency: Common
# development: false
# illustration: meadow

//Important Irregular Characters
    //| (Vertical Bar)

//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES
    
    //Restrictions
        //Terrain: Not dessert,
    
    //Triggers:
        //While travelling on campaign map
    
    //Scenario Explanation (explain the main scenario and any major variations that you are planning to build in. If a variation is different enough consider making it its own file.)
    
        //Main: You are travelling and come across a meadow.

        //Alt: If encountered while in a chaos area it gets weird.
        
    //Future Options/Additions
        //Make it so the player does not have to click through each time they do a loop.
        //More options
            //Search for animals (capture animals like horses)
            //If a lore of life wizard is present they can channel to regain some magic
            //Spend some time training
        //Add choices/effects for nature gods
            //Hunting success chance improved by Priest of Tall
            //Healing success chance improved by Pries of Rhya or Shallya
            //Foraging success chance improved by Priest of Rhya
        //Add choices/effects for wizards (Lore of Life, Lore of Beasts, ...)
            //Hunting success chance improved by lore of beasts
            //Healing success chance improved by Lore of Life
            //Foraging improved by lore of Life
        //?Add olives as a future option
        //Add randomness to the amount of plant and animal life as well as the difficulty of success
            //Randomize elements of Foraging
            //Randomize elements of Hunting
        
//Data Import/Export Section
    //Make sure you include this in all ink files to get access to integration functions
        INCLUDE include.ink
        
    //List of Data Being Imported (use this to help keep track of what data you are importing; will help with troubleshooting and testing.)
    
        //Scouting Highest In party
            //Used in hunting skill check
                VAR PartyScoutingCheckText = 0
                    //~ PartyScoutingCheckText = print_party_skill_chance("Scouting", HuntDifficulty) [Variable Update]
                
                VAR PartyScoutingCheckTest = 0
                    //~ PartyScoutingCheckTest = perform_party_skill_check("Scouting", HuntDifficulty) [Variable Update]
        //Medicine (Highest in Party)
            //Used in party recovery skill check
                VAR WoundedCount = 1
                    ~ WoundedCount = GetTotalPartyWoundedCount() + 1

                VAR MedicineDifficulty = 1
                    ~ MedicineDifficulty = 3*WoundedCount
                    
                    
                VAR PartyMedicineCheckText = 2
                    ~ PartyMedicineCheckText = print_party_skill_chance("Medicine", MedicineDifficulty)
                
                VAR PartyMedicineCheckTest = 2
                    ~ PartyMedicineCheckTest = perform_party_skill_check("Medicine", MedicineDifficulty)
                    
        //Ranged Weapon Skill Highest In the party
            //Bows, Crossbows, Throwing, Gunnery
                //Bow
                    VAR BowHighestInParty = 0
                        ~ BowHighestInParty = GetPartySkillValue("Bow")

                //Crossbow
                    VAR CrossbowHighestInParty = 0
                        ~ CrossbowHighestInParty = GetPartySkillValue("Crossbow")

                //Bow
                    VAR ThrowingHighestInParty = 0
                        ~ ThrowingHighestInParty = GetPartySkillValue("Throwing")
                //Bow
                    VAR GunpowderHighestInParty = 0
                        ~ GunpowderHighestInParty = GetPartySkillValue("Gunpowder")
                        
            //Comparison
                VAR SkillText1 = ""
                VAR SkillText2 = ""
                VAR SkillTextFinal = ""
                
                VAR BowVsCrossbow = 0
                    {
                        - BowHighestInParty >= CrossbowHighestInParty:
                            ~ BowVsCrossbow = BowHighestInParty
                            ~ SkillText1 = "Bow"
                        - else:
                            ~ BowVsCrossbow = CrossbowHighestInParty
                            ~ SkillText1 = "Crossbow"
                    }
                    
                VAR ThrowingVsGunpowder = 0
                    {
                        - ThrowingHighestInParty >= GunpowderHighestInParty:
                            ~ ThrowingVsGunpowder = ThrowingHighestInParty
                            ~ SkillText2 = "Throwing"
                        - else:
                            ~ ThrowingVsGunpowder = GunpowderHighestInParty
                            ~ SkillText2 = "Gunpowder"
                    }
                    
                VAR FinalComparison = 0
                    {
                        - BowVsCrossbow >= ThrowingVsGunpowder:
                            ~ FinalComparison = BowVsCrossbow
                            ~ SkillTextFinal = SkillText1
                        - else:
                            ~ FinalComparison = ThrowingVsGunpowder
                            ~ SkillTextFinal = SkillText2
                    }
 
            //RangedSkillCheck
                VAR PartyRangedSkillCheckText = 1
                    //~ PartyRangedSkillCheckText = print_party_skill_chance(SkillTextFinal, 200) [Variable Update]
                    
            //Wizards in party
                //Lore of life
                    VAR LoreOfLifeInParty = false
                        ~ LoreOfLifeInParty = DoesPartyKnowSchoolOfMagic(false, "LoreOfLife")
                //Lore of life
                    VAR LoreOfBeastsInParty = false
                        ~ LoreOfBeastsInParty = DoesPartyKnowSchoolOfMagic(false, "LoreOfBeasts")
                        
    //Data Exported (use this to help keep track of what data you are exporting; will help with troubleshooting and testing.)
        //Give Items
            
        
//Variables setup
    //IMPORTANT! Initial values are mandatory, but they can only be primitives (number, string, boolean). If we want to assign the return value of a function to the variable, we must do it on a separate line, see one line below

    //Seed
        //~ SEED_RANDOM(100) //Uncomment to lock an RNG testing seed for the randomness. Change number inside () for different seed
        
    //Hunt
        VAR HuntDifficulty = 150
            
        VAR HuntLoops = 3
        
        VAR HideSuccessful = false
        
    //Forage
        VAR ForageDifficulty = 50
        
        VAR ForageLoops = 5
        
    //Was X attempt successful
        VAR AttemptSuccessful = false
        
    //Reward Roll
        VAR RewardRoll = 0
        

//Variable Update (Update any variables here)
    ~ PartyScoutingCheckText = print_party_skill_chance("Scouting", HuntDifficulty)
                
    //~ PartyScoutingCheckTest = perform_party_skill_check("Scouting", HuntDifficulty) Needs to be done each loop

    ~ PartyRangedSkillCheckText = print_party_skill_chance(SkillTextFinal, HuntDifficulty*2)
    
    
    
//Variable Check (Use for sanity check. Uncomment variables to see what they are)
    
     ~ SetTextVariable("IsNight",IsNight())

-> Start

===Start===

Вы и ваша партия долго шли по извилистой тропе, пока пейзаж не начал постепенно меняться. Воздух стал мягче, звуки — более мирными. #STR_Start1
И вот вы вышли на поляну, и от восторга вырвался вздох. Перед вами раскинулась луга, которую вы давно не видели. Трава была богатым ковром изумрудного цвета, нежно покачиваясь на ветру. Множество диких цветов оживило картину яркими красками: красным, фиолетовым и желтым. #STR_Start2
{IsNight(): Серебристый лунный свет | Золотистый солнечный свет} пробивался сквозь листву деревьев, наполняя поляну теплом. В воздухе витал сладкий аромат расцветающих цветов. Птицы пели свои песни, создавая симфонию, которая казалась бальзамом для вашей уставшей души. #STR_Start3
        ->choice1
        
    =choice1
Что прикажете сделать вашей партии? #STR_Start4
            *[Собрать дикорастущие растения (Несколько попыток {LoreOfLifeInParty: 75% шанс (усилено магией Жизни)| 50% шанс} на успешный сбор разных диких растений)]
Вы приказали своей партии собирать растения на лугу. #STR_Forage1
            
                //Lore of Life in Party Increases success chance
                    {LoreOfLifeInParty:
                        -true: 
Маг из вашей партии призвал Ветер Гираны, чтобы помочь своим людям в поисках. #STR_Forage_LoreOFLifeInParty
                            ~ ForageDifficulty = ForageDifficulty - 25
                        -false:
-else: ОШИБКА
                    }
                    
                ->ForageLoop

            *[Охотиться на животных (Множественные шансы получить мясо, шкуру или мех {PartyRangedSkillCheckText})]
                
                //Bonus Attempts from Lore of Beasts
                    {LoreOfBeastsInParty:
                        -true: 
                            Маг в вашей партии призывает Ветер Гхура, чтобы помочь вашим людям в поисках. (+1 попытка) #STR_Hunt_LoreOFBeastInParty
                            ~ HuntLoops = HuntLoops + 1
                        -false:
                        -else: ОШИБКА
                    }
                    
                //Bonus attempt from Scouting
                    {perform_party_skill_check("Scouting", HuntDifficulty):
                        -true: 
                            Ваши разведчики удачно находят дополнительных животных. (Разведка)(+1 Попытка) #STR_Hunt_Scout
                            ~HuntLoops = HuntLoops + 1
                        -false:
                        -else: ОШИБКА
                    }
                    
                ->HuntLoop
                
            *[Отдых для людей (Все спутники исцелены, все раненые войска восстановлены {PartyMedicineCheckText})]
                
                Вы пытаетесь дать людям передышку, надеясь, что краткий отдых поможет им поправиться. Вы устанавливаете временный лагерь у края луга. #STR_Rest1
                
                {PartyMedicineCheckTest:
                    -true: 
                        ~ HealPartyToFull()
                    -false:
                    -else: "ОШИБКА"
                }
                
{PartyMedicineCheckTest: Ваш отряд использует передышку, чтобы позаботиться о раненых.| К сожалению, как только люди начали устраиваться на отдых, налетает сильная буря, и отряд вынужден искать укрытие.} #STR_Rest2
                
                ->Leave
                
            *[Отступить] Вы решаете, что вашей партии не время отдыхать, и сразу отправляетесь в путь.->END

    =ForageLoop
        //Decrease number of loops remaining
            ~ ForageLoops = ForageLoops - 1
        
        //Was attempt successful
            {RANDOM(0,100)>=ForageDifficulty:
                -true:
                    ~ AttemptSuccessful = true
                -false:
                    ~ AttemptSuccessful = false
                -else: ОШИБКА
            }

        //Reward if successful
            {AttemptSuccessful:
                -true:
                    ~ RewardRoll = RANDOM(1,4)
                -false:
                    ~ RewardRoll = 0
            }
            
            {RewardRoll:
                -0:
                    Поиск провианта не дал результатов, ваши люди возвращаются с пустыми руками. #ForageLoop0
                -1:
                    Ваши люди находят дикую зерновую культуру. (+1 Зерно) #ForageLoop1
                    ~ GiveItem("grain",1)
                -2:
                    Ваши люди находят дикие ягоды. (+1 Виноград) #ForageLoop2
                    ~ GiveItem("grape",1)
                -3:
                    Ваши люди находят дикое льняное растение. (+1 Лен) #ForageLoop3
                    ~ GiveItem("flax",1)
                -4:
                    Ваши люди находят дикие специи. (+1 Специя) #ForageLoop4
                    ~ GiveItem("spice",1)
            }
            
        //End of Loop
{ForageLoops > 0 : ->ForageLoop | ->Leave}
        
    ->END
    
    =HuntLoop
        //Decrease number of loops remaining
            ~HuntLoops = HuntLoops - 1
        
        //Trouble assistance shooting each loop
            //{FinalComparison}
            //{print_party_skill_chance("Scouting", HuntDifficulty)}
            //{perform_party_skill_check("Scouting", HuntDifficulty)}
        
        //Was attempt successful
            {perform_party_skill_check(SkillTextFinal, HuntDifficulty):
                -true:
                    ~ AttemptSuccessful = true
                -false:
                    ~ AttemptSuccessful = false
                -else: ОШИБКА
            }
            
            //Roll for bonus hide
                ~ HideSuccessful = perform_party_skill_check(SkillTextFinal, HuntDifficulty*2)
            
                {HideSuccessful:
                    -true:
                        ~ RewardRoll = RANDOM(1,2)
                    -false:
                        ~ RewardRoll = 0
                }
            
        //Reward
            {
                - AttemptSuccessful == true && RewardRoll == 0:
                    Ваши люди успешны, они возвращаются с фазанами. (+1 Мясо) #HuntLoop0
                    ~ GiveItem("meat",1)
                    ~ GiveItem("hides",1)
                - AttemptSuccessful == true && RewardRoll == 1:
                    Ваши люди успешны, они возвращаются с оленем. (+1 Мясо, +1 Шкура) #HuntLoop1
                    ~ GiveItem("meat",1)
                    ~ GiveItem("hides",1)
                - AttemptSuccessful == true && RewardRoll == 2:
                    Ваши люди успешны, они возвращаются с кабаном. (+1 Мясо, +1 Шерсть) #HuntLoop2
                    ~ GiveItem("meat",1)
                    ~ GiveItem("fur",1)
                - AttemptSuccessful == false:
                     Дичь уклоняется от вас, ваши люди возвращаются пустыми руками. #HuntLoop3
                -else: ОШИБКА
            }
                    
        //End of Loop
            {HuntLoops > 0 : ->HuntLoop | ->Leave}
        
    ->END
    
===Leave===
П #STR_Leave

    ~ MakePartyDisorganized()
    
-> END


