// Emit the datapack: writes every generated file under the repo root.
import { writeFileSync, mkdirSync, existsSync, rmSync, readdirSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { out, pack, spec } from "../menus/main.ts";
import { summarize } from "./core/guigen.ts";

const root = resolve(import.meta.dirname, "../..");

// Generated output is disposable: wipe it first so renamed/removed menus can never
// leave a stale function behind (that is how a broken file survives a reload).
for (const dir of ["data/ezgui/function/gen", "data/ezgui/item_modifier/ezgui", "data/ezgui/predicate/ezgui"]) {
  rmSync(join(root, dir), { recursive: true, force: true });
}
const keep = new Set(["defs.mcfunction"]);
let written = 0;
for (const [path, content] of out) {
  const full = join(root, path);
  mkdirSync(dirname(full), { recursive: true });
  writeFileSync(full, content, "utf8");
  written++;
}
console.log(summarize(pack));
console.log(`\nwrote ${written} generated file(s) into ${root}`);
console.log("menus:", JSON.stringify(spec.menus.map((m) => m.id)));
console.log("runtime files:", existsSync(join(root, "data/ezgui/function/menu/click.mcfunction")) ? "present" : "MISSING");
