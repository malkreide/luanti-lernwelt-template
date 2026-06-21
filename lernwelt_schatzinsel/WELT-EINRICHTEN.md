# Passende Welt einrichten — Schatzinsel 🏝️

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du
eine Welt mit **Inseln, Meer und Höhlen** baust, in der sich die Schatzinsel besonders
gut spielt.

> **Wichtig zu wissen:** Du brauchst **keine perfekte Insel-Welt**. Mit dem Befehl
> **`/schatzinsel_schiff`** steht sofort ein fertiges Schatzschiff mit Steg vor dir,
> und die Tiere setzt du jederzeit mit den **Spawn-Eiern** (in der Startausrüstung).
> Ein selbst gegrabenes Wasserbecken reicht für das Floss und die Lagunen-Fische.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_schatzinsel`.
- **Insel + Wasser:** Schön ist viel Meer mit Inseln. Die Lagunen-Tiere
  (`swims = true`) schwimmen nur in Wasser; die Insel- und Höhlentiere leben an Land.
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

---

## 3) Variante A — „Meer mit Inseln" (empfohlen)

Eine normale, hügelige Welt, aber mit höherem Wasserspiegel, sodass viel Meer mit
einzelnen **Inseln** entsteht — perfekt für eine Schatzinsel.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
water_level = 20
```

`water_level` hebt den Meeresspiegel an. Je höher der Wert, desto mehr Land wird
überflutet und desto „inseliger" wird die Welt — gern mit Werten zwischen 10 und 40
experimentieren, bis dir das Verhältnis von Meer und Inseln gefällt.

> 🕳️ **Tropfsteinhöhle:** In VoxeLibre/Mineclonia gibt es natürliche Höhlen unter der
> Erde. Grabe dich an einer Insel nach unten — oder baue dir mit `hoehlenstein`,
> `tropfstein` und `kristall` selbst eine kleine Höhle als dritte Lern-Zone.

---

## 4) Variante B — „Flache Insel-Bucht" (zum Testen)

Eine durchgehend flache, ruhige Welt mit einer großen Wasserfläche — übersichtlich und
ideal zum schnellen Ausprobieren.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 3
water_level = 2
```

Das ergibt flachen Boden bei Höhe 3 mit einer ruhigen Wasserkante darunter. Mit
Kreativ-Flug baust du dir aus `sand`, `palme_stamm`/`palme_blatt` und den
Schiffs-Blöcken schnell deine eigene Insel.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_schatzinsel`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Bordbuch, Kompass, Schatzkarte, Floss, Goldmünzen, Bau-Blöcke, Spawn-Eier).
6. **`/schatzinsel_schiff`** eingeben → ein fertiges Schatzschiff mit Steg, Tafeln,
   Mast (zum Klettern), Schatzkiste und Floss erscheint vor dir.
7. **`/schatzinsel_schnitzeljagd`** eingeben → eine Schnitzeljagd mit Wegweisern legt
   sich an. Folge den Pfeilen bis zum Schatz!
8. **`/schatzinsel_muenzen`** eingeben → Goldmünzen zum Einsammeln und Zählen.

---

## 6) Keine Insel? Mini-Bucht bauen

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus, ein Loch graben (z. B. 8×8×4) und mit Wasser füllen (Wasser-Eimer /
   im Kreativ-Inventar) — das wird deine **Lagune**.
2. Rundherum mit **`sand`** einen Strand und mit **Palmen** ein paar Bäume bauen.
3. **`/schatzinsel_schiff`** an der Wasserkante eingeben — das **Floss** fährt hier.
4. Spawn-Eier setzen — die Lagunen-Fische ins Wasser, die Insel-Tiere an den Strand.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, kein Ertrinken, fester Tag, keine
Monster) setzt die Engine **zur Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen
dazu zeigt im Spiel der Befehl **`/lernwelt`**.
