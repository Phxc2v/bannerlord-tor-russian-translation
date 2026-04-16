//Global story tags
# title: The Campfire
# frequency: Special
# development: false
# illustration: campfirenight

//Important Irregular Characters
    //| (Vertical Bar)

//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES
    
    //Triggers:
        //While traveling on the campaign map
    
    //Scenario Explanation (explain the main scenario and any major variations that you are planning to build in. If a variation is different enough consider making it its own file.)
    
        //Main: You are around a campfire and can listen to a story to gain xp or tell your men to rest.

        //Alt: You can get ambushed
        
    //Future Options/Additions
        //More possible variants in groupings
        //Magic and Faith XP options when proper restictions are in place
        
//Data Import/Export Section
    //Make sure you include this in all ink files to get access to integration functions
        INCLUDE include.ink
        
    //List of Data Being Imported (use this to help keep track of what data you are importing; will help with troubleshooting and testing.)
    
        //
        
    //Data Exported (use this to help keep track of what data you are exporting; will help with troubleshooting and testing.)
        
        //Skill XP
        
//Variables setup
    //IMPORTANT! Initial values are mandatory, but they can only be primitives (number, string, boolean). If we want to assign the return value of a function to the variable, we must do it on a separate line, see one line below

    //Seed
        //~ SEED_RANDOM(100) //Uncomment to lock an RNG testing seed for the randomness. Change number inside () for different seed
        
    //Learning sets (The groupings of exp by campfire story category)
        //Each option gives 3000 Xp total. So if a story has 2 skills attached they each get 1500 Xp. For 3 it is 1000 for each.
        //Grouping 1: War stories
            //1. The Hunt (Scouting, Random ranged weapon skill, Tactics)
            //2. The Ambush (Leadership, Tactics, Roguery)
            //3. The Charge (Riding, Polearm, Leadership)
            //4. Holding the Line (Random Melee skill, Leadership, Tactics)
            //5. The Brawl (All melee skills)
            //6. The Shootout (All ranged weapon skills)
        //Grouping 2: Talk about
            //1. Great Rulers (Steward, Leadership, Charm)
            //2. Craftsman (Smithing and Engineering) - smithing's skill object is called Crafting
            //3. Negotiation (Charm, Trade, Roguery)
            //4. Traveling (Riding and Athletics)
            //5. Survival (Medicine, Scouting, Athletics)
            
    //Random Selections
        //Melee Weapon
            VAR MeleeWeaponRandom = 0
                ~ MeleeWeaponRandom = RANDOM(1,3)
            VAR MeleeWeaponText = ""
                
                {MeleeWeaponRandom:
                    -1:
                        ~ MeleeWeaponText = "One Handed"
                    -2:
                        ~ MeleeWeaponText = "Two Handed"
                    -3:
                        ~ MeleeWeaponText = "Polearm"
                }
                

        //Ranged
            VAR RangedWeaponRandom = 0
                ~ RangedWeaponRandom = RANDOM(1,4)
            VAR RangedWeaponText = ""
                
                {RangedWeaponRandom:
                    -1:
                        ~ RangedWeaponText = "Bow"
                    -2:
                        ~ RangedWeaponText = "Crossbow"
                    -3:
                        ~ RangedWeaponText = "Throwing"
                    -4:
                        ~ RangedWeaponText = "Gunpowder"
                }
    
    //Group 1
        VAR StoryName = ""
        VAR StoryBranch = ""
        VAR StoryXpText = ""
        
        VAR StorySelect = 0
            ~ StorySelect = RANDOM(1,6)
            
            {StorySelect:
                -0: ERROR
                -1:
                    ~ StoryName = "The Hunt"
                    ~ StoryBranch = ->TheHunt
                    ~ StoryXpText = "(+1000 XP for Scouting, {RangedWeaponText}, and Tactics)"
                -2:
                    ~ StoryName = "The Ambush"
                    ~ StoryBranch = ->TheAmbush
                    ~ StoryXpText = "(+1000 XP for Leadership, Tactics, and Roguery)"
                -3:
                    ~ StoryName = "The Charge"
                    ~ StoryBranch = ->TheCharge
                    ~ StoryXpText = "(+1000 XP for Riding, Polearm, and Leadership)"
                -4:
                    ~ StoryName = "Holding the Line"
                    ~ StoryBranch = ->HoldingTheLine
                    ~ StoryXpText = "(+1000 XP for {MeleeWeaponText}, Leadership, and Tactics)"
                -5:
                    ~ StoryName = "The Brawl"
                    ~ StoryBranch = ->TheBrawl
                    ~ StoryXpText = "(+1000 XP for all melee weapon skills)"
                -6:
                    ~ StoryName = "The Shootout"
                    ~ StoryBranch = ->TheShootout
                    ~ StoryXpText = "(+750 XP for all ranged weapon skills)"
            }
    
    //Group 2
        VAR DiscussionName = ""
        VAR DiscussionBranch = ""
        VAR DiscussionXpText = ""
        
        VAR DiscussionSelect = 0
            ~ DiscussionSelect = RANDOM(1,5)
            
            {DiscussionSelect:
                -0: ERROR
                -1:
                    ~ DiscussionName = "Great Rulers"
                    ~ DiscussionBranch = ->GreatRulers
                    ~ DiscussionXpText = "(+1000 XP for Steward, Leadership, and Charm)"
                -2:
                    ~ DiscussionName = "Craftsman"
                    ~ DiscussionBranch = ->Craftsman
                    ~ DiscussionXpText = "(+1500 XP for Smithing and Engineering)"
                -3:
                    ~ DiscussionName = "Negotiation"
                    ~ DiscussionBranch = ->Negotiation
                    ~ DiscussionXpText = "(+1000 XP for Charm, Trade, and Roguery)"
                -4:
                    ~ DiscussionName = "Traveling"
                    ~ DiscussionBranch = ->Traveling
                    ~ DiscussionXpText = "(+1500 XP for Riding and Athletics)"
                -5:
                    ~ DiscussionName = "Survival"
                    ~ DiscussionBranch = ->Survival
                    ~ DiscussionXpText = "(+1000 XP for Medicine, Scouting, and Athletics)"
            }
            
            
            
        
