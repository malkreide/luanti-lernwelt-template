# Kosmo-Station 🚀

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.2,%20NMG.3-2e7d32)
![Bewegung und Sport](https://img.shields.io/badge/Bewegung%20und%20Sport-BS.2-ef6c00)
![Deutsch (Sprache)](https://img.shields.io/badge/Deutsch%20(Sprache)-D.2-c62828)
![Medien und Informatik](https://img.shields.io/badge/Medien%20und%20Informatik-MI.1-6a1b9a)

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um eine **Weltraum-Forschungsstation**. Gedacht zum **gemeinsamen Spielen von Eltern und
Kind** (ca. 5–7 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1. Zyklus**
(Natur-Mensch-Gesellschaft, Mathematik, Sprache, Medien und Informatik).

> Motto: **Entdecken · Erforschen · Helfen**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Logbuch, Ränge, Abzeichen, Rettungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebauten Extras, die die Engine nicht abbildet: den **Raumgleiter** und die
**Mond-Schwerkraft-Blöcke**.

## Funktionen

- 🪐 **6 bunte Planetenblöcke** (Mars, Sonne, Jupiter …) + 🟦 **Bullaugen-Glas** (durchsichtig)
  – glühend, ideal zum **Zählen** und für **Farben**
- 🕳️ **Schwarzes Loch** – ein Block, der Spieler sanft ansaugt (Gravitations-Sog,
  kinderfreundlich, kein Schaden) – passt zum Schwerkraft-Thema
- ☄️ **Meteoritenschauer** – fallende Meteore mit Feuerschweif (`/kosmo_meteore`); die
  gelandeten **Meteoriten** einsammeln und **zählen** (Meilensteine)
- 🌠 **Sternschnuppen** – huschen gelegentlich am Himmel vorbei (Atmosphäre, „wünsch dir was")
- ☀️ **Leuchtende Sonne** – ein hell strahlender Sonnenblock + `/kosmo_sonne` baut eine
  kleine Sonnenkugel als Lichtquelle
- 🌑 **Mond-Schwerkraft** – das Highlight: stell dich auf einen Block und verändere, wie du
  dich bewegst:
  - **Mond-Boden** → leichte Schwerkraft, du springst federleicht und hoch
  - **Sprung-Pad (Trampolin)** → katapultiert dich nach oben
  - **Schwerelos-Feld** → du schwebst fast wie im All
  - **Schwerkraft-Normal** → zurück zur normalen Schwerkraft
- 🎨 **Gemusterte Bau-Blöcke** (Sternenhimmel, Streifen, Punkte, Schachbrett, Rahmen,
  Raketen-Rumpf, Steuerpult, Solarpanel, Mondgestein, Asteroid, Sternenstaub, Ringplanet)
  – Muster rein prozedural, ganz ohne Bilddateien
- 📦 **Vorratskiste** mit echtem Deckel (Pro-Seiten-Textur: Bild oben, Metall an den Seiten)
- 🔤 **Buchstaben-Blöcke A–Z** zum Wörterlegen (passt zu „Deutsch / benennen")
- 🗺️ **4 Lern-Zonen** (Bunte Planeten, Asteroidengürtel, Sternennebel-Höhle, Mond-Basis) mit
  platzierbaren Lern-Tafeln (Aktivität + Lehrplan-21-Bezug)
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (zählen, vergleichen, benennen, Farben), **Muster
  nachlegen** (Farb-Reihen **und** die Raketen-**Start-Reihenfolge**, MI/„Missionsreihenfolge")
  und Rette-Ziele mit Belohnung; zählen für `/lernfortschritt`
- 📋 **Stern-Logbuch** – Steckbriefe mit Rettungs-Zähler und „entdeckt"-Status
- 📷 **Entdecker-Kamera** – Weltraum-Freunde fotografieren = im Logbuch entdecken (Sammeln,
  getrennt vom Retten)
- 👽 **14 rettbare Weltraum-Freunde** (mit Mob-API): Grüner Alien, Marsmännchen,
  Weltraum-Katze, Plasma-Vogel, Mini-UFO, Asteroiden-Krabbe, Satellit Robi, Mini-Roboter,
  verirrter Astronaut, Mond-Hase, Weltraum-Qualle, Sternen-Wesen, Nebel-Schweber – plus den
  seltenen, magischen **Goldenen Kometen** 🌟
- 👪 **Familien** – wer ein Elterntier rettet (Marsmännchen, Weltraum-Katze, Mond-Hase),
  bringt seine Jungen mit
- 🛰️ **Lebendige Station** – die Freunde erscheinen automatisch auf festem Boden in deiner
  Nähe (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`)
- 🧹 **Orbit aufräumen** – Weltraumschrott einsammeln macht den Orbit sauberer
  (Zähler + Meilensteine)
- ⭐ **Sterne pflanzen** – Stern-Samen wachsen zu Planeten/Sternen, eigener Galaxie-Zähler
- 🚀 **Raumgleiter** mit Upgrades – Triebwerk-Glühen, Flammenspur, **Doppelsitz** für
  Eltern + Kind
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Raumgleiter, Planeten,
  Schwerkraft-Blöcke, Stern-Samen und je ein Spawn-Ei (abschaltbar per Einstellung)
- 🏆 **Ränge und Abzeichen**: Anwärter → Kadett → Pilot → Commander → Sternen-Kapitän
- 🔊 **Sound-Hooks** – Rettungs-/Rang-Sounds aus der Engine, Triebwerk-, Sprung- und
  Ambient-/Funk-Sounds aus diesem Thema

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Freunden.

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_kosmo` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_kosmo`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Passende Welt

Anders als bei der Tiefsee braucht die Kosmo-Station **kein Wasser**. Du baust deine
**Raumstation** am besten selbst – mit Stations-Wand, Bullaugen-Glas und Planeten. Wie du
eine passende, flache Welt mit viel Platz und freiem Blick einrichtest, steht in
**[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**. Der schnellste Weg: im Spiel `/kosmo_basis`
eingeben – eine fertige Kuppel-Station erscheint vor dir.

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung**
ins Inventar: Stern-Logbuch, Kamera, Raumgleiter, Planetenblöcke + Bullaugen-Glas, die
**Schwerkraft-Blöcke**, Stern-Samen und ein Spawn-Ei pro Weltraum-Freund. Damit kannst du
sofort losforschen. Im Kreativ-Modus liegen alle Items zusätzlich im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_kosmo_starter_kit = false` setzen.

## Steuerung des Raumgleiters

Platzieren → Rechtsklick zum Einsteigen → **W/S** fliegen, **A/D** lenken,
**Springen** = hoch, **Schleichen** = runter, **Rechtsklick** = aussteigen.

## Nützliche Befehle

- `/kosmo_teststation` – baut eine kleine fertige Test-Station vor dir (Metallboden,
  alle 4 Lern-Tafeln, ein Raumgleiter, ein Mond-Boden mit Sprung-Pad, etwas Schrott).
  Benötigt das `server`-Privileg (im Einzelspieler automatisch vorhanden); überschreibt
  die Blöcke am Bauort.
- `/kosmo_basis` – baut eine **grössere** Glaskuppel-Station mit Tür, Tafeln, Raumgleiter,
  Mond-Boden/Sprung-Pad und Schrott (Priv `server`)
- `/kosmo_schrott` – verteilt etwas Weltraumschrott zum Aufräumen um dich herum (Priv `server`)
- `/kosmo_meteore` – löst einen Meteoritenschauer über dir aus (zum Sammeln/Zählen) (Priv `server`)
- `/kosmo_sonne` – baut eine kleine leuchtende Sonne über dir (Priv `server`)
- `/lernfortschritt` – dein persönlicher Lernfortschritt: Rang, Rettungen, gelöste
  Aufgaben, getroffene Freunde und berührte Lernbereiche (aus der Engine)
- `/lernplan` – Übersicht aller Lern-Zonen und ihrer Lehrplan-21-Bezüge (aus der Engine)
- `/lernwelt` – Status + empfohlene `minetest.conf`-Zeilen (aus der Engine)

## Eigene Grafiken und Sounds

Das Thema läuft **ohne externe Dateien** (Farben via `[fill`-Generator der Engine).
Eigene Texturen/Sounds können ergänzt werden – siehe `textures/README.txt`
und `sounds/README.txt`. **Bitte nur selbst erstellte oder frei lizenzierte
Inhalte verwenden.**

## Lizenz

- **Code:** MIT – siehe [LICENSE.txt](LICENSE.txt)
- **Mitgelieferte Medien:** keine (alle Farben werden zur Laufzeit erzeugt)

## Rechtlicher Hinweis

Dies ist ein **eigenständiges Werk**. Es ist **nicht** mit einer Fernsehserie,
Marke oder einem Unternehmen verbunden und verwendet **keine** geschützten Namen,
Figuren, Logos oder Designs. Die allgemeine Spielidee „Weltraum-Forschungsstation"
sowie echte Himmelskörper-Namen (Mars, Jupiter, Saturn …) sind nicht schutzfähig.
