# Passende Welt einrichten — Drachenhort 🐉⛰️

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du eine
Welt baust, in der sich die Drachen wohlfühlen: **Berge zum Nisten** und **Himmel zum Fliegen**.

> **Wichtig zu wissen:** Du brauchst **keine besondere Welt**. Mit dem Befehl
> `/drachenhort_nest` baust du dir sofort ein fertiges **Drachennest** mit Tafeln, Eiern,
> Brut-Ei und Reitdrachen — egal, wie die Welt aussieht. Die Tipps unten sind nur für eine
> besonders schöne, drachengerechte Landschaft.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Drachen mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_drachenhort`.
- **Höhe & Berge:** Drachen laufen an Land und der **Reitdrache fliegt** gern hoch hinaus.
  Eine **hügelige/bergige** Welt mit viel Platz nach oben passt am besten.
- **Friedlich/kein Schaden:** Die Engine schaltet Schaden ab — Kinder können nichts kaputt
  machen und keine Monster stören. (Setzt die Engine automatisch.) Auch die „kalte Lava" im
  Krater ist **ungefährlich**.

---

## 2) Wo trägt man die Mapgen-Werte ein?

Mapgen-Einstellungen werden beim **Erstellen** der Welt fest in die Welt geschrieben
(`map_meta.txt`) und lassen sich danach nicht mehr ändern. Der einfachste, zuverlässige Weg:

1. Im Luanti-Hauptmenü unter **Einstellungen** (oder direkt in der Datei `minetest.conf`) die
   unten stehenden Zeilen eintragen.
2. **Danach** eine **neue Welt erstellen** — die Werte werden in die Welt übernommen.
3. Welt betreten. Fertig.

---

## 3) Variante A — „Sanfte Hügel & Berge" (empfohlen)

Eine normale, abwechslungsreiche Welt mit Bergen zum Nisten und Tälern für den Krater.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Das ist die normale Welt-Erzeugung mit Bergen, Tälern und Höhlen — ideal, um einen
**Drachenberg** zu suchen und im Tal ein **Nest** (`/drachenhort_nest`) zu bauen.

---

## 4) Variante B — „Schwebe-Bühne für die Himmelsinseln"

Du willst hoch oben **Himmelsinseln** bauen? Eine flache Welt gibt dir eine ruhige Basis,
über der du im Kreativ-Flug frei schwebende Inseln aus **Wolkenblöcken** und **Bergstein**
setzt.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Steig dann mit dem **Reitdrachen** oder im Kreativ-Flug hoch und baue deine Inseln in die Luft.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_drachenhort`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Tagebuch, Reitdrache, Drachenfutter, Brut-Eier, Zähl-Eier, Spawn-Eier).
6. Befehl **`/drachenhort_nest`** eingeben → ein fertiges Drachennest erscheint vor dir.
7. **Brut-Ei** setzen, Baby **geduldig füttern** → zähmen. Drachen anfreunden (Rechtsklick).

---

## 6) Schnell loslegen ohne große Welt

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus.
2. Befehl `/drachenhort_nest` (oder `/drachenhort_teststation`) eingeben.
3. Mit **Wolkenblöcken**, **Bergstein** und **Drachensteinen** Inseln und einen Hort bauen.
4. **Brut-Eier** ausbrüten, **Spawn-Eier** setzen — der **Reitdrache** fliegt überall.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, fester Tag, keine Monster) setzt die Engine **zur
Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im Spiel der Befehl
**`/lernwelt`**.
