# Passende Welt einrichten — Saurier-Forscher 🦕

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du
eine Welt baust, in der sich die Dinos wohlfühlen.

> **Wichtig zu wissen:** Die Dinos laufen auf **festem Boden** (Land). Es eignet sich
> jede ganz normale Welt. Sie **erscheinen** in deiner Nähe automatisch (Boden + Luft
> darüber) oder du setzt sie mit den **Spawn-Eiern** (in der Startausrüstung).

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Dinos mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_saurier`.
- **Boden:** Die Dinos brauchen festen Boden (Gras, Sand, Erde, Stein). Eine Welt mit
  Hügeln, etwas Sand und Grün passt am besten.
- **Friedlich/kein Sterben:** Die Engine schaltet Schaden ab — Kinder können nichts
  kaputtmachen und keine Monster stören. (Setzt die Engine automatisch.)

---

## 2) Wo trägt man die Mapgen-Werte ein?

Mapgen-Einstellungen werden beim **Erstellen** der Welt fest in die Welt geschrieben
(`map_meta.txt`) und lassen sich danach nicht mehr ändern. Der einfachste, zuverlässige
Weg:

1. Im Luanti-Hauptmenü unter **Einstellungen** (oder direkt in der Datei
   `minetest.conf`) die unten stehenden Zeilen eintragen.
2. **Danach** eine **neue Welt erstellen** — die Werte werden in die Welt übernommen.
3. Welt betreten. Fertig.

---

## 3) Variante A — „Flaches Übungsland" (empfohlen zum Testen)

Eine durchgehend flache, ruhige Welt — übersichtlich und ideal für Kinder und zum
Bauen einer Forscherstation.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Das ergibt überall flachen Boden. Mit Kreativ-Flug baust du bequem deine Station, legst
mit `/saurier_grabung` Grabungsfelder an und setzt Dinos aus den Spawn-Eiern.

---

## 4) Variante B — „Natürliche Landschaft"

Eine normale, hügelige Welt mit Wäldern, Wiesen und Sand — schön für ein lebendiges
Dino-Tal.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Hügel, Täler und Sandflächen entstehen von selbst. Such dir ein schönes Tal als
Forscherstation aus.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_saurier`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Kamera, Jeep, Dino-Eier, Grabungssand, Spawn-Eier).
6. Befehl `/saurier_forscherstation` eingeben → fertige Station mit Tafeln, Jeep und
   Grabungsfeld erscheint vor dir.
7. Dinos erforschen (Rechtsklick), Fossilien ausgraben (Grabungssand abbauen) und
   Eier ausbrüten.

---

## 6) Eine Forscherstation bauen

Auch ohne Befehl geht es leicht von Hand:

1. Kreativmodus, einen ebenen Platz suchen.
2. Mit **Sandstein**, **Fels** und **Stations-Glas** eine Station bauen.
3. Die drei **Lern-Tafeln** (`tafel_tal`, `tafel_grabung`, `tafel_nistplatz`) aufstellen.
4. Ein Feld mit **Grabungssand** als Grabungsstätte anlegen.
5. Ein paar **Spawn-Eier** setzen und **Dino-Eier** zum Ausbrüten platzieren.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, kein Sterben, fester Tag, keine
Monster) setzt die Engine **zur Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen
dazu zeigt im Spiel der Befehl **`/lernwelt`**.
