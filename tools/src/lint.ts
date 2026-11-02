// Static checks for the macro runtime. These are the rules the 1.21.1 parser
// enforces at /reload time — a violation silently disables a whole function, so
// they are checked here instead of in game.
import { readFileSync, readdirSync, statSync } from "node:fs";
import { join, relative } from "node:path";

const root = process.argv[2] ?? "data";
const problems: string[] = [];

function walk(dir: string, out: string[] = []): string[] {
  for (const e of readdirSync(dir)) {
    const p = join(dir, e);
    if (statSync(p).isDirectory()) walk(p, out);
    else if (p.endsWith(".mcfunction")) out.push(p);
  }
  return out;
}

const files = walk(root);
const bodies = new Map(files.map((f) => [f, readFileSync(f, "utf8")]));
const isMacro = (f: string) => (bodies.get(f) ?? "").split("\n").some((l) => l.trimStart().startsWith("$"));
const id = (f: string) => f.replace(/\\/g, "/").replace(/^.*function\//, "").replace(/\.mcfunction$/, "");
const macroIds = new Set(files.filter(isMacro).map(id));

for (const [f, body] of bodies) {
  body.split("\n").forEach((line, i) => {
    const where = `${relative(".", f)}:${i + 1}`;
    const t = line.trimStart();
    if (t.startsWith("#")) return;
    // rule 1: a macro line must contain at least one variable
    if (t.startsWith("$") && !/\$\([a-z0-9_]+\)/.test(line)) problems.push(`${where}: macro line without a $(variable)`);
    // rule 2: variables are only allowed on macro lines
    if (!t.startsWith("$") && /\$\([a-z0-9_]+\)/.test(line)) problems.push(`${where}: $(variable) outside a macro line`);
    // rule 3: storage paths use a space, never a dot ("storage ns:name path")
    for (const m of line.matchAll(/storage\s+([a-z0-9_.-]+:[a-z0-9_./-]+)\./g)) problems.push(`${where}: dotted storage path (${m[1]}.)`);
    // rule 4: strings cannot be produced by execute store result
    if (/store result[^"]*\bstring\b/.test(line)) problems.push(`${where}: store result … string (copy the value with data modify instead)`);
    // rule 5: every call to a macro function must pass an argument source
    for (const m of line.matchAll(/function\s+([a-z0-9_.-]+:[a-z0-9_/]+)(?![a-z0-9_/])/g)) {
      if (macroIds.has(m[1]) && !/with\s+storage|with\s+entity|with\s+block/.test(line)) {
        problems.push(`${where}: call to macro function ${m[1]} without "with storage"`);
      }
    }
  });
}

if (problems.length) {
  console.error(`lint: ${problems.length} problem(s)\n` + problems.join("\n"));
  process.exit(1);
}
console.log(`lint: ${files.length} functions OK (${macroIds.size} macro functions)`);