//Variable Check (Use for sanity check. Uncomment variables to see what they are)
//{GiveSkillExperience("Throwing", 1000)}

-> Start

===Start===

С наступлением темноты вы и ваши люди разбивают лагерь. По мере того как ночь наступает, вы замечаете, что ваши люди разделились на две группы: одна рассказывает военные истории, а другая просто беседует. #STR_Start1
-> choice1

    =choice1
        What will you do? //{MeleeWeaponRandom} {RangedWeaponRandom} //Uncomment for bug testing
            *[Послушайте историю {StoryName} {StoryXpText}]
                ->StoryBranch
            *[Присоединитесь к обсуждению {DiscussionName} {DiscussionXpText}]
                ->DiscussionBranch
            *[Прикажите своим людям отдохнуть (все спутники исцелены, все раненые войска восстановлены)]
                You tell your men to head to bed early and get all the rest they can.
                ~ HealPartyToFull()
                ->END

===TheHunt===
    На фоне треска костра голос опытного солдата рассказывал историю о скрытности и преследовании. Мерцающие языки пламени словно отражали напряжение в глазах его товарищей, которые наклонились ближе, чтобы послушать. #STR_TheHunt1

«Слушайте, ребята и девчата,» начал солдат, «позвольте мне рассказать вам историю нашей последней охоты. Это был безлунный вечер, наши шаги направляли тени и шелест листьев. Наши разведчики двигались сквозь подлесок, глаза острые, чувства настороженные, пока мы не почувствовали мимотавра...» #STR_TheHunt2

По мере того как история раскрывалась, солдаты чувствовали, как их затягивает повествование, испытывая адреналин погони и напряжение, царящее в воздухе. Слова рассказчика рисовали яркую картину хитрости и стратегии, и к тому времени, когда повесть завершилась, солдаты обрели новое уважение к разведке и искусству охоты. #STR_TheHunt3
    
    //Give Xp
        ~ GiveSkillExperience("Scouting",1000)
        ~ GiveSkillExperience("Tactics",1000)
        
        {RangedWeaponRandom:
                    -1:
                        ~ GiveSkillExperience("Bow" ,1000)
                    -2:
                        ~ GiveSkillExperience("Crossbow" ,1000)
                    -3:
                        ~ GiveSkillExperience("Throwing" ,1000)
                    -4:
                        ~ GiveSkillExperience("Gunpowder" ,1000)
                }
    -> END

===TheAmbush===
    Среди трескующихся углей голос солдата возвышался с лукавым блеском в глазах. Теплое сияние костра освещало лица его товарищей, которые устроились послушать историю. #STR_TheAmbush1

«Соберитесь вокруг, ребята,» сказал солдат с улыбкой, «и позвольте мне рассказать вам об засаде, которой нам удалось выжить. Представьте себе: ночь Манслиблит, вражеские звероплемя наступают в неведении. Наш план был хитёр, наши движения быстры. Мы ударили внезапно и жестоко, повернув ход событий в нашу пользу...» #STR_TheAmbush2

Солдаты были перенесены в сцену расчётливой хитрости и быстрого исполнения. Смех и кивки одобрения последовали за завершением истории, оставив солдат с более глубоким пониманием тактики и силы хорошо выполненной засады. #STR_TheAmbush3
    
        //Give Xp
            ~ GiveSkillExperience("Leadership",1000)
            ~ GiveSkillExperience("Tactics",1000)
            ~ GiveSkillExperience("Roguery",1000)
    -> END

