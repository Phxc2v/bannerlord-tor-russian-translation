//Global story tags
# title: The Hanged Men
# frequency: Common
# development: false
# illustration: hangedman

//Important Irregular Characters
    //| (Vertical Bar)

//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES
    
    //Triggers:
        //While Travelling on Campaign map
    
    //Scenario Explanation (explain the main scenario and any major variations that you are planning to build in. If a variation is different enough consider making it its own file.)
    
        //Main: You come across a bunch of hanged men with a sword in the ground underneath them. There is a body buried under the sword.

        //Alt:
        
    //Future Options/Additions
        //Add ability to gain relations or gain faith skill for people who have a death god (ex. Morr)
        //Remove certain choices if the player is not Order (Undead, Chaos, Greenskin)
        //Make sure the spellcraft skill used for raise dead comes from a necromancer in the party
        //Add in a murder mystery available by speaking to the dead
            //Necro can make Spirit hosts instead of zombies
        //Take skulls option for chaos
        //Change skeleton to zombie
        //Defile corpses

INCLUDE include.ink

//Variables setup

    //Party can raise departed
        VAR PartyCanRaiseDead = false
            ~ PartyCanRaiseDead = PartyHasNecromancer(false)
                
    //Spellcraft (Highest In Party)
        VAR PartySpellcraftCheckText = 0 //Not important initial value
            ~ PartySpellcraftCheckText = print_party_skill_chance("Spellcraft", RaiseDeadDifficulty)
                
        VAR PartySpellcraftCheckTest = 0 //Not important initial value
            ~ PartySpellcraftCheckTest = perform_party_skill_check("Spellcraft", RaiseDeadDifficulty)
                
    //Give Items
        VAR HaveSword = false
        VAR TookSword = false
        VAR LootedBody = false

    //Raise Dead
        VAR RaiseDeadDifficulty = 50
        VAR SkeletonSuccess = false

    //Grave Interaction
        VAR DugUpGrave = false
        VAR CryptGuardSuccess = false


-> Start

===Start===
    Вы находите дерево, с которого висят трое мужчин, а под ними в земле торчит меч. Подойдя ближе, вы видите, что на дереве выбита надпись «Предатели», а меч использовался для обозначения могилы. #STR_Start1
    ->choice1

    //What to do with the hanging bodies
    =choice1
        Что сделает ваша группа с повешенными телами? #STR_Start2
        
            *[Ничего не делать]
                Вы решаете ничего не делать с повешенными телами. #STR_DoNothing
                ->Grave
        
            *[Похоронить повешенных (Милосердие+)]
                Вы срубили тела и отпустили их в последний путь. #STR_Bury
                ~ AddTraitInfluence("Mercy", 80)
                ->Grave
        
            *[Лутуйте повешенные тела (Милосердие-)]
                Вы срубили тела и разграбили трупы, взяв лохмотья, в которых их казнили. #STR_Loot
                ~ AddTraitInfluence("Mercy", -80)
                ~ GiveItem("wrapped_headcloth",3)
                ~ GiveItem("ragged_robes",3)
                ~ GiveItem("leather_shoes",3)
                ->Grave
            
        //Raise the hanging bodies as skeletons
            *{PartyCanRaiseDead}[Возродите повешенные тела в скелеты (Милосердие--) {вероятность навыка партии "Магия" для воскрешения}]
                ~ AddTraitInfluence("Mercy", -200)
                {perform_party_skill_check("Spellcraft", RaiseDeadDifficulty):
                    -true:
                        ~ ChangePartyTroopCount("tor_vc_skeleton",3)
                        ~ SkeletonSuccess = true
                }
                Ваша партия пытается возродить трупы в скелеты {Успех_скелета: и успешно. ->Могила | и неудачно.->выбор1} #STR_Loot

===Grave===
    //Needed for intermission text 
        После того как вы решили, что делать с повешенными телами, ваше внимание привлекает могила, отмеченная мечом. #STR_Grave
        ->choice2
        
    //What to do with the buried body
    =choice2
        
        //Variable Update
        ~ RaiseDeadDifficulty = 100
        Что вы сделаете с этой могилей? #STR_Grave
        *[Оставить это место (Уйти)]
            ->Leave
            
        *[Отдать дань уважения (Милосердие+)]
            Вы молите за усопших, надеясь, что они найдут покой. #STR_Prayer
            ~ AddTraitInfluence("Mercy", 80)
            ->Leave


        *[Возьмите меч (меч 3-го ранга, милосердие-)]
            Вы берете меч в свои руки. #STR_TakeSword
            ~ AddTraitInfluence("Mercy", -80)
            ~ HaveSword = true
            ~ TookSword = true
            ->choice2
            
        *[Выкопайте могилу (милосердие-)]
            Вы раскапываете могилу и находите воина, похороненного в доспехах. Вы видите, что часть доспехов повреждена, скорее всего, предателями. #STR_Dig
            ~ AddTraitInfluence("Mercy", -80)
            ~ DugUpGrave = true
            ->choice2
        
        *{DugUpGrave == true}[Лутуйте тело воина (2 предмета доспехов 3-го ранга, милосердие-)]
            Вы снимаете с трупа всю броню, которая ещё целая. #STR_DigLoot
            ~LootedBody = true
            ~AddTraitInfluence("Mercy", -80)
            
                //Loot Rolls
                    {RANDOM(0,1):
                        -0: 
                            ~GiveItem("roundkettle_over_imperial_leather",1)
                        -1: 
                            ~GiveItem("imperial_padded_cloth",1)
                    }
                    {RANDOM(0,1):
                        -0: 
                            ~GiveItem("mail_mitten",1)
                        -1: 
                            ~GiveItem("mail_chausses",1)
                    }

            ->choice2
            
        *{DugUpGrave && PartyCanRaiseDead && not LootedBody}[Возродите погребённое тело в виде призрака (+1 Страж Гробницы, Милосердие--) {print_party_skill_chance("Магия", СложностьВозрождения)}]
            ~AddTraitInfluence("Mercy", -200)
                
                //Raise Dead
                    {perform_party_skill_check("Spellcraft", RaiseDeadDifficulty):
                        -true:
                            ~ ChangePartyTroopCount("tor_vc_crypt_guard",1)
                            ~ CryptGuardSuccess = true
                            ~ HaveSword = false
                        -false:
                    }

                Your party attempts to resurrect the corpse as a wight {CryptGuardSuccess: and succeed. The wight stands up {TookSword: and holds out its hand as if to ask for its sword back. You give back the weapon} then it marches off to join the rest of your forces. ->Leave | and fail.->choice2} #STR_DigResurrect
            ->Leave

===Leave===
    Приняв решения, вы продолжаете свой путь. #STR_Leave1
    {HaveSword: 
        ~GiveItem("vlandia_sword_1_t2",1)
    }
-> END















