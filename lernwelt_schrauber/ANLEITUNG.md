# Spielanleitung — Schrauber-Werkstatt 🤖🔧

Diese Anleitung erklärt **alle Elemente** der Lernwelt „Schrauber-Werkstatt", **wie du sie
benutzt** und **welche Aufgaben und Ziele** es gibt. Gedacht zum gemeinsamen Spielen von
**Eltern und Kind** (ca. 6–9 Jahre).

> 🧒 **Einseitige Kinder-Kurzfassung zum Ausdrucken:** [KINDER-KURZ.md](KINDER-KURZ.md)
> · 🇬🇧 **English version:** [GUIDE.md](GUIDE.md)

> Motto: **Verdrahten · Zusammenbauen · Wiederverwerten**
>
> Ziel ist kein „Gewinnen", sondern entdecken, tüfteln und lernen: kleine Schaltungen bauen
> (Schalter → Lampe → Tür), Roboter in der richtigen Reihenfolge zusammensetzen, Roboter
> reparieren und fotografieren — und dabei spielerisch **Ursache & Wirkung**, **einfache Logik**
> und **Informatik-Grundlagen** üben (Lehrplan 21, Medien & Informatik).

---

## 1. Schnellstart

1. Neue Welt mit **VoxeLibre** oder **Mineclonia** anlegen und die Mods
   **`lernwelt`** + **`lernwelt_schrauber`** aktivieren. (Optional: **`mesecons`** für die
   echte Mesecons-Brücke; Tipps zur Welt: **[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.)
2. Welt betreten → du bekommst automatisch die **Startausrüstung** ins Inventar.
3. Tipp für den schnellen Einstieg: Befehl **`/schrauber_logik`** → eine fertige
   Schalter-Lampe-Tür-Schaltung steht vor dir. Oder **`/schrauber_werkstatt`** für die ganze
   Werkstatt.

---

## 2. Grundlegende Bedienung

| Aktion | So geht's |
|---|---|
| Etwas **benutzen / Schalter umlegen / Roboter reparieren / Bauteil anbauen / Tafel öffnen** | **Rechtsklick** |
| **Fotografieren / Blöcke abbauen (z. B. Schrotthaufen)** | **Linksklick** (halten) |
| **Bauen / Item setzen (Block, Bausatz …)** | **Rechtsklick** auf den Boden |
| **Fliegen (Kreativ)** | Doppel-Sprung; dann Springen = hoch, Schleichen = runter |

In der Kinder-Einstellung sind **Schaden aus** — es kann nichts passieren. Tag ist fest
eingestellt (helle Werkstatt), keine Monster. Auch die „Funken" der Funkenbots sind
**völlig harmlos**.

---

## 3. Die Welt: 3 Lern-Zonen

Jede Zone ist ein „Bereich" mit einer **Lern-Tafel** und passenden Robotern:

| Zone | Roboter dort | Lernbereiche |
|---|---|---|
| 🎢 **Fließband** | Rollbot, Greifbot, Sortierbot | Ursache & Wirkung, Algorithmus, Technik |
| 🔌 **Energieraum** | Funkenbot, Lampenbot, Schaltbot, *Meisterbot* | Logik (Schalter→Lampe→Tür) |
| ♻️ **Recyclinghof** | Sammelbot, Pressbot, Putzbot | Ursache & Wirkung, Materialkreislauf |

---

## 4. Lern-Tafeln & Aufgaben (das Lern-Herzstück)

**Bedienung:** Lern-Tafel mit **Rechtsklick** anklicken → ein Fenster zeigt die **Aktivität**,
die **Lehrplan-Bezüge** und die **Aufgaben** der Zone.

Es gibt drei Aufgabentypen:

- ❓ **Quiz** — eine Frage mit Antwort-Knöpfen. Richtig = Häkchen ✓ + Belohnung,
  falsch = „Versuch es nochmal".
- 🎨 **Muster nachlegen / Reihenfolge** — oben ist ein Muster vorgegeben (z. B. die Bau-Reihenfolge
  als Farben: Beine-Körper-Arme). Klicke die Knöpfe **in der richtigen Reihenfolge** an. Ein
  Fehler setzt zurück. Das übt **Algorithmen** (Schritte in Reihenfolge).
- 🤖 **Reparier-Ziel** — z. B. „Repariere 2 Rollbots". Der Fortschritt (x/N) zählt sich
  automatisch hoch.

Gelöste Aufgaben geben einen Ton + Lob und zählen in deinen Fortschritt
(siehe `/lernfortschritt`).

**Welche Aufgaben gibt es?**

| Zone | Aufgaben |
|---|---|
| Fließband | Quiz „Was macht ein Fließband?" · **Reihenfolge** Beine-Körper-Arme · 2 Rollbots reparieren |
| Energieraum | Quiz „Schalter um → Lampe?" · Quiz „Wer steuert die Tür?" · 1 Funkenbot reparieren |
| Recyclinghof | Quiz „Recycler: was kommt heraus?" · Quiz „Warum recyceln?" · 2 Sammelbots reparieren |

---

## 5. Einfache Logik: Schalter → Leitung → Lampe → Tür 🔌 (die Mesecons-Brücke)

Das **Herzstück** des Themas und die direkte Brücke zu **Mesecons**. Du verdrahtest selbst eine
kleine Schaltung und siehst **Ursache & Wirkung** (wenn-dann):

1. 🟥 **Schalter** auf den Boden setzen.
2. ➖ Eine Reihe **Leitungen** anlegen, die vom Schalter wegführen.
3. 💡 Am Ende eine **Lampe** setzen — und/oder eine **Tür** an die Leitung.
4. 🖱️ **Schalter** mit **Rechtsklick** umlegen → die **Leitung leuchtet**, die **Lampe geht an**,
   die **Tür öffnet sich**. Schalter wieder aus → alles geht aus.

**Bausteine des Logik-Kits:**

| Block | Was er tut |
|---|---|
| **Schalter** | Rechtsklick = ein/aus. Bleibt so (Quelle). |
| **Taster** | Rechtsklick = kurzer **Strom-Impuls** (geht nach ein paar Sekunden von selbst aus). |
| **Leitung** | Verbindet alles; **leuchtet**, wenn Strom anliegt. |
| **Lampe** | Geht an, wenn das Netz unter Strom steht. |
| **Tür** | **Öffnet sich** (man kann durchgehen), wenn Strom anliegt. |

> **Regel ganz einfach:** Ein zusammenhängendes Leitungsnetz ist „unter Strom", sobald
> **irgendein** Schalter oder Taster daran **an** ist. Dann gehen **alle** Lampen und Türen
> im Netz an.

> 🔌 **Mesecons-Brücke:** Ist die Mod **`mesecons`** installiert, sprechen Schalter, Taster,
> Lampe und Tür **zusätzlich** mit echten Mesecons-Drähten (Schalter = Receptor, Lampe/Tür =
> Effector). Ohne Mesecons läuft das eigene Mini-Logik-System ganz allein. So oder so lernst
> du dieselbe Idee – und kannst später nahtlos mit echtem Mesecons weiterbauen.

Tipp: Der Befehl **`/schrauber_logik`** baut dir eine fertige Beispiel-Schaltung zum Ausprobieren.

---

## 6. Roboter zusammenbauen 🤖 (ein Algorithmus: Reihenfolge!)

Hier übst du, **Schritte in der richtigen Reihenfolge** auszuführen — genau das ist ein
**Algorithmus**.

1. 🧰 **Roboter-Bausatz** in die Hand nehmen und auf den Boden setzen → ein **Roboter-Rahmen**
   erscheint (noch ohne Teile).
2. 🦿 Jetzt die Bauteile **in dieser Reihenfolge** anbauen: **Beine → Körper → Arme → Kopf**.
   Dazu das passende Bauteil **in die Hand** nehmen und den Rahmen mit **Rechtsklick** antippen.
3. ❌ **Falsches Teil?** Der Rahmen sagt dir, welches Teil **als Nächstes** kommt — die
   Reihenfolge muss stimmen. (So lernt man, dass die Reihenfolge zählt.)
4. ✅ Nach dem **Kopf** ist der Roboter fertig: Er **schaltet sich ein**, leuchtet und **folgt
   dir** durch die Werkstatt. Jeder fertige Roboter zählt („Gebaute Roboter: N").

> Ohne Mob-API? **Kein Problem:** Bausatz, Bauteile und der zusammengebaute, folgende Roboter
> sind eigener Code des Themas und laufen immer.

Bauteile bekommst du aus der **Startausrüstung**, im **Kreativ-Inventar** — oder frisch aus dem
**Recycler** (siehe unten)!

---

## 7. Fließband 🎢 (Ursache & Wirkung zum Draufstellen)

**Bedienung:** ein **Fließband** auf den Boden setzen. Der **Pfeil oben** zeigt die Richtung
(dreht sich mit, je nachdem wie du es platzierst). Stell dich drauf — es **schiebt dich** in
Pfeilrichtung weiter. Auch **Gegenstände und Roboter**, die darauf liegen, werden mitgeschoben.

Das ist **Ursache & Wirkung** zum Anfassen: Die Maschine bewegt Dinge, ganz ohne dass du läufst.
Baue eine Strecke und schick einen Roboter auf die Reise.

---

## 8. Recyclinghof ♻️ (Materialkreislauf)

**So funktioniert der Kreislauf:**

1. ⛏️ Einen **Schrotthaufen** **abbauen** (Linksklick) → du bekommst **Schrott**.
2. 🔁 **Schrott** in die Hand nehmen und den **Recycler** mit **Rechtsklick** antippen →
   heraus kommt ein **neues Roboter-Bauteil** (zufällig Beine/Körper/Arme/Kopf).
3. 🤖 Mit den Bauteilen baust du wieder einen **Roboter** zusammen — und der Kreislauf schließt
   sich.

So lernst du: **Aus Alt mach Neu** — Material wird wiederverwendet, statt weggeworfen (NMG.4).

---

## 9. Roboter reparieren 🤖

**Bedienung:** einen Roboter mit **Rechtsklick** antippen = **reparieren**. Es gibt Funken,
einen Ton, einen Zähler-Eintrag und (ab genug Reparaturen) einen neuen Rang. Alle Roboter sind
**friedlich** — kein Kämpfen.

**Alle Roboter:**

| Roboter | Bereich | „Frisst" | Besonderheit |
|---|---|---|---|
| Rollbot | Fließband | Strom | rollt schnell |
| Greifbot | Fließband | Schmieröl | 👪 Begleiter |
| Sortierbot | Fließband | Strom | sortiert |
| Funkenbot | Energieraum | Strom | 💡 leuchtet |
| Lampenbot | Energieraum | Strom | 💡 leuchtet hell |
| Schaltbot | Energieraum | Strom | 👪 Begleiter |
| Sammelbot | Recyclinghof | Strom | sammelt Schrott |
| Pressbot | Recyclinghof | Schmieröl | groß & langsam |
| Putzbot | Recyclinghof | Strom | sehr flink |
| **Meisterbot** | Energieraum | Gold-Strom | 🌟 sehr selten, leuchtet |

- 👪 **Familien:** Reparierst du ein „Eltern"-Modell (Greifbot, Schaltbot), tauchen kleine
  Begleit-Bots auf, die du auch reparieren kannst.
- 🌟 **Meisterbot:** erscheint **nicht** von selbst (sehr selten). Du holst ihn über sein
  **Spawn-Ei** (in der Startausrüstung / im Kreativ-Inventar).
- 🌍 **Lebendige Werkstatt:** Die übrigen Roboter **erscheinen automatisch** an Land in deiner
  Nähe (schonend begrenzt). Abschaltbar (siehe Einstellungen).

**Spawn-Eier:** Jeder Roboter hat ein Ei. Ei in der Hand → **Rechtsklick** auf den Boden =
Roboter setzen. (Hinweis: Das sind die **Mob**-Spawn-Eier — nicht zu verwechseln mit dem
**Roboter-Bausatz**.)

---

## 10. Entdecker-Kamera 📷

**Bedienung:** Kamera in die Hand nehmen, in die Nähe eines Roboters gehen und **Linksklick**
= Foto. Der nächste noch **nicht entdeckte** Roboter wird im Katalog als **entdeckt** markiert
(Reichweite ca. 12 Blöcke).

Das ist das **Sammel-Spiel**: Fotografiere nach und nach **alle** Roboter. Im Katalog siehst du
„Entdeckt: X/10". Entdecken ist unabhängig vom Reparieren.

---

## 11. Roboter-Katalog 📋

**Bedienung:** Katalog in der Hand → **Rechtsklick** öffnet ihn.

Du siehst eine Liste aller Roboter; ein Klick zeigt den **Steckbrief** (Name, Bereich,
„Frisst", Aufgabe), wie **oft du ihn repariert** hast und ob er schon **entdeckt** wurde. Oben
stehen dein **Rang**, die **Gesamt-Reparaturen** und der **Entdeckt-Zähler**.

---

## 12. Ränge & Abzeichen 🏆

Jede Reparatur zählt. Bei bestimmten Schwellen steigst du im Rang auf (Ton + Pop-up);
ab „Techniker" gibt es ein **Abzeichen-Item** ins Inventar (Rechtsklick darauf zeigt deine Bilanz).

| Ab … Reparaturen | Rang | Abzeichen |
|---|---|---|
| 0 | Schrauber-Lehrling | – |
| 5 | Bastler | – |
| 10 | Techniker | 🥉 ja |
| 25 | Ingenieur | 🥈 ja |
| 50 | Robotermeister | 🥇 ja |

Oben links zeigt eine **Anzeige (HUD)** laufend: Welt · Rang · Reparaturen.

---

## 13. Blöcke, Items & interne Namen

Alles wird ohne externe Bilder erzeugt (Farben/Muster). Interne Namen (für Kreativ-Suche oder
`/giveme`) beginnen mit `lernwelt_schrauber:`.

**Logik-Kit:** `schalter_aus` (Schalter) · `taster_aus` (Taster) · `leitung` (Leitung) ·
`lampe_aus` (Lampe) · `tuer_zu` (Tür). (Die „an/auf"-Varianten entstehen automatisch unter
Strom und sind nicht im Kreativ-Menü.)

**Werkstatt-Blöcke:** `werkbank` (Werkbank, Pro-Seite-Textur) · `stahlplatte` · `riffelblech` ·
`schraubenkiste` · `zahnrad_block` · `warnband` · `bodenfliese` · `glaswand` (durchsichtig) ·
`energie_block` (leuchtend) · `roboblech_blau/rot/gelb` · `tafel_fliessband/energieraum/recyclinghof`
(Lern-Tafeln).

**Roboter bauen:** `roboter_bausatz` (Rahmen) · `teil_beine` · `teil_koerper` · `teil_arme` ·
`teil_kopf` (Bauteile, in dieser Reihenfolge).

**Recycling:** `schrotthaufen` (abbauen = Schrott) · `schrott` · `recycler` (Schrott → Bauteil) ·
`fliessband` (schiebt alles weiter).

**Buchstaben-Blöcke** `buchstabe_a` … `buchstabe_z` (A–Z) – zum **Beschriften** (Maschinen
benennen). Für Umlaute AE/OE/UE verwenden.

> **Eigene Muster oder Bilder an Blöcke hängen?** Ja! Im Block kann statt `color = "#..."`
> ein `texture = "..."` stehen (Muster ohne Datei, eine PNG, oder pro Seite `top/side/bottom`).
> Mehr dazu in `textures/README.txt`.

**Items:** `logbuch` (Roboter-Katalog) · `kamera` · die Mob-Spawn-Eier (z. B. `rollbot`,
`funkenbot`, `meisterbot`) · Abzeichen (`badge_10/25/50`).

---

## 14. Befehle

| Befehl | Wirkung | Wer |
|---|---|---|
| `/lernfortschritt` | Dein Bericht: Rang, Reparaturen, gelöste Aufgaben, getroffene Roboter, Lernbereiche | alle |
| `/lernplan` | Übersicht aller Zonen + Lehrplan-21-Bezüge (für Eltern/Lehrpersonen) | alle |
| `/lernwelt` | Status + empfohlene `minetest.conf`-Zeilen | alle |
| `/schrauber_werkstatt` | Baut eine ganze Werkstatt (Raum, Tafeln, Logik, Fließband, Recycler, Roboter) | Admin¹ |
| `/schrauber_logik` | Fertige Schalter → Leitung → Lampe → Tür-Schaltung | Admin¹ |
| `/schrauber_teststation` | Kleine fertige Test-Station | Admin¹ |
| `/schrauber_roboter` | Setzt einen Roboter-Rahmen zum Zusammenbauen aus | Admin¹ |

¹ Braucht das `server`-Privileg — im **Einzelspieler automatisch vorhanden**.

---

## 15. Einstellungen

Im Menü unter **Einstellungen → Alle Einstellungen → Mods** (oder in `minetest.conf`):

| Einstellung | Standard | Wirkung |
|---|---|---|
| `lernwelt_show_hud` | an | Fortschritts-Anzeige oben links |
| `lernwelt_spawn_creatures` | an | Defekte Roboter erscheinen automatisch an Land |
| `lernwelt_big_text` | aus | **Größere Schrift** auf den Lern-Tafeln |
| `lernwelt_easy_mode` | aus | **Einfacher Modus**: Quiz zeigt nur 2 Antworten |
| `lernwelt_schrauber_starter_kit` | an | Startausrüstung beim ersten Join |

---

## 16. Für Eltern & Lehrpersonen 👪

- **Lehrplan 21 (Medien & Informatik):** Jede Zone und Aufgabe ist mit Kompetenzbereichen
  getaggt — **Informatik-Grundlagen** (Ursache & Wirkung, einfache Logik wenn-dann, Algorithmus
  = Schritte in Reihenfolge), **Technik/TTG** (Bauteile erkennen und zusammenbauen) und
  **NMG** (Materialkreislauf / Recycling).
- Das **Verdrahten von Schalter → Lampe → Tür** ist die kindgerechte Einstiegsrampe zu
  **Mesecons** (Luantis Redstone): dieselbe Idee, ohne Überforderung. Mit installiertem
  Mesecons arbeiten die Bausteine sogar mit echten Drähten zusammen.
- Das **Zusammenbauen in fester Reihenfolge** macht den Begriff **Algorithmus** anfassbar.
- `/lernplan` zeigt alle Zonen und ihre Bezüge auf einen Blick.
- `/lernfortschritt` zeigt pro Kind: Rang, Reparaturen, gelöste Aufgaben, getroffene Roboter
  und berührte Lernbereiche.
- **Barrierearm:** `lernwelt_big_text` (Großschrift) und `lernwelt_easy_mode` (weniger
  Quiz-Optionen) erleichtern den Einstieg.

---

## 17. Kleine Missionen & Spielideen

- 💡 **Erleuchtung:** baue Schalter → Leitung → Lampe und bringe die Lampe zum Leuchten.
- 🚪 **Türöffner:** steuere mit einem Schalter eine Tür — geh hindurch, wenn sie offen ist.
- 🔘 **Impuls:** baue einen **Taster** ein, der die Lampe nur kurz anschaltet.
- 🤖 **Erster Roboter:** baue einen Roboter in der richtigen Reihenfolge fertig.
- ⛓️ **Reihenfolge-Profi:** baue drei Roboter, ohne die Reihenfolge zu verwechseln.
- ♻️ **Kreislauf:** Schrott abbauen → recyceln → daraus einen Roboter bauen.
- 🎢 **Fließband-Reise:** schicke einen Roboter über ein langes Fließband.
- 🟢 **Erste Schritte:** 5 Roboter reparieren → Rang „Bastler".
- 📷 **Forscher:** alle Roboter fotografieren (Entdeckt 10/10).
- 🌟 **Legende:** den seltenen Meisterbot reparieren.
- 🔤 **Werkstatt-Schild:** beschrifte deine Werkstatt mit Buchstaben-Blöcken.

---

## 18. Problemlösung

- **Roboter erscheinen nicht automatisch:** `lernwelt_spawn_creatures` muss an sein und es
  braucht eine Mob-API (VoxeLibre/Mineclonia oder `mobs_redo`). Du kannst Roboter jederzeit mit
  **Spawn-Eiern** setzen.
- **Schalter macht nichts:** Lampe/Tür müssen über **Leitungen** mit dem Schalter **verbunden**
  sein (Blöcke direkt aneinander). Probiere `/schrauber_logik` für ein funktionierendes Beispiel.
- **Roboter-Rahmen nimmt mein Teil nicht:** Die **Reihenfolge** muss stimmen (Beine → Körper →
  Arme → Kopf). Der Rahmen sagt dir, welches Teil als Nächstes kommt.
- **Recycler tut nichts:** Du musst **Schrott in der Hand** halten (aus einem Schrotthaufen).
- **Kein Ton:** Sounddateien sind optional. Lege eigene `.ogg`-Dateien in den `sounds/`-Ordner
  (siehe `sounds/README.txt`) — ohne sie läuft alles, nur leise.

Viel Spass beim Verdrahten, Zusammenbauen und Wiederverwerten! 🤖🔧
