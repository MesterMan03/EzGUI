# Switch menu: op.open holds the target menu number.
execute store result score @s ezgui.mid run data get storage ezgui:ctx op.open
function ezgui:menu/open with storage ezgui:ctx
