# Contributing

Thanks for helping improve the Lernwelt template! The most welcome
contribution is a **translation** of the engine UI into a new language.
This guide explains exactly how.

## Translating the engine (`lernwelt.<lang>.tr`)

The engine's UI strings live in [`lernwelt/locale/`](lernwelt/locale/) and
use Luanti's built-in translation system. Each language is one file named
`lernwelt.<lang>.tr`, where `<lang>` is the
[ISO 639-1 language code](https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes)
the player's client reports (e.g. `fr`, `es`, `it`, `pt`, `pl`, `de`).

### 1. Copy the template

Start from the master template, which lists every translatable string:

```
lernwelt/locale/template.txt   ->   lernwelt/locale/lernwelt.<lang>.tr
```

For example, for French:

```bash
cp lernwelt/locale/template.txt lernwelt/locale/lernwelt.fr.tr
```

(`template.txt` is not a `.tr` file, so Luanti never tries to load it as a
translation — it stays as the master template.)

### 2. Fill in the translations

Each line has the form:

```
English source string=your translation
```

Rules:

- **Keep the left side of `=` exactly as-is** — it is the lookup key. If
  you change it, the string will no longer be found.
- **Write your translation on the right side of `=`.**
- **Keep the placeholders** `@1`, `@2`, … — they are filled in at runtime
  (numbers, names, ranks). You *may reorder* them to fit your grammar, e.g.
  `Rank: @1 | @2 rescued.` → in another language `@2 rescued | rank: @1`.
- Lines starting with `#` are comments; blank lines are ignored.
- Make sure the **first line stays** `# textdomain: lernwelt`.

Example (`lernwelt.fr.tr`):

```
# textdomain: lernwelt
Mathematics=Mathématiques
Total rescued: @1=Sauvés au total : @1
Teleport here=Se téléporter ici
```

You do not have to translate every line at once — any line left with an
empty right side simply falls back to the English source string, so partial
translations are fine and still useful.

### 3. Test it in-game

1. Put the `lernwelt` mod in a world and enable it.
2. Set your client language to your target language
   (Luanti: *Settings → General → Language*, or `language = <lang>` in
   `minetest.conf`).
3. Join the world and check the texts: the `/lernplan` and `/lernwelt`
   chat output, the learning boards, the logbook item, rank/badge messages
   and spawn-egg names.

If a string still shows in English, the most common causes are a typo in
the left-hand (key) side, a missing/wrong language code in the filename, or
a missing `# textdomain: lernwelt` header.

### 4. Keep the template in sync (maintainers)

When you add or change a `S("…")` source string in the engine code, also
add it to `lernwelt/locale/template.txt` so translators see it. You can
regenerate the template with Luanti's translation update tool
(`mod_translation_updater.py`) if you prefer.

### 5. Submit

Open a pull request that adds your `lernwelt/locale/lernwelt.<lang>.tr`
file. A one-line note in the PR mentioning the language (and the spelling
convention, if relevant — e.g. Swiss vs. standard German) is appreciated.

## Other contributions

Bug fixes, documentation improvements and new example themes are welcome
too. Please keep engine UI strings wrapped in `S("…")` so they remain
translatable, and add a note to `CHANGELOG.md` under `## [Unreleased]`.
