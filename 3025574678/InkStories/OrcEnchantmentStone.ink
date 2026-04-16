//Global story tags
# title: 'Ow to make speshul fings
# frequency: Special
# development: false
# illustration: gs_enchant_tablet_1

INCLUDE include.ink

->START

===START===
#illustration: gs_enchant_tablet_1
You'z got yerself a flat stone wiv piktures on it. Dis side shows some shinee fings an' squiggly lines - looks like magic stuff, innit? 
+ [Переверни этот чертов палец]->SecondSide
+ [Безмозглый палец, убирайся отсюда]->END

===SecondSide===
#illustration: gs_enchant_tablet_2
Turned it o'er, ya did! Dis side's got different piktures - more shinee bits an' some proppa choppa at da end wiv sparkles on it! 
+ [ПЕРЕВЕРНИ ЭТОТ ЧЕРТОВ ПАЛЕЦ СНОВА]->ThirdSide
+ [Безмозглый палец, убирайся отсюда]->END

===ThirdSide===
#illustration: none
You'z lookin' fer sumfin'? Stone carvin' can't 'ave 3 sides, ya git! 

+ [ПЕРЕВЕРНИ ЭТОТ ЧЕРТОВ ПАЛЕЦ СНОВА]->START
+ [Безмозглый палец, убирайся отсюда]->END