# AS player — print a portable copy of the current menu definition so it can be pasted
# into tools/menus/*.ts (that is how a saved menu leaves the world).
function ezgui:core/ctx
$data modify storage ezgui:ctx dump set from storage ezgui:defs menus.$(mid)
$tellraw @s [{"text":"[EzGUI] ","color":"aqua"},{"text":"Menu definition is in storage ezgui:defs menus.$(mid) — /data get storage ezgui:defs menus.$(mid) copies it.","color":"gray"}]
