//Global story tags
# title: Повешенные
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
Вы встречаете дерево, от которого висят трое мужчин, а под ними в земле воткнут меч. Подойдя ближе, вы видите, что на дереве высечено слово "Предатели", а меч использовался для обозначения могилы. #STR_Start1
    ->choice1

    //What to do with the hanging bodies
    =choice1
Что сделает ваш отряд с повешенными телами? #STR_Start2
        
            *[Ничего не делать]
Вы решаете ничего не делать с повешенными телами. #STR_DoNothing
                ->Grave
        
            *[Погребать повешенных (Милосердие+)]
Вы рубите тела и кладете их в покой. #STR_Bury
                ~ AddTraitInfluence("Mercy", 80)
                ->Grave
        
            *[Лутовать повешенных (Милосердие-)]
Вы рубите тела и обыскиваете трупы, забирая лохмотья, в которых их казнили. #STR_Loot
                ~ AddTraitInfluence("Mercy", -80)
                ~ GiveItem("wrapped_headcloth",3)
                ~ GiveItem("ragged_robes",3)
                ~ GiveItem("leather_shoes",3)
                ->Grave
            
        //Raise the hanging bodies as skeletons
            *{PartyCanRaiseDead}[Воскрешать повешенных как скелеты (Милосердие--) {print_party_skill_chance("Spellcraft", RaiseDeadDifficulty)}]
                ~ AddTraitInfluence("Mercy", -200)
                {perform_party_skill_check("Spellcraft", RaiseDeadDifficulty):
                    -true:
                        ~ ChangePartyTroopCount("tor_vc_skeleton",3)
                        ~ SkeletonSuccess = true
                }
Ваш отряд пытается воскресить трупы как скелеты {SkeletonSuccess: и успешно. ->Grave | и неудачно.->choice1} #STR_Loot

===Grave===
    //Needed for intermission text 
Приняв решение относительно повешенных тел, вы обращаете внимание на могилу, отмеченную мечом. #STR_Grave
        ->choice2
        
    //What to do with the buried body
    =choice2
        
        //Variable Update
        ~ RaiseDeadDifficulty = 100
Что вы будете делать с могилой? #STR_Grave
        *[Оставить это место (Уйти)]
            ->Leave
            
        *[Сказать молитву (Милосердие+)]
Вы говорите молитву за усопших, надеясь, что они найдут покой. #STR_Prayer
            ~ AddTraitInfluence("Mercy", 80)
            ->Leave


        *[Взять меч (меч 3 уровня, Милосердие-)]
Вы берете меч в руки. #STR_TakeSword
            ~ AddTraitInfluence("Mercy", -80)
            ~ HaveSword = true
            ~ TookSword = true
            ->choice2
            
        *[Выкопать могилу (Милосердие-)]
Вы выкапываете могилу, чтобы найти воина, погребенного в доспехах. Вы видите, что часть доспехов повреждена, скорее всего, от рук "предателей". #STR_Dig
            ~ AddTraitInfluence("Mercy", -80)
            ~ DugUpGrave = true
            ->choice2
        
        *{DugUpGrave == true}[Лутовать погребенное тело (2 предмета доспехов 3 уровня, Милосердие-)]
Вы сбрасываете с тела все еще целые доспехи. #STR_DigLoot
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
            
        *{DugUpGrave && PartyCanRaiseDead && not LootedBody}[Воскресить погребённое тело как вайта (+1 Страж склепа, Милосердие--) {print_party_skill_chance("Spellcraft", RaiseDeadDifficulty)}]
            ~AddTraitInfluence("Mercy", -200)
                
                //Raise Dead
                    {perform_party_skill_check("Spellcraft", RaiseDeadDifficulty):
                        -true:
                            ~ ChangePartyTroopCount("tor_vc_crypt_guard",1)
                            ~ CryptGuardSuccess = true
                            ~ HaveSword = false
                        -false:
                    }

Ваш отряд пытается воскресить труп как вайта {CryptGuardSuccess: и успешно. Вайт встает на ноги {TookSword: и протягивает руку, словно просит вернуть свой меч. Вы возвращаете оружие} затем он марширует к остальным силам вашего отряда. ->Leave | и неудачно.->choice2} #STR_DigResurrect
            ->Leave

===Leave===
Приняв решения, вы отправляетесь в путь. #STR_Leave1
    {HaveSword: 
        ~GiveItem("vlandia_sword_1_t2",1)
    }
-> END















