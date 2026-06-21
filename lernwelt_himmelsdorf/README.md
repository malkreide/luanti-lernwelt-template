# Himmelsdorf 🌈☁️🎈

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um eine **Himmelswelt / Wolkenstadt**. Gedacht zum **gemeinsamen Spielen von Eltern und
Kind** (ca. 6–9 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1./2. Zyklus**
(**NMG Wetter & Raumorientierung**, dazu Mathematik, Deutsch und Gestalten).

> Motto: **Entdecken · Benennen · Bewahren**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Katalog/Logbuch, Ränge, Abzeichen,
Belohnungs-Sounds, Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema
selbst ist im Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` –
plus die selbstgebauten Extras: der **Heissluftballon**, der **Regenbogen** (Farbwechsel-Block),
die **Wetter-Station**, die **Regenbogen-Samen** und der **Höhenmesser**, die die Engine nicht
abbildet.

## Wetter, Regenbogen & oben/unten 🌦️🌈🔼

Das Herzstück sind **Wetter und Raumorientierung** (NMG). Die Kinder entdecken die schwebende
**Wolkenstadt** mit ihren drei Bereichen und lernen die wichtigsten Himmels-Themen:

- 🌈 **Regenbogenbrücke** – die **sieben Regenbogenfarben** in der richtigen Reihenfolge
  (Rot, Orange, Gelb, Grün, Blau, Indigo, Violett).
- ☁️ **Wolkenfelder** – das **Wetter** beobachten (Sonne, Wolken, Regen, Gewitter) und
  **oben/unten** üben (die Wolken sind oben, der Boden tief unten).
- 🎈 **Ballonhafen** – die **Flug-Physik** verstehen (warme Luft steigt → der Ballon fliegt) und
  sich in der Höhe zurechtfinden (**Raumorientierung**).

Dazu gestalten die Kinder mit **Regenbogen-, Wolken-, Sonnen- und Sternen-Mustern** – an den
Lern-Tafeln zum Nachlegen und beim Bauen.

## Funktionen

- 🐾 **12 Himmels-Tiere** (mit Mob-API): Regenbogen-Kolibri, Sonnenfalter, Sonnenvogel,
  Wolkenschaf, Wolkenkatze, Schwalbe, Himmelsqualle, Sturmvogel, Windgeist, Wetterfrosch und
  Donnervogel – plus den seltenen, leuchtenden **Regenbogen-Pegasus** 🌟. Rechtsklick = dem Tier
  **helfen** (friedlich, kein Kämpfen).
- 🗺️ **3 Lern-Zonen** (Regenbogenbrücke, Wolkenfelder, Ballonhafen) mit platzierbaren
  Lern-Tafeln (Aktivität + Lehrplan-21-Bezug).
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (Regenbogenfarben, Wetter, oben/unten, Flug-Physik),
  **Regenbogen-Muster nachlegen** und Hilfe-Ziele mit Belohnung; zählen für `/lernfortschritt`.
- 🌦️ **Wetter-Station** – Rechtsklick wechselt das Wetter für alle: **Sonne → Wolken → Regen →
  Gewitter → Regenbogen** (mit Himmelsfarbe, Wolken und Regen-Tropfen). Eine anfassbare Wetterkunde.
- 🌈 **Regenbogen-Block** – leuchtet und **wechselt langsam die Farbe** (rot → orange → gelb →
  grün → blau → indigo → violett). Schön anzusehen und eine sanfte Farb-/Reihenfolge-Lehre.
- 🎈 **Heissluftballon** – ein echtes **fliegendes Fahrzeug** (warme Luft steigt!): hoch, runter,
  vor, zurück – auch zu zweit.
- 📏 **Höhenmesser** – Linksklick zeigt deine **Höhe** und ob du **oben** oder **unten** bist
  (Raumorientierung).
- 🌱 **Regenbogen pflanzen** – einen Samen setzen → er wächst zu einem zufälligen
  **Regenbogen-Farbblock** (eigener Zähler).
- 🧱 **Wolken-, Himmels- & Regenbogen-Blöcke** (rein prozedural, ohne Bilddateien): Wolke,
  Glaswolke (durchsichtig), Wolkenziegel, Schwebeland (Inselboden, Pro-Seite-Textur),
  Himmelsstein, leuchtender Sonnen-/Sternenblock, Wolkenlampe, vier Muster-Blöcke, ein
  Ballonkorb (Pro-Seite-Textur) und die **sieben Regenbogenfarben** als Blöcke.
- 🔤 **Buchstaben-Blöcke A–Z** zum Beschriften (Tiernamen legen).
- 📋 **Himmels-Logbuch** – Tier-Steckbriefe mit Lebensraum, „frisst", Zähler und
  „entdeckt"-Status.
- 📷 **Entdecker-Kamera** – Tiere fotografieren = im Logbuch entdecken (Sammeln, getrennt
  vom Helfen).
- 👪 **Tier-Familien** – wer ein „Eltern"-Tier trifft (Wolkenschaf, Wetterfrosch), bringt
  kleine Begleiter mit.
- 🌍 **Lebendiger Himmel** – Tiere erscheinen automatisch auf den Wolken-Plattformen in deiner
  Nähe (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`).
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Heissluftballon, Höhenmesser,
  Wetter-Station, Regenbogen-Samen, Bau-Blöcke und je ein Spawn-Ei (abschaltbar).