===TheCharge===
    Тепло огня отбрасывало пляшущие тени на лица солдат, собравшихся вокруг. Их внимание было полностью захвачено, когда голос опытного бойца наполнил воздух. #STR_Charge1

"Слушайте внимательно, мои друзья," начал солдат, "историю нашей последней битвы. Это был день, залитый светом заходящего солнца. Наши кони были нетерпеливы, копыта их топтали землю. С громогласным криком мы ринулись вперёд..." #STR_Charge2

Солдаты словно могли почувствовать порыв ветра на лицах и стук копыт под ногами. История рисовала яркую картину единства и мужества, оставляя солдат с более глубоким пониманием верховой езды, использования оружия и силы хорошо скоординированного штурма. #STR_Charge3
    
    //Give Xp
        ~ GiveSkillExperience("Riding",1000)
        ~ GiveSkillExperience("Polearm",1000)
        ~ GiveSkillExperience("Leadership",1000)
    -> END 

===HoldingTheLine===
    В мерном треске костра голос солдата нес в себе тяжесть решимости. Свет пламени словно отражал твердость взглядов его товарищей. #STR_HoldingTheLine1

"Слушайте внимательно, мои друзья," сказал солдат с непоколебимой убеждённостью, "историю нашей последней битвы. Это был момент неразрывного единства, когда мы заняли позиции для стойкого удержания, щиты были сцеплены в незыблемой защите. Когда армия нежити двинулась вперёд, мы стояли непоколебимо..." #STR_HoldingTheLine2

Воины почувствовали прилив единства, словно стояли плечом к плечу с героями повествования. Слова рассказчика подчеркивали важность лидерства и тактики, углубляя понимание искусства обороны. #STR_HoldingTheLine3
    
    //Give Xp
            ~ GiveSkillExperience("Scouting",1000)
            
            ~ GiveSkillExperience("Tactics",1000)
            
            {MeleeWeaponRandom:
                    -1:
                        ~ GiveSkillExperience("OneHanded",1000)
                    -2:
                        ~ GiveSkillExperience("TwoHanded",1000)
                    -3:
                        ~ GiveSkillExperience("Polearm",1000)
                }
    -> END

===TheBrawl===
    В мерцающем свете костра солдат рассказывал о товариществе и дружеском соперничестве. Смех перемешивался с треском огня, пока его спутники наклонялись вперед, желая услышать историю. #STR_TheBrawl1

«Ах, мои товарищи», — засмеялся солдат, — «позвольте рассказать вам о событиях последней тренировки! Это была ночь веселья, превратившаяся в азартное состязание. Мы с игривым настроением проверяли свои силы, каждый удар и парирование были танцем мастерства...» #STR_TheBrawl2

Воины обменялись понимающими взглядами, их собственные воспоминания о дружеских состязаниях всплывали в памяти. Слова рассказчика подчеркивали узы товарищества и уроки ближнего боя, даря чувство общего опыта. #STR_TheBrawl3
    
    //Give Xp
            ~ GiveSkillExperience("OneHanded",1000)
            ~ GiveSkillExperience("TwoHanded",1000)
            ~ GiveSkillExperience("Polearm",1000)
    -> END

===TheShootout===
    В тёплом объятии костра голос солдата возвышался с чувством предвкушения. Огонь танцевал в глазах его спутников, пока они усаживались, чтобы послушать историю. #STR_TheShootout1

"Слушайте внимательно, мои товарищи," начал солдат, "историю нашей последней битвы. Представьте небо, затянутое тучами, создающее сцену для демонстрации меткого боя, пока мой полк целится в приближающихся зверей-людоедов. Лукы, арбалеты, кинжалы и пороховые оружие стали главными действующими лицами..." #STR_TheShootout2

Солдаты кивали друг другу, их умы ярко рисовали картины летящих в воздухе стрел и снарядов. Слова рассказчика подчеркивали тонкости меткого боя, оставляя солдат с более глубоким пониманием различных навыков использования метательного оружия. #STR_TheShootout3
    
    //Give Xp
            ~ GiveSkillExperience("Bow",750)
            ~ GiveSkillExperience("Crossbow",750)
            ~ GiveSkillExperience("Throwing",750)
            ~ GiveSkillExperience("Gunpowder",750)
    -> END

===GreatRulers===
    В теплом свете костра группа солдат вела оживленный разговор о великих правителях Старого Света. Их голоса звучали с восхищением и уважением, их рассказы переплетались уроками руководства и государственного управления. #STR_GreatRulers1

