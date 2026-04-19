//Global story tags
# title: Пруд
# frequency: Common
# development: false
# illustration: pond

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
    
        //Main: You are travelling and come across a pond.

        //Alts:
            //If encountered while in a chaos area it gets weird.
            //Something comes out of the water and attacks. (River troll or River troll hag for a mini boss fight)
        
        
    //Future Options/Additions
        //Make it so the player does not have to click through each time they do a loop.
        //More options
            //Search for animals (capture geese)
            //Spend some time training
        //Add choices/effects for nature gods
            //Fishing success chance improved by Priest of Manaan
            //Healing success chance improved by Pries of Rhya or Shallya
            //Foraging success chance improved by Priest of Rhya
        //Add choices/effects for wizards (Lore of Life, Lore of Beasts, ...)
            //Lore of Beast for fishing Bonus?
        //Add randomness to the amount of plant and animal life as well as the difficulty of success
            //Randomize elements of Foraging
            //Randomize elements of Fishing
        //Add scavenging option
            //can find jewerly that was lost in the pond
        
//Data Import/Export Section
    //Make sure you include this in all ink files to get access to integration functions
        INCLUDE include.ink
        
    //List of Data Being Imported (use this to help keep track of what data you are importing; will help with troubleshooting and testing.)
    
        //Scouting Highest In party
            //Used in Fishing skill check
                VAR PartyScoutingCheckText = 0
                    //~ PartyScoutingCheckText = print_party_skill_chance("Scouting", FishDifficulty) [Variable Update]
                
                VAR PartyScoutingCheckTest = 0
                    //~ PartyScoutingCheckTest = perform_party_skill_check("Scouting", FishDifficulty) [Variable Update]
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
        
    //Fish
        VAR FishDifficulty = 50
            
        VAR FishLoops = 3
        
        VAR HideSuccessful = false
        
    //Forage
        VAR ForageDifficulty = 75
        
        VAR ForageLoops = 5
        
    //Was X attempt successful
        VAR AttemptSuccessful = false
        
    //Reward Roll
        VAR RewardRoll = 0
        

//Variable Update (Update any variables here)
    ~ PartyScoutingCheckText = print_party_skill_chance("Scouting", FishDifficulty)
                
    //~ PartyScoutingCheckTest = perform_party_skill_check("Scouting", FishDifficulty) Needs to be done each loop

    ~ PartyRangedSkillCheckText = print_party_skill_chance(SkillTextFinal, FishDifficulty*2)
    
//Variable Check (Use for sanity check. Uncomment variables to see what they are)

-> Start

===Start===

Пока ваша группа путешествует, вы натолкнетесь на идиллическую сцену, которая заставит вас замереть от восторга. Перед вами раскинулось спокойное озеро — скрытая жемчужина среди дикой природы. Вода тиха и прозрачна, отражая лазурное небо. Обильная растительность окружает озеро, создавая мирный убежище. #STR_Start1
 {IsNight(): Серебристый лунный свет | Золотистый солнечный свет} пробивается сквозь деревья, отбрасывая свет на поверхность воды. Воздух наполнен нежным ароматом природы — успокаивающим бальзамом для ваших уставших чувств. Птицы поют мелодичные песни, дополняя атмосферу спокойствия. #STR_Start2

 Стоя там и очарованный видом, вы замечаете, что ваши люди догоняют вас. Их лица, исписанные усталостью, озаряются удивлением и облегчением. Даже обычно сдержанный член вашей группы позволяет себе небольшую улыбку. #STR_Start3
    
 Ваш второй кладет руку вам на плечо, его голос звучит с редкой ноткой легкости: «Минута отдыха у озера. Что скажете?» #STR_Start4
        ->choice1
        
    =choice1
        Что прикажете сделать вашей группе? #STR_Start4 
            *[Собрать дикорастущие растения (несколько попыток {LoreOfLifeInParty: 50% шанс (усилено магией Жизни)| 25% шанс} на успешный сбор разных диких растений)]
                
                Вы приказываете своей группе собрать дикорастущие растения. #STR_Forage1
            
                //Lore of Life in Party Increases success chance
                    {LoreOfLifeInParty:
                        -true: 
                            Маг в вашей группе призывает Ветер Гиран, чтобы помочь вашим людям в поиске. #STR_ForageLoreOfLife1
                            ~ ForageDifficulty = ForageDifficulty - 25
                        -false:
                        -else: ОШИБКА
                    }
                    
                ->ForageLoop

            *[Рыба (Множество шансов поймать рыбу (50% шанс успеха))] 
            
            Вы приказываете своим людям отправиться на рыбалку. #STR_Fish1
                
                ->FishLoop
                
            *[Дайте вашим людям отдохнуть (Все спутники исцеляются, а все раненые войска восстанавливаются {PartyMedicineCheckText})]
                
                Вы пытаетесь дать своим людям передышку, надеясь, что кратковременный отдых поможет им поправиться. #STR_Rest1
                
                {PartyMedicineCheckTest:
                    -true: 
                        Ваша компания использует передышку, чтобы позаботиться о раненых. #STR_RestMedicineSuccess
                        ~ HealPartyToFull()
                    -false:
                    Пока люди начинают ухаживать за ранеными, земля внезапно начинает трястись под вами, и рык заполняет воздух. В пруд обрушивается поток земли и камней, вызванный оползнем на берегу. Вода бурлит, проглатывая часть суши, которую она эродировала со временем. #STR_RestMedicineFail
                    -else: "ОШИБКА"
                }
                
               
                
                ->Leave
                
[Уйти] Вы решаете, что вашей партии не время отдыхать, и сразу отправляетесь в путь.->END

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
                    ~ RewardRoll = 1
                -false:
                    ~ RewardRoll = 0
            }
            
            {RewardRoll:
                -0:
                    Поиск провианта не приносит результатов, ваши люди возвращаются с пустыми руками.
                -1:
                    Ваши люди находят дикорастущий рис. (+1 Зерно)
                    ~ GiveItem("grain",1)
            }
            
        //End of Loop
            {ForageLoops > 0 : ->ForageLoop | ->Leave}
        
    ->END
    
    =FishLoop
        //Decrease number of loops remaining
            ~ FishLoops = FishLoops - 1
        
        //Was attempt successful
            {RANDOM(0,100)>=ForageDifficulty:
                -true:
                    ~ AttemptSuccessful = true
                -false:
                    ~ AttemptSuccessful = false
                -else: ОШИБКА
            }

        //Reward
            {
                - AttemptSuccessful == true:
                    Ваши люди ловят рыбу (+1 Рыба).
                    ~ GiveItem("fish",1)
                - AttemptSuccessful == false:
                     Ваши люди ничего не ловят.
                -else: ОШИБКА
            }
                    
        //End of Loop
            {FishLoops > 0 : ->FishLoop | ->Leave}
        
    ->END
    
===Leave===
    Проведя время у пруда, вы решаете отправиться в путь.

    ~ MakePartyDisorganized()
    
-> END

