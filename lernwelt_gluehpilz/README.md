# Glühpilz-Wald 🍄

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.1-2e7d32)
![Deutsch (Sprache)](https://img.shields.io/badge/Deutsch%20(Sprache)-D.2-c62828)

<!-- Screenshot-Slot — sobald docs/img/lernwelt_gluehpilz.png existiert, die nächste Zeile einkommentieren:
![Screenshot der Welt lernwelt_gluehpilz](../docs/img/lernwelt_gluehpilz.png)
-->

Ein besonders **niederschwelliges, „kuscheliges" Lernwelt-Thema für
[Luanti](https://www.luanti.org/)** (früher Minetest) rund um ein **gemütliches
Pilzreich** – gedacht als **ideale Erstwelt** für die Jüngsten. Zum **gemeinsamen Spielen
von Eltern und Kind** (ca. 4–7 Jahre), spielerisch passend zum Schweizer **Lehrplan 21,
1. Zyklus** (Mathematik, Natur-Mensch-Gesellschaft).

> Motto: **Staunen · Sortieren · Kuscheln**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Logbuch, Ränge, Abzeichen, Rettungs-Sounds,
Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema selbst ist im
Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` – plus die
selbstgebauten Extras, die die Engine nicht abbildet: den **Leucht-Käfer** und die
**Tag-Nacht-Pilze**.

## Warum als Erstwelt?

- **Sehr einfach:** wenig Text, grosse Knöpfe, freundliche Tiere, **kein Verlieren**.
- **Kein Wasser-Stress, keine dunklen Tiefen:** ein **heller, gemütlicher Wald**.
- **Drei klare Lernideen** statt vieler Mechaniken: **Grössen vergleichen** (klein/gross),
  **nach Farbe sortieren** und den **Tag-Nacht-Wechsel** über leuchtende Pilze erleben.
- **Easy-Mode** (`lernwelt_easy_mode`) blendet bei Quizfragen nur **2 Antworten** ein.

## Funktionen

- 🍄 **6 bunte Glühpilze** (rot, blau, gelb, grün, pink, lila) – glühend, ideal zum
  **Sortieren nach Farbe**, zum **Zählen** und als **kuschliges Nachtlicht**
- 🌗 **Tag-Nacht-Pilze** – das Highlight: per **Rechtsklick** auf einen leuchtenden Pilz
  wechselt die **Tageszeit** der ganzen Welt:
  - **Tag-Pilz** → es wird hell, die Sonne scheint
  - **Dämmer-Pilz** → goldene Abendstimmung
  - **Nacht-Pilz** → es wird Nacht, und die Glühpilze leuchten den Wald aus
- 📏 **Grössen vergleichen** am **Bach**: der grosse **Biber** und die winzige
  **Wassermaus** machen klein/gross zum Kinderspiel
- 🎨 **Gemusterte Bau-Blöcke** (Fliegenpilz, Punkte, Streifen, Schachbrett, Rahmen,
  Honigwabe, Moos, Waldboden, Pilz-Stamm, Holz-Dielen, Bach-Kiesel, Seerose …) – Muster
  rein prozedural, ganz ohne Bilddateien
- 🍄 **Pilz-Hut** mit echtem roten Punkt-Dach (Pro-Seiten-Textur) + **Vorrats-Stumpf**
- 🔤 **Buchstaben-Blöcke A–Z** zum Wörterlegen (passt zu „Deutsch / benennen")
- 🗺️ **3 Lern-Zonen** (Pilzwald, Glüh-Höhle, Bach) mit platzierbaren Lern-Tafeln
  (Aktivität + Lehrplan-21-Bezug)
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (Farbe, gross/klein, Tag/Nacht), **Muster
  nachlegen** (Farb-Reihe sortieren) und Rette-Ziele mit Belohnung
- 📔 **Wald-Tagebuch** – Steckbriefe mit Rettungs-Zähler und „entdeckt"-Status
- 📷 **Entdecker-Kamera** – Waldtiere fotografieren = im Tagebuch entdecken (Sammeln,
  getrennt vom Retten)
- 🦔 **14 rettbare Waldtiere** (mit Mob-API): Igel, Marienkäfer, Schmetterling,
  Eichhörnchen, Schnecke, Glühwürmchen, Leucht-Käfer, Fledermaus, Kristall-Schnecke,
  Biber, Wassermaus, Entlein, Frosch – plus den seltenen, magischen **Traum-Falter** ✨
- 👪 **Familien** – wer ein Elterntier rettet (Igel, Eichhörnchen, Entlein), bringt
  seine Jungen mit
- 🐌 **Lebendiger Wald** – die Tiere erscheinen automatisch auf festem Boden in deiner
  Nähe (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`)
- ✨ **Glüh-Sporen** – nachts treiben weiche, leuchtende Sporen um dich herum (reine
  Atmosphäre, kuschelig)
- 🧹 **Wald aufräumen** – Müll einsammeln macht den Wald sauberer (Zähler + Meilensteine)
- 🍄 **Pilze pflanzen** – Pilz-Setzlinge wachsen zu bunten Glühpilzen, eigener Pilz-Zähler
- 🪲 **Leucht-Käfer** zum Reiten – sanft und langsam, mit Glühen, Sporen-Spur und
  **Doppelsitz** für Eltern + Kind
- 🎒 **Startausrüstung** beim ersten Join: Tagebuch, Kamera, Leucht-Käfer, Glühpilze,
  Tag-Nacht-Pilze, Bau-Blöcke, Pilz-Setzlinge und je ein Spawn-Ei (abschaltbar)
- 🏆 **Ränge und Abzeichen**: Pilz-Knirps → Wald-Schnupperer → Pilz-Freund →
  Glüh-Hüter → Wald-König
- 🔊 **Sound-Hooks** – Rettungs-/Rang-Sounds aus der Engine, Käfer-, Pilz- und
  Wald-/Ambient-Sounds aus diesem Thema

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Tieren.

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_gluehpilz` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_gluehpilz`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Passende Welt

Der Glühpilz-Wald braucht **kein Wasser**. Deine **Basis ist ein grosses Pilzhaus** –
am schnellsten mit dem Befehl `/pilzwald_haus` (es erscheint fertig vor dir). Wie du
eine passende, flache und ruhige Welt einrichtest, steht in
**[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung**
ins Inventar: Wald-Tagebuch, Kamera, Leucht-Käfer, Glühpilze, die **Tag-Nacht-Pilze**,
Bau-Blöcke, Pilz-Setzlinge und ein Spawn-Ei pro Waldtier. Damit kannst du sofort
losspielen. Im Kreativ-Modus liegen alle Items zusätzlich im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_gluehpilz_starter_kit = false` setzen.

## Steuerung des Leucht-Käfers

Platzieren → Rechtsklick zum Aufsteigen → **W/S** fliegen, **A/D** lenken,
**Springen** = hoch, **Schleichen** = runter, **Rechtsklick** = absteigen.

## Nützliche Befehle

- `/pilzwald_haus` – baut das **grosse Pilzhaus** (Basis) mit Tafeln, Glühpilzen,
  Tag-Nacht-Pilzen und einem Leucht-Käfer. Benötigt das `server`-Privileg (im
  Einzelspieler automatisch vorhanden); überschreibt die Blöcke am Bauort.
- `/pilzwald_teststation` – baut eine kleine fertige Test-Station vor dir (Moos-Boden,
  alle 3 Lern-Tafeln, ein Leucht-Käfer, eine Reihe Tag-Nacht-Pilze, etwas Müll) (Priv `server`)
- `/pilzwald_muell` – verteilt etwas Wald-Müll zum Aufräumen um dich herum (Priv `server`)
- `/lernfortschritt` – dein persönlicher Lernfortschritt: Rang, Rettungen, gelöste
  Aufgaben, getroffene Tiere und berührte Lernbereiche (aus der Engine)
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
Marke oder einem Unternehmen verbunden und verwendet **keine** geschützten Namen,
Figuren, Logos oder Designs. Die allgemeine Spielidee „gemütlicher Pilzwald" sowie
allgemeine Tier- und Pilznamen sind nicht schutzfähig.
