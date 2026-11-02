# AS player — /trigger ezgui.open opens the pack's default menu.
function ezgui:core/seed
execute store result score @s ezgui.mid run data get storage ezgui:api default
function ezgui:menu/open with storage ezgui:ctx
