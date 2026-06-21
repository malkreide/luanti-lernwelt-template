# Naschwerk-Tal 🍭🍫🐻

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![Bildnerisches Gestalten](https://img.shields.io/badge/Bildnerisches%20Gestalten-BG.1-ad1457)
![Deutsch (Sprache)](https://img.shields.io/badge/Deutsch%20(Sprache)-D.2-c62828)

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um ein **knallbuntes Süssigkeiten-Tal**. Gedacht zum **gemeinsamen Spielen von Eltern und
Kind** (ca. 5–8 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1./2. Zyklus**
(Schwerpunkt **MA.1 – Zahl & Menge**, dazu Muster und Farben).

> Motto: **Zählen · Mustern · Naschen**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Katalog/Logbuch, Ränge, Abzeichen,
Belohnungs-Sounds, Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema
selbst ist im Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` –
plus die selbstgebauten Extras: der **Zähl-Naschtisch** (Zähl-Spiel), der **Naschwagen**, der
**Regenbogen-Lolli**, die **Naschschale** und die **Lollis**, die die Engine nicht abbildet.

## Frühe Mathematik im Süssigkeiten-Tal 🔢🎨

Das Herzstück ist **MA.1 – Mengen zählen**, dazu **Muster** (rot–gelb–rot …) und **Farben**.
Die Kinder entdecken das **Naschwerk-Tal** mit seinen drei Zonen:

- 🍫 **Schoko-Fluss** – im süssen Schoko-Fluss schwimmen Schoko-Fisch, Marshmallow-Schwan und
  Keks-Schildkröte. *Wie viele siehst du? Welche Farben?*
- 🍭 **Lolli-Wald** – bunte Lollis und Zuckerwatte. Hier werden **Muster** gelegt
  (rot–gelb–rot …) und Farben benannt.
- 🐻 **Gummi-Hügel** – weiche Hügel voller Gummibären zum **Zählen grösserer Mengen** und
  Sortieren.

Dazu steht der **Zähl-Naschtisch**: ein kleines Zähl-Spiel – „Wie viele Bonbons siehst du?" –
das **Mengen erfassen** direkt übt.

## Funktionen

- 🔢 **Zähl-Naschtisch** – ein interaktives **Zähl-Spiel** (1–9 Bonbons): die richtige Zahl
  anklicken = Belohnung + persönlicher Zähler mit kleinen Auszeichnungen (MA.1).
- 🐾 **12 Naschtiere** (mit Mob-API): Schoko-Fisch, Marshmallow-Schwan, Keks-Schildkröte,
  Brause-Qualle, Zuckerwatte-Schaf, Lolli-Vogel, Bonbon-Hase, Karamell-Eichhörnchen, Gummibär,
  Lakritz-Schnecke, Zucker-Maus – plus die seltene, leuchtende **Regenbogen-Lolli-Fee** 🌈.
  Rechtsklick = dem Tier **helfen** (friedlich, kein Kämpfen).
- 🗺️ **3 Lern-Zonen** (Schoko-Fluss, Lolli-Wald, Gummi-Hügel) mit platzierbaren Lern-Tafeln
  (Aktivität + Lehrplan-21-Bezug).
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (Zählen & Farben), **bunte Muster nachlegen**
  (rot–gelb–rot …) und Hilfe-Ziele mit Belohnung; zählen für `/lernfortschritt`.
- 🌈 **Regenbogen-Lolli** – leuchtende Blöcke, die **langsam die Farbe wechseln**
  (rot → orange → gelb → grün → blau → violett). Schön anzusehen und eine sanfte Farblehre.
- 🛒 **Naschwagen** – ein fahrbares Fahrzeug, das bunte Streusel sprüht (auch zu zweit).
- 🍬 **Naschtiere füttern** – eine **Naschschale** mit **Bonbons** versorgen = satte Tiere
  (persönlicher Zähler mit kleinen Auszeichnungen).
- 🍭 **Lollis pflanzen** – einen Setzling setzen → er wächst zu einem **bunten
  Süssigkeits-Block** (eigener Zähler).
- 🧱 **Süssigkeits-Blöcke** (rein prozedural, ohne Bilddateien): Lebkuchen & Lebkuchen-Ziegel,
  Zuckerguss, Schokolade & weisse Schokolade, Keks, Waffel, Zuckerwatte (rosa/blau), Lakritz,
  warmes Karamell, **durchscheinende Gummi-Blöcke** (rot/grün/gelb/orange), bunte **Drops**
  (rot/gelb/blau/grün) für Muster, Zuckerstange, gestreiftes Bonbon, Lolli, Bonbon-Lampe und
  eine Naschkiste (Pro-Seite-Textur).
- 🔤 **Buchstaben-Blöcke A–Z** zum Beschriften (Süssigkeiten-Namen legen).
- 📋 **Naschwerk-Logbuch** – Tier-Steckbriefe mit Zone, „frisst", Zähler und „entdeckt"-Status.
- 📷 **Entdecker-Kamera** – Tiere fotografieren = im Logbuch entdecken (Sammeln, getrennt
  vom Helfen).
- 👪 **Tier-Familien** – wer ein „Eltern"-Tier trifft (Marshmallow-Schwan, Zuckerwatte-Schaf,
  Bonbon-Hase, Gummibär, Zucker-Maus), bringt kleine Begleiter mit.
- 🌍 **Lebendiges Tal** – Land-Tiere erscheinen automatisch in deiner Nähe, Wasser-Tiere im
  Schoko-Fluss (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`).
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Naschwagen, Bonbons + Naschschale,
  Lolli-Setzlinge, Zähl-Naschtisch, Bau-Blöcke und je ein Spawn-Ei (abschaltbar).
- 🏆 **Ränge und Abzeichen**: Naschmaus → Bonbon-Sammler → Zucker-Forscher → Naschmeister →
  Naschwerk-Held.
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Blubber-/Ambient-Sounds aus
  diesem Thema.

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Tieren –
  **Zähl-Naschtisch, Naschwagen, Regenbogen-Lolli, Naschschale und Lollis laufen auch ohne
  Mob-API** (eigener Code).

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_naschwerk` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_naschwerk`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung** ins
Inventar. Tipp für den schnellen Einstieg: der Befehl **`/naschwerk_lebkuchenhaus`** baut dir
sofort ein ganzes **Lebkuchenhaus** mit Lern-Tafeln, Regenbogen-Lolli-Wand, Zähl-Naschtisch,
Naschschale und Naschwagen. Im Kreativ-Modus liegen alle Items zusätzlich im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_naschwerk_starter_kit = false` setzen.

## Nützliche Befehle

- `/naschwerk_lebkuchenhaus` – baut ein **ganzes Lebkuchenhaus** vor dir (Halle, 3 Lern-Tafeln,
  Regenbogen-Lolli-Wand, Zähl-Naschtisch, Naschschale, Naschwagen). Benötigt das
  `server`-Privileg (im Einzelspieler automatisch vorhanden).
- `/naschwerk_teststation` – kleine fertige Test-Station, Priv `server`
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
Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee „ein Süssigkeiten-Land entdecken
und bauen" ist nicht schutzfähig.
