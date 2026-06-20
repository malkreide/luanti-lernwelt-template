# Player Guide — Glühpilz-Wald (Glow-Mushroom Forest) 🍄✨

A cosy, very low-threshold **Luanti** (formerly Minetest) learning world set in a
gentle mushroom realm — designed as an **ideal first world** for young children
(approx. 4–7) playing together with a parent. It loosely follows the Swiss curriculum
**Lehrplan 21, cycle 1** (mathematics, science/NMG).

> 🇩🇪 The complete German guide is **[ANLEITUNG.md](ANLEITUNG.md)**; a one-page,
> print-friendly kids' version is **[KINDER-KURZ.md](KINDER-KURZ.md)**.

> Motto: **Marvel · Sort · Snuggle**
>
> There is no "winning" — just explore, help and learn: rescue forest animals,
> photograph them, solve small tasks, keep the forest tidy and plant your own
> mushrooms, while playfully **sorting by colour**, **comparing big and small**, and
> experiencing the **day–night change** through glowing mushrooms.

The whole game mechanic (peaceful config, learning boards, logbook, ranks, badges,
rescue sounds, curriculum tagging) comes from the **`lernwelt`** engine mod. This theme
is essentially a single declarative `register_world{...}` call plus two self-contained
extras: the **glow-beetle mount** and the **day/night mushrooms**.

---

## 1. Quick start

1. Create a world with **VoxeLibre** or **Mineclonia** (for the animals) and enable the
   mods **`lernwelt`** + **`lernwelt_gluehpilz`**. A flat, calm world is ideal — see
   **[WELT-EINRICHTEN.md](WELT-EINRICHTEN.md)** (German).
2. Enter the world → you automatically receive a **starter kit**.
3. Fastest start: type **`/pilzwald_haus`** — a big **mushroom house** with boards,
   glow mushrooms, day/night mushrooms and a glow-beetle appears in front of you.

---

## 2. Basic controls

| Action | How |
|---|---|
| **Use / rescue animal / open board / switch a mushroom** | **Right-click** |
| **Photograph / dig litter / dig blocks** | **Left-click** (hold) |
| **Build / place item** | **Right-click** on the ground |
| **Fly (creative)** | Double-jump; then jump = up, sneak = down |

Damage is **off** in the kids' setup — nothing can hurt you, no monsters. The world
starts **bright (day)**; you change the time yourself with the day/night mushrooms.

---

## 3. The world: 3 learning zones

| Zone | Animals | Learning idea |
|---|---|---|
| 🍄 **Pilzwald** (forest) | Hedgehog, Ladybug, Butterfly, Squirrel, Snail | **sort by colour**, count, name |
| 🌙 **Glüh-Höhle** (glow cave, dark) | Firefly, Glow-beetle, Bat, Crystal-snail, *Dream-moth* | **day/night**, light/dark |
| 💧 **Bach** (brook) | Beaver, Water-mouse, Duckling, Frog | **compare big/small** |

Right-click a learning board to see the activity, curriculum references and the zone's
tasks. Three task types: **quiz** (question + answer buttons), **pattern** (copy a colour
row in order = sorting by colour) and **rescue goal** (e.g. "rescue 2 ladybugs").

---

## 4. Day/night mushrooms 🌗 (the special feature)

This theme's highlight: **right-click** a glowing mushroom to change the **time of day**
for the whole world:

| Mushroom | Effect |
|---|---|
| ☀️ **Tag-Pilz** (day) | It becomes **bright** — the sun shines. |
| 🌅 **Dämmer-Pilz** (dusk) | A warm, **golden evening** mood. |
| 🌙 **Nacht-Pilz** (night) | It becomes **night** — and the glow mushrooms light up the forest! |

Because the world is frozen (no fast, scary cycle), the chosen time **stays** until a
child picks another mushroom — a calm, self-directed experience of day and night
(NMG: daily rhythm, light/dark). At night, soft glowing **spores** also drift around you.

---

## 5. Rescuing animals 🦔

**Right-click** an animal to **rescue** it (hearts, sound, counter, eventually a new
rank). There are **14** animals, including the rare, magical **Traum-Falter** (dream
moth), which only appears from its **spawn egg**. Rescuing a parent (Hedgehog, Squirrel,
Duckling) brings its **babies** along. Other animals appear automatically on solid ground
near you (capped; switch off with `lernwelt_spawn_creatures`).

**Spawn eggs:** every animal has an egg — right-click the ground to place one.

---

## 6. Camera, logbook, ranks 📷📔🏆

- **Camera:** hold it, get close to an animal, **left-click** = photo. Marks the nearest
  not-yet-discovered animal as **discovered** (collecting, separate from rescuing).
- **Wald-Tagebuch (logbook):** right-click to open. Lists all animals; click one for its
  profile (home, food, power), rescue count and discovered status. Shows your rank, total
  rescues and discovered count.
- **Ranks & badges:** Pilz-Knirps (0) → Wald-Schnupperer (5) → Pilz-Freund (10, badge) →
  Glüh-Hüter (25, badge) → Wald-König (50, badge).

---

## 7. Tidy up & plant mushrooms 🧹🍄

- **Tidy the forest:** left-click litter (paper, can, bottle) to collect it. Milestones:
  Wald-Putzer (5), Hain-Heger (15), Wald-Held (30). Get practice litter with
  `/pilzwald_muell`.
- **Plant mushrooms:** place a **Pilz-Setzling** (mushroom seed); after ~20 s it grows
  into a random glowing mushroom and counts towards your mushroom total.

---

## 8. Glow-beetle mount 🪲

Place the beetle item, **right-click** to mount, then **W/S** move, **A/D** steer, **jump**
= up, **sneak** = down, **right-click** = dismount. It glows while ridden, leaves a soft
spore trail and seats a **second player** (parent + child). It is deliberately **slow and
gentle** — cosy.

---

## 9. Commands

| Command | Effect | Who |
|---|---|---|
| `/lernfortschritt` | Your report: rank, rescues, solved tasks, animals met, learning areas | all |
| `/lernplan` | Overview of all zones + curriculum references | all |
| `/lernwelt` | Status + recommended `minetest.conf` lines | all |
| `/pilzwald_haus` | Big **mushroom house** (base) with boards, glow + day/night mushrooms, beetle | admin¹ |
| `/pilzwald_teststation` | Small ready-made station (3 boards, beetle, day/night mushrooms, litter) | admin¹ |
| `/pilzwald_muell` | Scatter litter to clean up | admin¹ |

¹ Needs the `server` privilege — automatically present in single-player.

---

## 10. Settings & tips

| Setting | Default | Effect |
|---|---|---|
| `lernwelt_show_hud` | on | Progress display top-left |
| `lernwelt_spawn_creatures` | on | Animals appear automatically on solid ground |
| `lernwelt_big_text` | off | **Larger font** on the learning boards |
| `lernwelt_easy_mode` | off | **Easy mode**: quizzes show only 2 answers |
| `lernwelt_gluehpilz_starter_kit` | on | Starter kit on first join |

> Tip for the youngest: turn **both** `lernwelt_big_text` and `lernwelt_easy_mode` on.

Have fun marvelling, sorting and snuggling in the glow-mushroom forest! 🍄✨

---

*Deutsche Vollanleitung: [ANLEITUNG.md](ANLEITUNG.md) · one-page kids' version:
[KINDER-KURZ.md](KINDER-KURZ.md)*
