# One cell of a widget (exactly one for a button, one per segment for a progress bar).
execute store result score #c ezgui.tmp run data get storage ezgui:ctx cells
execute if score #c ezgui.tmp matches ..0 run scoreboard players set #c ezgui.tmp 1
execute if score #g ezgui.tmp >= #c ezgui.tmp run return 1
function ezgui:core/ctx
execute store result score #i ezgui.tmp run data get storage ezgui:ctx i
execute store result score #g ezgui.tmp run data get storage ezgui:ctx g
$execute store result score #slot ezgui.tmp run data get storage ezgui:defs menus.$(mid).pages[$(page)].widgets[$(i)].slot
scoreboard players operation #slot ezgui.tmp += #g ezgui.tmp
execute store result storage ezgui:ctx slot int 1 run scoreboard players get #slot ezgui.tmp
execute store result storage ezgui:ctx g int 1 run scoreboard players get #g ezgui.tmp
function ezgui:menu/place with storage ezgui:ctx
scoreboard players add #g ezgui.tmp 1
execute store result storage ezgui:ctx g int 1 run scoreboard players get #g ezgui.tmp
execute store result score #c ezgui.tmp run data get storage ezgui:ctx cells
execute if score #g ezgui.tmp < #c ezgui.tmp run function ezgui:menu/draw_cell_loop with storage ezgui:ctx
