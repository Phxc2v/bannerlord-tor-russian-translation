//Global story tags
# title: Da Boss Awakens
# frequency: Special
# development: false
# illustration: orc_boss_career_2

INCLUDE include.ink

//Variables setup
VAR QuestToStart = ""

->START

===START===
Приходит внезапно, почти не мысль, почти не чувство. Что-то ближе к инстинкту. Сердце бешено колотится. Внутри тебя что-то бурлит: азарт. Спешка. Нужно двигаться. Нужно УБИВАТЬ.

Голос шепчет, а потом рычит. Он подталкивает тебя вперёд.

“Bigga… betta… stronga… kill… KILL… WAAAAAAAAAAAAAGH!”

Знак богов? Голос ведёт тебя, гонит тебя. Игнорировать его — значит призвать ярость самого Горка и Морка.

Тебя выбрали. ТЕБЯ. Дана возможность доказать себя перед богами.
Ты должен встать. Встречать вызовы. Разбивать всё. Но главное — ты должен УБИВАТЬ.

+ [LET’S DO DIS!]
    ~ StartQuest("Quests.Careers.OrcBossQuest1")
    ~ CloseStory()
    -> END

    
    