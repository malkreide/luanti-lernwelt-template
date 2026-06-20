# Passende Welt einrichten — Kosmo-Station 🚀

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst und **baust deine Raumstation**
am besten mit den mitgelieferten Blöcken (Stations-Wand, Bullaugen-Glas, Planeten).
Diese Anleitung zeigt, wie du eine **flache, ruhige** Welt mit viel Platz und freiem
Blick einrichtest — ideal für eine Station und fürs Mond-Hüpfen.

> **Wichtig zu wissen:** Die Weltraum-Freunde laufen auf **festem Boden** (kein Wasser
> nötig). Sie erscheinen automatisch in deiner Nähe — und du kannst sie jederzeit mit
> den **Spawn-Eiern** aus der Startausrüstung selbst setzen.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Freunde mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_kosmo`.
- **Kein Wasser nötig:** anders als bei der Tiefsee laufen die Freunde an Land.
- **Friedlich/kein Schaden:** Die Engine schaltet Schaden ab — es kann nichts
  passieren, keine Monster. (Setzt die Engine automatisch.)
- **Himmel:** Das Thema stellt einen **Sternenhimmel** ein (fester Nachthimmel). Die
  Station leuchtet durch viele glühende Planeten- und Sternenstaub-Blöcke.

---

## 2) Wo trägt man die Mapgen-Werte ein?

Mapgen-Einstellungen werden beim **Erstellen** der Welt fest in die Welt geschrieben
(`map_meta.txt`) und lassen sich danach nicht mehr ändern. Der einfachste, zuverlässige
Weg:

1. Im Luanti-Hauptmenü unter **Einstellungen** (oder direkt in `minetest.conf`) die
   unten stehenden Zeilen eintragen.
2. **Danach** eine **neue Welt erstellen** — die Werte werden in die Welt übernommen.
3. Welt betreten. Fertig.

---

## 3) Variante A — „Flache Plattform" (empfohlen zum Bauen)

Eine durchgehend flache Welt — viel Platz und Übersicht, ideal zum Bauen der Station
und für ein Mond-Hüpf-Feld.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 8
```

Das ergibt einen flachen Boden — perfekt, um darauf deine Raumstation zu errichten
(mit `/kosmo_basis` geht es in Sekunden).

---

## 4) Variante B — „Schwebende Plattform / fast leer"

Wer eine möglichst „weltraumartige" leere Umgebung mag, kann mit dem
`singlenode`-Mapgen eine fast leere Welt erzeugen und sich die Station selbst bauen
(Kreativ-Flug an). Das ist etwas für Fortgeschrittene:

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = singlenode
```

In `singlenode` ist die Welt leer — flieg mit Doppel-Sprung, setze einen Boden aus
**Stations-Wand** und baue darauf. (Tipp: `/kosmo_basis` baut dir gleich eine fertige
Kuppel.)

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. Die Zeilen aus **Variante A** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_kosmo`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Kamera, Raumgleiter, Planeten, Schwerkraft-Blöcke, Spawn-Eier).
6. `/kosmo_basis` eingeben → eine fertige Raumstation mit Tafeln, Raumgleiter und
   Mond-Boden erscheint vor dir.
7. Ein paar **Spawn-Eier** setzen → Freunde retten (Rechtsklick). Auf den **Mond-Boden**
   stellen und hoch springen!

---

## 6) Eigene Station bauen (in jeder Welt)

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus, eine flache Stelle suchen.
2. Mit **Stations-Wand** und **Bullaugen-Glas** eine kleine Station bauen.
3. Ein paar **Mond-Boden**- und **Sprung-Pad**-Blöcke als Hüpf-Feld legen.
4. Spawn-Eier setzen — der **Raumgleiter** fliegt überall.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, fester Sternenhimmel, keine Monster) setzt
die Engine **zur Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im
Spiel der Befehl **`/lernwelt`**.
