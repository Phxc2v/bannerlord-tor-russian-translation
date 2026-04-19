//Global story tags
# title: Как делаца всякия штуки
# frequency: Special
# development: false
# illustration: gs_enchant_tablet_1

INCLUDE include.ink

->START

===START===
#illustration: gs_enchant_tablet_1
У тебя в лапах плоский камень с чёрканьем на нём. С этой стороны какие-то блестящие штуковины и кривые линии — шибко смахивает на магию, а?
+ [Переверни камешек]->SecondSide
+ [Бесполезная фиговина, кидай]->END

===SecondSide===
#illustration: gs_enchant_tablet_2
Перевернул! Теперь видно другую сторону — ещё черкотни, больше блеску, а в конце чё-то вроде меча с искрами!
+ [Переверни камешек ещё раз]->ThirdSide
+ [Бесполезная фиговина, кидай]->END

===ThirdSide===
#illustration: none
Чё шаришь-то? У камня три стороны не бывает, башка твоя дырявая!

+ [Переверни камешек ЕЩЁ РАЗ]->START
+ [Бесполезная фиговина, кидай]->END
