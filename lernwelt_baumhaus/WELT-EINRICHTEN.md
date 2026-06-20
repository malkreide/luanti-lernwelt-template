# Passende Welt einrichten — Baumhaus-Forscher 🌳

Das Thema bringt **keine fertige Karte** mit (Luanti-Welten sind Spielstände, kein
Mod-Inhalt). Du erstellst die Welt in Luanti selbst. Deine **Basis ist ein grosses
Baumhaus** – das baust du am schnellsten mit dem Befehl `/baumhaus_bauen`. Diese Anleitung
zeigt, wie du eine **ruhige** Welt mit viel Platz einrichtest – ideal zum Erkunden der
**Stockwerke des Waldes** (oben/unten).

> **Wichtig zu wissen:** Die Tiere laufen auf **festem Boden** (kein Wasser nötig).
> Sie erscheinen automatisch in deiner Nähe — und du kannst sie jederzeit mit den
> **Spawn-Eiern** aus der Startausrüstung selbst setzen.

---

## 1) Das Wichtigste in Kürze

- **Game:** **VoxeLibre** oder **Mineclonia** (bringen `mcl_mobs` für die Tiere mit) —
  empfohlen. Alternativ **Minetest Game** mit `mobs_redo`.
- **Mods aktivieren:** `lernwelt` **und** `lernwelt_baumhaus`.
- **Kein Wasser nötig:** die Tiere laufen an Land (ein Fluss ist trotzdem hübsch).
- **Friedlich/kein Schaden:** Die Engine schaltet Schaden ab — es kann nichts passieren,
  keine Monster. (Setzt die Engine automatisch.)
- **Tageszeit:** Die Welt startet **hell (Tag)** und ist eingefroren — ein freundlicher,
  sonniger Dschungel.

---

## 2) Wo trägt man die Mapgen-Werte ein?

Mapgen-Einstellungen werden beim **Erstellen** der Welt fest in die Welt geschrieben
(`map_meta.txt`) und lassen sich danach nicht mehr ändern. Der einfachste Weg:

1. Im Luanti-Hauptmenü unter **Einstellungen** (oder direkt in `minetest.conf`) die
   unten stehenden Zeilen eintragen.
2. **Danach** eine **neue Welt erstellen** — die Werte werden in die Welt übernommen.
3. Welt betreten. Fertig.

---

## 3) Variante A — „Flache Lichtung" (empfohlen zum Bauen)

Eine durchgehend flache Welt — viel Platz und Übersicht, ideal für das **Baumhaus** und
die **Schnitzeljagd** (die Posten stehen dann schön sichtbar).

```
# minetest.conf  (VOR dem Erstellen der Welt eintragen)
mg_name = flat
mgflat_ground_level = 8
```

Das ergibt einen flachen Boden — perfekt, um darauf dein **Baumhaus** zu errichten
(mit `/baumhaus_bauen` geht es in Sekunden). Weil das Baumhaus **in die Höhe** baut,
erlebst du oben/unten auch auf flachem Grund.

---

## 4) Variante B — „Echter Dschungel/Wald"

Wer einen abwechslungsreichen, hügeligen Wald mit echten Bäumen, Hängen und kleinen
Flüssen mag, nimmt den **Standard-Mapgen** des Games (`v7`). In **VoxeLibre/Mineclonia**
findest du sogar **Dschungel-Biome** mit hohen Bäumen – ideal zum Klettern.

```
# minetest.conf  (optional)
mg_name = v7
```

Suche dir einen grossen Baum oder eine Lichtung und baue dort dein Baumhaus.

---

## 5) Schritt für Schritt

1. Game **VoxeLibre/Mineclonia** installieren (falls noch nicht vorhanden).
2. Die Zeilen aus **Variante A** in `minetest.conf` eintragen (oder Variante B lassen).
3. **Neue Welt** erstellen, dabei das Game wählen.
4. Bei „Mods auswählen": **`lernwelt`** + **`lernwelt_baumhaus`** anhaken.
5. Welt betreten → du erhältst automatisch die **Startausrüstung**
   (Tagebuch, Kamera, Kompass, Reit-Papagei, Bilderrahmen, Lianen, Spawn-Eier).
6. `/baumhaus_bauen` → ein grosses Baumhaus erscheint. **Klettere die Strickleiter hoch!**
7. `/baumhaus_schnitzeljagd` → folge den **Bild-Hinweisen** bis zum Schatz.

---

## 6) Eigenes Baumhaus & eigene Schnitzeljagd

Auch in einer ganz normalen Welt geht es sofort los:

1. Kreativmodus, eine Stelle mit Platz nach oben suchen.
2. Mit **Baum-Stamm**, **Planke**, **Wand**, **Fenster** und **Blättern** ein Baumhaus
   bauen; **Strickleitern**/**Lianen** zum Klettern setzen.
3. **Bilderrahmen** an Wände/Pfosten hängen, per **Rechtsklick** das Bild wählen und so
   eine eigene **Bild-Hinweis-Kette** (Schnitzeljagd) legen.
4. Spawn-Eier setzen — der **Reit-Papagei** fliegt überall hin (auch hoch hinaus).

---

## Hinweis

Die friedliche Konfiguration (kein Schaden, heller Tag, keine Monster) setzt die Engine
**zur Laufzeit** selbst. Empfohlene `minetest.conf`-Zeilen dazu zeigt im Spiel der Befehl
**`/lernwelt`**.
