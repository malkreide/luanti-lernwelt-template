# Installation auf Windows 11 — Schritt für Schritt 🪟🌊

Diese Anleitung zeigt, wie du das **Luanti Lernwelt Template** und das Thema
**`lernwelt_tiefsee`** (Tiefsee-Retter) auf einem Windows-11-PC installierst, sodass
**alle Funktionen** laufen — Tiere, Lern-Tafeln, Tauchkapsel und Startausrüstung.

> 🇬🇧 An English version of the general setup is in [README.md](README.md).
> · 🐙 Die vollständige Spielanleitung steht in
> [`lernwelt_tiefsee/ANLEITUNG.md`](lernwelt_tiefsee/ANLEITUNG.md).

---

## 1. Luanti installieren

Du brauchst zuerst **Luanti 5.x** (früher „Minetest" genannt):

- **Empfohlen (am einfachsten):** Microsoft Store öffnen → nach **„Luanti"** suchen →
  installieren. Alternativ über die offizielle Seite **[luanti.org](https://www.luanti.org)**
  den Windows-Download holen.
- Beim Download von luanti.org bekommst du eine ZIP-Datei. Entpacke sie z. B. nach
  `C:\Games\luanti\`. Gestartet wird mit `luanti.exe` im Ordner `bin`.

## 2. Ein passendes Game installieren

Das Template ist nur die Lern-Mechanik — es braucht ein **Basis-Game** darunter. Für
die Tiefsee-Welt wird **VoxeLibre** oder **Mineclonia** empfohlen, weil diese die
Tier-API (`mcl_mobs`) für die lebenden Meerestiere schon mitbringen.

1. Luanti starten → Reiter **„Inhalt" / „Content"** → **„Online-Inhalte durchsuchen"**
   (ContentDB).
2. Oben den Filter auf **„Games"** stellen, nach **VoxeLibre** suchen und **installieren**.
3. (Minetest Game mit `mobs_redo` geht auch, aber VoxeLibre/Mineclonia ist die
   einfachere Wahl.)

## 3. Die beiden Mods herunterladen

Du brauchst **zwei Ordner** aus dem Repository: die Engine `lernwelt` **und** das Thema
`lernwelt_tiefsee`. Beide stecken im selben GitHub-Repo.

1. Gehe auf <https://github.com/malkreide/luanti-lernwelt-template>
2. Grüner Button **„Code" → „Download ZIP"**.
3. Entpacke die ZIP (z. B. auf den Desktop). Du erhältst einen Ordner
   `luanti-lernwelt-template-main` mit u. a. diesen Unterordnern:
   - `lernwelt` ← die Engine (**Pflicht**)
   - `lernwelt_tiefsee` ← das Tiefsee-Thema (das willst du spielen)
   - `lernwelt_beispiel` ← optionales zweites Beispiel-Thema (Glühpilz-Wald)

## 4. Die Mods in den richtigen Ordner kopieren

Luanti sucht Mods in deinem Benutzer-Ordner. Öffne den Windows-Explorer und gib in die
Adressleiste ein:

```
%APPDATA%\Luanti\mods
```

> **Hinweis zum Pfad:** Bei der Microsoft-Store-Version kann der Pfad abweichen — wenn
> `%APPDATA%\Luanti` nicht existiert, probiere `%APPDATA%\Minetest\mods`. Bei der
> portablen ZIP-Version liegt der Mods-Ordner direkt im entpackten Luanti-Ordner:
> `…\luanti\mods`. Welcher Pfad bei dir gilt, zeigt Luanti unter **Einstellungen** an.

Kopiere jetzt aus dem entpackten GitHub-Ordner diese **zwei Ordner** komplett dorthin:

```
%APPDATA%\Luanti\mods\lernwelt\
%APPDATA%\Luanti\mods\lernwelt_tiefsee\
```

> ⚠️ **Wichtig:** Es muss direkt `mods\lernwelt\init.lua` geben — **nicht**
> `mods\lernwelt\lernwelt\init.lua`. Falls beim Entpacken ein doppelter Ordner
> entsteht, eine Ebene hochziehen.

## 5. Wasserreiche Welt vorbereiten (VOR dem Erstellen!)

Die Meerestiere schwimmen nur in **Wasser**. Stelle deshalb **vor** dem Erstellen der
Welt eine wasserreiche Karte ein. Diese Mapgen-Werte werden beim Welt-Erstellen fest
geschrieben und lassen sich danach **nicht mehr ändern**.

Öffne `minetest.conf` (über **Einstellungen → erweitert**, oder direkt
`%APPDATA%\Luanti\minetest.conf`) und trage diese Zeilen ein — Variante „Flaches Meer"
(empfohlen zum Testen):

```
mg_name = flat
mgflat_ground_level = 2
water_level = 14
```

Das ergibt überall ~12 Blöcke tiefes Wasser — ideal für Kinder. Mehr Varianten
(natürlicher Ozean, Mini-Becken) in
[`lernwelt_tiefsee/WELT-EINRICHTEN.md`](lernwelt_tiefsee/WELT-EINRICHTEN.md).

## 6. Welt erstellen und Mods aktivieren

1. Luanti starten → Reiter **„Start / Play" → „Neue Welt"**.
2. Als Game **VoxeLibre** (oder Mineclonia) wählen, Namen vergeben, erstellen.
3. Welt markieren → **„Mods auswählen / Configure"** → beide anhaken:
   - ✅ **`lernwelt`**
   - ✅ **`lernwelt_tiefsee`**
4. Speichern.

## 7. Spielen — so läuft alles

Welt betreten:

- Beim **ersten Betreten** bekommst du automatisch die **Startausrüstung** (Logbuch,
  Kamera, Tauchkapsel, Korallen-Setzlinge, Spawn-Eier).
- Befehl **`/tiefsee_basis`** → eine fertige Station mit Lern-Tafeln und Tauchkapsel
  erscheint vor dir.
- Befehl **`/tiefsee_teststation`** → kleinere Test-Station mit Müll zum Aufräumen.
- **Rechtsklick** = Tier retten / Tafel öffnen / einsteigen.
  **Linksklick** = fotografieren / Müll & Blöcke abbauen.
- Spawn-Ei in die Hand → **Rechtsklick ins Wasser** = Tier setzen.

Nützliche Befehle: `/lernwelt` (Status + empfohlene Config), `/lernplan`
(Lernziele-Übersicht), `/lernfortschritt` (persönlicher Bericht).

---

## Optionale Einstellungen

Unter **Einstellungen → Alle Einstellungen → Mods** (oder in `minetest.conf`):

| Einstellung | Standard | Wirkung |
|---|---|---|
| `lernwelt_spawn_creatures` | an | Tiere erscheinen automatisch im Wasser |
| `lernwelt_tiefsee_starter_kit` | an | Startausrüstung beim ersten Join |
| `lernwelt_big_text` | aus | Größere Schrift auf den Lern-Tafeln |
| `lernwelt_easy_mode` | aus | Quiz mit nur 2 Antworten |
| `lernwelt_show_hud` | an | Fortschritts-Anzeige oben links |

## Häufige Stolpersteine

- **Tiere zappeln an Land / verschwinden:** Sie brauchen Wasser → ans Meer gehen oder
  ein Becken bauen. Deshalb Schritt 5 nicht überspringen.
- **Tiere erscheinen nicht automatisch:** `lernwelt_spawn_creatures` muss an sein **und**
  es braucht ein Game mit Mob-API (VoxeLibre/Mineclonia oder Minetest Game + `mobs_redo`).
  Mit Spawn-Eiern kannst du Tiere aber jederzeit selbst setzen.
- **Kein Ton:** Sound-Dateien sind optional — ohne sie läuft alles, nur leise.
- **Mods werden nicht angezeigt:** Prüfe die Ordnerstruktur (`mods\lernwelt\init.lua`
  direkt, kein doppelter Ordner) und ob du den richtigen Mods-Ordner getroffen hast.

---

Viel Spaß beim Entdecken, Helfen und Bewahren! 🐙🌊
