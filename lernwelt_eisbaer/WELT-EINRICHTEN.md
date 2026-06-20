# Passende Welt einrichten — Eisbär-Bucht 🐻‍❄️🏔️

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du eine Welt
baust, in der sich die Eisbär-Bucht gut einrichten lässt: am liebsten mit **Schnee und etwas
Wasser** für die Wasser-Tiere (Robbe, Beluga, Narwal).

> **Wichtig zu wissen:** Du brauchst **keine besondere Welt**. Mit dem Befehl
> `/eisbaer_eispalast` baust du dir sofort einen fertigen **Eispalast** mit Tafeln,
> Polarlicht-Wand, Schlitten und Futterstelle — egal, wie die Welt aussieht. Die Tipps unten
> sind nur für eine besonders schöne, winterliche Bühne.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_eisbaer`.
- **Etwas Wasser ist gut:** Die **Wasser-Tiere** (Robbe, Beluga, Narwal) erscheinen nur in der
  Nähe von Wasser. Ein See oder eine Meeresküste neben dem Schnee ist ideal — der „gefrorene
  See" deiner Bucht.
- **Friedlich/kein Schaden:** Die Engine schaltet Schaden ab — Kinder können nichts kaputt
  machen, niemand erfriert und keine Monster stören. (Setzt die Engine automatisch.)

---

## 2) Wo trägt man die Mapgen-Werte ein?

Mapgen-Einstellungen werden beim **Erstellen** der Welt fest in die Welt geschrieben
(`map_meta.txt`) und lassen sich danach nicht mehr ändern. Der einfachste, zuverlässige Weg:

1. Im Luanti-Hauptmenü unter **Einstellungen** (oder direkt in der Datei `minetest.conf`) die
   unten stehenden Zeilen eintragen.
2. **Danach** eine **neue Welt erstellen** — die Werte werden in die Welt übernommen.
3. Welt betreten. Fertig.

---

## 3) Variante A — „Flache Schnee-Bucht" (empfohlen)

Eine ebene Welt als große, freie Bühne für die ganze Bucht.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Damit hast du überall ebenen Boden. Hebe dir mit **Klarem Eis/Blauem Eis** einen kleinen See
aus (oder grabe eine Mulde und fülle Wasser hinein), damit Robbe, Beluga und Narwal erscheinen.

---

## 4) Variante B — „Echte Schneelandschaft mit Bergen"

Du willst auch Hügel, Höhlen und natürlichen Schnee? Dann nimm die normale Welt-Erzeugung und
suche dir ein **kaltes/verschneites Biom** (z. B. eine eisige Küste).

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Eine verschneite Küste am Wasser ist perfekt: Schneewald an Land, der „gefrorene See" am Meer,
eine Höhle für das Polarlicht.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_eisbaer`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Kamera, Schlitten, Fisch + Futterstelle, Eisblumen, Bau-Blöcke, Spawn-Eier).
6. Befehl **`/eisbaer_eispalast`** eingeben → ein fertiger Eispalast erscheint vor dir.
7. Tieren **helfen** (Rechtsklick), an der **Futterstelle** füttern, das **Polarlicht**
   bestaunen und **Blau-Weiss-Muster** bauen.

---

## 6) Schnell loslegen ohne große Welt

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus.
2. Befehl `/eisbaer_iglu` (kleines Iglu) oder `/eisbaer_eispalast` (ganzer Palast) eingeben.
3. Mit **Schnee**, **Eis** und den **Blau-Weiss-Muster-Blöcken** eine eigene Bucht bauen.
4. **Schlitten** setzen, **Eisblumen** pflanzen, **Spawn-Eier** setzen, **Polarlicht** als
   leuchtende Wand bauen.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, fester Tag, keine Monster) setzt die Engine **zur
Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im Spiel der Befehl
**`/lernwelt`**.
