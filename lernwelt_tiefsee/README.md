# Tiefsee-Retter 🐙

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um ein Unterwasser-Rettungsteam. Gedacht zum **gemeinsamen Spielen von Eltern und Kind**
(ca. 5–7 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1. Zyklus**
(Natur-Mensch-Gesellschaft, Mathematik, Sprache, Medien & Informatik).

> Motto: **Entdecken · Helfen · Bewahren**

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Logbuch, Ränge, Abzeichen, Rettungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebaute **Tauchkapsel**, die die Engine nicht abbildet.

## Funktionen

- 🪸 **5 bunte Korallenblöcke** + 🟦 **Stations-Glas** (durchsichtig)
- 🗺️ **4 Lern-Zonen** (Korallenriff, Offenes Meer, Dunkle Tiefsee, Meeresboden) mit
  platzierbaren Lern-Tafeln (Aktivität + Lehrplan-21-Bezug)
- ❓ **Aufgaben an den Lern-Tafeln** – kleine Quiz (zählen, vergleichen, benennen) und
  Rette-Ziele mit Belohnung; gelöste Aufgaben zählen für `/lernfortschritt`
- 📋 **Meeres-Logbuch** – Tier-Steckbriefe mit persönlichem Rettungs-Zähler
- 🐠 **8 rettbare Tiere** (mit Mob-API): Clownfisch, Schildkröte, Blauwal, Hai,
  Anglerfisch (leuchtet), Krake, Seestern, Qualle (leuchtet)
- 🌊 **Lebendiges Meer** – die Tiere erscheinen automatisch im Wasser in deiner Nähe
  (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`)
- 🧹 **Meer aufräumen** – Müll-Teile (Flasche, Dose, Tüte) einsammeln macht das Meer
  sauberer, mit eigenem Zähler und Meilensteinen (Meeres-Putzer → Ozean-Held)
- 🚤 **Tauchkapsel** – fahrbares Fahrzeug zum Tauchen (themen-eigenes Extra)
- 🎒 **Startausrüstung** – beim ersten Join bekommt jede Spielerin/jeder Spieler
  automatisch Logbuch, Tauchkapsel, Korallenblöcke und je ein Spawn-Ei pro Tier
  (praktisch zum sofortigen Testen; abschaltbar per Einstellung)
- 🏆 **Ränge & Abzeichen**: Frischling → Tauchschüler → Junior-Retter → Meeresheld → Kapitän
- 🔊 **Sound-Hooks** – Rettungs-/Rang-Sounds aus der Engine, Motor-Sound aus diesem Thema

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles außer den lebenden Tieren.

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
- `/tiefsee_muell` – verteilt etwas Müll zum Aufräumen um dich herum (Priv `server`)
- `/lernfortschritt` – dein persönlicher Lernfortschritt: Rang, Rettungen, gelöste
  Aufgaben, getroffene Tiere und berührte Lernbereiche (aus der Engine)
- `/lernplan` – Übersicht aller Lern-Zonen und ihrer Lehrplan-21-Bezüge (für Eltern/Lehrpersonen, aus der Engine)
- `/lernwelt` – Status + empfohlene `minetest.conf`-Zeilen (aus der Engine)

## Eigene Grafiken & Sounds

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
