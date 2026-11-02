// ============================================================================
// guigen — the EzGUI 3.0 datapack generator. Pure functions, zero DOM.
//
// Model (1.21.1, data driven):
//   • A menu is a JSON/TS definition that is compiled into a *runtime definition*
//     (storage ezgui:defs) plus a handful of generated artifact files (item
//     modifiers, predicates, hook functions).
//   • The runtime itself is a fixed, shared machine (data/ezgui/function/**), so a
//     menu never adds commands to a tick loop. Widgets are walked by ONE macro
//     loop; every per-slot value comes from the definition.
//   • Containers: entity ones (carts / boats) are summoned per player and bound via
//     ezgui.p<pid>; block ones (chest / barrel / hopper …) are a shared kiosk.
//   • Clicks: a widget is clicked when its slot no longer holds the widget item
//     (pick up, shift-move, throw, or an env action we did not cause). Extra modes
//     from 2.x — drop, return, any-click, F-click — are expressed as ops/tests.
// ============================================================================

export type OutMap = Map<string, string>;

// ------------------------------------------------------------------ text

/** One run of a rich text: plain text, a live score, or a selector. */
export interface TextPart {
  text?: string;
  score?: { name: string; objective: string };
  selector?: string;
  color?: string | null;
  bold?: boolean | null;
  italic?: boolean | null;
  underlined?: boolean | null;
}

/** Text as stored in a menu definition: `{"text","extra":[...]}`. */
export interface Text {
  text: string;
  color?: string | null;
  bold?: boolean | null;
  italic?: boolean | null;
  underlined?: boolean | null;
  extra?: TextPart[];
}

export interface StaticTextContext {
  page?: number;
  pages?: number;
  page_index?: number;
  page_name?: string;
  menu?: string;
}

// ------------------------------------------------------------------ widgets

export interface ItemState {
  /** item id, e.g. "minecraft:stone" */
  id: string;
  /** verbatim item stack (chest-editor captures keep name/lore/data untouched) */
  raw?: Record<string, unknown>;
  /** component suffix without the brackets, e.g. `minecraft:custom_name='…'` */
  comp: string;
  /** item modifier ids applied after placing (live text, live count) */
  live?: string[];
  /** item modifier id that sets the stack size from a score */
  count?: string;
  /** indicator range, e.g. "1..5", "..0", "6.." */
  matches?: string;
  /** kind markers — exactly one is set on a stateful widget, so the runtime can tell a
   *  toggle from a cycle/radio/indicator/progress that also happens to use a score */
  toggle?: string;
  cycle?: boolean;
  radio?: boolean;
  indicator?: boolean;
  progress?: boolean;
}

export interface Op {
  cmd?: string;
  fn?: string;
  page?: number;
  open?: string;
  close?: boolean;
  toggle?: string;
  add?: number;
  set?: number;
  score?: string;
  min?: number;
  max?: number;
  wrap?: boolean;
  give?: string;
  n?: number;
  sound?: string;
  msg?: string;
  url?: string;
  label?: string;
  draw?: boolean;
}

export interface Cost {
  item?: string;
  score?: string;
  n: number;
  fail?: string;
}

export interface Widget {
  slot: number;
  kind: string;
  id: string;
  /** how many slots the widget occupies (progress bars, groups) */
  cells?: number;
  locked?: boolean;
  click?: boolean;
  /** condition function — returns 1 to allow the click */
  cond?: string;
  fail?: string;
  cost?: Cost[];
  cool?: number;
  coolscore?: string;
  /** states: index 0 usually the "off"/default look */
  e: ItemState[];
  /** toggle / cycle / radio / progress / indicator / tab driver */
  score?: string;
  value?: number;
  max?: number;
  act: Op[];
  sound?: string;
}

export interface Page {
  index: number;
  name: string;
  /** the in-game editor may write this page back from the chest contents */
  editable?: boolean;
  widgets: Widget[];
  on_enter?: string;
  on_leave?: string;
  /** literal "block x y z" for kiosk menus, empty for player containers */
  target?: string;
}

export interface Container {
  /** entity container id (minecraft:chest_minecart …) */
  entity?: string;
  /** block kiosk description */
  kiosk?: { block: string; state: string; pos: [number, number, number] };
  /** height offset for entity containers */
  y: number;
}

export interface Menu {
  id: string;
  /** stable integer id used in storage (menus.<nid>) and in scores */
  nid: number;
  display: string;
  namespace: string;
  container?: Container;
  timer?: number;
  start_page?: number;
  on_open?: string;
  on_close?: string;
  /** scoreboard objectives the menu renders/uses */
  scores: string[];
  /** every score that must be seeded with 0 on open */
  init: string[];
  pages: Page[];
  /** menu-level floor item so empty slots can never be used */
  floor: string;
}

