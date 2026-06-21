# Schrauber-Werkstatt 🤖🔧

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Medien und Informatik](https://img.shields.io/badge/Medien%20und%20Informatik-MI.1,%20MI.2,%20MI.3-6a1b9a)
![Textiles und Technisches Gestalten](https://img.shields.io/badge/Textiles%20und%20Technisches%20Gestalten-TTG.2-5d4037)
![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.4-2e7d32)

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um eine **Werkstatt voller Roboter**. Gedacht zum **gemeinsamen Spielen von Eltern und
Kind** (ca. 6–9 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1./2. Zyklus**
(**Medien & Informatik**, Technik/TTG).

> Motto: **Verdrahten · Zusammenbauen · Wiederverwerten**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Katalog/Logbuch, Ränge, Abzeichen,
Belohnungs-Sounds, Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema
selbst ist im Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` –
plus die selbstgebauten Extras: das **Logik-System** (Schalter → Leitung → Lampe → Tür),
**Roboter zusammenbauen**, ein **Fließband** und ein **Recycler**, die die Engine nicht abbildet.

## Die direkte Brücke zu Mesecons 🔌

Das Herzstück ist **einfache Logik und Ursache & Wirkung**. Kinder verdrahten selbst eine
kleine Schaltung: **Schalter → Leitung → Lampe → Tür**. Schalter umlegen → die Leitung leuchtet,
die Lampe geht an, die Tür öffnet sich. Genau dieses „**wenn-dann**" ist die Grundidee von
[Mesecons](https://mesecons.net/) (Luantis Redstone) – und dieses Thema ist die sanfte
**Einstiegsrampe** dahin.

- **Ohne Mesecons** läuft das eigene Mini-Logik-System komplett selbstständig.
- **Mit installiertem Mesecons** sprechen Schalter, Taster, Lampe und Tür **zusätzlich** mit
  echten Mesecons-Drähten (Schalter = Receptor, Lampe/Tür = Effector). So lässt sich nahtlos
  weiterbauen.

## Funktionen

- 🔌 **Einfache Logik selbst verdrahten** – **Schalter**, **Taster** (kurzer Impuls),
  **Leitung** (leuchtet unter Strom), **Lampe** und **Tür** (öffnet sich). Ein verbundenes
  Leitungsnetz ist „unter Strom", sobald **irgendein** Schalter an ist (Ursache & Wirkung).
- 🤖 **Roboter zusammenbauen** (das Herzstück): einen **Roboter-Bausatz** setzen und die
  Bauteile **in der richtigen Reihenfolge** anbauen – **Beine → Körper → Arme → Kopf**. Ein
  falsches Teil wird mit einem Hinweis abgelehnt: die **Reihenfolge ist der Algorithmus**. Fertig
  schaltet der Roboter sich ein, leuchtet und **folgt** seinem Kind.
- 🎢 **Fließband** – schiebt **dich und alles, was darauf liegt** in Pfeilrichtung weiter.
  Cause & Effect zum Draufstellen.
- ♻️ **Recyclinghof** – einen **Schrotthaufen** abbauen = **Schrott**, den **Recycler** damit
  füttern = ein **neues Bauteil** (Materialkreislauf, NMG.4).
- 🛠️ **Werkstatt-Blöcke** (rein prozedural, ohne Bilddateien): Werkbank (Pro-Seite-Textur),
  Stahlplatte, Riffelblech, Schraubenkiste, Zahnrad-Block, Warnband, Bodenfliese, Glaswand,
  leuchtender Energie-Block und Roboterblech in 3 Farben.
- 🔤 **Buchstaben-Blöcke A–Z** zum Beschriften (Maschinen, Schränke benennen).
- 🗺️ **3 Lern-Zonen** (Fließband, Energieraum, Recyclinghof) mit platzierbaren Lern-Tafeln
  (Aktivität + Lehrplan-21-Bezug).
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (Ursache & Wirkung, Logik, Recycling), **Muster
  nachlegen** (die Bau-Reihenfolge als Algorithmus) und Reparier-Ziele mit Belohnung; zählen
  für `/lernfortschritt`.
- 📋 **Roboter-Katalog** – Roboter-Steckbriefe mit Reparier-Zähler und „entdeckt"-Status.
- 📷 **Entdecker-Kamera** – Roboter fotografieren = im Katalog entdecken (Sammeln, getrennt
  vom Reparieren).
- 🤖 **10 Roboter** (mit Mob-API): Rollbot, Greifbot, Sortierbot, Funkenbot, Lampenbot,
  Schaltbot, Sammelbot, Pressbot, Putzbot – plus den seltenen, goldenen **Meisterbot** 🌟.
- 👪 **Roboter-Familien** – wer ein „Eltern"-Modell repariert (Greifbot, Schaltbot), bringt
  kleine Begleit-Bots mit.
- 🌍 **Lebendige Werkstatt** – defekte Roboter erscheinen automatisch an Land in deiner Nähe
  (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`).
- 🎒 **Startausrüstung** beim ersten Join: Katalog, Kamera, Roboter-Bausätze + Bauteile,
  Logik-Kit, Fließband, Recycler + Schrott, Bau-Blöcke und je ein Spawn-Ei (abschaltbar).
- 🏆 **Ränge und Abzeichen**: Schrauber-Lehrling → Bastler → Techniker → Ingenieur → Robotermeister.
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Maschinen-/Ambient-Sounds aus
  diesem Thema.

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia). Ohne Mob-API funktioniert alles ausser den lebenden Robotern –
  **Logik, Roboter-Bausatz, Fließband und Recycler laufen auch ohne Mob-API** (eigener Code).
- **`mesecons`** – *optional*: Ist es installiert, sprechen Schalter/Lampe/Tür zusätzlich mit
  echten Mesecons-Drähten. Ohne Mesecons läuft das eigene Mini-Logik-System.

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_schrauber` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional) Eine Mob-API installieren bzw. ein Game mit Mobs nutzen
   (VoxeLibre/Mineclonia bringt `mcl_mobs` mit). (Optional) **Mesecons** installieren.
3. In der Welt-Konfiguration **beide** Mods aktivieren (`lernwelt` + `lernwelt_schrauber`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung** ins
Inventar. Tipp für den schnellen Einstieg: der Befehl **`/schrauber_logik`** baut dir sofort
eine fertige **Schalter → Lampe → Tür**-Schaltung; **`/schrauber_werkstatt`** baut die ganze
Werkstatt. Im Kreativ-Modus liegen alle Items zusätzlich im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_schrauber_starter_kit = false` setzen.

## Logik in 3 Schritten (kurz)

1. **Schalter** auf den Boden setzen, daneben ein paar **Leitungen** in einer Reihe, am Ende
   eine **Lampe** (und/oder eine **Tür**).
2. **Schalter** mit **Rechtsklick** umlegen → die Leitung leuchtet, die Lampe geht an, die Tür
   öffnet sich.
3. Schalter wieder aus → alles geht aus. Das ist **Ursache und Wirkung** (wenn-dann).

## Roboter bauen (kurz)

1. **Roboter-Bausatz** setzen (Rechtsklick auf den Boden) → ein Roboter-Rahmen erscheint.
2. Bauteile **in dieser Reihenfolge** in die Hand nehmen und den Rahmen mit **Rechtsklick**
   anbauen: **Beine → Körper → Arme → Kopf**.
3. Nach dem Kopf schaltet der Roboter sich **ein**, leuchtet und **folgt** dir.

## Nützliche Befehle

- `/schrauber_werkstatt` – baut eine **ganze Werkstatt** vor dir (Raum, 3 Lern-Tafeln, eine
  funktionierende Schalter-Lampe-Tür-Schaltung, Fließband, Recycler + Schrotthaufen,
  Roboter-Rahmen). Benötigt das `server`-Privileg (im Einzelspieler automatisch vorhanden).
- `/schrauber_logik` – baut eine fertige **Schalter → Leitung → Lampe → Tür**-Schaltung, Priv `server`
- `/schrauber_teststation` – kleine fertige Test-Station, Priv `server`
- `/schrauber_roboter` – setzt einen Roboter-Rahmen zum Zusammenbauen aus, Priv `server`
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
Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee „Roboter bauen und kleine
Schaltungen verdrahten" ist nicht schutzfähig.