Один солдат начал, его голос был полон благоговения: "Давайте поговорим о легендарных правителях, которые сформировали наши земли. В последний раз я слышал, что великий Карл Франц, казалось, хорошо держал свою репутацию, ведь управлять требует многого..." #STR_GreatRulers2

Пока текли истории, солдаты размышляли о качествах, которые делали этих правителей выдающимися — их мастерство управления, искусство руководства и харизма, объединявшая их подданных. В их умах уроки управления, руководства и обаяния прижились корнями, оставив после себя более глубокое понимание ответственности, которая приходит с властью. #STR_GreatRulers3
    
    //Give Xp
            ~ GiveSkillExperience("Steward",1000)
            ~ GiveSkillExperience("Leadership",1000)
            ~ GiveSkillExperience("Charm",1000)
    -> END

===Craftsman===
    Вокруг костра, где царил дух товарищества, группа солдат обменивалась историями о ремеслах и инженерных чудесах. Их голоса звучали с благоговением и восхищением, рассказывая о подвигах мастеровых и изобретательных инженеров.  #STR_Craftsman1

"Слушайте внимательно, товарищи! — воскликнул один из солдат. — Не многие знают об этом, но мне выпала честь научиться инженерному делу у эльфа. Дворфы-держатели являются доказательством искусства кузнечного дела..." #STR_Craftsman2

По мере того как истории раскрывались, солдаты поражались сложным конструкциям и невероятному изобретательству, стоящему за этими подвигами. Их разговоры затрагивали темы кузнечного дела, инженерии и чудес, рождённых умелыми мастерами и мастерскими дворфами, что привило им новое уважение к этим важным ремёслам. #STR_Craftsman3
    
    //Give Xp
            ~ GiveSkillExperience("Crafting",1500)
            ~ GiveSkillExperience("Engineering",1500)
    -> END

===Negotiation===
    В мерцающем свете костра группа солдат рассказывала друг другу истории о торге и сделках. Смех перемешивался с их голосами, пока они делились как успешными переговорами, так и забавными историями о том, когда дела шли не по плану. #STR_Negotiation1

"Ах, мои товарищи! — засмеялся один из солдат. — Позвольте поделиться искусством торга и танцем сделок. От обмена с хитрыми половинками до противостояния пронырливым купцам Мариенбурга — путь к справедливой сделке усыпан уловками и хитростью..." #STR_Negotiation2

Солдаты наклонились вперед, очарованные историями о остроумии и шутках, которые разворачивались в шумных рынках и базарах Старого Света. Они задумывались о хрупком балансе обаяния, торговых навыков и неизбежных ошибок, связанных с этим делом, что углубило их понимание искусства переговоров. #STR_Negotiation3
    
    //Give Xp
            ~ GiveSkillExperience("Charm",1000)
            ~ GiveSkillExperience("Trade",1000)
            ~ GiveSkillExperience("Roguery",1000)
    -> END

===Traveling===
   Вокруг трещащего костра группа солдат делилась историями о своих путешествиях и приключениях верхом. Их голоса звучали с чувством авантюризма и товарищества, рассказывая о переходах через опасные земли и встречах с обитателями Старого Света. #STR_Traveling1

«Поддержание здоровья боевой лошади», — заявил один солдат, — «это уже само по себе испытание. Связь между всадником и конем — это нечто уникальное, чего нет ни у кого другого...» #STR_Traveling2

Пока истории плели свою ткань приключений, солдаты словно переносились в далёкие земли и дикие пустоши. Они размышляли о навыках верховой езды и нерушимой связи между всадником и его конём, что углубило их appreciation к искусству путешествий верхом.#STR_Traveling3
    
    //Give Xp
            ~ GiveSkillExperience("Riding",1500)
            ~ GiveSkillExperience("Athletics",1500)
    -> END
    
===Survival===
    В тишине трещащего костра группа солдат делилась своими знаниями о выживании в дикой природе. Их голоса звучали с весом опыта, рассказывая истории об изобретательности и стойкости перед лицом вызовов природы. #STR_Survival1

"Слушайте внимательно," начал один солдат, его голос был твердым и уверенным, "ибо я поведаю мудрость того, как правильно выживать в самых густых диких лесах. От поиска пропитания до ориентирования в густых лесах и опасных болотах — ключ кроется в понимании ритмов земли..." #STR_Survival2

По мере того как рассказы раскрывались, солдаты погружались в искусство выживания, обучаясь читать знаки природы и адаптироваться к её требованиям. Истории подчеркивали навыки медицины, разведки и athleticism, оставляя солдат с newfound уважением к беспощадному, но внушающему трепет миру за пределами безопасности цивилизации. #STR_Survival3
    
    //Give Xp
            ~ GiveSkillExperience("Medicine",1000)
            ~ GiveSkillExperience("Scouting",1000)
            ~ GiveSkillExperience("Athletics",1000)
    -> END


-> END


























