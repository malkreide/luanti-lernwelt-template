# Passende Welt einrichten — Naschwerk-Tal 🍭🏞️

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du eine Welt
baust, in der sich das Naschwerk-Tal gut einrichten lässt: am liebsten mit **etwas Wasser** für
den „Schoko-Fluss" und die Wasser-Tiere (Schoko-Fisch, Marshmallow-Schwan, Keks-Schildkröte,
Brause-Qualle).

> **Wichtig zu wissen:** Du brauchst **keine besondere Welt**. Mit dem Befehl
> `/naschwerk_lebkuchenhaus` baust du dir sofort ein fertiges **Lebkuchenhaus** mit Tafeln,
> Regenbogen-Lolli-Wand, Zähl-Naschtisch, Naschschale und Naschwagen — egal, wie die Welt
> aussieht. Die Tipps unten sind nur für eine besonders schöne, bunte Bühne.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_naschwerk`.
- **Etwas Wasser ist gut:** Die **Wasser-Tiere** erscheinen nur in der Nähe von Wasser. Ein
  Fluss oder See neben dem Naschgarten ist ideal — der „Schoko-Fluss" deines Tals.
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

## 3) Variante A — „Flaches Nasch-Tal" (empfohlen)

Eine ebene Welt als große, freie Bühne für das ganze Tal.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Damit hast du überall ebenen Boden. Grabe dir eine Mulde und fülle Wasser hinein (dein
„Schoko-Fluss"), damit Schoko-Fisch, Marshmallow-Schwan & Co. erscheinen.

---

## 4) Variante B — „Hügel-Landschaft mit Fluss"

Du willst auch Hügel, Höhlen und einen natürlichen Fluss? Dann nimm die normale Welt-Erzeugung.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Ein Fluss oder See ist perfekt: der „Schoko-Fluss" am Wasser, der „Lolli-Wald" an Land, die
„Gummi-Hügel" auf den Hügeln.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_naschwerk`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Kamera, Naschwagen, Bonbons + Naschschale, Lollis, Zähl-Naschtisch, Bau-Blöcke,
   Spawn-Eier).
6. Befehl **`/naschwerk_lebkuchenhaus`** eingeben → ein fertiges Lebkuchenhaus erscheint vor dir.
7. Tieren **helfen** (Rechtsklick), am **Zähl-Naschtisch** zählen, an der **Naschschale**
   füttern, den **Regenbogen-Lolli** bestaunen und **bunte Muster** bauen.

---

## 6) Schnell loslegen ohne große Welt

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus.
2. Befehl `/naschwerk_lebkuchenhaus` (ganzes Haus) oder `/naschwerk_teststation` (kleine Station)
   eingeben.
3. Mit **Lebkuchen**, **Schokolade** und den **bunten Drops-Blöcken** ein eigenes Tal bauen.
4. **Naschwagen** setzen, **Lollis** pflanzen, **Spawn-Eier** setzen, **Regenbogen-Lollis** als
   leuchtende Wand bauen.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, fester Tag, keine Monster) setzt die Engine **zur
Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im Spiel der Befehl
**`/lernwelt`**.
