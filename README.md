# EzGUI

> by Mester

Data-driven GUI engine for **Minecraft Java 1.21.1** — chest menus built from data, not
from generated commands.

```mcfunction
/trigger ezgui.open
```

## Install

1. Copy `pack.mcmeta` and `data/` into `<world>/datapacks/ezgui/`.
2. `/reload` — you should see `[EzGUI] loaded — /trigger ezgui.open`.
3. `/trigger ezgui.open`

Ships with four menus: hub, shop (score/item costs, conditions, cooldowns, a progress
bar), settings (toggle, counter, cycle, radio) and an in-game chest editor.

## Docs

| | |
| --- | --- |
| `docs/kurulum.md` | **kurulum ve kullanım** (Türkçe): install, triggers, widget types, actions, making your own menu |
| `docs/3.0-runtime.md` | how the macro runtime works and why it is split into compute/print steps |
| `docs/3.0-testing.md` | test report: 17 end-to-end checks on a live 1.21.1 server |
| `CHANGELOG_3.0.md` | what changed in 3.0 |

## Build your own menus

```bash
cd tools
npm install
npx tsx src/cli.ts            # regenerate defs + generated files
npx tsx src/lint.ts ../data   # macro rules, enforced before you deploy
```

Menus are declared in `tools/menus/main.ts` as `MenuSpec` objects; the generator emits the
runtime definition blob, item modifiers and hooks.

## Version

`pack_format` 48 (1.21.1), `supported_formats` 48–57. Requires no mods, no resource pack.
