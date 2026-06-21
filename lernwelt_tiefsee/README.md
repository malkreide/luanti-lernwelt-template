# Tiefsee-Retter 🐙

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.2,%20NMG.3-2e7d32)
![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![Bewegung und Sport](https://img.shields.io/badge/Bewegung%20und%20Sport-BS.2-ef6c00)
![Deutsch (Sprache)](https://img.shields.io/badge/Deutsch%20(Sprache)-D.2-c62828)
![Medien und Informatik](https://img.shields.io/badge/Medien%20und%20Informatik-MI.1-6a1b9a)

<!-- Screenshot-Slot — sobald docs/img/lernwelt_tiefsee.png existiert, die nächste Zeile einkommentieren:
![Screenshot der Welt lernwelt_tiefsee](../docs/img/lernwelt_tiefsee.png)
-->

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um ein Unterwasser-Rettungsteam. Gedacht zum **gemeinsamen Spielen von Eltern und Kind**
(ca. 5–7 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1. Zyklus**
(Natur-Mensch-Gesellschaft, Mathematik, Sprache, Medien und Informatik).

> Motto: **Entdecken · Helfen · Bewahren**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Logbuch, Ränge, Abzeichen, Rettungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebaute **Tauchkapsel**, die die Engine nicht abbildet.

## Funktionen

- 🪸 **5 bunte Korallenblöcke** + 🟦 **Stations-Glas** (durchsichtig)
- 🎨 **Gemusterte Bau-Blöcke** (Streifen, Punkte, Schachbrett, Rahmen, Schatzkiste,
  Sand mit Muschel, Wellen, Fischschuppen, Anker, Steuerrad) – Muster rein
  prozedural, ganz ohne Bilddateien
- 📦 **Schatztruhe** mit echtem Deckel (Pro-Seiten-Textur: Bild oben, Holz an den Seiten)
- 🔤 **Buchstaben-Blöcke A–Z** zum Wörterlegen (passt zu „Deutsch / benennen")
- 🗺️ **4 Lern-Zonen** (Korallenriff, Offenes Meer, Dunkle Tiefsee, Meeresboden) mit
  platzierbaren Lern-Tafeln (Aktivität + Lehrplan-21-Bezug)
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (zählen, vergleichen, benennen), **Muster
  nachlegen** (Farben) und Rette-Ziele mit Belohnung; zählen für `/lernfortschritt`
- 📋 **Meeres-Logbuch** – Tier-Steckbriefe mit Rettungs-Zähler und „entdeckt"-Status
- 📷 **Entdecker-Kamera** – Tiere fotografieren = im Logbuch entdecken (Sammeln,
  getrennt vom Retten)
- 🐠 **14 rettbare Tiere** (mit Mob-API): Clownfisch, Schildkröte, Blauwal, Hai,
  Anglerfisch, Krake, Seestern, Qualle, Seepferdchen, Krabbe, Delfin, Rochen, Seekuh
  – plus den seltenen, magischen **Goldenen Wal** 🌟
- 👪 **Tier-Familien** – wer ein Elterntier rettet (z. B. Delfin, Schildkröte, Seekuh),
  bringt seine Jungtiere mit
- 🌊 **Lebendiges Meer** – die Tiere erscheinen automatisch im Wasser in deiner Nähe
  (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`)
- 🧹 **Meer aufräumen** – Müll einsammeln macht das Meer sauberer (Zähler + Meilensteine)
- 🪸 **Korallen pflanzen** – Setzlinge wachsen zu Korallen, eigener Riff-Zähler
- 🚤 **Tauchkapsel** mit Upgrades – Scheinwerfer-Glühen, Blasenspur, **Doppelsitz**
  für Eltern + Kind
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Tauchkapsel, Korallen,
  Setzlinge und je ein Spawn-Ei (abschaltbar per Einstellung)
- 🏆 **Ränge und Abzeichen**: Frischling → Tauchschüler → Junior-Retter → Meeresheld → Kapitän
- 🔊 **Sound-Hooks** – Rettungs-/Rang-Sounds aus der Engine, Motor- und Ambient-/
  Walgesang-Sounds aus diesem Thema

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Tieren.

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_tiefsee` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_tiefsee`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Passende Welt (Wasser!)

Die Meerestiere schwimmen nur in **Wasser** – am besten ein Meer. Wie du eine
wasserreiche Welt erstellst (fertige Mapgen-Einstellungen für „flaches Meer" oder
„natürlicher Ozean") steht in **[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.
Kein eigenes Meer nötig: ein selbst gefülltes Becken reicht, denn die Tiere setzt du
mit den Spawn-Eiern aus der Startausrüstung.

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung**
ins Inventar: Meeres-Logbuch, Tauchkapsel, je 10 Korallenblöcke + Stations-Glas und
ein Spawn-Ei pro Meerestier. Damit kannst du sofort Tiere setzen und retten, ohne
sie erst suchen zu müssen. Im Kreativ-Modus liegen alle Items zusätzlich im
Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_tiefsee_starter_kit = false` setzen.

## Steuerung der Tauchkapsel

Platzieren → Rechtsklick zum Einsteigen → **W/S** fahren, **A/D** lenken,
**Springen** = auftauchen, **Schleichen** = abtauchen, **Rechtsklick** = aussteigen.

## Nützliche Befehle

- `/tiefsee_teststation` – baut eine kleine fertige Test-Station vor dir
  (Glasboden, alle 4 Lern-Tafeln, eine Tauchkapsel, etwas Müll). Praktisch zum
  Testen oder zum Vorbereiten durch die Erwachsenen. Benötigt das `server`-Privileg
  (im Einzelspieler automatisch vorhanden); überschreibt die Blöcke am Bauort.
- `/tiefsee_basis` – baut eine **grössere** Glaskuppel-Basis mit Tür, Tafeln,
  Tauchkapsel und Müll (Priv `server`)
- `/tiefsee_muell` – verteilt etwas Müll zum Aufräumen um dich herum (Priv `server`)
- `/lernfortschritt` – dein persönlicher Lernfortschritt: Rang, Rettungen, gelöste
  Aufgaben, getroffene Tiere und berührte Lernbereiche (aus der Engine)
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

Dies ist ein **eigenständiges Werk**. Es ist **nicht** mit einer Fernsehserie,
Marke oder einem Unternehmen verbunden und verwendet **keine** geschützten Namen,
Figuren, Logos oder Designs. Die allgemeine Spielidee „Unterwasser-Rettungsteam"
sowie echte Tiernamen sind nicht schutzfähig.
