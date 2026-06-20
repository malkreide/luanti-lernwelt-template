# Passende Welt einrichten — Glühpilz-Wald 🍄

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Deine **Basis ist ein grosses
Pilzhaus** – das baust du am schnellsten mit dem Befehl `/pilzwald_haus`. Diese Anleitung
zeigt, wie du eine **flache, ruhige** Welt mit viel Platz einrichtest – ideal für eine
Erstwelt mit den Jüngsten.

> **Wichtig zu wissen:** Die Waldtiere laufen auf **festem Boden** (kein Wasser nötig).
> Sie erscheinen automatisch in deiner Nähe — und du kannst sie jederzeit mit den
> **Spawn-Eiern** aus der Startausrüstung selbst setzen.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_gluehpilz`.
- **Kein Wasser nötig:** die Tiere laufen an Land (ein kleiner Bach ist trotzdem hübsch).
- **Friedlich/kein Schaden:** Die Engine schaltet Schaden ab — es kann nichts
  passieren, keine Monster. (Setzt die Engine automatisch.)
- **Tageszeit:** Die Welt startet **hell (Tag)** und ist eingefroren. Mit den
  **Tag-Nacht-Pilzen** wechselst du selbst zwischen Tag, Dämmerung und Nacht – die
  Nacht ist dank der Glühpilze kuschelig, nicht gruselig.

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

## 3) Variante A — „Flache Wiese" (empfohlen zum Bauen)

Eine durchgehend flache Welt — viel Platz und Übersicht, ideal für das Pilzhaus und
zum Pilze-Pflanzen.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 8
```

Das ergibt einen flachen Boden — perfekt, um darauf dein **Pilzhaus** zu errichten
(mit `/pilzwald_haus` geht es in Sekunden).

---

## 4) Variante B — „Normaler Wald"

Wer einen abwechslungsreichen, hügeligen Wald mit Bäumen und kleinen Bächen mag, nimmt
einfach den **Standard-Mapgen** des Games (`v7`). Nichts eintragen nötig – beim
Welt-Erstellen einfach die Voreinstellung lassen.

```
# minetest.conf  (optional)
mg_name = v7
```

Suche dir eine flache Lichtung und baue dort dein Pilzhaus.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. Die Zeilen aus **Variante A** in `minetest.conf` eintragen (oder Variante B lassen).
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_gluehpilz`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Tagebuch, Kamera, Leucht-Käfer, Glühpilze, Tag-Nacht-Pilze, Spawn-Eier).
6. `/pilzwald_haus` eingeben → ein grosses Pilzhaus mit Tafeln, Glühpilzen,
   Tag-Nacht-Pilzen und einem Leucht-Käfer erscheint vor dir.
7. Ein paar **Spawn-Eier** setzen → Tiere retten (Rechtsklick). Einen **Nacht-Pilz**
   antippen und zuschauen, wie der Wald zu leuchten beginnt!

---

## 6) Eigenes Pilzhaus bauen (in jeder Welt)

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus, eine flache Stelle suchen.
2. Mit **Pilz-Stamm**, **Pilzhaus-Wand**, **Pilz-Hut** (Dach) und **Fenster** ein
   kleines Pilzhaus bauen.
3. Ein paar **Glühpilze** für gemütliches Licht und je einen **Tag-/Dämmer-/Nacht-Pilz**
   hinstellen.
4. Spawn-Eier setzen — der **Leucht-Käfer** fliegt überall.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, heller Start-Tag, keine Monster) setzt
die Engine **zur Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im
Spiel der Befehl **`/lernwelt`**.
