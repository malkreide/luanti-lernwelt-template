# Baumhaus-Forscher 🌳🔭

Ein **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest) rund um
ein **Dschungel-Baumhaus**. Kinder erkunden die **Stockwerke des Waldes** – oben das
**Blätterdach**, unten der **Fluss** und die **alten Ruinen** – und üben dabei
**Raumorientierung**: oben/unten, Norden/Osten, einem Plan und **Bild-Hinweisen**
folgen. Passend zum Schweizer **Lehrplan 21, 1./2. Zyklus** (NMG.3, Raumorientierung).

> Motto: **Erkunden · Orientieren · Entdecken**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Logbuch, Ränge, Abzeichen, Rettungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebauten Extras: der **Reit-Papagei**, die **Bilderrahmen mit Bild-Hinweisen**,
die **Schnitzeljagd**, der **Forscher-Kompass** und die kletterbaren Lianen/Strickleitern.

## Die Lernidee: Raumorientierung 🧭

- **Stockwerke des Waldes (oben/unten):** Die Welt ist bewusst **vertikal** gebaut. Du
  kletterst über **Strickleitern** und **Lianen** ins **Blätterdach** (oben) und steigst
  zum **Fluss** und in die **Ruinen** hinab (unten).
- **Schnitzeljagd mit Bild-Hinweisen:** Kleine **Bilderrahmen** zeigen ein **Bild** –
  ein Blatt, einen Wassertropfen, einen Stein, eine Tier-Spur, einen Schatz oder einen
  **Richtungspfeil**. Das Kind „liest" das Bild als Hinweis, folgt der Richtung
  (Norden/Osten/oben/unten) und findet den nächsten Rahmen – bis zum **Schatz**.
- **Forscher-Kompass:** sagt dir, in welche **Himmelsrichtung** du schaust, **wie hoch**
  du bist (welches Stockwerk) und wo der **nächste Hinweis** ist.

## Funktionen

- 🗺️ **3 Lern-Zonen / Stockwerke** (Blätterdach, Fluss, Alte Ruinen) mit platzierbaren
  Lern-Tafeln (Aktivität + Lehrplan-21-Bezug)
- 🖼️ **Bilderrahmen mit Bild-Hinweisen** – platziere eigene Rahmen, **Rechtsklick**
  wechselt das Bild, **Schleichen+Rechtsklick** öffnet die Bild-Auswahl. Baue deine
  **eigene Schnitzeljagd**!
- 🧭 **Schnitzeljagd** (`/baumhaus_schnitzeljagd`) – eine fertige Bild-Hinweis-Kette mit
  Pfeilen, die (auch nach oben!) zum **Schatz** führt
- 🧭 **Forscher-Kompass** – Himmelsrichtung, Höhe/Stockwerk und Weg zum nächsten Hinweis
- 🪜 **Kletterbare Lianen & Strickleitern** – hoch ins Blätterdach, runter zum Boden
  (das **Stockwerke-oben/unten**-Erlebnis zum Anfassen)
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (oben/unten, wer schwimmt, Pfeile lesen),
  **Muster nachlegen** (Blätter von hell nach dunkel) und Rette-Ziele mit Belohnung
- 📔 **Forscher-Tagebuch** – Steckbriefe mit Rettungs-Zähler und „entdeckt"-Status
- 📷 **Entdecker-Kamera** – Dschungeltiere fotografieren = im Tagebuch entdecken
- 🦜 **14 rettbare Dschungeltiere** (mit Mob-API): Papagei, Affe, Faultier, Tukan,
  Dschungel-Falter, Laubfrosch, Fisch, Schildkröte, Reiher, Libelle, Gecko, Fledermaus,
  Nashorn-Käfer – plus den seltenen, legendären **Goldenen Jaguar** ✨
- 👪 **Familien** – wer ein Elterntier rettet (Papagei, Affe, Schildkröte), bringt seine
  Jungen mit
- 🐒 **Lebendiger Dschungel** – die Tiere erscheinen automatisch auf festem Boden in
  deiner Nähe (schonend begrenzt; abschaltbar per `lernwelt_spawn_creatures`)
- 🌿 **Treibende Blätter** – sanft herabschwebende Blätter (reine Atmosphäre)
- 🦜 **Reit-Papagei** zum Reiten – fliegt **hoch ins Blätterdach** und über den Fluss,
  mit **Doppelsitz** für Eltern + Kind
