# 🇷🇺 Russian Translation — The Old Realms (TOR)
### Mount & Blade II: Bannerlord | Warhammer Fantasy

A community Russian translation for **[The Old Realms](https://steamcommunity.com/sharedfiles/filedetails/?id=3025574678)** — a total conversion mod bringing the Warhammer Fantasy Old World to Bannerlord.

---

## 📊 Translation Coverage

| Category | Strings | Status |
|----------|---------|--------|
| UI, Skills, Abilities, Dialogues | ~5,000 | ✅ Done |
| Troop Definitions | 432 | ✅ Done |
| Items (Weapons, Armor, Shields) | 3,162 | ✅ Done |
| Settlements (Cities, Villages) | 2,160 | ✅ Done |
| Heroes & Lords | 751 | ✅ Done |
| Clans & Kingdoms | 556 | ✅ Done |
| Character Creation & Backstories | 296 | ✅ Done |
| Religions & Abilities | 272 | ✅ Done |
| Townspeople (all factions) | 263 | ✅ Done |
| Ink Stories (Book Quests) | 26 files | ✅ Done |
| **Total** | **~16,000+** | |

### Not Translated
- ~83 hardcoded strings in DLL (shader popups, etc.)
- Base game strings (Caravan Guard, Peasant) — these come from the Native module

---

## 📥 Installation

1. Download or clone this repository
2. Copy **both folders** into your Steam workshop directory:
   ```
   Steam/steamapps/workshop/content/261550/
   ```
   - `3025574678` → Core (UI, characters, dialogues)
   - `3025575223` → Assets (items, weapons, armor)

3. Windows will merge the contents — only Russian language files are added, original mod files are untouched.

4. Launch Bannerlord → **Options → Language → Русский** → Restart

---

## 📁 File Structure

```
3025574678/
├── InkStories/              # 26 translated book quests (.ink)
└── ModuleData/Languages/RU/
    ├── language_data.xml
    ├── str_tor_strings-rus.xml
    ├── str_tor_settlements-rus.xml
    ├── str_tor_cultures-rus.xml
    ├── str_tor_heroes-rus.xml
    ├── str_tor_troopdefinitions-rus.xml
    ├── str_tor_clans-rus.xml
    ├── str_tor_kingdoms-rus.xml
    └── ... (25+ XML files)

3025575223/
└── ModuleData/Languages/RU/
    ├── language_data.xml
    ├── str_tor_armors-rus.xml
    ├── str_tor_meleeweapons-rus.xml
    ├── str_tor_crafting_pieces-rus.xml
    ├── str_tor_other_items-rus.xml
    └── ... (8 XML files)
```

---

## ⚠️ Troubleshooting

| Problem | Solution |
|---------|----------|
| Game crashes on startup | Restore original `.ink` files from the mod's `InkStories/` folder |
| Encoding issues (hieroglyphs) | All files are UTF-8 without BOM — check your mod supports Cyrillic fonts |
| Some text still in English | These are either base game strings or DLL-hardcoded strings |
| Mod updated, translation outdated | Create an issue or PR — happy to update |

---

## 🔧 How It Works

Bannerlord uses localization tokens: `{=string_id}English text`. When a Russian translation file provides the same `string_id`, the game displays the Russian text instead. If no translation exists, English is shown as fallback.

**This translation is safe** — it only adds Russian language files without modifying any original mod files.

---

## 🤝 Contributing

Found a typo or bad translation? PRs welcome!

Edit any `*-rus.xml` file:
```xml
<string id="STRING_ID" text="Ваш перевод" />
```

---

## 📜 Credits

- **Translation**: Phoenix (@v2Phoenix)
- **Mod**: [The Old Realms](https://steamcommunity.com/sharedfiles/filedetails/?id=3025574678) by the TOR Team
- **Game**: Mount & Blade II: Bannerlord by TaleWorlds Entertainment

---

*Warhammer Fantasy and all associated names are trademarks of Games Workshop Limited.*
