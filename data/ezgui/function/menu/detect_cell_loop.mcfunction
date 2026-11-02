# One cell of the widget: a progress bar is many slots, everything else is one. The
# slot is computed here and printed by detect_cell, never in the same call.
execute store result score #c ezgui.tmp run data get storage ezgui:ctx cells
execute if score #c ezgui.tmp matches ..0 run scoreboard players set #c ezgui.tmp 1
execute if score #g ezgui.tmp >= #c ezgui.tmp run return 1
execute store result score #base ezgui.tmp run data get storage ezgui:ctx w.slot
scoreboard players operation #slot ezgui.tmp = #base ezgui.tmp
scoreboard players operation #slot ezgui.tmp += #g ezgui.tmp
execute store result storage ezgui:ctx slot int 1 run scoreboard players get #slot ezgui.tmp
function ezgui:menu/detect_cell with storage ezgui:ctx
execute if score @s ezgui.click matches 2 run return 1
scoreboard players add #g ezgui.tmp 1
execute store result storage ezgui:ctx g int 1 run scoreboard players get #g ezgui.tmp
function ezgui:menu/detect_cell_loop with storage ezgui:ctx
