# Passende Welt einrichten — Summ-Garten 🐝🏞️

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein Mod-Inhalt).
Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du eine Welt baust, in der
sich der Summ-Garten gut einrichten lässt: am liebsten mit **etwas freier, ebener Fläche** für
die Blumenwiese, den Obstgarten und das Honiglager.

> **Wichtig zu wissen:** Du brauchst **keine besondere Welt**. Mit dem Befehl
> `/summgarten_bienenstock` baust du dir sofort einen fertigen **Garten** mit Bienenstock,
> Tafeln, Blumenwiese, Obstbaum, Waben-Wand und Honigschleuder — egal, wie die Welt aussieht.
> Die Tipps unten sind nur für eine besonders schöne Bühne.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_summgarten`.
- **Etwas freie Fläche ist gut:** Für eine lange Blumenwiese und einen kleinen Obstgarten ist
  ebener Boden praktisch.
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

## 3) Variante A — „Flacher Garten" (empfohlen)

Eine ebene Welt als große, freie Bühne für Wiese, Obstgarten und Bienenstock.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Damit hast du überall ebenen Boden — perfekt für eine lange Blumenwiese und ein ordentliches
Honiglager mit Waben-Wand.

---

## 4) Variante B — „Wiesen-Landschaft mit Bäumen"

Du willst auch Hügel, Wiesen und echte Bäume? Dann nimm die normale Welt-Erzeugung.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Blühende Wiesen und Bäume sind eine schöne Kulisse: die Blumenwiese auf der ebenen Fläche, den
Obstgarten an den Bäumen, das Honiglager in der Nähe des Bienenstocks.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_summgarten`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Kamera, Pinsel, Nektar + Honig, Blumen & Obstblüten, Bau-Blöcke, Spawn-Eier).
6. Befehl **`/summgarten_bienenstock`** eingeben → ein fertiger Garten erscheint vor dir.
7. **Bestäuben** (Pinsel), Nektar sammeln, an der **Honigschleuder** Honig machen, an der
   **Honigwabe** Tropfen **zählen**, das **Waben-Muster** legen und Tieren **helfen**
   (Rechtsklick).

---

## 6) Schnell loslegen ohne große Welt

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus.
2. Befehl `/summgarten_bienenstock` (ganzer Garten) oder `/summgarten_teststation` (kleine
   Station) eingeben.
3. Mit **Bienenstock**, **Waben**, **Gartenzaun** und **Blütenhecke** einen eigenen Garten bauen.
4. **Blumen** setzen, mit dem **Pinsel** bestäuben, **Obstblüten** pflanzen, **Spawn-Eier**
   verteilen.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, fester Tag, keine Monster) setzt die Engine **zur
Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im Spiel der Befehl
**`/lernwelt`**.
