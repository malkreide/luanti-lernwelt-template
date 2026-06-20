# Player Guide — Schrauber-Werkstatt (Tinkerer's Workshop) 🤖🔧

This guide explains **all the elements** of the "Schrauber-Werkstatt" learning world, **how to
use them** and **what the tasks and goals are**. Made for **parents and children playing
together** (about 6–9 years old).

> Note: the in-game texts are in **German** (the theme is authored in German), so names you see
> on screen are German; this guide adds English explanations.

> Motto: **Verdrahten · Zusammenbauen · Wiederverwerten** (Wire up · Assemble · Recycle)
>
> There is no "winning" — the point is to tinker, discover and learn: build little circuits
> (switch → lamp → door), assemble robots in the right order, repair and photograph robots,
> while practising **cause & effect**, **simple logic** and **computer-science basics** (Swiss
> curriculum *Lehrplan 21*, Media & Informatics).

---

## 1. Quick start

1. Make a new world with **VoxeLibre** or **Mineclonia** and enable the mods
   **`lernwelt`** + **`lernwelt_schrauber`**. (Optional: **`mesecons`** for the real Mesecons
   bridge; world tips: **[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**.)
2. Enter the world → you automatically get the **starter kit**.
3. Fast start: type **`/schrauber_logik`** — a ready-made switch-lamp-door circuit appears.
   Or **`/schrauber_werkstatt`** for the whole workshop.

---

## 2. Basic controls

| Action | How |
|---|---|
| **Use / flip a switch / repair a robot / attach a part / open a board** | **Right-click** |
| **Photograph / dig blocks (e.g. scrap heap)** | **Left-click** (hold) |
| **Build / place an item (block, kit …)** | **Right-click** on the ground |
| **Fly (creative)** | Double-jump; then jump = up, sneak = down |

In the child setting, **damage is off** — nothing bad can happen. The time of day is fixed
(bright workshop), and there are no monsters. The Funkenbots' "sparks" are completely harmless.

---

## 3. The world: 3 learning zones

Each zone has a **learning board** and matching robots:

| Zone | Robots there | Learning areas |
|---|---|---|
| 🎢 **Fließband** (conveyor) | Rollbot, Greifbot, Sortierbot | Cause & effect, algorithm, tech |
| 🔌 **Energieraum** (energy room) | Funkenbot, Lampenbot, Schaltbot, *Meisterbot* | Logic (switch→lamp→door) |
| ♻️ **Recyclinghof** (recycling yard) | Sammelbot, Pressbot, Putzbot | Cause & effect, material cycle |

---

## 4. Learning boards & tasks (the learning heart)

**Use:** right-click a learning board → a window shows the **activity**, the **curriculum
links** and the zone's **tasks**.

Three task types:

- ❓ **Quiz** — a question with answer buttons. Right = ✓ + reward, wrong = "try again".
- 🎨 **Copy the pattern / order** — a pattern is shown at the top (e.g. the build order as
  colours: legs-body-arms). Click the buttons **in the right order**. A mistake resets it. This
  practises **algorithms** (steps in order).
- 🤖 **Repair goal** — e.g. "repair 2 Rollbots". The progress (x/N) counts up automatically.

Solved tasks give a sound + praise and count towards your progress (see `/lernfortschritt`).

---

## 5. Simple logic: switch → wire → lamp → door 🔌 (the Mesecons bridge)

The **heart** of the theme and the direct bridge to **Mesecons**. You wire up a little circuit
and see **cause & effect** (if-then):

1. 🟥 Place a **Schalter** (switch) on the ground.
2. ➖ Lay a row of **Leitung** (wires) leading away from the switch.
3. 💡 Put a **Lampe** (lamp) at the end — and/or a **Tür** (door) on the wire.
4. 🖱️ **Right-click the switch** → the **wire glows**, the **lamp turns on**, the **door opens**.
   Switch off again → everything turns off.

**The logic kit:**

| Block | What it does |
|---|---|
| **Schalter** (switch) | Right-click = on/off, stays put (a source). |
| **Taster** (button) | Right-click = a short **pulse** (turns off by itself after a few seconds). |
| **Leitung** (wire) | Connects everything; **glows** when powered. |
| **Lampe** (lamp) | Turns on when the network is powered. |
| **Tür** (door) | **Opens** (you can walk through) when powered. |

> **Simple rule:** a connected wire network is "powered" as soon as **any** switch or button on
> it is **on**. Then **all** lamps and doors in the network turn on.

> 🔌 **Mesecons bridge:** if the **`mesecons`** mod is installed, switch, button, lamp and door
> **also** talk to real Mesecons wires (switch = receptor, lamp/door = effector). Without
> Mesecons the theme's own mini-logic runs by itself. Either way you learn the same idea — and
> can later keep building with real Mesecons.

Tip: the command **`/schrauber_logik`** builds a ready-made example circuit to try out.

---

## 6. Assembling a robot 🤖 (an algorithm: order matters!)

Here you practise doing **steps in the right order** — exactly what an **algorithm** is.

1. 🧰 Hold a **Roboter-Bausatz** (robot kit) and place it → a **robot frame** appears (no parts
   yet).
2. 🦿 Now attach the parts **in this order**: **Beine → Körper → Arme → Kopf** (legs → body →
   arms → head). Hold the right part and **right-click** the frame.
3. ❌ **Wrong part?** The frame tells you which part comes **next** — the order must be correct.
4. ✅ After the **head** the robot is finished: it **powers on**, glows and **follows you**
   around. Each finished robot counts ("Gebaute Roboter: N").

> No mob API? **No problem:** the kit, the parts and the assembled, following robot are the
> theme's own code and always work.

Parts come from the **starter kit**, the **creative inventory** — or fresh out of the
**Recycler** (see below)!

---

## 7. Conveyor (Fließband) 🎢 (cause & effect to stand on)

**Use:** place a **Fließband** on the ground. The **arrow on top** shows the direction (it
rotates with how you place it). Stand on it — it **pushes you** along. **Items and robots** on
it are carried too. Cause & effect you can feel: the machine moves things without you walking.

---

## 8. Recycling yard (Recyclinghof) ♻️ (the material cycle)

1. ⛏️ **Dig** a **Schrotthaufen** (scrap heap, left-click) → you get **Schrott** (scrap).
2. 🔁 Hold the **scrap** and **right-click** the **Recycler** → out comes a **new robot part**
   (random legs/body/arms/head).
3. 🤖 Use the parts to assemble a **robot** again — and the cycle closes.

The lesson: **turn old into new** — material is reused instead of thrown away (NMG.4).

---

## 9. Repairing robots 🤖

**Use:** right-click a robot = **repair**. You get sparks, a sound, a counter entry and (after
enough) a new rank. All robots are **peaceful** — no fighting.

**All robots:**

| Robot (DE / EN) | Zone | "Eats" | Note |
|---|---|---|---|
| Rollbot / Roll-bot | Conveyor | Power | rolls fast |
| Greifbot / Grab-bot | Conveyor | Oil | 👪 helpers |
| Sortierbot / Sort-bot | Conveyor | Power | sorts parts |
| Funkenbot / Spark-bot | Energy room | Power | 💡 glows |
| Lampenbot / Lamp-bot | Energy room | Power | 💡 glows bright |
| Schaltbot / Switch-bot | Energy room | Power | 👪 helpers |
| Sammelbot / Collect-bot | Recycling yard | Power | collects scrap |
| Pressbot / Press-bot | Recycling yard | Oil | big & slow |
| Putzbot / Clean-bot | Recycling yard | Power | very nimble |
| **Meisterbot / Master-bot** | Energy room | Gold power | 🌟 very rare, glows |

- 👪 **Families:** repair a "parent" model (Greifbot, Schaltbot) and small helper bots appear,
  which you can repair too.
- 🌟 **Meisterbot:** does **not** appear by itself (very rare). Get it from its **spawn egg**
  (in the starter kit / creative inventory).
- 🌍 **Living workshop:** the other robots **appear automatically** on land near you (gently
  capped). Can be turned off (see Settings).

**Spawn eggs:** every robot has an egg. Egg in hand → **right-click** the ground = place it.
(Note: these are the **mob** spawn eggs — not the **robot kit**.)

---

## 10. Explorer camera 📷

**Use:** hold the camera, get near a robot and **left-click** = photo. The nearest
**not-yet-discovered** robot is marked **discovered** in the catalogue (range about 12 blocks).
Photograph **all** robots; the catalogue shows "Discovered: X/10". Separate from repairing.

---

## 11. Robot catalogue 📋

**Use:** catalogue in hand → **right-click** to open. You see a list of all robots; click one
for the **profile** (name, zone, "eats", job), how **often you repaired** it, and whether it has
been **discovered**. The top shows your **rank**, the **total repaired** and the **discovered
count**.

---

## 12. Ranks & badges 🏆

Every repair counts. At certain thresholds your rank goes up (sound + pop-up); from "Techniker"
on you also get a **badge item** (right-click it for your tally).

| From … repaired | Rank | Badge |
|---|---|---|
| 0 | Schrauber-Lehrling (apprentice) | – |
| 5 | Bastler (tinkerer) | – |
| 10 | Techniker (technician) | 🥉 yes |
| 25 | Ingenieur (engineer) | 🥈 yes |
| 50 | Robotermeister (robot master) | 🥇 yes |

Top-left a **HUD** always shows: world · rank · repaired.

---

## 13. Blocks, items & internal names

Everything is generated without external pictures. Internal names (for the creative search or
`/giveme`) begin with `lernwelt_schrauber:`.

**Logic kit:** `schalter_aus` (switch) · `taster_aus` (button) · `leitung` (wire) ·
`lampe_aus` (lamp) · `tuer_zu` (door). (The "on/open" variants appear automatically when
powered and are not in the creative menu.)

**Workshop blocks:** `werkbank` (workbench, per-face) · `stahlplatte` · `riffelblech` ·
`schraubenkiste` · `zahnrad_block` · `warnband` · `bodenfliese` · `glaswand` (transparent) ·
`energie_block` (glowing) · `roboblech_blau/rot/gelb` · `buchstabe_a` … `buchstabe_z` (letter
blocks A–Z) · `tafel_fliessband/energieraum/recyclinghof` (learning boards).

**Robot building:** `roboter_bausatz` (frame) · `teil_beine`, `teil_koerper`, `teil_arme`,
`teil_kopf` (parts, in this order).

**Recycling:** `schrotthaufen` (dig for scrap) · `schrott` · `recycler` (scrap → part) ·
`fliessband` (conveyor).

**Items:** `logbuch` (robot catalogue) · `kamera` · the mob spawn eggs (e.g. `rollbot`,
`funkenbot`, `meisterbot`) · badges (`badge_10/25/50`).

> **Own patterns or pictures on blocks?** Yes! A block can use `texture = "..."` instead of
> `color = "#..."` (a pattern without a file, a PNG, or per face `top/side/bottom`). See
> `textures/README.txt`.

---

## 14. Commands

| Command | Effect | Who |
|---|---|---|
| `/lernfortschritt` | Your report: rank, repaired, tasks solved, robots met, learning areas | everyone |
| `/lernplan` | Overview of all zones + Lehrplan-21 links (for parents/teachers) | everyone |
| `/lernwelt` | Status + recommended `minetest.conf` lines | everyone |
| `/schrauber_werkstatt` | Builds a whole workshop (room, boards, logic, conveyor, recycler, robot) | admin¹ |
| `/schrauber_logik` | Ready-made switch → wire → lamp → door circuit | admin¹ |
| `/schrauber_teststation` | Small ready-made station | admin¹ |
| `/schrauber_roboter` | Drops a robot frame to assemble | admin¹ |

¹ Needs the `server` privilege — **automatically available in single-player**.

---

## 15. Settings

In the menu under **Settings → All settings → Mods** (or in `minetest.conf`):

| Setting | Default | Effect |
|---|---|---|
| `lernwelt_show_hud` | on | Progress display top-left |
| `lernwelt_spawn_creatures` | on | Broken robots appear automatically on land |
| `lernwelt_big_text` | off | **Larger text** on the learning boards |
| `lernwelt_easy_mode` | off | **Easy mode**: quizzes show only 2 answers |
| `lernwelt_schrauber_starter_kit` | on | Starter kit on first join |

---

## 16. For parents & teachers 👪

- **Lehrplan 21 (Media & Informatics):** every zone and task is tagged with competence areas —
  **computer-science basics** (cause & effect, simple if-then logic, algorithm = steps in
  order), **technology/TTG** (recognising and assembling parts) and **science/NMG** (the
  material cycle / recycling).
- Wiring **switch → lamp → door** is the child-friendly on-ramp to **Mesecons** (Luanti's
  redstone): the same idea, without overwhelm. With Mesecons installed, the blocks even
  interoperate with real wires.
- **Assembling in a fixed order** makes the idea of an **algorithm** tangible.
- `/lernplan` shows all zones and their links at a glance; `/lernfortschritt` shows per child:
  rank, repaired, tasks solved, robots met and learning areas covered.
- **Accessibility:** `lernwelt_big_text` (large text) and `lernwelt_easy_mode` (fewer quiz
  options) make it easier to start.

---

## 17. Little missions & ideas

- 💡 **Light it up:** build switch → wire → lamp and turn the lamp on.
- 🚪 **Door opener:** control a door with a switch — walk through when it's open.
- 🔘 **Pulse:** add a **button** that turns the lamp on only briefly.
- 🤖 **First robot:** finish a robot in the right order.
- ⛓️ **Order pro:** build three robots without mixing up the order.
- ♻️ **The cycle:** dig scrap → recycle → build a robot from it.
- 🎢 **Conveyor ride:** send a robot down a long conveyor.
- 🟢 **First steps:** repair 5 robots → rank "Bastler".
- 📷 **Researcher:** photograph all robots (Discovered 10/10).
- 🌟 **Legend:** repair the rare Meisterbot.
- 🔤 **Workshop sign:** label your workshop with the letter blocks.

---

## 18. Troubleshooting

- **Robots don't appear automatically:** `lernwelt_spawn_creatures` must be on and a mob API is
  required (VoxeLibre/Mineclonia or `mobs_redo`). You can always place robots with **spawn eggs**.
- **Switch does nothing:** the lamp/door must be **connected** to the switch via **wires**
  (blocks touching). Try `/schrauber_logik` for a working example.
- **The frame won't take my part:** the **order** must be right (legs → body → arms → head). The
  frame tells you which part comes next.
- **Recycler does nothing:** you must hold **scrap** in your hand (from a scrap heap).
- **No sound:** sound files are optional. Put your own `.ogg` files in the `sounds/` folder (see
  `sounds/README.txt`) — without them everything works, just silently.

Have fun wiring, assembling and recycling! 🤖🔧

---

*Deutsche Fassung / German version: [ANLEITUNG.md](ANLEITUNG.md) · einseitige
Kinder-Kurzfassung: [KINDER-KURZ.md](KINDER-KURZ.md)*
