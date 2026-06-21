# Passende Welt einrichten — Sonnenhof 🌻🏞️

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du eine Welt
baust, in der sich der Sonnenhof gut einrichten lässt: am liebsten mit **etwas freier Fläche**
für die Felder und das Tiergehege und **etwas Wasser** für die Ente (ein „Hofteich").

> **Wichtig zu wissen:** Du brauchst **keine besondere Welt**. Mit dem Befehl
> `/sonnenhof_scheune` baust du dir sofort einen fertigen **Bauernhof** mit Scheune, Tafeln,
> Weizen-Feld, Tiergehege, Zaubermühle und Futtertrog — egal, wie die Welt aussieht. Die Tipps
> unten sind nur für eine besonders schöne Bühne.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_sonnenhof`. Für **echte** Pflanzen & Tiere
  zusätzlich **`farming`** (Farming Redo) und **`animalia`**.
- **Etwas Wasser ist gut:** Die **Ente** erscheint nur in der Nähe von Wasser. Ein kleiner
  Teich neben dem Hof ist ideal.
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

## 3) Variante A — „Flacher Bauernhof" (empfohlen)

Eine ebene Welt als große, freie Bühne für Felder, Gehege und Scheune.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Damit hast du überall ebenen Boden — perfekt für lange Felder und ein großes Tiergehege. Grabe
dir eine kleine Mulde und fülle Wasser hinein (dein „Hofteich"), damit die Ente erscheint.

---

## 4) Variante B — „Hügel-Landschaft mit Teich"

Du willst auch Hügel, Wiesen und einen natürlichen Teich? Dann nimm die normale Welt-Erzeugung.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Ein See oder Fluss ist perfekt: die Felder auf der ebenen Wiese, das Gehege daneben, der
Hofteich am Wasser.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. (Optional, empfohlen) **Farming Redo** und **Animalia** in den `mods/`-Ordner legen.
4. **Neue Welt** erstellen, dabei das Game wählen.
5. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_sonnenhof`** anhaken (dazu nach Wunsch
   `farming` + `animalia`).
6. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Kamera, Giesskanne, Weizen-Samen, Tierfutter + Korn, Bau-Blöcke, Spawn-Eier).
7. Befehl **`/sonnenhof_scheune`** eingeben → ein fertiger Bauernhof erscheint vor dir.
8. **Säen, giessen, ernten**, an der **Zaubermühle** mahlen & backen, am **Futtertrog**
   Tiere pflegen und Tieren **helfen** (Rechtsklick).

---

## 6) Schnell loslegen ohne große Welt

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus.
2. Befehl `/sonnenhof_scheune` (ganzer Hof) oder `/sonnenhof_teststation` (kleine Station)
   eingeben.
3. Mit **Scheunenwand**, **Fachwerk**, **Stroh** und **Weidezaun** einen eigenen Hof bauen.
4. **Weizen-Samen** säen, mit der **Giesskanne** giessen, **Spawn-Eier** ins Gehege setzen,
   **Sonnenblumen** pflanzen.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, fester Tag, keine Monster) setzt die Engine **zur
Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im Spiel der Befehl
**`/lernwelt`**.
