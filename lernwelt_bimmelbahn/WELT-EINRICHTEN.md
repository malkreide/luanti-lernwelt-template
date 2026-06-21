# Passende Welt einrichten — Bimmelbahn-Land 🚂

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Diese Anleitung zeigt, wie du
eine Welt baust, in der sich Schienen, Bahnhof und Dörfer schön anlegen lassen.

> **Wichtig zu wissen:** Die Bimmelbahn und die Fahrgäste laufen auf **festem Boden**
> (Land). Es eignet sich jede ganz normale Welt. Die Fahrgäste **erscheinen** in deiner
> Nähe automatisch (Boden + Luft darüber) oder du setzt sie mit den **Spawn-Eiern**
> (in der Startausrüstung).

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Fahrgäste mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_bimmelbahn`.
- **Boden:** Für Schienen und Dörfer ist eine **flache** Welt am praktischsten.
- **Friedlich/kein Sterben:** Die Engine schaltet Schaden ab — Kinder können nichts
  kaputtmachen und keine Monster stören. (Setzt die Engine automatisch.)

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

## 3) Variante A — „Flaches Bahnland" (empfohlen)

Eine durchgehend flache, ruhige Welt — ideal, um lange Schienenstrecken und mehrere
Dörfer bequem zu bauen.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 2
```

Das ergibt überall flachen Boden. Mit Kreativ-Flug baust du bequem deinen Bahnhof,
legst Schienen, Stations-Schilder und die bunten Dörfer an und setzt Fahrgäste aus den
Spawn-Eiern.

---

## 4) Variante B — „Natürliche Landschaft"

Eine normale, hügelige Welt mit Wäldern und Wiesen — schön für eine kurvige Strecke
durch Täler und über Brücken.

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = v7
```

Hügel und Täler entstehen von selbst. Such dir eine schöne Ebene als Hauptbahnhof aus
und baue die Strecke ins Gelände.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. (Optional) Die Zeilen aus **Variante A** oder **B** in `minetest.conf` eintragen.
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_bimmelbahn`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Logbuch, Kamera, Bimmelbahn, Fahrplan-Pult, Stations-Schilder, Signal, Weiche,
   Schienen, Spawn-Eier).
6. Befehl `/bimmelbahn_hauptbahnhof` eingeben → fertige Bahnhofshalle mit Tafeln,
   Fahrplan-Pult, Stations-Schildern und Bimmelbahn erscheint vor dir.
7. Eine Route holen (Fahrplan-Pult), an den Stations-Schildern in der richtigen
   Reihenfolge halten, Fahrgäste begrüssen und mit `/bimmelbahn_demo` die Signal-Logik
   ausprobieren.

---

## 6) Einen Bahnhof und Dörfer bauen

Auch ohne Befehl geht es leicht von Hand:

1. Kreativmodus, einen ebenen Platz suchen.
2. Mit **Backstein**, **Bahnsteig** und **Bahnhofs-Glas** einen Bahnhof bauen.
3. Die fünf **Lern-Tafeln** (`tafel_hauptbahnhof`, `tafel_rotdorf`, `tafel_gelbdorf`,
   `tafel_blaudorf`, `tafel_gruendorf`) aufstellen.
4. Mit **Schienen** Strecken zu vier kleinen **bunten Dörfern** legen (Haus-Blöcke in
   rot/gelb/blau/grün) und an jedem Dorf das passende **Stations-Schild** setzen.
5. Ein **Fahrplan-Pult** an den Bahnhof stellen, dazu ein paar **Signale** und eine
   **Weiche** für die Logik.
6. Ein paar **Spawn-Eier** setzen, damit Fahrgäste an den Bahnsteigen warten.

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, kein Sterben, fester Tag, keine
Monster) setzt die Engine **zur Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen
dazu zeigt im Spiel der Befehl **`/lernwelt`**.
