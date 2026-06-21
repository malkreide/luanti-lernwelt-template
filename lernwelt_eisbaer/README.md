# Eisbär-Bucht 🐻‍❄️❄️

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.2,%20NMG.3-2e7d32)
![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![Bildnerisches Gestalten](https://img.shields.io/badge/Bildnerisches%20Gestalten-BG.1-ad1457)
![Bewegung und Sport](https://img.shields.io/badge/Bewegung%20und%20Sport-BS.2-ef6c00)
![Deutsch (Sprache)](https://img.shields.io/badge/Deutsch%20(Sprache)-D.2-c62828)

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um eine **kalte Polarwelt**. Gedacht zum **gemeinsamen Spielen von Eltern und
Kind** (ca. 6–9 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1./2. Zyklus**
(**NMG.2 Tiere & Lebensräume**, dazu Mathematik, Deutsch und Gestalten).

> Motto: **Entdecken · Benennen · Bewahren**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Katalog/Logbuch, Ränge, Abzeichen,
Belohnungs-Sounds, Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema
selbst ist im Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` –
plus die selbstgebauten Extras: der **Schlitten**, das **Polarlicht** (Aurora), die
**Futterstelle** und die **Eisblumen**, die die Engine nicht abbildet.

## Tiere & Lebensräume in der Kälte 🐧🦭🐻‍❄️

Das Herzstück ist **NMG.2 – Tiere und ihre Lebensräume**. Die Kinder entdecken die kalte
**Eisbär-Bucht** mit ihren drei Lebensräumen und lernen, **wer wo lebt**:

- 🧊 **Gefrorener See** – Pinguin, Robbe, Walross, Beluga-Wal und Narwal. *Wer schwimmt unter
  dem Eis, wer watschelt darauf?*
- 🌲 **Schneewald** – Schneehase, Polarfuchs, Rentier und Schneeeule mit dickem, weissem Fell.
- 🌌 **Polarlicht-Höhle** – die Höhle des grossen **Eisbären**, beleuchtet vom leuchtenden
  **Polarlicht**.

Dazu gestalten die Kinder **Blau-Weiss-Muster** (Streifen, Punkte, Schachbrett, Wellen,
Schneeflocken) – an den Lern-Tafeln zum Nachlegen und beim Bauen.

## Funktionen

- 🐾 **12 Kälte-Tiere** (mit Mob-API): Pinguin, Robbe, Walross, Beluga, Narwal, Schneehase,
  Polarfuchs, Rentier, Schneeeule, Eisbär, Polarlicht-Fuchs – plus den seltenen, leuchtenden
  **Polarlicht-Bär** 🌟. Rechtsklick = dem Tier **helfen** (friedlich, kein Kämpfen).
- 🗺️ **3 Lern-Zonen** (Gefrorener See, Schneewald, Polarlicht-Höhle) mit platzierbaren
  Lern-Tafeln (Aktivität + Lehrplan-21-Bezug).
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (Tiere & Lebensräume), **Blau-Weiss-Muster
  nachlegen** und Hilfe-Ziele mit Belohnung; zählen für `/lernfortschritt`.
- 🌌 **Polarlicht (Aurora)** – leuchtende Blöcke, die **langsam die Farbe wechseln**
  (blau → türkis → grün → violett → weiss). Schön anzusehen und eine sanfte Farb-/Musterlehre.
- 🛷 **Schlitten** – ein fahrbares Fahrzeug, das über Schnee und Eis gleitet (auch zu zweit).
- 🐟 **Tiere füttern** – eine **Futterstelle** mit **Fisch** versorgen = satte Tiere
  (persönlicher Zähler mit kleinen Auszeichnungen). Motto: Bewahren.
- 🌸 **Eisblumen pflanzen** – einen Setzling setzen → er wächst zu einem **blau-weissen
  Muster-Block** (eigener Zähler).
- 🧱 **Schnee-, Eis- & Muster-Blöcke** (rein prozedural, ohne Bilddateien): Schnee, Packeis,
  Blaues Eis, Klares Eis (durchsichtig), Iglu-Block & Eisziegel, fünf **Blau-Weiss-Muster**,
  leuchtender Eiskristall, verschneiter Fels, warmes Lagerfeuer und eine Proviantkiste
  (Pro-Seite-Textur).
- 🔤 **Buchstaben-Blöcke A–Z** zum Beschriften (Tiernamen legen).
- 📋 **Polar-Logbuch** – Tier-Steckbriefe mit Lebensraum, „frisst", Zähler und
  „entdeckt"-Status.
- 📷 **Entdecker-Kamera** – Tiere fotografieren = im Logbuch entdecken (Sammeln, getrennt
  vom Helfen).
- 👪 **Tier-Familien** – wer ein „Eltern"-Tier trifft (Robbe, Walross, Schneehase, Rentier,
  Eisbär), bringt kleine Begleiter mit.
- 🌍 **Lebendige Bucht** – Land-Tiere erscheinen automatisch in deiner Nähe, Wasser-Tiere im
  Wasser (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`).
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Schlitten, Fisch + Futterstelle,
  Eisblumen-Setzlinge, Bau-Blöcke und je ein Spawn-Ei (abschaltbar).
- 🏆 **Ränge und Abzeichen**: Schnee-Frischling → Spurenleser → Polar-Forscher →
  Eisbär-Freund → Polar-Held.
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Wind-/Ambient-Sounds aus
  diesem Thema.

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Tieren –
  **Schlitten, Polarlicht, Futterstelle und Eisblumen laufen auch ohne Mob-API** (eigener Code).

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_eisbaer` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_eisbaer`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung** ins
Inventar. Tipp für den schnellen Einstieg: der Befehl **`/eisbaer_eispalast`** baut dir sofort
einen ganzen **Eispalast** mit Lern-Tafeln, Polarlicht-Wand, Schlitten und Futterstelle;
**`/eisbaer_iglu`** baut ein kleines Iglu. Im Kreativ-Modus liegen alle Items zusätzlich im
Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_eisbaer_starter_kit = false` setzen.

## Nützliche Befehle

- `/eisbaer_eispalast` – baut einen **ganzen Eispalast** vor dir (Halle, 3 Lern-Tafeln,
  Polarlicht-Wand, Lagerfeuer, Schlitten, Futterstelle, Eisblume). Benötigt das
  `server`-Privileg (im Einzelspieler automatisch vorhanden).
- `/eisbaer_iglu` – baut ein kleines **Iglu** mit Lagerfeuer und Lern-Tafel, Priv `server`
- `/eisbaer_teststation` – kleine fertige Test-Station, Priv `server`
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
Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee „Polartiere entdecken und eine
Eiswelt bauen" ist nicht schutzfähig.
