# Installation — Schritt für Schritt 🪟🍎🐧🌊

Diese Anleitung zeigt, wie du das **Luanti Lernwelt Template** und das Thema
**`lernwelt_tiefsee`** (Tiefsee-Retter) installierst, sodass **alle Funktionen** laufen —
Tiere, Lern-Tafeln, Tauchkapsel und Startausrüstung. Es gibt einen eigenen
Installations-Abschnitt für **Windows 11**, **macOS (Apple)** und **Linux**; die übrigen
Schritte sind auf allen Systemen gleich.

> 🇬🇧 An English version of the general setup is in [README.md](README.md).
> · 🐙 Die vollständige Spielanleitung steht in
> [`lernwelt_tiefsee/ANLEITUNG.md`](lernwelt_tiefsee/ANLEITUNG.md).

---

## 1. Luanti installieren

Du brauchst zuerst **Luanti 5.x** (früher „Minetest" genannt). Wähle dein System:

### 🪟 Windows 11

- **Empfohlen (am einfachsten):** Microsoft Store öffnen → nach **„Luanti"** suchen →
  installieren. Alternativ über die offizielle Seite **[luanti.org](https://www.luanti.org)**
  den Windows-Download holen.
- Beim Download von luanti.org bekommst du eine ZIP-Datei. Entpacke sie z. B. nach
  `C:\Games\luanti\`. Gestartet wird mit `luanti.exe` im Ordner `bin`.

### 🍎 macOS (Apple)

- **Empfohlen:** Auf **[luanti.org](https://www.luanti.org)** den macOS-Download holen
  (eine `.dmg`-Datei, läuft sowohl auf Apple-Silicon- als auch auf Intel-Macs).
- DMG öffnen und **Luanti.app** in den Ordner **Programme** ziehen. Per Doppelklick
  starten.
- Beim ersten Start meldet sich macOS evtl. mit „App von unbekanntem Entwickler". Dann
  **Rechtsklick auf die App → „Öffnen"** und bestätigen (oder unter
  **Systemeinstellungen → Datenschutz & Sicherheit** freigeben).
- Alternativ per Homebrew: `brew install --cask minetest` (Paketname kann je nach
  Version `minetest` oder `luanti` heißen).

### 🐧 Linux

- **Empfohlen:** Über **Flatpak** (funktioniert auf allen Distributionen):
  ```bash
  flatpak install flathub net.minetest.Minetest
  flatpak run net.minetest.Minetest
  ```
- Oder über den Paketmanager deiner Distribution:
  - Debian/Ubuntu: `sudo apt install minetest`
  - Fedora: `sudo dnf install minetest`
  - Arch: `sudo pacman -S minetest`
- Hinweis: Distributions-Pakete sind manchmal älter. Wenn dein Luanti unter 5.x liegt,
  nimm lieber Flatpak oder das offizielle AppImage von [luanti.org](https://www.luanti.org).

## 2. Ein passendes Game installieren

Das Template ist nur die Lern-Mechanik — es braucht ein **Basis-Game** darunter. Für
die Tiefsee-Welt wird **VoxeLibre** oder **Mineclonia** empfohlen, weil diese die
Tier-API (`mcl_mobs`) für die lebenden Meerestiere schon mitbringen.

1. Luanti starten → Reiter **„Inhalt" / „Content"** → **„Online-Inhalte durchsuchen"**
   (ContentDB).
2. Oben den Filter auf **„Games"** stellen, nach **VoxeLibre** suchen und **installieren**.
3. (Minetest Game mit `mobs_redo` geht auch, aber VoxeLibre/Mineclonia ist die
   einfachere Wahl.)

Dieser Schritt ist auf allen Systemen identisch (ContentDB lädt direkt im Spiel).

## 3. Die beiden Mods herunterladen

Du brauchst **zwei Ordner** aus dem Repository: die Engine `lernwelt` **und** das Thema
`lernwelt_tiefsee`. Beide stecken im selben GitHub-Repo.

1. Gehe auf <https://github.com/malkreide/luanti-lernwelt-template>
2. Grüner Button **„Code" → „Download ZIP"**.
3. Entpacke die ZIP. Du erhältst einen Ordner `luanti-lernwelt-template-main` mit u. a.
   diesen Unterordnern:
   - `lernwelt` ← die Engine (**Pflicht**)
   - `lernwelt_tiefsee` ← das Tiefsee-Thema (das willst du spielen)
   - `lernwelt_kosmo` ← optionales Weltraum-Thema (Kosmo-Station, mit Mond-Schwerkraft)
   - `lernwelt_beispiel` ← optionales zweites Beispiel-Thema (Glühpilz-Wald)

> Diese Anleitung beschreibt die **Tiefsee**-Welt; die **Kosmo-Station** wird genauso
> installiert (Engine `lernwelt` + Thema `lernwelt_kosmo` aktivieren). Sie braucht
> **kein Wasser** — Details in [`lernwelt_kosmo/WELT-EINRICHTEN.md`](lernwelt_kosmo/WELT-EINRICHTEN.md).

Auf Linux/macOS geht das auch im Terminal:
```bash
git clone https://github.com/malkreide/luanti-lernwelt-template.git
```

## 4. Die Mods in den richtigen Ordner kopieren

Luanti sucht Mods in deinem Benutzer-Ordner. Der Pfad unterscheidet sich je nach System.
Kopiere die **zwei Ordner** `lernwelt` und `lernwelt_tiefsee` dorthin.

### 🪟 Windows 11

Öffne den Explorer und gib in die Adressleiste ein:
```
%APPDATA%\Luanti\mods
```
> **Pfad-Hinweis:** Existiert `%APPDATA%\Luanti` nicht, probiere `%APPDATA%\Minetest\mods`.
> Bei der portablen ZIP-Version liegt der Mods-Ordner direkt im entpackten Luanti-Ordner:
> `…\luanti\mods`. Welcher Pfad gilt, zeigt Luanti unter **Einstellungen** an.

Ergebnis:
```
%APPDATA%\Luanti\mods\lernwelt\
%APPDATA%\Luanti\mods\lernwelt_tiefsee\
```

### 🍎 macOS (Apple)

Der Mods-Ordner liegt im versteckten `Library`-Ordner:
```
~/Library/Application Support/minetest/mods
```
Im Finder erreichst du ihn über **„Gehe zu" → „Gehe zu Ordner…"** (⇧⌘G) und Einfügen des
Pfads. Oder im Terminal:
```bash
mkdir -p ~/Library/Application\ Support/minetest/mods
cp -R lernwelt lernwelt_tiefsee ~/Library/Application\ Support/minetest/mods/
```
> Falls du Luanti per Homebrew/neuere Version installiert hast, kann der Ordner
> `~/Library/Application Support/Luanti/mods` heißen — der in Luanti unter
> **Einstellungen** angezeigte Pfad gilt.

### 🐧 Linux

Bei einer normalen Installation:
```
~/.minetest/mods
```
Im Terminal:
```bash
mkdir -p ~/.minetest/mods
cp -R lernwelt lernwelt_tiefsee ~/.minetest/mods/
```
> **Flatpak-Hinweis:** Bei der Flatpak-Version liegt der Pfad stattdessen unter
> `~/.var/app/net.minetest.Minetest/.minetest/mods`. Neuere Versionen nutzen evtl.
> `~/.local/share/luanti/mods` — der in Luanti angezeigte Pfad gilt.

> ⚠️ **Auf allen Systemen wichtig:** Es muss direkt `mods/lernwelt/init.lua` geben —
> **nicht** `mods/lernwelt/lernwelt/init.lua`. Falls beim Entpacken ein doppelter Ordner
> entsteht, eine Ebene hochziehen.

## 5. Wasserreiche Welt vorbereiten (VOR dem Erstellen!)

Die Meerestiere schwimmen nur in **Wasser**. Stelle deshalb **vor** dem Erstellen der
Welt eine wasserreiche Karte ein. Diese Mapgen-Werte werden beim Welt-Erstellen fest
geschrieben und lassen sich danach **nicht mehr ändern**.

Öffne die Datei `minetest.conf` (über **Einstellungen → erweitert** im Spiel, oder direkt
in deinem Benutzer-Ordner — siehe Schritt 4) und trage diese Zeilen ein — Variante
„Flaches Meer" (empfohlen zum Testen):

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
- **Mods werden nicht angezeigt:** Prüfe die Ordnerstruktur (`mods/lernwelt/init.lua`
  direkt, kein doppelter Ordner) und ob du den richtigen Mods-Ordner getroffen hast (der
  in Luanti unter **Einstellungen** angezeigte Pfad ist maßgeblich).
- **macOS – App startet nicht:** Rechtsklick auf die App → „Öffnen" (Gatekeeper-Freigabe).
- **Linux – falscher Mods-Ordner bei Flatpak:** Pfad unter
  `~/.var/app/net.minetest.Minetest/.minetest/mods` verwenden.

---

Viel Spaß beim Entdecken, Helfen und Bewahren! 🐙🌊
