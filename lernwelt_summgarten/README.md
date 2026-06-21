# Summ-Garten 🐝🌸🍯

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.1,%20NMG.2-2e7d32)
![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![Bildnerisches Gestalten](https://img.shields.io/badge/Bildnerisches%20Gestalten-BG.1-ad1457)

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um einen **Bienen-und-Blumen-Garten**. Gedacht zum **gemeinsamen Spielen von Eltern und
Kind** (ca. 5–8 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1./2. Zyklus**: das
Thema **verbindet Natur (NMG) mit Geometrie (Mathematik)**.

> Motto: **Bestäuben · Zählen · Muster legen**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Katalog/Logbuch, Ränge, Abzeichen,
Belohnungs-Sounds, Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema
selbst ist im Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` –
plus wenige selbstgebaute Extras (Bestäubungs-Pinsel, Honigschleuder, Honigwabe, Obstblüten).

## Natur trifft Geometrie 🐝➕📐

Der Summ-Garten hat ein klares Ziel: **NMG und Mathematik verbinden**.

- 🐝 **Bestäubung (NMG.1):** Bienen, Hummeln und Schmetterlinge tragen Pollen von Blüte zu Blüte.
  Mit dem **Bestäubungs-Pinsel** machst du das selbst – und siehst, wie aus einer **bestäubten
  Blüte eine Frucht** wird.
- 📐 **Sechseck-Muster (MA.2 – Form & Raum):** Eine **Wabe ist ein Sechseck** (6 Ecken). Viele
  Waben ergeben ein **Muster**, das du auf der Lern-Tafel **fortsetzt**.
- 🎨 **Farben (BG):** Sechs bunte Blumen (rot, gelb, blau, lila, weiss, orange) zum Benennen und
  Ordnen.
- 🔢 **Zählen (MA.1):** Zähle Bienen, Blüten und **Honigtropfen** aus der gefüllten Wabe.

## Lernen im Garten 🌸

Die Kinder entdecken den **Summ-Garten** mit seinen drei Zonen:

- 🌸 **Blumenwiese** – hier beginnt alles: Bienen **bestäuben** die bunten Blumen. Lerne die
  **Farben**, lege ein **Blumenmuster** und hilf den fleissigen Bestäubern.
- 🍎 **Obstgarten** – hier siehst du, **wozu Bestäubung gut ist**: Aus einer bestäubten **Blüte**
  wächst eine **Frucht**. Marienkäfer, Raupen und Regenwürmer helfen dem Garten – zähle sie!
- 🍯 **Honiglager** – hier stapeln sich die **Waben**. Eine Wabe ist ein **Sechseck**. Setze das
  **Waben-Muster** fort, **zähle Honigtropfen** und **schleudere** aus Nektar Honig.

## Funktionen

- 🐝 **Bestäubungs-Pinsel** – Rechtsklick auf eine Blume/Blüte verteilt **Pollen**, lässt aus
  **Obstblüten Früchte wachsen** und sammelt **Nektar**. Übt **Bestäubung** (NMG.1); eigener
  Zähler (Bestäuber-Anfänger → -Profi → -Meister).
- 🍯 **Honigschleuder** – **Nektar → Honig**, mit Zähler und kleinen Auszeichnungen
  (Imker-Lehrling → Imker → Imkermeister).
- 🔢 **Honigwabe zum Zählen** – Rechtsklick erntet einen **Honigtropfen** (zählt mit, MA.1); die
  Wabe wird leer und **füllt sich nach kurzer Zeit wieder** – so kann man immer weiterzählen.
- 📐 **Waben = Sechsecke** – prozedural erzeugte **Honigwaben-Blöcke** (gelb/orange) zum **Muster
  bauen**, plus Aufgaben „Setze das Waben-Muster fort" und „Wie viele Ecken hat ein Sechseck?".
- 🌱 **Obstblüten-Beet** – aus einer **bestäubten** Blüte wächst über Stufen ein **Apfel** (kein
  Bestäuben → keine Frucht).
- 🎨 **Sechs bunte Blumen** (rot, gelb, blau, lila, weiss, orange) – Farben lernen & Wiese bauen.
- 🐾 **13 Garten-Tiere** (mit Mob-API): Biene, Hummel, Schmetterling, Marienkäfer, Raupe, Libelle,
  Regenwurm, Ameise, Grashüpfer, Igel, Amsel, Bienenkönigin – plus die seltene, leuchtende
  **Goldene Honigbiene** 🌟. Rechtsklick = dem Tier **helfen** (friedlich, kein Kämpfen).
- 🗺️ **3 Lern-Zonen** (Blumenwiese, Obstgarten, Honiglager) mit platzierbaren Lern-Tafeln
  (Aktivität + Lehrplan-21-Bezug).
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (Bestäubung, Beine zählen, Sechseck-Ecken), zwei
  **Muster**-Aufgaben (Blumen-Farbmuster & Waben-Muster) und Hilfe-Ziele mit Belohnung.
- 🧱 **Garten-Blöcke** (rein prozedural, ohne Bilddateien): Bienenstock, Bienenkasten, Waben
  (Sechseck-Muster), Wachsblock, Honigglas, Blumenwiese, Gartenerde, Gartenweg, Gartenzaun,
  Blütenhecke, Obstbaum (Stamm & Laub), Gartenlaterne (leuchtet), Obstkiste.
- 📋 **Summ-Garten-Logbuch** – Tier-Steckbriefe mit Zone, „frisst", Zähler und „entdeckt"-Status.
- 📷 **Entdecker-Kamera** – Tiere fotografieren = im Logbuch entdecken.
- 👪 **Tier-Familien** – wer ein „Eltern"-Tier trifft (Biene, Hummel, Marienkäfer, Ameise), bringt
  kleine Begleiter mit.
- 🌍 **Lebendiger Garten** – Tiere erscheinen automatisch in deiner Nähe (abschaltbar per
  Einstellung `lernwelt_spawn_creatures`).
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Pinsel, Nektar + Honig, Blumen &
  Obstblüten, Bau-Blöcke (inkl. Honigschleuder & Honigwabe) und je ein Spawn-Ei (abschaltbar).
- 🏆 **Ränge und Abzeichen**: Gartenkind → Blütenfreund → Bienenhelfer → Gartenmeister →
  Summ-Garten-Held.
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Summen-/Ambient-Sounds aus diesem
  Thema.

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia) für die Tiere. Ohne Mob-API funktioniert alles ausser den lebenden
  Tieren – **Pinsel, Honigschleuder, Honigwabe, Blumen und Obstblüten laufen auch ohne Mob-API**
  (eigener Code).

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_summgarten` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) Ein Game mit Mobs nutzen (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration die Mods aktivieren (`lernwelt` + `lernwelt_summgarten`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung** ins
Inventar. Tipp für den schnellen Einstieg: der Befehl **`/summgarten_bienenstock`** baut dir
sofort einen **ganzen Garten** mit Bienenstock, Lern-Tafeln, Blumenwiese, Obstbaum mit Blüten,
Waben-Wand und Honigschleuder. Im Kreativ-Modus liegen alle Items zusätzlich im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_summgarten_starter_kit = false` setzen.

## Nützliche Befehle

- `/summgarten_bienenstock` – baut einen **ganzen Garten** vor dir (Bienenstock, 3 Lern-Tafeln,
  Blumenwiese, Obstbaum mit Blüten, Waben-Wand, Honigschleuder). Benötigt das `server`-Privileg
  (im Einzelspieler automatisch vorhanden).
- `/summgarten_teststation` – kleine fertige Test-Station, Priv `server`
- `/lernfortschritt` · `/lernplan` · `/lernwelt` – aus der Engine (Fortschritt, Lehrplan, Status)

## Eigene Grafiken und Sounds

Das Thema läuft **ohne externe Dateien** (Farben/Muster via `[fill`-Generator der Engine; das
Waben-Muster wird per Code erzeugt). Eigene Texturen/Sounds können ergänzt werden – siehe
`textures/README.txt` und `sounds/README.txt`. **Bitte nur selbst erstellte oder frei
lizenzierte Inhalte verwenden.**

## Lizenz

- **Code:** MIT – siehe [LICENSE.txt](LICENSE.txt)
- **Mitgelieferte Medien:** keine (alle Farben/Muster werden zur Laufzeit erzeugt)

## Rechtlicher Hinweis

Dies ist ein **eigenständiges Werk**. Es ist **nicht** mit einer Fernsehserie, einem Film,
einem Spiel, einer Marke oder einem Unternehmen verbunden und verwendet **keine** geschützten
Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee „einen Garten mit Bienen pflegen"
ist nicht schutzfähig.
