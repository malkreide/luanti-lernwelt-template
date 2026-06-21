# Drachenhort 🐉

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.1,%20NMG.2,%20NMG.3-2e7d32)

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um einen Hort **freundlicher Drachen**. Gedacht zum **gemeinsamen Spielen von Eltern und
Kind** (ca. 5–7 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1. Zyklus**
(Natur-Mensch-Gesellschaft, Mathematik).

> Motto: **Ausbrüten · Umsorgen · Anfreunden**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Tagebuch, Ränge, Abzeichen, Belohnungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebauten Extras: **Drachenbabys füttern & zähmen**, **Brut-Eier ausbrüten** und ein
**fliegender Reitdrache**, die die Engine nicht abbildet.

## Funktionen

- 🐉 **Drachen rein friedlich** – kein Kämpfen. Drachen werden per **Rechtsklick angefreundet**
  (sanfter „Rette/Besänftige"-Kreislauf der Engine: Herzchen, Ton, Zähler, Rang).
- 🥚 **Drachenbabys großziehen** (das Herzstück): ein **Brut-Ei** setzen → es **schlüpft** →
  das Baby **geduldig füttern**, bis es dir vertraut und **gezähmt** ist. Lernt **Verantwortung
  und Geduld** (Animalia/`mobs_redo`-Logik: zähmen durch Füttern, mit Besitzer). Ein gezähmtes
  Baby **folgt** seinem Kind.
- 🔢 **Eier zählen** und 🎨 **Farben zuordnen** an den Lern-Tafeln (MA.1 / NMG) – mit echten,
  bunten **Zähl-Eiern** zum Hinlegen.
- 🟥 **Drachensteine** in 5 Farben (leuchtend) + ☁️ **Wolkenblock**, 🪨 **Bergstein**,
  💎 **Kristallglas** (durchsichtig) und „**kalte Lava**" (leuchtend, aber **völlig ungefährlich**)
- 🎨 **Gemusterte Bau-Blöcke** (Drachenschuppen, Drachenauge, Ei-Muster, Gold-Rahmen,
  **Goldhort**) – Muster rein prozedural, ganz ohne Bilddateien
- 🪹 **Drachennest** mit echtem Stroh-Rand (Pro-Seiten-Textur: Nest oben, Zweige an den Seiten)
- 🔤 **Buchstaben-Blöcke A–Z** zum Wörterlegen (passt zu „Deutsch / benennen")
- 🗺️ **3 Lern-Zonen** (Drachenberg, Lavafreier Krater, Himmelsinseln) mit platzierbaren
  Lern-Tafeln (Aktivität + Lehrplan-21-Bezug)
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (zählen, Farben, Verantwortung), **Muster nachlegen**
  (Farben zuordnen) und Anfreund-Ziele mit Belohnung; zählen für `/lernfortschritt`
- 📋 **Drachen-Tagebuch** – Drachen-Steckbriefe mit Anfreund-Zähler und „entdeckt"-Status
- 📷 **Entdecker-Kamera** – Drachen fotografieren = im Tagebuch entdecken (Sammeln, getrennt
  vom Anfreunden)
- 🐲 **10 Drachen** (mit Mob-API): Glutdrache, Funkendrache, Beerendrache, Felsendrache,
  Smaragddrache, Kristalldrache, Wolkendrache, Winddrache, Sonnendrache – plus den seltenen,
  magischen **Sternendrachen** 🌟
- 👪 **Drachen-Familien** – wer ein Elterntier anfreundet (z. B. Glutdrache, Beerendrache,
  Wolkendrache), bringt seine Jungtiere mit
- 🌍 **Lebendige Welt** – wilde Drachen erscheinen automatisch an Land in deiner Nähe
  (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`)
- 🐉 **Reitdrache** – ein **fliegendes** Reittier mit Funkenspur und **Doppelsitz**
  für Eltern + Kind (ideal für die Himmelsinseln)
- 🎒 **Startausrüstung** beim ersten Join: Tagebuch, Kamera, Reitdrache, Drachenfutter,
  Brut-Eier, Bau-Blöcke, Zähl-Eier und je ein Spawn-Ei (abschaltbar per Einstellung)
- 🏆 **Ränge und Abzeichen**: Eierhüter → Drachenfreund → Drachenreiter → Drachenhüter → Drachenmeister
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Flügelschlag- und
  Ambient-/Drachenruf-Sounds aus diesem Thema

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Drachen –
  **Brut-Eier, Drachenbabys, Füttern und Zähmen laufen auch ohne Mob-API** (eigener Code).

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_drachenhort` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_drachenhort`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Passende Welt (Berge & Höhe!)

Die Drachen laufen an Land und fliegen gern hoch hinaus. Eine **hügelige/bergige** Welt mit
Platz nach oben passt am besten. Wie du eine passende Welt erstellst, steht in
**[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)** – nötig ist sie aber nicht: mit dem Befehl
`/drachenhort_nest` baust du dir sofort ein fertiges Drachennest.

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung**
ins Inventar: Drachen-Tagebuch, Kamera, Reitdrache, **Drachenfutter**, **Brut-Eier**,
Bau-Blöcke, **Zähl-Eier** und ein Spawn-Ei pro Drache. Damit kannst du sofort ein Ei
ausbrüten, das Baby füttern und losfliegen. Im Kreativ-Modus liegen alle Items zusätzlich
im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_drachenhort_starter_kit = false` setzen.

## Drachenbaby großziehen (kurz)

1. **Brut-Ei** auf den Boden setzen (am schönsten in ein **Nest**). Nach ca. 30 Sek. schlüpft
   ein Drachenbaby.
2. **Drachenfutter** (Beeren) **in die Hand** nehmen und das Baby mit **Rechtsklick** füttern.
3. Nach jeder Fütterung ist das Baby eine Weile **satt** – **hab Geduld** und warte kurz, bevor
   du wieder fütterst.
4. Nach **5 geduldigen Fütterungen** ist das Baby **gezähmt**, vertraut dir und **folgt** dir.

## Steuerung des Reitdrachen

Platzieren → Rechtsklick zum Aufsteigen → **W/S** fliegen, **A/D** lenken,
**Springen** = hoch, **Schleichen** = runter, **Rechtsklick** = absteigen.

## Nützliche Befehle

- `/drachenhort_nest` – baut ein **großes Drachennest** vor dir (Plattform mit Nest-Rand,
  Goldhort, Eier zum Zählen, 3 Lern-Tafeln, Brut-Ei, Reitdrache). Benötigt das `server`-Privileg
  (im Einzelspieler automatisch vorhanden); überschreibt die Blöcke am Bauort.
- `/drachenhort_teststation` – kleine fertige Test-Station (Boden, 3 Tafeln, Zähl-Eier,
  Brut-Ei, Reitdrache), Priv `server`
- `/drachenhort_baby` – setzt ein hungriges Drachenbaby zum Füttern/Zähmen aus (Priv `server`)
- `/lernfortschritt` – dein persönlicher Lernfortschritt: Rang, Anfreundungen, gelöste
  Aufgaben, getroffene Drachen und berührte Lernbereiche (aus der Engine)
- `/lernplan` – Übersicht aller Lern-Zonen und ihrer Lehrplan-21-Bezüge (für Eltern/Lehrpersonen, aus der Engine)
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

Dies ist ein **eigenständiges Werk**. Es ist **nicht** mit einer Fernsehserie, einem Film,
einem Spiel, einer Marke oder einem Unternehmen verbunden und verwendet **keine** geschützten
Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee „freundliche Drachen großziehen"
ist nicht schutzfähig.
