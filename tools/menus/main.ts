// ============================================================================
// EzGUI 3.0 — the pack's own menus (real, not samples):
//   main      the hub that ships, opened by /trigger ezgui.open
//   shop      an economy menu: score costs, item costs, a condition and a cooldown
//   settings  one page per stateful widget kind (toggle, counter, cycle, radio)
//   editor    the in-game chest editor
// ============================================================================
import { buildPack, mkText, type MenuSpec, type PackSpec } from "../src/core/build.ts";

const coin = (n: number) => mkText(`Price: ${n} coins`, { color: "gray" });

const MAIN: MenuSpec = {
  id: "main",
  display: "EzGUI",
  container: { entity: "minecraft:chest_minecart", y: 1 },
  timer: 20 * 60 * 60,
  start_page: 0,
  on_open: "ezgui:hooks/on_open_main",
  pages: [
    {
      index: 0,
      name: "Hub",
      widgets: [
        { slot: 10, item: "minecraft:emerald", name: mkText("Shop", { color: "green", bold: true }), lore: [mkText("Spend your coins", { color: "gray" })], ops: [{ open: "shop" }] },
        { slot: 12, item: "minecraft:comparator", name: mkText("Settings", { color: "gold", bold: true }), lore: [mkText("Your preferences", { color: "gray" })], ops: [{ open: "settings" }] },
        { slot: 14, item: "minecraft:writable_book", name: mkText("Editor", { color: "aqua", bold: true }), lore: [mkText("Build this menu in a chest", { color: "gray" })], ops: [{ open: "editor" }] },
        {
          slot: 16,
          item: "minecraft:player_head",
          name: mkText("Balance", { color: "light_purple" }),
          lore: [mkText("You have ", { color: "gray" }), mkText("coins", { color: "gold" })],
          ops: [{ url: "https://github.com/MesterMan03/EzGUI", label: "Open the EzGUI repository" }],
        },
        { slot: 22, kind: "close", item: "minecraft:barrier", name: mkText("Close", { color: "red" }), ops: [{ close: true }] },
      ],
    },
  ],
};

const SHOP: MenuSpec = {
  id: "shop",
  display: "EzGUI Shop",
  container: { entity: "minecraft:chest_minecart", y: 1 },
  timer: 20 * 60 * 60,
  pages: [
    {
      index: 0,
      name: "Buy",
      widgets: [
        {
          slot: 10,
          item: "minecraft:bread",
          name: mkText("Bread × 4", { color: "gold" }),
          lore: [coin(3), mkText("Left click to buy", { color: "dark_gray" })],
          cost: [{ score: "ezgui.coins", n: 3, fail: mkText("You need 3 coins.", { color: "red" }) }],
          ops: [{ give: "minecraft:bread", n: 4 }, { sound: "minecraft:entity.villager.yes" }],
        },
        {
          slot: 12,
          item: "minecraft:diamond_pickaxe",
          name: mkText("Diamond pickaxe", { color: "aqua" }),
          lore: [coin(25), mkText("Needs an empty main hand", { color: "dark_gray" })],
          cond: "ezgui:hooks/cond_hand_empty",
          fail: mkText("Empty your main hand first.", { color: "red" }),
          cost: [{ score: "ezgui.coins", n: 25 }],
          cool: 40,
          ops: [{ give: "minecraft:diamond_pickaxe", n: 1 }, { sound: "minecraft:block.anvil.use" }],
        },
        {
          slot: 14,
          item: "minecraft:cake",
          name: mkText("Cake", { color: "light_purple" }),
          lore: [coin(2), mkText("Trades 2 wheat instead of coins", { color: "dark_gray" })],
          cost: [{ item: "minecraft:wheat", n: 2, fail: mkText("You need 2 wheat.", { color: "red" }) }],
          ops: [{ give: "minecraft:cake", n: 1 }],
        },
        { slot: 16, kind: "progress", item: "minecraft:experience_bottle", cells: 4, name: mkText("Coin vault", { color: "light_purple" }), lore: [mkText("Fills at 100 coins", { color: "gray" })], score: "ezgui.coins", max: 100, click: false },
        { slot: 22, item: "minecraft:arrow", name: mkText("Back", { color: "white" }), ops: [{ open: "main" }] },
      ],
    },
  ],
};

