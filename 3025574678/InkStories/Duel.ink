//Global story tags
# title: The Art of the blade
# frequency: Special
# development: false
# illustration: roadpoint2

INCLUDE include.ink

VAR PlayerWin = false
VAR MetBefore = true
    ~ MetBefore = GetPlayerHasCustomTag("MetVittorio")
VAR DeniedBefore = true
    ~ DeniedBefore = GetPlayerHasCustomTag("DeniedVittorio")
    
    ~ SetTextVariable("MetBefore",MetBefore)
    ~ SetTextVariable("DeniedBefore1",DeniedBefore)
    ~ SetTextVariable("DeniedBefore2",DeniedBefore)
    ~ SetTextVariable("MetBefore2",MetBefore)

->START

===START===
Пока вы продолжаете свой путь по извилистой дороге, мягкое шуршание ветра сопровождает каждый ваш шаг.#STR_Start1
Suddenly, the rhythmic beat of approaching footsteps captures your attention. Glancing up, {not MetBefore: you spot a mysterious figure approaching with confident strides. As they draw nearer, the glint of a finely crafted rapier catches your eye. The stranger stops before you, a warm smile on their face as they appraise you.}{MetBefore:  you spot the familiar figure of Vittorio de Luca, the renowned Tilean duelist, making his way towards your group with confident strides. {not DeniedBefore: Memories of your previous encounter flood back, the thrill of the first duel still lingering in your mind.}} #illustration: stranger #STR_Start2
{not MetBefore: «Ах, какая удача встретить отряд достойных воинов на этой одинокой дороге», — говорят они. «Я Витторио де Лука, мастер клинка из далёких земель Тилии. Я странствовал по свету, ища достойного противника, который сможет сравниться со мной в бою. И вот судьба привела меня к вам. Не желаете ли вы доказать свои навыки в дружеском дуэли, с небольшой ставкой, чтобы сделать её более захватывающей?»#STR_Start3NotMetBefore} 
{MetBefore: As Vittorio draws nearer, the glint of his finely crafted rapier catches your eye, and a warm smile spreads across his face as he appraises you. "Ah, what a stroke of luck to meet again on this lonely path," he says, his voice carrying a playful undertone. "I see the fire of a warrior still burns within you. {not DeniedBefore: Care to prove your skills once more in a rematch?"} {DeniedBefore: Care to prove your skills this time around?}#STR_Start3MetBefore} 
~ SetPlayerCustomTag("MetVittorio") 
-> choices

=choices
*[Примите вызов.] ->accept
*[Может быть, в другой раз. У нас нет времени на пустую трату.] -> deny

=accept
{not MetBefore: Заинтересовавшись этим предложением, вы возвращаете им улыбку, с любопытством ожидая узнать условия их пари. #STR_AcceptNotMetBefore1}
{not MetBefore: "A duel with a wager? I'm listening," you reply, open to the idea. #STR_AcceptNotMetBefore2}
{not MetBefore: Глаза дуэлянта блестят от нетерпения, пока он объясняет условия: «Если вы победите, я предложу вам сумму в 5000 золотых монет как доказательство вашего мастерства. Если же я докажу своё превосходство, я не требую ничего большего, кроме чести испытать свои навыки против ваших».#STR_AcceptNotMetBefore3}
With a gleam of excitement in your eyes, you accept the duelist's challenge, and a determined smile crosses your face. "Very well," you say, "I accept your offer, Vittorio de Luca. Let us make this duel one to remember {MetBefore: once more}." #STR_Accept1
Пока ваши товарищи-воины поддерживают вас криками, вы приказываете им разбить лагерь у дороги, превращая поляну в импровизированную арену. #иллюстрация: луг #STR_Accept2
Когда арена готова, вы步入 центр, ваше сердце бьётся от предвкушения. Ваши товарищи-воины собираются вокруг, образуя круг, чтобы наблюдать за состязанием, их лица выражают смесь возбуждения и гордости. #STR_Accept3
->enterArena

=deny
~ SetPlayerCustomTag("DeniedVittorio")
Выражение лица Витторио остаётся сдержанным, но в уголках его губ играет едва заметная усмешка. #STR_Deny1
«К сожалению», — отвечает он, в голосе звучит оттенок высокомерия. «Я надеялся найти кого-то достойного моего времени, но, похоже, слухи о вашем мастерстве были преувеличены.» #STR_Deny2
С видом высокомерной элегантности Витторио де Лука завершает встречу презрительным поклоном, его движения излучают неоспоримое превосходство. #STR_Deny3
->END

=enterArena
~ OpenDuelMission()
...
{PlayerWin: По мере того как схватка меча затихает, крики поддержки ваших товарищей по оружию наполняют воздух, отзываясь в эхо вашей тяжёлой победы. {SetPlayerCustomTag("DefeatedVittorio")}#STR_PlayerWin1}
{PlayerWin: Вы стоите в центре самодельной бойни, грудь вздымаясь от напряжения и триумфа. Витторио де Лука, знаменитый тилеанский фехтовальщик, протягивает руку в жесте уважения, искренняя улыбка озаряет его лицо. "Well fought," he says, his voice filled with admiration.#STR_PlayerWin2}
{PlayerWin: Дружба между вашей партией и Витторио укрепляется, когда он с великодушием вручает вам 5000 золотых монет, выполняя своё пари и признавая ваше мастерство. {GiveGold(5000)}#STR_PlayerWin3} 
{not PlayerWin: По мере завершения дуэли воздух густо наполнен смесью эмоций. Ваши товарищи по оружию наблюдают в молчаливом уважении, как Витторио де Лука, знаменитый тилеанский фехтовальщик, выходит победителем из ожесточённого состязания.#STR_PlayerLost1}
{not PlayerWin:Вы отступаете назад, признавая его мастерство кивком восхищения. Витторио стоит в центре самодельной бойни, его рапира сверкает в меркнущем свете, на его лице сияет победная улыбка. "A formidable opponent indeed," he says, his voice carrying a sense of pride in his achievement. "You fought valiantly, but this time, the victory is mine."#STR_PlayerLost2}
Витторио де Лука прощается с вашей компанией почтительным жестом. Его грациозность и элегантность слов остаются неизменными, несмотря на исход дуэли. #STR_DuelEnd
->END