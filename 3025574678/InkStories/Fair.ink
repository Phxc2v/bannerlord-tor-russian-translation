//Global story tags
# title: A Fair in the Woods
# frequency: Uncommon
# development: false
# illustration: trader

INCLUDE include.ink

VAR HorsePrice = 2000
VAR FoodPrice = 10
VAR HorseBetPrice = 500
VAR HorseBetPayout = 2500
VAR WinHorseRace = 0
    ~ WinHorseRace = RANDOM(0,1)
VAR TurnipPrice = 50

-> Start

===Start===




Пока ваша армия движется вперёд, внезапная поляна открывает удивительную картину — шумный праздник, известный как Моррслиевский Карнавал. Шатры возвышаются гордо, цвета танцуют в пятнистом солнечном свете. Смех перемешивается с ржанием лошадей, сердце этого радостного собрания. #STR_Start1

Торговцы зовут, их глаза горят хитростью, предлагая лошадей со скидкой по сравнению с обычными ценами, указанными в свитках. Воздух наполнен соблазнительными ароматами жареного мяса, пенистого эля и кисловатого вина. Среди весёлой толпы фермер улыбается, предлагая репу, странно напоминающую знаменитую двухогонную комету. За копейку — шанс обладать этим любопытным чудом. #STR_Start2
    ->choices

    =choices
    * [Присоединяйтесь к толпе на лошадином рынке.]->HorseStalls 
    * [Насладитесь вкусами праздника.]->FoodStalls
    * [Проверьте свою удачу на скачках.]->HorseRaces
    * [Изучите странную свеклу.]->Turnip
    * [Продолжайте свой путь через лес.]->Leave

===HorseStalls===
Сердце ярмарки бьётся сильнее всего на лошадином рынке. Гордые жеребцы скачут, их глаза полны дикой ярости. Одна лошадь особенно привлекает ваше внимание. У неё гладкая чёрная шерсть, которая блестит на солнце, а в её глазах словно читается мудрость. #STR_HorseStalls1
    ->choices

    =choices
    + [Примите предложение торговца за лошадь. ({HorsePrice} золотых)]->BuyHorse
    * [Убедите торговца снизить цену. {print_player_skill_chance("Чарм",150)}]->PersuadeMerchant
    * [Вернись в сердце ярмарки.]->Start.choices

===BuyHorse===
{HasEnoughGold(HorsePrice): You strike a deal with the merchant. You exchange coins for a sturdy saddle and reins. With a surge of anticipation, you mount the horse. The connection between you is immediate, the horse seems to respond to your touch with trust and eagerness. {GiveGold(-HorsePrice)} {GiveItem("t2_empire_horse",1)} | You don't have enough gold. #STR_BuyHorse1NOTENOUGHGOLD }  #STR_BuyHorse1

* [Вернись к веселью]->Start.choices

===PersuadeMerchant===
{perform_player_skill_check("Charm",150): -> success | -> fail}

    =success
    Твои слова творят чудеса, и купец соглашается снизить цену на 50%. Купец ворчит, но уважает твои навыки торга. #STR_PersuadeMerchant_Success
    ~HorsePrice = 1000
    ->HorseStalls.choices

    =fail
    Несмотря на все твои попытки торговаться, купец остаётся непреклонным в цене. #STR_PersuadeMerchant_Fail
    ->HorseStalls.choices
    

===FoodStalls===
Ароматы кружатся и манят, ведя вас к пиршеству вкусов. Мясо шипит, а эль пенится — карнавал для чувств. Еды предостаточно, и решение за вами: участвовать или нет. #STR_FoodStalls1

* [Покормите себя угощениями ярмарки. ({FoodPrice} золотых)]->BuyFood
* [Продолжайте, устояв перед искушением.]->Start

===BuyFood===
{HasEnoughGold(FoodPrice): Indulgence wins. You feast, the fair's flavors a delightful symphony on your tongue. Merchants nod their approval as you partake. {GiveGold(-FoodPrice)} | You don't have enough gold. #STR_BuyFood1NOTENOUGHGOLD}#STR_BuyFood1

* [Вернитесь к веселью.]->Start.choices

===HorseRaces===
Cheers erupt from an amphitheater. Horses thunder, riders urging them to glory. #STR_HorseRaces
->choices

    =choices
    * [Place a wager on a racing horse. ({HorseBetPrice} gold - payout 5x on win)]->PlaceBet
    * [You decide that you shouldn't test your luck.]->Start.choices

===PlaceBet===
{not HasEnoughGold(HorseBetPrice): You don't have enough gold. #STR_PlaceBet_NOTENOUGHGOLD -> HorseRaces.choices } 
~GiveGold(-HorseBetPrice)
{WinHorseRace: ->success | ->fail}
    =success
    Your heart races as you place your wager. The horse you chose surges forward, and luck dances in your favor. Laughter and clinking coins surround you. #STR_PlaceBet_Success
    ~ GiveGold(HorseBetPayout)
    * [Вернись к весёлой толпе.]->Start.choices

    =fail
    Your heart races as you place your wager. The horse you chose quickly surges forward at first, but the other riders soon catch up. Eventually, your horse slows down to the point of only earning a late place. Laughter and clinking coins surround you.
        #STR_PlaceBet_Fail
    * [Вернись к весёлой толпе.]->Start.choices

===Turnip===
Схемы тянут за ваши чувства, когда вы смотрите на кометовидную репу — причудливое чудо. Фермер улыбается, приглашая вас принять участие в лотерее. #STR_Turnip1
    ->choices

    =choices
    * [Попробуйте удачу с билетом лотереи. ({TurnipPrice} золотых)]->BuyTicket
    * [Используйте своё восприятие, чтобы найти скрытые подсказки о репе. {print_player_skill_chance("Рогерия", 80)}]->PerceiveTurnip
    * [Продолжайте путь, оставив любопытную репу позади.]->Start.choices

===BuyTicket===
{HasEnoughGold(TurnipPrice): With a coin and a smile, you secure your chance at the raffle. Who knows? The comet-kissed turnip might be yours after all. {GiveGold(-TurnipPrice)} | You don't have enough gold. #STR_BuyTicket1NOTENOUGHGOLD  -> Turnip.choices}  #STR_BuyTicket1

В воздухе витает предвкушение, и лотерея начинается. Когда ведущий называет выигрышный номер билета, вы задерживаете дыхание. Однако на этот раз удача не на вашей стороне. Выигрышный номер вам не принадлежит, и вас охватывает чувство разочарования. #STR_BuyTicket2

* [Вернитесь к весёлой тусовке.]->Start.choices

=== PerceiveTurnip ===
{perform_player_skill_check("Roguery", 80): -> success | ->fail}

    =success
    Ваше острое зрение замечает детали, которые могут ускользнуть от других. На тыкве нет никаких странных отметин, указывающих на её значимость. Она совершенно обычная.   #STR_PerceiveTurnip_Success
    ->Turnip.choices
    
    =fail
    Ваш осмотр не выявляет ничего необычного в тыкве. #STR_PerceiveTurnip_Success
    ->Turnip.choices

===Leave===
Пока веселье ярмарки угасает, вы возвращаетесь в объятия дикой природы, оставляя позади смех гуляющих. #STR_Leave1
->END
