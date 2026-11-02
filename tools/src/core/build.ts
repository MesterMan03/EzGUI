// ============================================================================
// Menu authoring layer.
//
// An author writes a MenuSpec (plain TS) and guigen compiles it into
//   • the runtime definition blob (storage ezgui:defs) that data/ezgui walks,
//   • one item modifier per live text / live count,
//   • hook functions (conditions, on_open/on_close).
//
// Nothing here generates per-slot functions: a menu is *data*, so the runtime cost
// of a menu is the same whether it has 3 widgets or 300.
// ============================================================================
import {
  type Menu,
  type Page,
  type Widget,
  type Op,
  type Pack,
  type Text,
  type ItemState,
  type OutMap,
  liveTextModifier,
  countModifier,
  componentsSnbt,
  itemId,
  hash8,
  safeId,
  mkText,
  generatePack,
  menusSnbt,
} from "./guigen.ts";

export { mkText };
export type { Op, Text };

export interface Look {
  item: string;
  name?: Text;
  lore?: Text[];
  glint?: boolean;
  cmd?: number | null;
}

export interface StateSpec extends Look {
  /** indicator range this state is used for */
  matches?: string;
}

export interface WidgetSpec extends Look {
  slot: number;
  /** how many slots the widget spans (progress bars) */
  cells?: number;
  kind?: string;
  on?: Look;
  options?: Look[];
  states?: StateSpec[];
  /** driver score: toggle / cycle / radio / progress / indicator / tab */
  score?: string;
  value?: number;
  max?: number;
  ops?: Op[];
  click?: boolean;
  cond?: string;
  fail?: Text;
  cost?: { item?: string; score?: string; n: number; fail?: Text }[];
  cool?: number;
  sound?: string;
}

export interface PageSpec {
  index: number;
  name: string;
  /** the chest editor may save this page back into the pack */
  editable?: boolean;
  widgets: WidgetSpec[];
  on_enter?: string;
  on_leave?: string;
  target?: string;
}

export interface MenuSpec {
  id: string;
  display: string;
  container?: Menu["container"];
  timer?: number;
  start_page?: number;
  on_open?: string;
  on_close?: string;
  init?: string[];
  floor?: string;
  pages: PageSpec[];
}

/** Score ids a menu seeds to 0 when it is opened (so widgets never render null). */
export interface PackSpec {
  namespace: string;
  description: string;
  default_menu: string;
  menus: MenuSpec[];
  /** extra functions shipped with the pack (conditions, hooks) */
  functions?: Record<string, string>;
}

const NON_CLICKABLE = new Set(["label", "separator", "progress", "indicator", "tab"]);

export function buildPack(spec: PackSpec): { out: OutMap; pack: Pack; ids: Record<string, number> } {
  const ns = spec.namespace;
  const pack: Pack = { namespace: ns, description: spec.description, menus: [], itemModifiers: {}, predicates: {}, functions: { ...(spec.functions ?? {}) } };
  const ids: Record<string, number> = {};

  // stable numeric ids first: ops reference menus by number at runtime
  spec.menus.forEach((m, i) => (ids[safeId(m.id)] = i + 1));
  for (const m of spec.menus) pack.menus.push(buildMenu(m, ids[safeId(m.id)]!, pack, ids));
  // string ⇄ number map: menus are addressed by stable integer ids at runtime
  pack.functions["gen/menu_ids"] = `# Auto-generated — menu name ⇄ runtime number\ndata merge storage ezgui:defs {ids:{${Object.entries(ids)
    .map(([k, v]) => `${k}:${v}`)
    .join(",")}}}\n`;

  const out = generatePack(pack);
  out.set(
    `data/${ns}/function/menu/defs.mcfunction`,
    [
      "# Auto-generated — runtime menu definitions (edited in game by the editor)",
      `data merge storage ezgui:defs {menus:${menusSnbt(pack)}}`,
      `data merge storage ezgui:api {default:${ids[safeId(spec.default_menu)] ?? 0}}`,
      "",
    ].join("\n")
  );
  return { out, pack, ids };
}

function buildMenu(spec: MenuSpec, nid: number, pack: Pack, ids: Record<string, number>): Menu {
  const ns = pack.namespace;
  const pages: Page[] = spec.pages.map((p) => ({
    index: p.index,
    name: p.name,
    widgets: p.widgets.map((w, i) => buildWidget(ns, nid, p.index, w, i, pack, ids)),
    on_enter: p.on_enter,
    on_leave: p.on_leave,
    target: p.target,
    editable: p.editable,
  }));

  const init = new Set<string>(spec.init ?? []);
  for (const p of pages) for (const w of p.widgets) if (w.score) init.add(w.score);

  return {
    id: safeId(spec.id),
    nid,
    display: spec.display,
    namespace: ns,
    container: spec.container,
    timer: spec.timer ?? 20 * 60 * 60,
    start_page: spec.start_page ?? 0,
    on_open: spec.on_open,
    on_close: spec.on_close,
    scores: [...init],
    init: [...init],
    pages,
    floor: itemId(spec.floor ?? "minecraft:black_stained_glass_pane"),
  };
}