- 🌳 **Großes Baumhaus** als Basis (`/baumhaus_bauen`) mit Plattform, Blätterdach,
  Strickleiter, den 3 Lern-Tafeln und Bild-Hinweisen auf zwei Stockwerken
- 🎒 **Startausrüstung** beim ersten Join: Tagebuch, Kamera, Kompass, Reit-Papagei,
  Bilderrahmen, Lianen, Strickleitern, Bau-Blöcke, Spawn-Eier (abschaltbar)
- 🏆 **Ränge und Abzeichen**: Baumhaus-Knirps → Ast-Kletterer → Blätterdach-Forscher →
  Ruinen-Entdecker → Dschungel-Meister
- 🔊 **Sound-Hooks** – Rettungs-/Rang-Sounds aus der Engine, Papagei-, Dschungel- und
  Ambient-Sounds aus diesem Thema

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Tieren.

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_baumhaus` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_baumhaus`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Passende Welt

Deine **Basis ist ein grosses Baumhaus** – am schnellsten mit dem Befehl
`/baumhaus_bauen` (es erscheint fertig vor dir). Eine flache, ruhige Welt ist ideal,
weil das Baumhaus dann besonders gut zur Geltung kommt – Details in
**[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung**:
Forscher-Tagebuch, Kamera, **Forscher-Kompass**, **Reit-Papagei**, **Bilderrahmen**,
Lianen, Strickleitern, Bau-Blöcke und ein Spawn-Ei pro Tier. Dann:

1. `/baumhaus_bauen` → ein grosses Baumhaus erscheint. Klettere die **Strickleiter hoch**.
2. `/baumhaus_schnitzeljagd` → eine **Schnitzeljagd mit Bild-Hinweisen** wird gelegt –
   folge den Pfeilen bis zum Schatz.

Abschalten der Startausrüstung: `lernwelt_baumhaus_starter_kit = false`.

## Steuerung des Reit-Papageis

Platzieren → Rechtsklick zum Aufsteigen → **W/S** fliegen, **A/D** lenken,
**Springen** = hoch (ins Blätterdach), **Schleichen** = runter, **Rechtsklick** = absteigen.

## Nützliche Befehle

- `/baumhaus_bauen` – baut das **grosse Baumhaus** (Basis) mit Plattform, Blätterdach,
  Strickleiter, Tafeln, Bild-Hinweisen und Papagei (Priv `server`)
- `/baumhaus_schnitzeljagd` – legt eine **Schnitzeljagd mit Bild-Hinweisen** vor dir an
  (Bilderrahmen mit Pfeilen → Schatz) (Priv `server`)
- `/baumhaus_teststation` – baut eine kleine fertige Test-Station (Boden, 3 Tafeln,
  Papagei, Bilderrahmen, Strickleiter) (Priv `server`)
- `/lernfortschritt` – dein persönlicher Lernfortschritt (aus der Engine)
- `/lernplan` – Übersicht aller Lern-Zonen und ihrer Lehrplan-21-Bezüge (aus der Engine)
- `/lernwelt` – Status + empfohlene `minetest.conf`-Zeilen (aus der Engine)

## Eigene Grafiken und Sounds

Das Thema läuft **ohne externe Dateien** (Farben & Muster via `[fill`-Generator). Eigene
Texturen/Sounds können ergänzt werden – siehe `textures/README.txt` und
`sounds/README.txt`. Besonders schön: **eigene Foto-Hinweise** in den Bilderrahmen für
eine Schnitzeljagd in der echten Umgebung der Kinder. **Bitte nur selbst erstellte oder
frei lizenzierte Inhalte verwenden.**

## Lizenz

- **Code:** MIT – siehe [LICENSE.txt](LICENSE.txt)
- **Mitgelieferte Medien:** keine (alle Farben werden zur Laufzeit erzeugt)

## Rechtlicher Hinweis

Dies ist ein **eigenständiges Werk**. Es ist **nicht** mit einer Fernsehserie, Marke
oder einem Unternehmen verbunden und verwendet **keine** geschützten Namen, Figuren,
Logos oder Designs. Die allgemeine Spielidee „Dschungel-Baumhaus" sowie allgemeine
Tier- und Pflanzennamen sind nicht schutzfähig.
