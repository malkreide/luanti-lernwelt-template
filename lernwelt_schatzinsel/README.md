# Schatzinsel 🏴‍☠️🗺️

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.3-1565c0)
![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.2,%20NMG.3-2e7d32)

<!-- Screenshot-Slot — sobald docs/img/lernwelt_schatzinsel.png existiert, die nächste Zeile einkommentieren:
![Screenshot der Welt lernwelt_schatzinsel](../docs/img/lernwelt_schatzinsel.png)
-->

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um eine **freundliche Schatzinsel**. Gedacht zum **gemeinsamen Spielen von Eltern und Kind**
(ca. 5–7 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1. Zyklus**
(Mathematik, Natur-Mensch-Gesellschaft).

> Motto: **Karte lesen · Schätze zählen · Insel entdecken**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Logbuch, Ränge, Abzeichen, Rettungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebauten Extras (Floss, Wegweiser-Schnitzeljagd, Kompass, Schatzkarte, Goldmünzen-Zählen).

> 🏴‍☠️ **Freundliche Piraten:** Hier wird **nicht** gekämpft und es gibt **keine** gruseligen
> Totenköpfe – nur Karten, Goldmünzen, Tiere und Entdeckungen. Die „Flagge" zeigt einen Papagei.

## Lernfokus

- 🧭 **Raumorientierung** (NMG.3 / MA.3): Karte lesen, Kompass, Himmelsrichtungen
  (Norden/Osten/Süden/Westen), **oben/unten** unterscheiden.
- 🔢 **Mengen erfassen und zählen** (MA.1): **Goldmünzen zählen**, Tiere zählen, Zahlen-Blöcke.

## Funktionen

- 🏝️ **3 Lern-Zonen** mit platzierbaren Lern-Tafeln: **Insel** (Karte & Kompass),
  **Tropfsteinhöhle** (oben/unten, Münzen im Dunkeln zählen) und **Lagune** (Tiere zählen).
- 🧭 **Schatz-Kompass** – sagt dir, wohin du **schaust** (N/O/S/W), **wo** du bist
  (Strand · Höhle · Mastkorb – oben/unten) und wie viele **Goldmünzen** du gezählt hast.
- 🗺️ **Schatzkarte** – „lies" die Karte: sie zeigt die Richtung zum nächsten Wegweiser.
- 🪧 **Wegweiser** (Bild-Hinweise) – Holzschilder mit Bildern (Insel, Palme, Welle, Truhe,
  Muschel, Anker, Goldmünze) und **Richtungspfeilen** (N/O/S/W, hoch/runter). Rechtsklick
  wechselt das Bild, Schleichen+Rechtsklick wählt eines – baue deine **eigene Schnitzeljagd**.
- 🧩 **Schnitzeljagd** – ein fertiger Such-Parcours aus Wegweisern mit Pfeilen → **Schatz**.
- 🪙 **Goldmünzen zählen** – Münzen einsammeln zählt einen persönlichen Zähler hoch
  (mit Meilensteinen) – echtes Zählen zum Anfassen (MA.1).
- 🔟 **Zahlen-Blöcke 0–9** – Zahlen und Mengen legen (z. B. die Anzahl deiner Münzen).
- 🎨 **Bau-Blöcke** (prozedural, ganz ohne Bilddateien): Strand-Sand, Sandstein, Palmen-Stamm
  & -Blatt, Deck-Planke, Schiffs-Rumpf, Steg, Segel, Tau, Fass, Kajüten-Glas, Insel-Flagge,
  **Kompass-Rose**, **Schatzkarten-Block**, Höhlen-Stein, Tropfstein, Leucht-Kristall,
  Gold-Ader, Goldmünzen-Haufen, Lagunen-Sand, Korallen u. a.
- 🐠 **14 rettbare Tiere** (mit Mob-API): Papagei, Äffchen, Strand-Krabbe, Land-Schildkröte,
  Möwe, Fledermaus, Leuchtkäfer, Höhlen-Grille, Kristall-Schnecke, Bunter Fisch, Seestern,
  Wasserschildkröte, Tintenfisch – plus den seltenen, glänzenden **Goldenen Papagei** 🌟
- 👪 **Tier-Familien** – wer ein Elterntier rettet (Äffchen, Papagei, Schildkröten),
  bringt seine Jungtiere mit.
- 🌊 **Lebendige Insel** – Tiere erscheinen automatisch in deiner Nähe (an Land und im
  Wasser; schonend begrenzt, abschaltbar per `lernwelt_spawn_creatures`).
- ⛵ **Floss** – ein kleines Segel-Floss für die Lagune, mit **Doppelsitz** für Eltern + Kind.
- 📋 **Bordbuch** – Tier-Steckbriefe mit Rettungs-Zähler und „entdeckt"-Status.
- 📷 **Entdecker-Kamera** – Tiere fotografieren = im Bordbuch entdecken.
- 🏆 **Ränge und Abzeichen**: Schiffsjunge → Maat → Steuermann → Schatzsucher → Kapitän.
- 🔊 **Sound-Hooks** – Rettungs-/Rang-Sounds aus der Engine, Möwen-/Meeres-Ambient aus diesem Thema.

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles außer den lebenden Tieren.

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_schatzinsel` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_schatzinsel`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Passende Welt (Insel + Wasser)

Schön ist eine Welt mit **Inseln und Meer** – die Lagunen-Tiere schwimmen nur in **Wasser**.
Wie du eine passende Welt erstellst, steht in **[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.
Kein eigenes Meer nötig: Mit dem Befehl `/schatzinsel_schiff` steht sofort ein fertiges
Schatzschiff mit Steg vor dir, und ein selbst gefülltes Becken reicht für das Floss und die Fische.

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung**
ins Inventar: Bordbuch, Kamera, Schatz-Kompass, Schatzkarte, Floss, leere Wegweiser,
ein paar Goldmünzen, je 10 Bau-Blöcke und ein Spawn-Ei pro Tier. Damit kannst du sofort
loslegen. Im Kreativ-Modus liegen alle Items zusätzlich im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_schatzinsel_starter_kit = false` setzen.

## Steuerung des Flosses

Platzieren → Rechtsklick zum Einsteigen → **W/S** segeln, **A/D** lenken,
**Springen** = hoch, **Schleichen** = runter, **Rechtsklick** = von Bord.

## Nützliche Befehle

- `/schatzinsel_schiff` – baut ein **Schatzschiff mit Steg** vor dir (Deck, Mast, Segel,
  Strickleiter zum Mastkorb, 3 Lern-Tafeln, Kompass-Rose, Wegweiser, Schatzkiste, Floss).
- `/schatzinsel_teststation` – kleine fertige Test-Station (Tafeln, Floss, Wegweiser,
  Strickleiter, Goldmünzen).
- `/schatzinsel_schnitzeljagd` – legt eine **Schnitzeljagd** mit Bild-Wegweisern → Schatz an.
- `/schatzinsel_muenzen` – verteilt **Goldmünzen** zum Einsammeln und Zählen um dich herum.
- `/lernfortschritt` – dein persönlicher Lernfortschritt (aus der Engine).
- `/lernplan` – Übersicht aller Lern-Zonen und ihrer Lehrplan-21-Bezüge (aus der Engine).
- `/lernwelt` – Status + empfohlene `minetest.conf`-Zeilen (aus der Engine).

Die Befehle, die etwas bauen, brauchen das `server`-Privileg (im Einzelspieler automatisch vorhanden).

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
einem Film, Spiel, einer Marke oder einem Unternehmen verbunden und verwendet **keine**
geschützten Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee „freundliche
Schatzinsel" sowie echte Tiernamen sind nicht schutzfähig.
