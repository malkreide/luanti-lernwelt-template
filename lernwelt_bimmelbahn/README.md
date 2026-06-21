# Bimmelbahn-Land 🚂

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![Bildnerisches Gestalten](https://img.shields.io/badge/Bildnerisches%20Gestalten-BG.1-ad1457)
![Deutsch (Sprache)](https://img.shields.io/badge/Deutsch%20(Sprache)-D.2-c62828)
![Medien und Informatik](https://img.shields.io/badge/Medien%20und%20Informatik-MI.1-6a1b9a)
![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.7-2e7d32)

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um einen **Hauptbahnhof und mehrere bunte Dörfer**, die durch **Schienen** verbunden sind.
Gedacht zum **gemeinsamen Spielen von Eltern und Kind** (ca. 5–7 Jahre) – spielerisch passend
zum Schweizer **Lehrplan 21, 1. Zyklus** (vor allem Medien & Informatik / **Reihenfolge**,
Mathematik / Muster und Bildnerisches Gestalten / Farben).

> Motto: **Fahren · Planen · Ordnen**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Logbuch, Ränge, Abzeichen, Belohnungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebauten Extras (**Routen-Auftrag**, **fahrbare Bimmelbahn**, **Weiche & Signal** mit
**Demo-Zug**, **Wagen-Parade**), die die Engine nicht abbildet.

## Lernziele

- 🗺️ **Routen & Reihenfolge der Stationen** – einen Fahrauftrag erfüllen: in der **richtigen
  Reihenfolge** an den Stationen halten (Medien & Informatik / **Abläufe und Reihenfolgen**, MI.1)
- 🔀 **Einfache Weichen- & Signal-Logik** – ein stark vereinfachtes Mesecons/Basic-Trains-Prinzip:
  Weiche umstellen, Signal auf rot/grün → **wenn–dann** verstehen (MI.2 / Technik TTG.2)
- 🎨 **Farben zuordnen** – jedes Dorf hat eine Farbe (rot, gelb, blau, grün); Dinge und
  Fahrgäste passend zuordnen (BG.1)
- 🔢 **Zählen & Muster** – Wagen und Stationen zählen, Farb-Muster legen (MA.1 / MA.2)

## Funktionen

- 🧱 **Bahn-Blöcke** (Schiene, Bahnsteig, Gleisbett/Schotter, Backstein, Holz-Bohle,
  Prellbock) + 🟦 **Bahnhofs-Glas** (durchsichtig) + 💡 **Bahnhofs-Lampe** (leuchtet)
- 🎨 **Bunte Dorf-Blöcke** (Haus rot/gelb/blau/grün) und **Wagen-Blöcke** in vier Farben
- 🖼️ **Gemusterte Bau-Blöcke** (Bahnübergang, Zug-Fenster, Backstein, Bahnhofsboden,
  Konfetti) – Muster rein prozedural, ganz ohne Bilddateien
- 🕰️ **Bahnhofs-Uhr** & 🧳 **Reise-Koffer** mit echten Pro-Seiten-Texturen (Bild oben,
  anders an den Seiten)
- 🔤 **Buchstaben-Blöcke A–Z** zum **Stationsnamen legen** + 🔢 **Zahlen-Blöcke 0–9** zum Zählen
- 🗺️ **5 Lern-Zonen** (Hauptbahnhof + Rotdorf, Gelbdorf, Blaudorf, Gründorf) mit
  platzierbaren Lern-Tafeln (Aktivität + Lehrplan-21-Bezug)
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (Farben, zählen, Logik), **Muster nachlegen**
  (Farb-Reihenfolge) und Begrüss-Ziele mit Belohnung
- 🚉 **Routen-Auftrag (das Herzstück)** – das **Fahrplan-Pult** gibt dir eine Route
  (z. B. *Rot → Blau → Gelb*); halte an den **Stations-Schildern** in **genau dieser
  Reihenfolge** → Belohnung + Meilensteine (MI.1)
- 🔀 **Weiche & Signal** – Weiche umstellen (geradeaus/rechts), Signal auf rot/grün; ein
  kleiner **Demo-Zug** fährt selbst, **hält bei Rot** und **fährt bei Grün** (wenn–dann)
- 📋 **Bahnhofs-Logbuch** – Fahrgast-Steckbriefe mit Zähler und „entdeckt"-Status
- 📷 **Entdecker-Kamera** – Fahrgäste fotografieren = im Logbuch entdecken
- 🐭 **12 freundliche Fahrgäste** (mit Mob-API): Schaffner-Maus, Bahnhofs-Hund,
  Gepäck-Igel, Rote Reise-Katze, Reise-Fuchs, Gelbes Entlein, Sonnen-Kanari, Blauer
  Papagei, Blaues Häschen, Grüner Frosch, Grüne Schildkröte – plus die seltene,
  leuchtende **Goldene Reise-Eule** ✨
- 👪 **Familien** – wer ein Elterntier begrüsst (z. B. Bahnhofs-Hund, Entlein, Frosch),
  bringt seine Jungtiere mit
- 🌿 **Lebendige Dörfer** – die Fahrgäste erscheinen automatisch auf festem Boden in
  deiner Nähe (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`)
- 🚂 **Fahrbare Bimmelbahn** – **Doppelsitz** für Eltern + Kind, Dampfwolke und **Pfiff**
  beim Fahren
- 🚃 **Wagen-Parade** – Befehl stellt einen bunten Wagen-Zug der Reihe nach auf
  (Farben & Reihenfolge)
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Bimmelbahn, Fahrplan-Pult,
  Stations-Schilder, Signal, Weiche, Schienen, Blöcke und je ein Spawn-Ei (abschaltbar)
- 🏆 **Ränge und Abzeichen**: Fahrgast → Schaffner-Lehrling → Schaffner → Lokführer → Bahnchef
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Pfiff- und Bimmel-Sounds
  aus diesem Thema

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden
  Fahrgästen (Blöcke, Zonen, Logbuch, Routen-Auftrag und Weichen-Logik laufen weiter).

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_bimmelbahn` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_bimmelbahn`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Passende Welt

Die Bimmelbahn und die Fahrgäste laufen auf **festem Boden** (Land). Es eignet sich jede
ganz normale Welt – am schönsten eine flache, auf der man bequem Schienen und Dörfer
bauen kann. Tipps zum Erstellen einer passenden Welt stehen in
**[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung**
ins Inventar: Bahnhofs-Logbuch, Kamera, Bimmelbahn, Fahrplan-Pult, Stations-Schilder,
Signal, Weiche, Schienen, je 20 Bau-Blöcke und ein Spawn-Ei pro Fahrgast. Tipp für den
schnellen Einstieg: Befehl **`/bimmelbahn_hauptbahnhof`** eingeben – dann steht eine
fertige Bahnhofshalle mit Tafeln, Fahrplan-Pult, Stations-Schildern und Bimmelbahn vor dir.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_bimmelbahn_starter_kit = false` setzen.

## Steuerung der Bimmelbahn

Platzieren → Rechtsklick zum Einsteigen → **W/S** fahren, **A/D** lenken,
**Springen** = pfeifen (tuut!) + kleiner Hops, **Rechtsklick** = aussteigen. Ein zweiter
Spieler kann mitfahren.

## Nützliche Befehle

- `/bimmelbahn_route` – gibt dir einen **Fahrauftrag** (Route der Stationen in einer
  Reihenfolge) und zeigt den Fahrplan
- `/bimmelbahn_teststation` – baut eine kleine fertige Test-Station vor dir (Bahnsteig,
  alle 5 Lern-Tafeln, Fahrplan-Pult, Stations-Schilder, Bimmelbahn). Benötigt das
  `server`-Privileg (im Einzelspieler automatisch vorhanden); überschreibt die Blöcke am Bauort.
- `/bimmelbahn_hauptbahnhof` – baut einen **grösseren** Hauptbahnhof als Glashalle mit Tür
  (Priv `server`)
- `/bimmelbahn_demo` – baut eine **Demo-Strecke** mit Signal: der Demo-Zug hält bei Rot
  und fährt bei Grün (Weichen-/Signal-Logik, Priv `server`)
- `/bimmelbahn_wagen` – stellt einen **bunten Wagen-Zug** der Reihe nach auf (Farben &
  Reihenfolge, Priv `server`)
- `/lernfortschritt` – dein persönlicher Lernfortschritt (aus der Engine)
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
einem Film, einer Marke oder einem Unternehmen verbunden und verwendet **keine**
geschützten Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee
„kleine Züge, die bunte Dörfer verbinden" ist nicht schutzfähig.
