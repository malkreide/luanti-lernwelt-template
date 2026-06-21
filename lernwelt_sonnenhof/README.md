# Sonnenhof 🌻🐄🍞

**🎓 Lehrplan 21 – vermittelte Kompetenzbereiche:**

![Natur, Mensch, Gesellschaft](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.2,%20NMG.3-2e7d32)
![Überfachliche Kompetenzen](https://img.shields.io/badge/%C3%9Cberfachliche%20Kompetenzen-EZ.1-00838f)
![Mathematik](https://img.shields.io/badge/Mathematik-MA.1-1565c0)
![Deutsch (Sprache)](https://img.shields.io/badge/Deutsch%20(Sprache)-D.2-c62828)

Ein kinderfreundliches **Lernwelt-Thema für [Luanti](https://www.luanti.org/)** (früher Minetest)
rund um einen **Zauber-Bauernhof**. Gedacht zum **gemeinsamen Spielen von Eltern und Kind**
(ca. 5–8 Jahre) – spielerisch passend zum Schweizer **Lehrplan 21, 1./2. Zyklus**
(Schwerpunkt **NMG – Natur, Mensch, Gesellschaft: Pflanzen & Tiere**).

> Motto: **Säen · Pflegen · Ernten**

📖 **Spielanleitung:** [ANLEITUNG.md](ANLEITUNG.md) (vollständig, DE) ·
🧒 [KINDER-KURZ.md](KINDER-KURZ.md) (einseitig zum Ausdrucken) ·
🇬🇧 [GUIDE.md](GUIDE.md) (English).

Dieses Mod ist ein **Thema** für das [Lernwelt-Template](../README.de.md): Die gesamte
Spielmechanik (friedliche Config, Lern-Tafeln, Katalog/Logbuch, Ränge, Abzeichen,
Belohnungs-Sounds, Lehrplan-21-Tagging) kommt aus der Engine-Mod **`lernwelt`**. Das Thema
selbst ist im Kern nur **ein deklarativer `register_world{...}`-Aufruf** in der `init.lua` –
plus wenige selbstgebaute Extras (Zauber-Giesskanne, Zaubermühle, Futtertrog, Weizen-Feld).

## Wenig Eigenbau – nutzt Farming Redo & Animalia 🌾🐔

Anders als die anderen Beispiel-Themen baut der **Sonnenhof bewusst wenig selbst**: Wenn die
beliebten Mods **[Farming Redo](https://content.luanti.org/packages/TenPlus1/farming/)** und
**[Animalia](https://content.luanti.org/packages/ElCeejo/animalia/)** installiert sind, nutzt das
Thema sie **direkt** – echte Saat, echtes Korn, Mehl und Brot sowie echte Hoftiere (Huhn, Kuh,
Schaf, Schwein …). Die **Zaubermühle** mahlt dann sogar echten `farming:wheat` zu `farming:flour`
und backt `farming:bread`, und die Startausrüstung legt **Farming-Saatgut** und
**Animalia-Tier-Eier** dazu.

**Ohne diese Mods läuft trotzdem alles:** Das Thema bringt eine eigene, kleine **Weizen-Pflanze**
(vom Samen über vier Wachstums-Stufen bis zum reifen Korn) und **eigene freundliche Hoftiere**
über die Engine mit. So funktioniert „Vom Samen zum Brot" und die Tierpflege in **jedem** Spiel.

## Lernen auf dem Bauernhof 🌱

Die Kinder entdecken den **Sonnenhof** mit seinen drei Zonen:

- 🌾 **Felder** – hier beginnt alles: **säen**, mit der **Zauber-Giesskanne giessen** und
  **Geduld** haben, bis aus dem Samen ein Halm und reifes Korn wird. Bienen bestäuben die Blüten.
- 🐄 **Tiergehege** – Huhn, Kuh, Schaf, Schwein, Ziege, Ente & Co. **pflegen** (Futtertrog),
  zählen und lernen, wer was gibt (Eier, Milch, Wolle) und was sie fressen (**Nahrungskette**).
- 🏭 **Mühle** – die **Zaubermühle** mahlt **Korn → Mehl** und backt **Mehl → Brot**. So
  schliesst sich der Weg **„Vom Samen zum Brot"**.

## Funktionen

- 🌾 **Vom Samen zum Brot** – säen → giessen → ernten → mahlen → backen, als anfassbare Kette
  (mit eigener Weizen-Pflanze; nutzt Farming Redo direkt, wenn vorhanden).
- 💧 **Zauber-Giesskanne** – Rechtsklick aufs Feld lässt **alle Pflanzen in der Nähe wachsen**
  (auch echte Farming-Redo-Pflanzen!). Übt **Geduld** und Fürsorge; eigener Zähler.
- 🏭 **Zaubermühle** – Korn → Mehl → Brot, mit Zähler und kleinen Auszeichnungen
  (Müllerlehrling → Müller → Müllermeister).
- 🐾 **13 Hoftiere** (mit Mob-API): Huhn, Kuh, Schaf, Schwein, Ziege, Ente, Esel, Hofkatze,
  Hofhund, Biene, Feldmaus, Storch – plus das seltene, leuchtende **Goldene Glückshuhn** 🌟.
  Rechtsklick = dem Tier **helfen** (friedlich, kein Kämpfen).
- 🍽️ **Futtertrog (Tierpflege)** – mit **Tierfutter** oder **Korn** füttern = **alle Tiere in
  der Nähe** (auch Animalia-Tiere!) bekommen ein Herzchen; eigener Zähler.
- 🗺️ **3 Lern-Zonen** (Felder, Tiergehege, Mühle) mit platzierbaren Lern-Tafeln
  (Aktivität + Lehrplan-21-Bezug).
- ❓ **Aufgaben an den Lern-Tafeln** – Quiz (Pflanzen, Tiere, Nahrungskette), eine
  **Saatreihen-Muster**-Aufgabe und Hilfe-Ziele mit Belohnung; zählen für `/lernfortschritt`.
- 🌻 **Sonnenblumen** und eine **Hoflaterne** für eine warme Hof-Stimmung.
- 🧱 **Farm-Blöcke** (rein prozedural, ohne Bilddateien): Scheunenwand, Fachwerk, Scheunendach,
  Holzbalken, Strohballen, Stroh, Ackererde, Blumenwiese, Feldweg, Weidezaun, Mehlsack,
  Hoflaterne (leuchtet).
- 📋 **Sonnenhof-Logbuch** – Tier-Steckbriefe mit Zone, „frisst", Zähler und „entdeckt"-Status.
- 📷 **Entdecker-Kamera** – Tiere fotografieren = im Logbuch entdecken (Sammeln, getrennt
  vom Helfen).
- 👪 **Tier-Familien** – wer ein „Eltern"-Tier trifft (Huhn, Kuh, Schaf, Schwein, Ente,
  Feldmaus), bringt kleine Begleiter mit.
- 🌍 **Lebendiger Hof** – Land-Tiere erscheinen automatisch in deiner Nähe, die Ente im Wasser
  (schonend begrenzt; abschaltbar per Einstellung `lernwelt_spawn_creatures`).
- 🎒 **Startausrüstung** beim ersten Join: Logbuch, Kamera, Giesskanne, Weizen-Samen,
  Tierfutter + Korn, Bau-Blöcke (inkl. Zaubermühle & Futtertrog) und je ein Spawn-Ei – plus
  Farming-Saatgut und Animalia-Eier, falls installiert (abschaltbar).
- 🏆 **Ränge und Abzeichen**: Hofkind → Jungbauer → Hofhelfer → Bauernmeister → Sonnenhof-Held.
- 🔊 **Sound-Hooks** – Belohnungs-/Rang-Sounds aus der Engine, Hahn-/Ambient-Sounds aus
  diesem Thema.

## Abhängigkeiten

- **`lernwelt`** (die Engine) – *erforderlich*. Ohne sie startet das Thema nicht.
- **`farming`** (Farming Redo) – *optional, empfohlen*. Wird direkt genutzt (echte Saat, Korn,
  Mehl, Brot). Fehlt sie, springt die eigene Weizen-Pflanze + Korn/Mehl/Brot des Themas ein.
- **`animalia`** – *optional, empfohlen*. Wird direkt genutzt (echte Hoftiere + Spawn-Eier).
  Fehlt sie, übernehmen die eigenen, freundlichen Hoftiere des Themas.
- Eine **Mob-API** – *optional*: `mobs_redo` (Minetest Game) **oder** `mcl_mobs`
  (VoxeLibre / Mineclonia) für die eigenen Tiere des Themas. Ohne Mob-API funktioniert alles
  ausser den lebenden Tieren – **Giesskanne, Mühle, Futtertrog und das Weizen-Feld laufen auch
  ohne Mob-API** (eigener Code).

## Installation

1. Den Ordner `lernwelt` **und** den Ordner `lernwelt_sonnenhof` in deinen
   Luanti-`mods/`-Ordner kopieren.
2. (Optional, empfohlen) **Farming Redo** und **Animalia** installieren – oder ein Game mit
   Mobs nutzen (VoxeLibre/Mineclonia bringt `mcl_mobs` mit).
3. In der Welt-Konfiguration die Mods aktivieren (`lernwelt` + `lernwelt_sonnenhof`, dazu nach
   Wunsch `farming` + `animalia`).
4. Empfehlung für Kinder: **Kreativ-Modus + friedlich** (setzt die Engine automatisch).

## Schnell testen

Beim **ersten Betreten** der Welt bekommst du automatisch eine **Startausrüstung** ins
Inventar. Tipp für den schnellen Einstieg: der Befehl **`/sonnenhof_scheune`** baut dir sofort
einen **ganzen Bauernhof** mit Scheune, Lern-Tafeln, Weizen-Feld, Tiergehege, Zaubermühle und
Futtertrog. Im Kreativ-Modus liegen alle Items zusätzlich im Kreativ-Inventar.

Abschalten: in der `minetest.conf` bzw. den Welt-Einstellungen
`lernwelt_sonnenhof_starter_kit = false` setzen.

## Nützliche Befehle

- `/sonnenhof_scheune` – baut einen **ganzen Bauernhof** vor dir (Scheune, 3 Lern-Tafeln,
  Weizen-Feld, Tiergehege mit Zaun, Zaubermühle, Futtertrog). Benötigt das `server`-Privileg
  (im Einzelspieler automatisch vorhanden).
- `/sonnenhof_teststation` – kleine fertige Test-Station, Priv `server`
- `/lernfortschritt` · `/lernplan` · `/lernwelt` – aus der Engine (Fortschritt, Lehrplan, Status)

## Eigene Grafiken und Sounds

Das Thema läuft **ohne externe Dateien** (Farben/Muster via `[fill`-Generator der Engine).
Eigene Texturen/Sounds können ergänzt werden – siehe `textures/README.txt`
und `sounds/README.txt`. **Bitte nur selbst erstellte oder frei lizenzierte Inhalte verwenden.**

## Lizenz

- **Code:** MIT – siehe [LICENSE.txt](LICENSE.txt)
- **Mitgelieferte Medien:** keine (alle Farben werden zur Laufzeit erzeugt)

## Rechtlicher Hinweis

Dies ist ein **eigenständiges Werk**. Es ist **nicht** mit einer Fernsehserie, einem Film,
einem Spiel, einer Marke oder einem Unternehmen verbunden und verwendet **keine** geschützten
Namen, Figuren, Logos oder Designs. Die allgemeine Spielidee „einen Bauernhof bewirtschaften"
ist nicht schutzfähig. *Farming Redo* und *Animalia* sind eigenständige Mods ihrer jeweiligen
Autoren und werden – falls installiert – nur über ihre öffentliche Schnittstelle genutzt.
