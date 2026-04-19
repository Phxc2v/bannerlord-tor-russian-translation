//Global story tags
# title: Защитите Наших Мёртвых
# frequency: Uncommon
# development: true
# illustration: campfirenight

INCLUDE include.ink

VAR PlayerWin = false
VAR PartyCanRaiseDead = false
            ~ PartyCanRaiseDead = PartyHasNecromancer(false)
VAR RaiseDeadSkillCheckTest = false
            ~ RaiseDeadSkillCheckTest = perform_party_skill_check("Spellcraft", 25)
//Scenarios notes
    //Rarity: COMMON
    //Repeatable: YES
    
    //Restrictions
        //Terrain: Empire, Bretonnia, Telia, Estalia, or Border Princes culture
    
    //Triggers:
        //While travelling on campaign map
    
    //Scenario Explanation
    
        //Main: You are traveling and a peasant asks you to rid the local graveyard of a necromancer.
		// Rewards: faith exp + small amount of gold or skeleton troops + staff.

->START

===START===
В конце дневного перехода ваши люди устрояют лагерь. Вы знаете, что скоро наступит закат, а эти земли опасны, особенно ночью. #STR_Start1
Внезапно один из ваших людей кричит предупреждение. Поднимая взгляд, вы видите местного жителя, приближающегося к вам. Он выглядит безоружным. #иллюстрация: странник #STR_Start2
Мужчина объясняет, что недавно прибывший некромант начал воскрешать мёртвых с кладбища деревни. Хотя житель довольно беден, он говорит, что заплатит скромное вознаграждение любому, кто убьёт некроманта. #STR_Start3 
-> choices

    =choices
    *[Мы убьём этого некроманта за вас.] ->accept
    *[Это ужасно, эти скелеты должны принадлежать мне!] ->accept
    *[Может быть, в другой раз. У нас есть более важные дела.] -> deny
    
    =accept
    Деревня сообщает, что некромант приходит каждую ночь со скелетами. Зная это, вы составляете план засады на кладбище.  #STR_Accept1
    
    ->enterArena
    
    =deny
    ->END

    =enterArena
    //~ OpenGraveyardMission()
    ...
    {PlayerWin: Когда некромант падает, вы благодарите insert_deity_name. #STR_PlayerWin1}

    ->BattleResult
    
===BattleResult===
        *[Вернитесь в деревню и возьмите награду {GiveGold(500)}{GiveSkillExperience("Вера",1000)}]
		-> END
		
        //Necromancer option
        *{PartyCanRaiseDead}[Попробуйте подчинить побеждённых скелетов своей воле, {print_party_skill_chance("Магия", 25)}]
                {RaiseDeadSkillCheckTest: -> raiseSucceed | -> raiseFail}
    
        =raiseSucceed
        Успев оживить мёртвых, вы обыскиваете некромантера на предмет ценных вещей. {GiveItem("tor_vc_weapon_staff_nm_001", 1)} #STR_HelpNecromancerSuccess
            
            ~ChangePartyTroopCount("tor_vc_skeleton",8)
            -> END
        
        =raiseFail
        Возможно, вы не смогли оживить мёртвых, но хотя бы некромантер оставил вам полезную жезл. {GiveItem("tor_vc_weapon_staff_nm_001", 1)} #STR_HelpNecromancerFail
            -> END
