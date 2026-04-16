РУССКИЙ ПЕРЕВОД ДЛЯ МОДА The Old Realms (TOR) — Mount & Blade II: Bannerlord
=============================================================================
Автор перевода: Phoenix (@v2Phoenix)

СТАТИСТИКА
----------
Переведено: ~16 000 строк
  - UI, навыки, способности, диалоги
  - Войска (432 юнита)
  - Предметы, оружие, доспехи (3 162)
  - Поселения, города, деревни (2 160)
  - Герои, кланы, королевства
  - Книжные квесты (Ink Stories, 26 файлов)
  - Создание персонажа, бэкстори

КАК УСТАНОВИТЬ
--------------
1. Откройте папку мода в Steam:
     Steam\steamapps\workshop\content\261550\

2. Скопируйте ДВЕ папки из этого архива ПОВЕРХ одноимённых:
       3025574678  (Core)
       3025575223  (Assets)

   Windows объединит содержимое — будут добавлены файлы перевода,
   оригинальные файлы мода не затронутся.

3. Запустите Bannerlord → Настройки → Язык → Русский.
   Может потребоваться перезапуск игры.

СТРУКТУРА ПАКЕТА
----------------
3025574678\ModuleData\Languages\RU\
    language_data.xml               — объявление русского языка
    str_tor_strings-rus.xml         — UI, навыки, способности, диалоги (~5 000 строк)
    str_tor_settlements-rus.xml     — города и деревни (~2 100 строк)
    str_tor_cultures-rus.xml        — имена персонажей
    str_tor_heroes-rus.xml          — герои
    str_tor_clans-rus.xml           — кланы
    str_tor_kingdoms-rus.xml        — королевства
    str_tor_religions-rus.xml       — религии
    str_tor_troopdefinitions-rus.xml — войска (432 юнита)
    str_tor_abilitytemplates-rus.xml — способности
    str_tor_ror_settlement_templates-rus.xml
    str_tor_campaign_lords-rus.xml
    str_tor_charactertemplates-rus.xml
    str_tor_townspeople_*.xml       — горожане (11 файлов по фракциям)
    str_tor_voiced_strings-rus.xml
    str_tor_concept_strings-rus.xml
    str_tor_lords-rus.xml

3025574678\InkStories\
    26 переведённых книжных квестов (.ink)

3025575223\ModuleData\Languages\RU\
    language_data.xml
    str_tor_armors-rus.xml          — доспехи (778)
    str_tor_meleeweapons-rus.xml    — ближнее оружие (242)
    str_tor_rangedweapons-rus.xml   — дальнобойное (55)
    str_tor_shields-rus.xml         — щиты (119)
    str_tor_projectiles-rus.xml     — снаряды (23)
    str_tor_horseandharness-rus.xml — кони и упряжь (54)
    str_tor_crafting_pieces-rus.xml — крафт (577)
    str_tor_other_items-rus.xml     — прочие предметы (1 369)

ЧТО НЕ ПЕРЕВЕДЕНО
------------------
- ~83 строки из DLL мода (шейдеры и пр.) — требуют патча бинарника
- Строки базовой игры (Caravan Guard, Peasant) — из модуля Native
- Книжные квесты могут вызывать краш — если игра падает при запуске,
  верните оригинальные .ink файлы из папки мода в InkStories\

КАК ЭТО РАБОТАЕТ
-----------------
Bannerlord использует систему токенов {=id}English text.
Если для выбранного языка есть перевод с тем же id — показывается он,
иначе — английский текст по умолчанию.

Установка безопасна: она только добавляет русский язык,
английский продолжает работать.

КАК ДОПОЛНИТЬ ПЕРЕВОД
---------------------
Откройте нужный *-rus.xml и добавьте / отредактируйте строку:
   <string id="ID" text="Ваш перевод" />

ID берётся из оригинального файла мода (часть после "{=" в атрибуте text).