export interface Pack {
  namespace: string;
  description: string;
  menus: Menu[];
  /** generated item modifiers: id → json */
  itemModifiers: Record<string, unknown>;
  /** generated predicates: id → json */
  predicates: Record<string, unknown>;
  /** generated hook functions: path → body */
  functions: Record<string, string>;
}

// ------------------------------------------------------------------ ids

export const PID = "ezgui.pid";
export const OBJ = {
  mid: "ezgui.mid",
  page: "ezgui.page",
  timer: "ezgui.timer",
  click: "ezgui.click",
  session: "ezgui.session",
  tmp: "ezgui.tmp",
  amount: "ezgui.amount",
} as const;

/** Minecraft keeps storage keys short and lowercase-free of surprises. */
export function safeId(s: string): string {
  return String(s)
    .toLowerCase()
    .replace(/[^a-z0-9._-]+/g, "_")
    .replace(/^_+|_+$/g, "")
    .slice(0, 40) || "x";
}

export function nsId(ns: string, path: string): string {
  return `${ns}:${path}`;
}

export function itemId(item: string): string {
  if (/^[a-z0-9_.-]+:[a-z0-9_./-]+$/.test(item)) return item;
  return `minecraft:${item}`;
}

export function escapeSnbtString(s: unknown): string {
  return String(s).replace(/\\/g, "\\\\").replace(/"/g, '\\"');
}

// ------------------------------------------------------------------ snbt

/** NBT value → SNBT literal (strings are always quoted). */
export function valueToSnbt(v: unknown): string {
  if (typeof v === "boolean") return v ? "1b" : "0b";
  if (typeof v === "number") return Number.isInteger(v) ? String(v) : `${v}d`;
  if (typeof v === "string") return `"${escapeSnbtString(v)}"`;
  if (Array.isArray(v)) return `[${v.map(valueToSnbt).join(",")}]`;
  if (v && typeof v === "object") return dictToSnbt(v as Record<string, unknown>);
  throw new TypeError(`Unsupported SNBT value: ${typeof v}`);
}

export function dictToSnbt(d: Record<string, unknown>): string {
  return `{${Object.entries(d)
    .map(([k, v]) => `${k}:${valueToSnbt(v)}`)
    .join(",")}}`;
}

// ------------------------------------------------------------------ text

export function mkText(text: string, opts: Partial<Text> = {}): Text {
  return { text, ...opts } as Text;
}

/** Text component for `custom_name` / `lore` components: JSON as a quoted string. */
export function textComponent(t: Text): string {
  const obj: Record<string, unknown> = { text: t.text ?? "", italic: t.italic ?? false };
  if (t.color != null) obj.color = t.color;
  if (t.bold != null) obj.bold = t.bold;
  if (t.underlined != null) obj.underlined = t.underlined;
  if (t.extra && t.extra.length) {
    obj.extra = t.extra.map((p) => {
      const r: Record<string, unknown> = {};
      if (p.score) r.score = p.score;
      else if (p.selector) r.selector = p.selector;
      else r.text = p.text ?? "";
      if (p.color != null) r.color = p.color;
      if (p.bold != null) r.bold = p.bold;
      if (p.italic != null) r.italic = p.italic;
      if (p.underlined != null) r.underlined = p.underlined;
      return r;
    });
  }
  return JSON.stringify(obj);
}

/** Snapshot text: what a *definition* stores (no live runs). */
export function staticText(t: Text): string {
  const parts: string[] = [`"${escapeSnbtString(t.text ?? "")}"`];
  if (t.color != null) parts.push(`"${t.color}"`);
  if (t.bold) parts.push("bold");
  if (t.underlined) parts.push("underlined");
  return `{t:[${parts.join(",")}]}`;
}

/** Item components suffix: `[minecraft:custom_name='…',minecraft:lore=['…']]`. */
export function componentsSnbt(opts: {
  name?: Text | null;
  lore?: Text[];
  cmd?: number | null;
  glint?: boolean;
  max_stack?: number;
}): string {
  const parts: string[] = [];
  if (opts.name) parts.push(`minecraft:custom_name='${textComponent(opts.name).replace(/'/g, "\\'")}'`);
  if (opts.lore && opts.lore.length) {
    const lore = opts.lore.map((l) => `'${textComponent(l).replace(/'/g, "\\'")}'`).join(",");
    parts.push(`minecraft:lore=[${lore}]`);
  }
  if (opts.glint) parts.push("minecraft:enchantment_glint_override=true");
  if (opts.cmd != null) parts.push(`minecraft:custom_model_data=${Math.trunc(opts.cmd)}`);
  if (opts.max_stack != null && opts.max_stack !== 1) parts.push(`minecraft:max_stack_size=${Math.trunc(opts.max_stack)}`);
  return parts.length ? `[${parts.join(",")}]` : "";
}

// ------------------------------------------------------------------ pages

export interface PageBuildCtx {
  menu: Menu;
  page: Page;
  pageNumber: number;
  pack: Pack;
}

/** Deterministic 8-hex hash, used to name generated artifacts. */
export function hash8(s: string): string {
  let h = 0x811c9dc5;
  for (let i = 0; i < s.length; i++) {
    h ^= s.charCodeAt(i);
    h = Math.imul(h, 0x01000193);
  }
  return (h >>> 0).toString(16).padStart(8, "0");
}

/** Item modifier that resolves live text for one slot, or null when fully static. */
export function liveTextModifier(name: Text | null, lore: Text[]): Record<string, unknown> | null {
  const fns: Record<string, unknown>[] = [];
  const dyn = (t: Text) => !!t.extra?.some((p) => p.score || p.selector);
  if (name && dyn(name)) fns.push({ type: "minecraft:set_name", entity: "this", target: "custom_name", name: toJsonComponent(name) });
  if (lore.some(dyn)) fns.push({ type: "minecraft:set_lore", entity: "this", mode: "replace_all", lore: lore.map(toJsonComponent) });
  if (!fns.length) return null;
  return fns.length === 1 ? fns[0]! : { type: "minecraft:sequence", functions: fns };
}

export function toJsonComponent(t: Text): Record<string, unknown> {
  return JSON.parse(textComponent(t)) as Record<string, unknown>;
}

/** Item modifier that sets a stack's count from a player score. */
export function countModifier(score: string): Record<string, unknown> {
  return { type: "minecraft:set_count", count: { type: "minecraft:score", target: "this", score }, add: false };
}

// ------------------------------------------------------------------ emit

export const CORE_FILES = [
  "core/load",
  "core/tick",
  "core/ctx",
  "core/t",
  "core/ensure_pid",
  "core/sweep",
  "core/summon_args",
  "core/strip",
  "core/hook",
  "menu/open",
  "menu/open_missing",
  "menu/open_mid",
  "menu/page_load",
  "menu/on_enter",
  "menu/on_leave",
  "menu/on_open",
  "menu/on_close",
  "menu/close",
  "menu/draw",
  "menu/draw_loop",
  "menu/draw_cell_loop",
  "menu/place",
  "menu/state_pick",
  "menu/live",
  "menu/live_loop",
  "menu/target",
  "menu/summon",
  "menu/kiosk",
  "menu/kiosk_teardown",
  "menu/save_containers",
  "menu/restore_containers",
  "menu/dismantle",
  "menu/init",
  "menu/act",
  "menu/act_loop",
  "menu/op_cmd",
  "menu/op_fn",
  "menu/op_page",
  "menu/op_open",
  "menu/op_close",
  "menu/op_toggle",
  "menu/op_add",
  "menu/op_set",
  "menu/op_give",
  "menu/op_sound",
  "menu/op_msg",
  "menu/op_link",
  "menu/cond",
  "menu/cost",
  "menu/cost_loop",
  "menu/cost_one",
  "menu/cost_item",
  "menu/cost_score",
  "menu/cost_fail",
  "menu/fail",
  "menu/cool",
  "menu/click",
  "menu/load_w",
  "menu/detect_loop",
  "menu/detect_one",
  "menu/player_tick",
  "menu/follow",
  "menu/reach",
  "menu/sweep",
  "menu/drop",
  "api/open_trigger",
  "api/close_trigger",
  "api/last_trigger",
  "api/save_trigger",
];

/**
 * SNBT single-quoted string: safe for item ids, commands and JSON components.
 * Only a backslash or a single quote needs escaping inside it — a double quote is
 * literal, so JSON components stay readable and the parser never sees a bogus escape.
 */
export function sq(s: unknown): string {
  // Components are carried verbatim: they were already SNBT-quoted by
  // componentsSnbt(), so the outer quotes here are the only ones that may be escaped.
  const body = String(s).split("'").join("\\'");
  return "'" + body + "'";
}

/** Definition NBT for the whole pack: {1:{…},2:{…}} keyed by menu number. */
export function menusSnbt(pack: Pack): string {
  return `{${pack.menus.map((m) => `${m.nid}:${menuSnbt(m)}`).join(",")}}`;
}

export function menuSnbt(m: Menu): string {
  const parts: string[] = [];
  if (m.container) {
    // the offset is rendered into a coordinate macro ("~ ~1 ~"), so it must be a
    // plain string: "1d" would make the summon command invalid
    if (m.container.entity) parts.push(`container:"${itemId(m.container.entity)}"`, `y:"${m.container.y}"`);
    if (m.container.kiosk) {
      const k = m.container.kiosk;
      parts.push(
        `target:"block ${k.pos[0]} ${k.pos[1]} ${k.pos[2]}"`,
        `kiosk:1b`,
        `block:"${itemId(k.block)}"`,
        `kiosk_state:"${k.state}"`,
        `bx:${k.pos[0]}`, `by:${k.pos[1]}`, `bz:${k.pos[2]}`
      );
    }
  }
  if (m.timer != null) parts.push(`timer:${m.timer}`);
  if (m.start_page != null) parts.push(`start_page:${m.start_page}`);
  if (m.on_open) parts.push(`on_open:"${m.on_open}"`);
  if (m.on_close) parts.push(`on_close:"${m.on_close}"`);
  parts.push(`floor:"${itemId(m.floor)}"`);
  if (m.init.length) parts.push(`init:[${m.init.map((x) => `"${x}"`).join(",")}]`);
  parts.push(`pages:[${m.pages.map(pageSnbt).join(",")}]`);
  return `{${parts.join(",")}}`;
}

export function pageSnbt(p: Page): string {
  const parts: string[] = [];
  if (p.target) parts.push(`target:"${p.target}"`);
  if (p.editable) parts.push("editable:1b");
  if (p.on_enter) parts.push(`on_enter:"${p.on_enter}"`);
  if (p.on_leave) parts.push(`on_leave:"${p.on_leave}"`);
  parts.push(`widgets:[${p.widgets.map(widgetSnbt).join(",")}]`);
  return `{${parts.join(",")}}`;
}

export function widgetSnbt(w: Widget): string {
  const parts: string[] = [`slot:${w.slot}`, `id:"${safeId(w.id)}"`];
  if (w.cells && w.cells > 1) parts.push(`cells:${w.cells}`);
  if (w.locked) parts.push("locked:1b");
  else if (w.click !== false) parts.push("click:1b");
  if (w.cond) parts.push(`cond:"${w.cond}"`);
  if (w.fail) parts.push(`fail:${sq(w.fail)}`);
  if (w.cost && w.cost.length) {
    const costs = w.cost
      .map((c) => {
        const cp: string[] = [];
        if (c.item) cp.push(`item:"${itemId(c.item)}"`);
        if (c.score) cp.push(`score:"${c.score}"`);
        cp.push(`n:${c.n}`);
        if (c.fail) cp.push(`fail:${sq(c.fail)}`);
        return `{${cp.join(",")}}`;
      })
      .join(",");
    parts.push(`cost:[${costs}]`);
  }
  if (w.cool && w.cool > 0) parts.push(`cool:${w.cool}`, `coolscore:"${w.coolscore}"`);
  if (w.score) parts.push(`score:"${w.score}"`);
  if (w.value != null) parts.push(`value:${w.value}`);
  if (w.max != null) parts.push(`max:${w.max}`);
  const states = w.e.map(stateSnbt).join(",");
  parts.push(`e:[${states}]`);
  parts.push(`act:[${w.act.map(opSnbt).join(",")}]`);
  if (w.sound) parts.push(`sound:"${w.sound}"`);
  return `{${parts.join(",")}}`;
}

export function stateSnbt(s: ItemState): string {
  const parts: string[] = [`id:"${itemId(s.id)}"`];
  // kind markers: exactly one of these is present on a stateful widget
  if (s.toggle) parts.push(`toggle:"${s.toggle}"`);
  if (s.cycle) parts.push("cycle:1b");
  if (s.radio) parts.push("radio:1b");
  if (s.indicator) parts.push("indicator:1b");
  if (s.progress) parts.push("progress:1b");
  if (s.comp) parts.push(`c:${sq(s.comp)}`);
  if (s.live && s.live.length) parts.push(`l:[${s.live.map((x) => `"${x}"`).join(",")}]`);
  if (s.count) parts.push(`n:"${s.count}"`);
  if (s.matches) parts.push(`matches:"${s.matches}"`);
  if (s.raw) parts.push(`raw:${dictToSnbt(s.raw as Record<string, unknown>)}`);
  return `{${parts.join(",")}}`;
}

export function opSnbt(o: Op): string {
  const parts: string[] = [];
  if (o.cmd) parts.push(`cmd:${sq(o.cmd)}`);
  if (o.fn) parts.push(`fn:"${o.fn}"`);
  if (o.page != null) parts.push(`page:${o.page}`);
  if (o.open) parts.push(`open:${Number(o.open)}`);
  if (o.close) parts.push("close:1b");
  if (o.toggle) parts.push(`toggle:"${o.toggle}"`);
  if (o.add != null) parts.push(`add:${o.add}`);
  if (o.set != null) parts.push(`set:${o.set}`);
  if (o.score) parts.push(`score:"${o.score}"`);
  if (o.min != null) parts.push(`min:${o.min}`);
  if (o.max != null) parts.push(`max:${o.max}`);
  if (o.wrap) parts.push("wrap:1b");
  if (o.give) parts.push(`id:"${itemId(o.give)}"`);
  if (o.n != null) parts.push(`n:${o.n}`);
  if (o.sound) parts.push(`sound:"${o.sound}"`);
  if (o.msg) parts.push(`msg:${sq(o.msg)}`);
  if (o.url) parts.push(`url:"${o.url}"`);
  if (o.label) parts.push(`label:"${o.label}"`);
  if (o.draw) parts.push("draw:1b");
  return `{${parts.join(",")}}`;
}

// ------------------------------------------------------------------ pack

export function generatePack(pack: Pack): OutMap {
  const out: OutMap = new Map();
  const ns = pack.namespace;

  // 1. runtime definitions (one storage blob, loaded on demand by the editor's save)
  out.set(`data/${ns}/function/menu/defs.mcfunction`, `# Auto-generated — runtime menu definitions\ndata merge storage ezgui:defs {menus:${menusSnbt(pack)}}\n`);

  // 2. generated artifacts
  for (const [id, json] of Object.entries(pack.itemModifiers)) {
    const [n, p] = id.split(":");
    out.set(`data/${n}/item_modifier/${p}.json`, JSON.stringify(json, null, 2) + "\n");
  }
  for (const [id, json] of Object.entries(pack.predicates)) {
    const [n, p] = id.split(":");
    out.set(`data/${n}/predicate/${p}.json`, JSON.stringify(json, null, 2) + "\n");
  }
  for (const [path, body] of Object.entries(pack.functions)) {
    out.set(`data/${ns}/function/${path}.mcfunction`, body.replace(/\n+$/, "") + "\n");
  }

  // 3. objectives for every score the menus touch, created once per load
  const allScores = new Set<string>();
  for (const m of pack.menus) {
    for (const sc of m.init) allScores.add(sc);
    for (const p of m.pages) for (const w of p.widgets) {
      if (w.coolscore) allScores.add(w.coolscore);
      for (const o of w.act) if (o.score) allScores.add(o.score);
      for (const c of w.cost ?? []) if (c.score) allScores.add(c.score);
    }
  }
  const staticScores = Object.values(OBJ);
  out.set(
    `data/${ns}/function/gen/objectives.mcfunction`,
    ["# Auto-generated — objectives used by the menus in this pack"]
      .concat([...new Set([...staticScores, ...allScores])].sort().map((sc) => `scoreboard objectives add ${sc} dummy`))
      .join("\n") + "\n"
  );

  // 4. tags
  out.set(`data/minecraft/tags/function/load.json`, JSON.stringify({ values: [`${ns}:core/load`, `${ns}:menu/defs`, `${ns}:gen/objectives`] }, null, 2) + "\n");
  out.set(`data/minecraft/tags/function/tick.json`, JSON.stringify({ values: [`${ns}:core/tick`] }, null, 2) + "\n");

  // 5. pack.mcmeta — 48 == 1.21.1, plus a wide compatible range
  out.set(
    "pack.mcmeta",
    JSON.stringify({ pack: { description: pack.description, pack_format: 48, supported_formats: [48, 57] } }, null, 2) + "\n"
  );
  return out;
}

export function summarize(pack: Pack): string {
  const menus = pack.menus.map((m) => `  • ${m.id} — ${m.display} (${m.pages.length} page(s), ${m.pages.reduce((a, p) => a + p.widgets.length, 0)} widgets)`);
  return [`EzGUI pack "${pack.description}"`, `namespace: ${pack.namespace}`, `menus:`, ...menus].join("\n");
}