- 🏆 **Ränge und Abzeichen**: Himmels-Frischling → Wolkenläufer → Himmels-Forscher →
  Wolken-Freund → Himmels-Held.
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Wind-/Vogel-/Donner-Sounds aus
  diesem Thema.

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Tieren –
  **Ballon, Regenbogen, Wetter-Station, Regenbogen-Samen und Höhenmesser laufen auch ohne
  Mob-API** (eigener Code).

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_himmelsdorf` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_himmelsdorf`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung** ins
Inventar. Tipp für den schnellen Einstieg: der Befehl **`/himmelsdorf_wolkenstadt`** baut dir
sofort eine ganze **Wolkenstadt** mit Lern-Tafeln, leuchtender Regenbogenbrücke, Wetter-Station
und Ballon; **`/himmelsdorf_schwebeinsel`** baut eine kleine Schwebeinsel. Im Kreativ-Modus
liegen alle Items zusätzlich im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_himmelsdorf_starter_kit = false` setzen.

## Nützliche Befehle

- `/himmelsdorf_wolkenstadt` – baut eine **ganze Wolkenstadt** vor dir (Plattform, 3 Lern-Tafeln,
  Regenbogenbrücke, Sonne, Wetter-Station, Ballon, Regenbogen-Samen). Benötigt das
  `server`-Privileg (im Einzelspieler automatisch vorhanden).
- `/himmelsdorf_schwebeinsel` – baut eine kleine **Schwebeinsel** mit Lern-Tafel, Priv `server`
- `/himmelsdorf_teststation` – kleine fertige Test-Station, Priv `server`
- `/lernfortschritt` · `/lernplan` · `/lernwelt` – aus der Engine (Fortschritt, Lehrplan, Status)

## Eigene Grafiken und Sounds

Das Thema läuft **ohne externe Dateien** (Farben/Muster via `[fill`-Generator der Engine).
Eigene Texturen/Sounds können ergänzt werden – siehe `textures/README.txt`
und `sounds/README.txt`. **Bitte nur selbst erstellte oder frei lizenzierte Inhalte verwenden.**

## Lizenz

- **Code:** MIT – siehe [LICENSE.txt](LICENSE.txt)
- **Mitgelieferte Medien:** keine (alle Farben werden zur Laufzeit erzeugt)

## Rechtlicher Hinweis

Dies ist ein **eigenständiges Werk**. Es ist **nicht** mit einer Fernsehserie, einem Film,
einem Spiel, einer Marke oder einem Unternehmen verbunden und verwendet **keine** geschützten
Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee „eine Wolkenstadt am Himmel
entdecken und bauen" ist nicht schutzfähig.
