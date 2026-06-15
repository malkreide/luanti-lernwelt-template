# Passende Welt einrichten — Tiefsee-Retter 🌊

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du
eine **wasserreiche** Welt baust, in der sich die Meerestiere wohlfühlen.

> **Wichtig zu wissen:** Die Tiere erscheinen **nicht von selbst**. Du setzt sie mit
> den **Spawn-Eiern** (in der Startausrüstung beim ersten Join). Damit reicht im
> Notfall sogar ein selbst gegrabenes Wasserbecken — ein großer Ozean ist vor allem
> für die Atmosphäre und den Platz schön.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_tiefsee`.
- **Wasser:** Die Tiere haben `swims = true` und schwimmen nur in Wasser. Du brauchst
  also ein Meer (oder ein selbst gefülltes Becken).
- **Friedlich/kein Ertrinken:** Die Engine schaltet Schaden ab — Kinder können nicht
  ertrinken und keine Monster stören. (Setzt die Engine automatisch.)

---

## 2) Wo trägt man die Mapgen-Werte ein?

Mapgen-Einstellungen werden beim **Erstellen** der Welt fest in die Welt geschrieben
(`map_meta.txt`) und lassen sich danach nicht mehr ändern. Der einfachste, zuverlässige
Weg:

1. Im Luanti-Hauptmenü unter **Einstellungen** (oder direkt in der Datei
   `minetest.conf`) die unten stehenden Zeilen eintragen.
2. **Danach** eine **neue Welt erstellen** — die Werte werden in die Welt übernommen.
3. Welt betreten. Fertig.

(Alternativ kann man die Werte vor dem ersten Betreten direkt in
`worlds/<deine_welt>/map_meta.txt` setzen — fummeliger, daher nicht nötig.)

---

## 3) Variante A — „Flaches Meer" (empfohlen zum Testen)

Eine durchgehend flache, ruhige Unterwasser-Welt — übersichtlich und ideal für Kinder.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
water_level = 14
```

Das ergibt einen flachen Meeresboden bei Höhe 2 und darüber rund **12 Blöcke tiefes
Wasser** — überall. Mit Kreativ-Flug tauchst du bequem ab und baust mit dem
**Stations-Glas** eine Unterwasser-Station.

---

## 4) Variante B — „Natürlicher Ozean"

Eine normale, hügelige Welt, aber mit höherem Wasserspiegel, sodass viel Meer mit
einzelnen Inseln entsteht.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
water_level = 30
```

`water_level` hebt den Meeresspiegel an (Standard ist meist 1). Je höher der Wert,
desto mehr Land wird überflutet — gern mit verschiedenen Werten experimentieren, bis
dir das Verhältnis von Meer und Inseln gefällt.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_tiefsee`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Tauchkapsel, Korallen, Spawn-Eier).
6. Ins Wasser gehen, ein paar **Spawn-Eier** setzen → Tiere retten (Rechtsklick).
7. Optional `/tiefsee_teststation` eingeben → fertige Station (Tafeln + Tauchkapsel)
   erscheint vor dir.

---

## 6) Kein eigenes Meer? Mini-Becken bauen

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus, ein Loch graben (z. B. 8×8×4).
2. Mit Wasser füllen (Wasser-Eimer / im Kreativ-Inventar).
3. Mit **Stations-Glas** und **Korallen** eine kleine Station bauen.
4. Spawn-Eier ins Wasser setzen — die **Tauchkapsel** fährt auch hier.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, kein Ertrinken, fester Tag, keine
Monster) setzt die Engine **zur Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen
dazu zeigt im Spiel der Befehl **`/lernwelt`**.
