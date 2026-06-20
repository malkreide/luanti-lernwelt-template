# Player Guide — Baumhaus-Forscher (Treehouse Explorer) 🌳🔭

A **Luanti** (formerly Minetest) learning world set in a **jungle treehouse**. Children
explore the **storeys of the forest** — the **canopy** up high, the **river** and the
**old ruins** down below — and practise **spatial orientation**: up/down, north/east,
following a plan and **picture hints**. It loosely follows the Swiss curriculum
**Lehrplan 21** (NMG.3, spatial orientation), for roughly ages 5–9 playing with an adult.

> 🇩🇪 The complete German guide is **[ANLEITUNG.md](ANLEITUNG.md)**; a one-page,
> print-friendly kids' version is **[KINDER-KURZ.md](KINDER-KURZ.md)**.

> Motto: **Explore · Orient · Discover**
>
> There is no "winning" — the goal is to **find your way in space**: climb the **storeys
> of the forest** (up/down), **discover animals**, and follow a **treasure hunt with
> picture hints**.

The whole game mechanic (peaceful config, learning boards, logbook, ranks, badges, rescue
sounds, curriculum tagging) comes from the **`lernwelt`** engine mod. This theme is
essentially a single declarative `register_world{...}` call plus self-contained extras:
the **parrot mount**, the **picture-hint item frames**, the **treasure hunt (Schnitzeljagd)**,
the **explorer compass** and the climbable **vines/rope ladders**.

---

## 1. Quick start

1. Create a world with **VoxeLibre** or **Mineclonia** (for the animals) and enable the
   mods **`lernwelt`** + **`lernwelt_baumhaus`**. See **[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)**
   (German).
2. Enter the world → you automatically receive a **starter kit**.
3. Type `/baumhaus_bauen` → a big **treehouse** with a platform, rope ladder, learning
   boards and picture hints appears. **Climb up!**
4. Type `/baumhaus_schnitzeljagd` → a **treasure hunt** is laid out. Follow the
   **picture hints** to the treasure.

---

## 2. Controls

| Action | How |
|---|---|
| Use / rescue an animal / open a board / **cycle a frame's picture** | **Right-click** |
| **Open the picture chooser** of a frame | **Sneak + right-click** |
| Photograph / use the compass / mine | **Left-click** |
| Build / place an item | **Right-click** on ground/wall |
| **Climb** | stand at a **vine / rope ladder** and press **forward** |

Damage is **off**, the world is a bright, peaceful jungle day, no monsters.

---

## 3. The world: 3 zones = 3 storeys

| Zone | Where | Animals | Learning idea |
|---|---|---|---|
| 🌿 **Blätterdach** (canopy) | **up** | Parrot, Monkey, Sloth, Toucan, Jungle Butterfly | "up", naming animals, ordering leaves |
| 💧 **Fluss** (river) | **down** | Tree Frog, Fish, Turtle, Heron, Dragonfly | who swims, where water flows |
| 🏛️ **Alte Ruinen** (old ruins) | **down/hidden** | Gecko, Bat, Rhino Beetle, *Golden Jaguar* | the treasure hunt, reading arrows |

---

## 4. Spatial orientation — the heart 🧭

- **Storeys of the forest (up/down):** the world is built **vertically**. Climb **rope
  ladders** and **vines** up into the **canopy**, and descend to the **river** and
  **ruins**.
- **Treasure hunt with picture hints:** small **item frames** show a **picture** — a leaf,
  a water drop, a stone, a paw print, a treasure, or a **direction arrow**. The child
  "reads" the picture, follows the direction (north/east/up/down) and finds the next frame
  — all the way to the **treasure**.
- **Explorer compass:** left-click tells you which **compass direction** you face, **how
  high** you are (which storey), and the direction to the **nearest hint**.

---

## 5. Learning boards & tasks

Right-click a board to see its **activity**, **curriculum tags** and **tasks**: **quiz**
(up/down, who swims, reading arrows), **pattern** (leaves light → dark) and **rescue
goals**. Solved tasks give a sound + praise and count towards your progress
(`/lernfortschritt`). `lernwelt_easy_mode` reduces quizzes to 2 options.

---

## 6. The treasure hunt 🧭🖼️

`/baumhaus_schnitzeljagd` lays out a chain of **four picture-hint frames** (one up high!)
ending at a **treasure**. Each frame, on **right-click**, shows its picture and an **arrow
+ text** to the next one ("Go EAST …", "… climb UP"). Reach the **chest** and right-click
it for gold and a **title** (Schatzsucher → Karten-Leser → Schatzmeister).

**Build your own:** take the **item frames** from the starter kit, right-click to cycle
the picture, **sneak+right-click** to pick one, and set up your own hint chain — even with
your **own PNG pictures** (see `textures/README.txt`), e.g. photos from the children's real
surroundings.

---

## 7. Climbing, animals, camera, logbook, parrot

- **Climb** vines/rope ladders by pressing **forward** against them — up to the canopy,
  down to the ground.
- **Rescue** animals with **right-click** (14 total incl. the rare **Golden Jaguar**;
  families: parrot, monkey, turtle). Use **spawn eggs** to place animals.
- **Camera:** left-click near an animal to photograph it = "discovered" in the logbook.
- **Forscher-Tagebuch (logbook):** right-click to open profiles, rescue counts and the
  discovered status.
- **Reit-Papagei (parrot mount):** place it, right-click to mount, **W/S** move, **A/D**
  steer, **jump = up into the canopy**, **sneak = down**, right-click = dismount. A second
  player can ride along.

---

## 8. Ranks & badges 🏆

| From … rescues | Rank | Badge |
|---|---|---|
| 0 | Baumhaus-Knirps | – |
| 5 | Ast-Kletterer | – |
| 10 | Blätterdach-Forscher | 🥉 yes |
| 25 | Ruinen-Entdecker | 🥈 yes |
| 50 | Dschungel-Meister | 🥇 yes |

---

## 9. Commands

| Command | Effect | Who |
|---|---|---|
| `/baumhaus_bauen` | builds the big **treehouse** base | Admin¹ |
| `/baumhaus_schnitzeljagd` | lays out a **picture-hint treasure hunt** → treasure | Admin¹ |
| `/baumhaus_teststation` | a small ready-made test spot | Admin¹ |
| `/lernfortschritt` | your personal progress report | all |
| `/lernplan` | overview of all zones + curriculum tags | all |
| `/lernwelt` | status + recommended `minetest.conf` lines | all |

¹ Needs the `server` privilege — automatically present in single-player.

---

## 10. Settings

`lernwelt_show_hud`, `lernwelt_spawn_creatures`, `lernwelt_big_text`, `lernwelt_easy_mode`
(engine) and `lernwelt_baumhaus_starter_kit` (this theme). For the youngest, enable
`lernwelt_big_text` **and** `lernwelt_easy_mode`.

---

## 11. Legal note

This is an **independent work**, **not** affiliated with any TV series, brand or company,
using **no** protected names, characters, logos or designs. The general idea "jungle
treehouse" and common animal/plant names are not protectable.

Have fun exploring, orienting and discovering in the jungle treehouse! 🌳🔭

---

*Deutsche Version: [ANLEITUNG.md](ANLEITUNG.md) · Kinder-Kurzfassung:
[KINDER-KURZ.md](KINDER-KURZ.md)*
