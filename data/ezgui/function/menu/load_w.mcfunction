# Load the widget named by ctx.i into ctx.w and expose its geometry to the macros.
$data modify storage ezgui:ctx w set from storage ezgui:defs menus.$(mid).pages[$(page)].widgets[$(i)]
execute store result storage ezgui:ctx slot int 1 run data get storage ezgui:ctx w.slot
execute store result storage ezgui:ctx cells int 1 run data get storage ezgui:ctx w.cells
# Flatten the widget's macro inputs, then lift its kind markers (menu/kind).
data modify storage ezgui:ctx sound set from storage ezgui:ctx w.sound
data modify storage ezgui:ctx score set from storage ezgui:ctx w.score
data modify storage ezgui:ctx coolscore set from storage ezgui:ctx w.coolscore
function ezgui:menu/kind