const SETTINGS: MenuSpec = {
  id: "settings",
  display: "EzGUI Settings",
  container: { entity: "minecraft:chest_minecart", y: 1 },
  timer: 20 * 60 * 60,
  init: ["ezgui.snd", "ezgui.pins", "ezgui.theme", "ezgui.reach"],
  pages: [
    {
      index: 0,
      name: "Settings",
      widgets: [
        { slot: 10, kind: "toggle", item: "minecraft:bell", name: mkText("Sounds: OFF", { color: "gray" }), on: { item: "minecraft:bell", name: mkText("Sounds: ON", { color: "green" }), glint: true }, score: "ezgui.snd", ops: [{ toggle: "ezgui.snd" }] },
        { slot: 12, kind: "counter", item: "minecraft:paper", name: mkText("Pins", { color: "yellow" }), lore: [mkText("Click: +1 (max 5)", { color: "gray" })], score: "ezgui.pins", ops: [{ add: 1, score: "ezgui.pins", min: 0, max: 5 }] },
        {
          slot: 14,
          kind: "cycle",
          item: "minecraft:redstone",
          name: mkText("Theme: Red", { color: "red" }),
          score: "ezgui.theme",
          options: [mkText("Theme: Red", { color: "red" }), mkText("Theme: Blue", { color: "blue" }), mkText("Theme: Green", { color: "green" })].map((n) => ({ item: "minecraft:redstone", name: n })),
          ops: [{ add: 1, score: "ezgui.theme", min: 0, max: 2 }],
        },
        { slot: 16, kind: "radio", item: "minecraft:stone_bricks", name: mkText("Reach: short", { color: "white" }), score: "ezgui.reach", value: 0, on: { item: "minecraft:stone_bricks", glint: true, name: mkText("Reach: short", { color: "green" }), lore: [mkText("Selected", { color: "green" })] }, ops: [{ set: 0, score: "ezgui.reach" }] },
        { slot: 17, kind: "radio", item: "minecraft:stone_bricks", name: mkText("Reach: long", { color: "gray" }), score: "ezgui.reach", value: 1, on: { item: "minecraft:stone_bricks", glint: true, name: mkText("Reach: long", { color: "green" }), lore: [mkText("Selected", { color: "green" })] }, ops: [{ set: 1, score: "ezgui.reach" }] },
        { slot: 22, item: "minecraft:arrow", name: mkText("Back", { color: "white" }), ops: [{ open: "main" }] },
      ],
    },
  ],
};

const EDITOR: MenuSpec = {
  id: "editor",
  display: "EzGUI Editor",
  container: { entity: "minecraft:chest_minecart", y: 1 },
  timer: 20 * 60 * 60,
  pages: [
    {
      index: 0,
      name: "Editor",
      editable: true,
      widgets: [
        { slot: 25, item: "minecraft:lime_dye", name: mkText("Save layout", { color: "green" }), lore: [mkText("Store the chest contents as this page", { color: "gray" })], ops: [{ fn: "ezgui:editor/save" }] },
        { slot: 24, item: "minecraft:red_dye", name: mkText("Reset page", { color: "red" }), lore: [mkText("Repaint from the definition", { color: "gray" })], ops: [{ draw: true }] },
        { slot: 22, item: "minecraft:arrow", name: mkText("Back", { color: "white" }), ops: [{ open: "main" }] },
      ],
    },
  ],
};

const functions: Record<string, string> = {
  "hooks/on_open_main": [
    "# AS player — seed the shop currency the first time a player opens the hub.",
    "execute unless score @s ezgui.coins matches -2147483648..2147483647 run scoreboard players set @s ezgui.coins 100",
    "scoreboard objectives add ezgui.coins dummy",
    "",
  ].join("\n"),
  "hooks/cond_hand_empty": [
    "# AS player — passes (returns 1) when the main hand is empty.",
    "execute unless items entity @s weapon.mainhand * run return 1",
    "return 0",
    "",
  ].join("\n"),
};

export const spec: PackSpec = {
  namespace: "ezgui",
  description: "EzGUI 3.0 — data driven GUI engine for Minecraft 1.21.1",
  default_menu: "main",
  menus: [MAIN, SHOP, SETTINGS, EDITOR],
  functions,
};

export const { out, pack, ids } = buildPack(spec);
