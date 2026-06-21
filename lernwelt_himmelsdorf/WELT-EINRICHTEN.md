# Passende Welt einrichten — Himmelsdorf 🌈☁️🎈

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du eine Welt
baust, in der sich Himmelsdorf gut einrichten lässt: am liebsten mit **viel freiem Himmel** und
einer **ebenen Bühne**, auf der du deine Wolkenstadt nach oben baust.

> **Wichtig zu wissen:** Du brauchst **keine besondere Welt**. Mit dem Befehl
> `/himmelsdorf_wolkenstadt` baust du dir sofort eine fertige **Wolkenstadt** mit Tafeln,
> Regenbogenbrücke, Wetter-Station und Ballon — egal, wie die Welt aussieht. Die Tipps unten
> sind nur für eine besonders schöne Himmels-Bühne.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_himmelsdorf`.
- **Viel Platz nach oben:** Himmelsdorf spielt **hoch in der Luft**. Eine ebene Welt, von der aus
  du nach oben Wolken-Plattformen baust, ist ideal — oder du fliegst (Kreativ / Ballon) einfach
  hoch und baust dort.
- **Friedlich/kein Schaden:** Die Engine schaltet Schaden ab — Kinder können nichts kaputt
  machen, niemand stürzt ab und keine Monster stören. (Setzt die Engine automatisch.)

---

## 2) Wo trägt man die Mapgen-Werte ein?

Mapgen-Einstellungen werden beim **Erstellen** der Welt fest in die Welt geschrieben
(`map_meta.txt`) und lassen sich danach nicht mehr ändern. Der einfachste, zuverlässige Weg:

1. Im Luanti-Hauptmenü unter **Einstellungen** (oder direkt in der Datei `minetest.conf`) die
   unten stehenden Zeilen eintragen.
2. **Danach** eine **neue Welt erstellen** — die Werte werden in die Welt übernommen.
3. Welt betreten. Fertig.

---

## 3) Variante A — „Flache Himmels-Bühne" (empfohlen)

Eine ebene Welt als große, freie Bühne. Von hier baust (oder fliegst) du nach oben und legst die
Wolken-Plattformen an.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Damit hast du überall ebenen Boden. Steig mit dem **Ballon** auf oder fliege im Kreativ-Modus
hoch und baue dort mit **Wolken-Blöcken** deine schwebende Stadt.

---

## 4) Variante B — „Schwebeinseln (Floatlands)"

Du willst echte schwebende Inseln am Himmel? Manche Mapgen-Versionen können „Floatlands"
erzeugen. Probiere die normale Welt-Erzeugung und nutze die fertigen Befehle, um deine eigene
Schwebeinsel zu setzen:

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Egal welche Landschaft — mit `/himmelsdorf_schwebeinsel` und `/himmelsdorf_wolkenstadt` baust du
deine eigene Wolkenstadt direkt vor dir in die Luft.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_himmelsdorf`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Kamera, Ballon, Höhenmesser, Wetter-Station, Regenbogen-Samen, Bau-Blöcke,
   Spawn-Eier).
6. Befehl **`/himmelsdorf_wolkenstadt`** eingeben → eine fertige Wolkenstadt erscheint vor dir.
7. Tieren **helfen** (Rechtsklick), an der **Wetter-Station** das Wetter wechseln, mit dem
   **Ballon** fliegen und **Regenbogen-Farben** bauen.

---

## 6) Schnell loslegen ohne große Welt

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus.
2. Befehl `/himmelsdorf_schwebeinsel` (kleine Insel) oder `/himmelsdorf_wolkenstadt` (ganze
   Stadt) eingeben.
3. Mit **Wolken**, **Himmelsstein** und den **Regenbogen-Blöcken** eine eigene Wolkenstadt bauen.
4. **Ballon** setzen, **Regenbogen-Samen** pflanzen, **Spawn-Eier** setzen, **Regenbogen** als
   leuchtende Brücke bauen, an der **Wetter-Station** das Wetter wechseln.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, fester Tag, keine Monster) setzt die Engine **zur
Laufzeit** selbst. Das Wetter dieser Welt steuerst du über die **Wetter-Station** im Spiel (nicht
über die Welt-Einstellungen). Empfohlene `minetest.conf`-Zeilen zeigt im Spiel der Befehl
**`/lernwelt`**.
