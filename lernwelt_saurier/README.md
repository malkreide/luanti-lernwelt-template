# Saurier-Forscher 🦕

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um eine **Forscherstation bei freundlichen Pflanzenfresser-Dinosauriern**. Gedacht zum
**gemeinsamen Spielen von Eltern und Kind** (ca. 5–7 Jahre) – spielerisch passend zum
Schweizer **Lehrplan 21, 1. Zyklus** (vor allem Natur-Mensch-Gesellschaft und
Mathematik / Grössen).

> Motto: **Entdecken · Erforschen · Vergleichen**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Logbuch, Ränge, Abzeichen, Belohnungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebauten Extras (**Ausgraben**, **Forscher-Jeep**, **Eier ausbrüten**,
**Grössen-Parade**), die die Engine nicht abbildet.

## Lernziele

- 🦕 **Dino-Namen** lernen und benennen (Deutsch / NMG)
- 📏 **Grössenvergleich** (klein – mittel – gross): die Dinos sind unterschiedlich gross
  (MA Grössen / MA.3)
- ⛏️ **«Ausgraben»** – im Sand nach Fossilien graben und suchen (NMG, Forscher-Arbeit)
- 🗂️ **Klassifizieren** – Dinos sortieren (Pflanzenfresser? Langhals, Hornträger,
  Plattendino, Entenschnabel …)

## Funktionen

- 🪨 **Erdige Bau-Blöcke** (Urzeit-Fels, Sandstein, Wüsten-Sand, Dschungel-Blatt,
  Vulkangestein, leuchtender Bernstein) + 🟦 **Stations-Glas** (durchsichtig)
- 🎨 **Gemusterte Bau-Blöcke** (Fussabdruck, Knochen, Nest, Schuppen, Farn, Lava,
  Schachbrett) – Muster rein prozedural, ganz ohne Bilddateien
- 📦 **Forscher-Kiste** mit echtem Deckel (Pro-Seiten-Textur: Bild oben, Holz an den Seiten)
- 🔤 **Buchstaben-Blöcke A–Z** zum **Dino-Namen legen** + 🔢 **Zahlen-Blöcke 0–9** zum Zählen
- 🗺️ **3 Lern-Zonen** (Tal, Fossilien-Grabungsstätte, Nistplatz) mit platzierbaren
  Lern-Tafeln (Aktivität + Lehrplan-21-Bezug)
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (benennen, vergleichen, klassifizieren,
  zählen), **Muster nachlegen** (Farben, Grössen-Reihe) und Forsch-Ziele mit Belohnung
- ⛏️ **Ausgraben** – im **Grabungssand** stecken Fossilien (Knochen, Zahn, Ammonit,
  versteinertes Ei); Graben zählt + Meilensteine (das NMG-/MA.1-Herzstück)
- 📋 **Forscher-Logbuch** – Dino-Steckbriefe mit Zähler und „entdeckt"-Status
- 📷 **Entdecker-Kamera** – Dinos fotografieren = im Logbuch entdecken
- 🦕 **14 freundliche Dinos** (mit Mob-API): Brachiosaurus, Diplodocus, Triceratops,
  Stegosaurus, Parasaurolophus, Ankylosaurus, Iguanodon, Pachycephalosaurus,
  Protoceratops, Microceratus, Maiasaura, Apatosaurus, Hadrosaurus – plus den seltenen,
  magischen **Regenbogen-Saurier** 🌈
- 👪 **Dino-Familien** – wer ein Elterntier begrüsst (z. B. Maiasaura, Apatosaurus),
  bringt seine Jungtiere mit
- 🥚 **Eier ausbrüten** – Dino-Eier am Nistplatz setzen → es schlüpfen kleine Dinos
- 🌿 **Lebendiges Tal** – die Dinos erscheinen automatisch auf festem Boden in deiner
  Nähe (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`)
- 🚙 **Forscher-Jeep** – fahrbar, **Doppelsitz** für Eltern + Kind, Staubwolke beim Fahren
- 📏 **Grössen-Parade** – Befehl stellt die Dinos von klein nach gross auf (Grössenvergleich)
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Jeep, Dino-Eier, Grabungssand,
  Blöcke und je ein Spawn-Ei (abschaltbar per Einstellung)
- 🏆 **Ränge und Abzeichen**: Frischling → Nachwuchs-Forscher → Junior-Paläontologe →
  Saurier-Experte → Chef-Paläontologe
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Dino-Ruf- und Ambient-Sounds
  aus diesem Thema

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Dinos
  (Blöcke, Zonen, Logbuch und das Ausgraben laufen weiter).

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_saurier` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_saurier`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Passende Welt

Die Dinos laufen auf **festem Boden** (Land). Es eignet sich jede ganz normale Welt –
am schönsten eine mit Hügeln, Sand und etwas Grün. Tipps zum Erstellen einer passenden
Welt (z. B. flache Übungs-Welt oder natürliche Landschaft) stehen in
**[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung**
ins Inventar: Forscher-Logbuch, Kamera, Forscher-Jeep, Dino-Eier, Grabungssand, je 10
Bau-Blöcke und ein Spawn-Ei pro Dino. Tipp für den schnellen Einstieg: Befehl
**`/saurier_forscherstation`** eingeben – dann steht eine fertige Station mit Tafeln,
Jeep und Grabungsfeld vor dir.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_saurier_starter_kit = false` setzen.

## Steuerung des Forscher-Jeeps

Platzieren → Rechtsklick zum Einsteigen → **W/S** fahren, **A/D** lenken,
**Springen** = kleiner Hops, **Rechtsklick** = aussteigen. Ein zweiter Spieler kann
mitfahren.

## Nützliche Befehle

- `/saurier_teststation` – baut eine kleine fertige Test-Station vor dir (Boden, alle 3
  Lern-Tafeln, Forscher-Jeep, kleines Grabungsfeld). Benötigt das `server`-Privileg
  (im Einzelspieler automatisch vorhanden); überschreibt die Blöcke am Bauort.
- `/saurier_forscherstation` – baut eine **grössere** Glaskuppel-Station mit Tür, Tafeln,
  Jeep und Grabungsfeld (Priv `server`)
- `/saurier_grabung` – legt eine **Grabungsstätte** an: ein Sandfeld mit versteckten
  Fossilien zum Ausgraben (Priv `server`)
- `/saurier_groessen` – stellt die Dinos von **klein nach gross** auf (Grössenvergleich,
  Priv `server`)
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
„Dinosaurier-Forscherstation" sowie echte Dinosaurier-Gattungsnamen sind nicht
schutzfähig.
