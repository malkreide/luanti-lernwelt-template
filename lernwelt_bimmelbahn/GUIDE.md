# Player Guide — Bimmelbahn-Land (Little Train Land) 🚂🚉

This guide explains **all the elements** of the "Bimmelbahn-Land" learning world,
**how to use them** and **what the tasks and goals are**. Made for **parents and
children playing together** (about 5–7 years old).

> Note: the in-game texts are in **German** (the theme is authored in German), so
> names you see on screen are German; this guide adds English explanations. German
> names appear with an English gloss where helpful.

> Motto: **Fahren · Planen · Ordnen** (Drive · Plan · Order)
>
> There is no "winning" — the point is to drive, plan and learn: visit the colourful
> villages with the little train, drive **routes in the right order**, set switches and
> signals, match colours and greet passengers, while practising sequencing, counting,
> patterns and naming (Swiss curriculum *Lehrplan 21*, cycle 1 — mainly media &
> informatics / **sequence** and maths).

---

## 1. Quick start

1. Create an ordinary world (flat is nicest for laying track) — see
   **[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.
2. Make a new world with **VoxeLibre** or **Mineclonia** and enable the mods
   **`lernwelt`** + **`lernwelt_bimmelbahn`**.
3. Enter the world → you automatically get the **starter kit**. Fast start: type the
   command **`/bimmelbahn_hauptbahnhof`** — a ready-made station hall with boards, a
   timetable desk, station signs and a train appears in front of you.

---

## 2. Basic controls

| Action | How |
|---|---|
| **Use / greet a passenger / open a board / sign, signal, desk** | **Right-click** |
| **Photograph / break blocks** | **Left-click** (hold) |
| **Build / place an item / lay track** | **Right-click** on the ground |
| **Fly (creative)** | Double-jump; then jump = up, sneak = down |

In the child setting, **damage and dying are off** — nothing bad can happen. The time
of day is fixed (no scary night), there are no monsters, and every passenger is
friendly.

---

## 3. The world: main station + 4 colourful villages

The base is the **Hauptbahnhof** (main station). Rails lead to four **colourful
villages**. Each zone has a **learning board** and matching passengers:

| Zone | Passengers there | Learning areas |
|---|---|---|
| 🚉 **Hauptbahnhof** (main station) | Schaffner-Maus, Bahnhofs-Hund, Gepäck-Igel, *golden owl* | Informatics (sequence), maths, science (transport) |
| 🔴 **Rotdorf** (red village) | Rote Reise-Katze, Reise-Fuchs | Colours (art), German, maths |
| 🟡 **Gelbdorf** (yellow village) | Gelbes Entlein, Sonnen-Kanari | Colours (art), maths (counting) |
| 🔵 **Blaudorf** (blue village) | Blauer Papagei, Blaues Häschen | Colours (art), maths (counting, patterns) |
| 🟢 **Gründorf** (green village) | Grüner Frosch, Grüne Schildkröte | Colours (art), maths (patterns) |

---

## 4. Learning boards & tasks (the heart of the game)

**Use:** right-click a learning board → a window shows the **activity**, the
**curriculum links** and the zone's **tasks**.

Three task types:

- ❓ **Quiz** — a question with answer buttons. Right = ✓ + reward, wrong = "try again".
- 🎨 **Copy the pattern** — a pattern is shown at the top (e.g. red-blue-yellow). Click the
  colour buttons **in the right order**. A mistake resets it.
- 🐭 **Greet goal** — e.g. "greet 2 yellow ducklings". The progress (x/N) counts up
  automatically as you greet the passengers.

Solved tasks give a sound + praise and count towards your progress
(see `/lernfortschritt`).

**Which tasks are there?**

| Zone | Tasks |
|---|---|
| Main station | **Pattern** red-blue-yellow (order) · Quiz "what does a switch do?" · Quiz "which station comes first?" · Greet 1 conductor mouse |
| Red village | Quiz "which colour?" · **Pattern** red-yellow-red · Greet 1 red cat |
| Yellow village | Quiz "which colour?" · Quiz "how many ducklings? (count)" · Greet 2 ducklings |
| Blue village | Quiz "which colour?" · Quiz "how many wagons? (count)" · Greet 1 blue parrot |
| Green village | Quiz "which colour?" · **Pattern** green-blue-green-blue · Greet 2 green frogs |

---

## 5. Route order task 🚉 (the sequencing heart)

This is the core idea of the world: **in which order** does the train visit the villages?

**Use:**
1. Right-click the **Fahrplan-Pult** (timetable desk) — or type `/bimmelbahn_route`. You
   get a **route** of three colours, e.g. **Rot → Blau → Gelb** (red → blue → yellow).
2. Drive (or walk) to the **Stations-Schilder** (station signs) and **right-click** to
   stop in **exactly that order**: first the red sign, then blue, then yellow.
3. **Right order** → the next station is announced; **whole route done** → reward + your
   **route counter** rises.
4. **Wrong station?** No problem — the route simply starts over from the beginning.

**Milestones:**

| Routes completed | Title |
|---|---|
| 3 | Routen-Planer (route planner) |
| 8 | Schaffner (conductor) |
| 15 | Lokführer (train driver) |

> 💡 This trains **sequences and order** (Lehrplan 21, media & informatics / MI.1) —
> with no screen theory, just by driving.

---

## 6. Switch & signal 🔀 (simple logic)

A real railway needs **switches** (choose the path) and **signals** (stop/go). Here there
is a **much simplified** version (a small idea borrowed from Mesecons / Basic Trains) so
children experience **if–then** with their hands:

- 🔀 **Weiche** (switch) — **right-click** flips the path: **straight ⇄ to the right**.
  The arrow on top turns. (Pure cause → effect.)
- 🚦 **Signal** — **right-click** toggles **red ⇄ green**. A train can pass through, but at
  **red it waits** in front.

**Demo to watch:** the command **`/bimmelbahn_demo`** builds a short track with a small
**demo train** that drives back and forth on its own. Set the signal to **red** → the
train **stops**. Set it to **green** → it **goes** again. That is how a railway's logic
works! (Lehrplan 21: MI.2 / technical design TTG.2)

---

## 7. Matching colours 🎨

Each village has **its colour**: red, yellow, blue, green.

- 🧩 **Quiz "which colour is the village?"** on each village board.
- 🎨 **Copy the pattern** with colour buttons.
- 🏠 **Colourful house blocks** and 🚃 **wagon blocks** in the four colours, to build with.
- 🚃 **Wagon parade:** `/bimmelbahn_wagen` lines up a colourful train **in order**
  (red – yellow – green – blue) — colours + sequence to look at.

---

## 8. Greeting passengers 🐭

**Use:** right-click a passenger = **greet**. You get hearts, a sound, a counter entry
and (after enough encounters) a new rank.

**All passengers:**

| Passenger | Home | Eats | Note |
|---|---|---|---|
| Schaffner-Maus (conductor mouse) | Main station | Cheese rolls | calls the stations |
| Bahnhofs-Hund (station dog) | Main station | Dog biscuits | guards the station · 👪 family |
| Gepäck-Igel (luggage hedgehog) | Main station | Berries | carries the cases |
| Rote Reise-Katze (red travel cat) | Red village | Milk | purrs on the train |
| Reise-Fuchs (travel fox) | Red village | Berries | knows all the ways |
| Gelbes Entlein (yellow duckling) | Yellow village | Grains | waddles to the train · 👪 family |
| Sonnen-Kanari (sun canary) | Yellow village | Grains | sings the departure song |
| Blauer Reise-Papagei (blue parrot) | Blue village | Nuts | calls "all aboard!" |
| Blaues Reise-Häschen (blue bunny) | Blue village | Carrots | hops onto the platform · 👪 family |
| Grüner Reise-Frosch (green frog) | Green village | Flies | croaks the timetable · 👪 family |
| Grüne Schildkröte (green turtle) | Green village | Salad | travels at its leisure |
| **Goldene Reise-Eule / golden travel owl** | Main station | Starlight | ✨ very rare, glows |

- 👪 **Families:** greet a parent (station dog, yellow duckling, blue bunny, green frog)
  and its **babies** appear, which you can greet too.
- ✨ **Golden owl:** does **not** appear by itself (very rare). Get it from its **spawn
  egg** (in the starter kit / creative inventory).
- 🌿 **Living villages:** the other passengers **appear automatically** on solid ground
  near you (gently capped). Can be turned off (see Settings).

**Spawn eggs:** every passenger has an egg. Egg in hand → **right-click** the ground =
place the passenger.

---

## 9. Driving the Bimmelbahn 🚂

**Use:**
1. **Place** the train item (right-click on the ground).
2. **Right-click** the train = **get in**.
3. Drive: **W/S** forward/back · **A/D** steer · **jump** = **whistle (toot!)** + a small
   hop · **right-click** = get out.

**Extras:**
- 💨 **Steam puff** from the chimney while driving.
- 📯 **Whistle** on jump (own sound, optional).
- 👨‍👧 **Second seat** — a **second player** can **ride along** with right-click (ideal
  for parent + child).

---

## 10. Explorer camera 📷

**Use:** hold the camera, get near a passenger and **left-click** = photo. The nearest
**not-yet-discovered** passenger is marked **discovered** in the logbook (range about 12
blocks). Photograph **all** passengers — the logbook shows "Discovered: X/12".

---

## 11. Station logbook 📋

**Use:** logbook in hand → **right-click** to open. You see a list of all passengers;
click one for the **profile** (name, home, eats, note), how **often you greeted** it, and
whether it has been **discovered**. The top shows your **rank**, the **total encounters**
and the **discovered count**.

---

## 12. Ranks & badges 🏆

Every greeting counts. At thresholds your rank goes up (sound + pop-up); from "Schaffner"
on you also get a **badge item**.

| From … encounters | Rank | Badge |
|---|---|---|
| 0 | Fahrgast (passenger) | – |
| 5 | Schaffner-Lehrling (trainee conductor) | – |
| 10 | Schaffner (conductor) | 🥉 yes |
| 25 | Lokführer (train driver) | 🥈 yes |
| 50 | Bahnchef (station chief) | 🥇 yes |

Top-left a **HUD** always shows: world · rank · encounters.

---

## 13. Blocks, items & internal names

Everything is generated without external pictures. Internal names (for the creative
search or `/giveme`) begin with `lernwelt_bimmelbahn:`.

**Railway blocks:** `schiene` (rail) · `bahnsteig` (platform) · `kies` (ballast) ·
`backstein` (brick) · `holzbohle` (plank) · `bahnhofsglas` (transparent) ·
`bahnhofslampe` (glows) · `prellbock` (buffer stop).

**Colourful blocks:** `haus_rot/gelb/blau/gruen` (houses) · `wagen_rot/gelb/blau/gruen`
(wagons).

**Interactive parts:** `schild_rot/gelb/blau/gruen` (station signs) · `fahrplan`
(timetable desk) · `signal_rot`/`signal_gruen` (signal) · `weiche_gerade`/`weiche_ab`
(switch) · `tafel_hauptbahnhof/rotdorf/gelbdorf/blaudorf/gruendorf` (learning boards).

**Patterned build blocks:** `muster_bahnuebergang` (level crossing), `muster_zugfenster`
(train window), `muster_backstein` (brick), `muster_schach` (station floor),
`muster_konfetti`, `bahnhofsuhr` (a real clock with a face on top), `koffer` (a suitcase
crate), `buchstabe_a` … `buchstabe_z` (**letter blocks A–Z**, lay out **station names**)
and `zahl_0` … `zahl_9` (**number blocks 0–9**, for counting). In creative mode all
blocks are in the build menu.

> **Own patterns or pictures on blocks?** Yes! A block can use `texture = "..."`
> instead of `color = "#..."`:
> - **Pattern without a file** — layer colour rectangles, e.g.
>   `texture = "[fill:16x16:#ecf0f1^[fill:8x8:0,0:#34495e^[fill:8x8:8,8:#34495e"`
>   (checker). Overlay format: `^[fill:WIDTHxHEIGHT:X,Y:#colour`.
> - **A real picture** — put a PNG (16×16 or 32×32) in the `textures/` folder and set
>   `texture = "lernwelt_bimmelbahn_mypic.png"`.
> - **Per face** — `top`, `side` and `bottom` give a block different faces (like
>   `bahnhofsuhr` and `koffer`). See `textures/README.txt`.

**Items:** `logbuch` · `kamera` · `bimmelbahn` · the spawn eggs (e.g. `schaffner_maus`,
`gelbes_entlein`, `goldene_reise_eule`) · badges (`badge_10/25/50`).

---

## 14. Commands

| Command | Effect | Who |
|---|---|---|
| `/bimmelbahn_route` | New route assignment (stations in an order) | everyone |
| `/lernfortschritt` | Your report: rank, greetings, tasks solved, passengers met | everyone |
| `/lernplan` | Overview of all zones + Lehrplan-21 links (for parents/teachers) | everyone |
| `/lernwelt` | Status + recommended `minetest.conf` lines | everyone |
| `/bimmelbahn_teststation` | Small ready-made station (boards, desk, signs, train) | admin¹ |
| `/bimmelbahn_hauptbahnhof` | Bigger glass-hall station with a door | admin¹ |
| `/bimmelbahn_demo` | Demo track with a signal (train stops at red) | admin¹ |
| `/bimmelbahn_wagen` | Lines up a colourful wagon train in order | admin¹ |

¹ Needs the `server` privilege — **automatically available in single-player**.

---

## 15. Settings

In the menu under **Settings → All settings → Mods** (or in `minetest.conf`):

| Setting | Default | Effect |
|---|---|---|
| `lernwelt_show_hud` | on | Progress display top-left |
| `lernwelt_spawn_creatures` | on | Passengers appear automatically on solid ground |
| `lernwelt_big_text` | off | **Larger text** on the learning boards |
| `lernwelt_easy_mode` | off | **Easy mode**: quizzes show only 2 answers |
| `lernwelt_bimmelbahn_starter_kit` | on | Starter kit on first join |

---

## 16. For parents & teachers 👪

- **Lehrplan 21 (cycle 1):** every zone and task is tagged with competence areas —
  **media & informatics** (planning **sequences and order**, simple if-then logic with
  switch/signal), **maths** (counting, ordering patterns), **visual arts** (matching
  colours), science (transport), German (naming).
- `/lernplan` shows all zones and their links at a glance.
- `/lernfortschritt` shows per child: rank, greetings, tasks solved, passengers met and
  the learning areas covered.
- **Accessibility:** `lernwelt_big_text` (large text) and `lernwelt_easy_mode` (fewer
  quiz options) make it easier to start.

---

## 17. Little missions & ideas

- 🟢 **First ride:** greet 5 passengers → rank "Schaffner-Lehrling".
- 🚉 **Route planner:** drive 3 whole routes in the right order.
- 🔀 **Logic tinkerer:** with `/bimmelbahn_demo`, set the signal and make the train
  stop/go — explain **why** the train stops.
- 📷 **Travel reporter:** photograph all passengers (Discovered 12/12).
- 🧩 **Task master:** solve all tasks on all five boards.
- 🎨 **Colour master:** use `/bimmelbahn_wagen` and name the colours in order.
- 🔤 **Name play:** build "ROTDORF" or your favourite village name with letter blocks.
- 🛤️ **Track builder:** build your own line with rails and station signs.
- ✨ **Legend:** find the rare golden travel owl.
- 👨‍👧 **Team ride:** drive the Bimmelbahn together.

---

## 18. Troubleshooting

- **Passengers don't appear automatically:** `lernwelt_spawn_creatures` must be on and a
  mob API is required (VoxeLibre/Mineclonia or `mobs_redo`). You can always place
  passengers with **spawn eggs**.
- **No sound:** sound files are optional. Put your own `.ogg` files in the `sounds/`
  folder (see `sounds/README.txt`) — without them everything works, just silently.
- **The route task doesn't count:** you first need a **route** (timetable desk or
  `/bimmelbahn_route`), then stop at the **station signs** — in the right order.
- **The demo train won't move:** check that the signal is **green** (right-click toggles
  it). At **red** it stops on purpose.
- **"Unknown node":** if something is missing, check that both mods (`lernwelt` +
  `lernwelt_bimmelbahn`) are enabled.

Have fun driving, planning and ordering! 🚂🚉

---

*Deutsche Fassung / German version: [ANLEITUNG.md](ANLEITUNG.md) · einseitige
Kinder-Kurzfassung: [KINDER-KURZ.md](KINDER-KURZ.md)*
