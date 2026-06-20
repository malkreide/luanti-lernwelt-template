# Passende Welt einrichten — Schrauber-Werkstatt 🤖🏭

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du eine Welt
baust, in der sich die Werkstatt gut einrichten lässt: am liebsten **flach und ebenerdig**.

> **Wichtig zu wissen:** Du brauchst **keine besondere Welt**. Mit dem Befehl
> `/schrauber_werkstatt` baust du dir sofort eine fertige **Werkstatt** mit Tafeln, einer
> funktionierenden Schaltung, Fließband, Recycler und Roboter — egal, wie die Welt aussieht.
> Die Tipps unten sind nur für eine besonders schöne, ebene Bühne.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Roboter mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_schrauber`. **Optional:** `mesecons` für die
  echte Mesecons-Brücke.
- **Flach ist gut:** Eine Werkstatt baut sich am leichtesten auf **ebenem Boden**. Eine flache
  Welt gibt dir eine ruhige, große Bühne für Fließbänder, Schaltungen und Roboterstraßen.
- **Friedlich/kein Schaden:** Die Engine schaltet Schaden ab — Kinder können nichts kaputt
  machen und keine Monster stören. (Setzt die Engine automatisch.)

---

## 2) Wo trägt man die Mapgen-Werte ein?

Mapgen-Einstellungen werden beim **Erstellen** der Welt fest in die Welt geschrieben
(`map_meta.txt`) und lassen sich danach nicht mehr ändern. Der einfachste, zuverlässige Weg:

1. Im Luanti-Hauptmenü unter **Einstellungen** (oder direkt in der Datei `minetest.conf`) die
   unten stehenden Zeilen eintragen.
2. **Danach** eine **neue Welt erstellen** — die Werte werden in die Welt übernommen.
3. Welt betreten. Fertig.

---

## 3) Variante A — „Flache Werkstatt-Halle" (empfohlen)

Eine ebene Welt als große, freie Bühne für die ganze Werkstatt.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Damit hast du überall ebenen Boden — ideal, um mit `/schrauber_werkstatt` eine Werkstatt zu
setzen und drumherum Fließbänder, Schaltungen und Roboterstraßen zu bauen.

---

## 4) Variante B — „Normale Welt mit Höhlen"

Du willst auch Berge, Höhlen und Material? Dann nimm die normale Welt-Erzeugung.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Eine ebene Stelle suchen (oder im Kreativ-Modus planieren) und dort die Werkstatt setzen.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
   (Optional) **Mesecons** installieren.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_schrauber`** anhaken (und ggf. `mesecons`).
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Katalog, Kamera, Roboter-Bausätze + Bauteile, Logik-Kit, Fließband, Recycler, Bau-Blöcke).
6. Befehl **`/schrauber_werkstatt`** eingeben → eine fertige Werkstatt erscheint vor dir.
7. **Schalter** umlegen (Lampe an, Tür auf), einen **Roboter** der Reihe nach zusammenbauen,
   **Schrott** recyceln. Roboter reparieren (Rechtsklick).

---

## 6) Schnell loslegen ohne große Welt

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus.
2. Befehl `/schrauber_logik` (Schaltung) oder `/schrauber_werkstatt` (ganze Werkstatt) eingeben.
3. Mit **Stahlplatten**, **Riffelblech**, **Warnband** und **Roboterblech** eine eigene
   Werkstatt bauen.
4. **Roboter-Bausätze** zusammenbauen, **Schaltungen** verdrahten, **Spawn-Eier** setzen.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, fester Tag, keine Monster) setzt die Engine **zur
Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im Spiel der Befehl
**`/lernwelt`**.