function buildWidget(ns: string, nid: number, page: number, w: WidgetSpec, i: number, pack: Pack, ids: Record<string, number>): Widget {
  const kind = w.kind ?? "button";
  const id = `${safeId(kind)}_${w.slot}_${i}`;
  const key = `m${nid}p${page}_${i}`;

  const state = (look: Look, tag: string, matches?: string): ItemState => {
    const comp = componentsSnbt({ name: look.name ?? null, lore: look.lore ?? [], glint: look.glint, cmd: look.cmd ?? null });
    const st: ItemState = { id: itemId(look.item), comp: comp === "[]" ? "" : comp.slice(1, -1) };
    st.comp = stamp(st.comp, id, ns, nid, page);
    // Kind markers ride on every state so the runtime can tell a real toggle from a
    // cycle/radio/indicator/progress — all of them are driven by a score.
    if (kind === "toggle") st.toggle = w.score ?? "x";
    if (kind === "cycle") st.cycle = true;
    if (kind === "radio") st.radio = true;
    if (kind === "indicator") st.indicator = true;
    if (kind === "progress") st.progress = true;
    if (matches) st.matches = matches;
    const live = liveTextModifier(look.name ?? null, look.lore ?? []);
    if (live) {
      const mid = `${ns}:ezgui/t_${safeId(key)}_${tag}_${hash8(JSON.stringify(live))}`;
      pack.itemModifiers[mid] = live;
      st.live = [mid];
    }
    return st;
  };

  // A cycle's states ARE its options (index → option), everything else keeps a
  // resting state 0 and appends the "other" looks after it.
  const e: ItemState[] = [];
  if (kind === "cycle" && w.options && w.options.length) w.options.forEach((o, n) => e.push(state(o, `o${n}`)));
  else {
    e.push(state(w, "a"));
    if (w.on) e.push(state(w.on, "on"));
    if (w.options) w.options.forEach((o, n) => e.push(state(o, `o${n}`)));
  }
  if (w.states) w.states.forEach((s, n) => e.push(state({ ...s, item: s.item ?? w.item }, `s${n}`, s.matches)));
  if (kind === "progress") {
    const cells = w.cells ?? 5;
    const max = w.max ?? 100;
    for (let c = 0; c < cells; c++) {
      const threshold = Math.ceil(((c + 1) * max) / cells);
      e.push(state({ item: (w.on?.item ?? "minecraft:lime_stained_glass_pane") as string, name: w.name, lore: w.lore }, `p${c}`, `${threshold}..`));
    }
  }

  const widget: Widget = {
    slot: w.slot,
    kind,
    id,
    cells: kind === "progress" ? (w.cells ?? 5) : w.cells,
    click: w.click ?? !NON_CLICKABLE.has(kind),
    cond: w.cond,
    fail: w.fail ? JSON.stringify(w.fail) : undefined,
    cost: w.cost?.map((c) => ({ item: c.item, score: c.score, n: c.n, fail: c.fail ? JSON.stringify(c.fail) : undefined })),
    cool: w.cool,
    coolscore: w.cool ? `ezgui.cd_${safeId(id)}` : undefined,
    e,
    score: w.score,
    value: w.value,
    max: w.max,
    // "open: shop" is resolved to the stable numeric menu id here, so the runtime
    // never has to look a name up.
    act: (w.ops ?? []).map((o) => (o.open != null ? { ...o, open: String(ids[safeId(o.open)] ?? o.open) } : o)),
    sound: w.sound,
  };
  return widget;
}

/** custom_data marker the click detector searches for. */
/**
 * The stamp every widget item carries.
 *
 * m/p are the menu and page it was drawn for. Click detection compares the slot against
 * "a widget of THIS page", so a page change (which reuses the same slots for different
 * widgets) must never look like a click on the old page's widget.
 */
function stamp(comp: string, id: string, ns: string, menu: number, page: number): string {
  const tag = `minecraft:custom_data={ezgui:{w:1,id:"${id}",ns:"${ns}",m:${menu},p:${page}}}`;
  return comp ? `${comp},${tag}` : tag;
}

/** Compile a menu spec alone (used by the editor's "add menu" tooling). */
export { buildMenu };
