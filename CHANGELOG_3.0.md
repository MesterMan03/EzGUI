3.0
---

* 1.21.1 port: the runtime is now a small macro engine over menu definitions in storage instead of generated per-widget functions.
* New: multi-state widgets (toggle, cycle, radio, indicator, progress) driven by scoreboard objectives, with the kind taken from the definition, never guessed.
* New: live text — names and lore can show a score, refreshed once a second, in item-modifier form (no more per-frame rewriting).
* New: item and score costs, checked as a batch and charged only if every entry can be paid.
* New: one entity container per player, addressed by a permanent player id, so two players never share a menu.
* New: in-game editor save/export (`/trigger ezgui.save`), plus `docs/3.0-runtime.md`.
* Fixed: clicks are detected from the widget stamp (menu + page + id), so redraws and page changes are no longer mistaken for clicks.
* Fixed: partial repaint — static cells keep their stack and real clicks stop being dropped.
* Tools: TypeScript generator (`tools/src`, guigen core) and a lint that enforces the macro rules; 17 end-to-end checks against a live 1.21.1 server.
