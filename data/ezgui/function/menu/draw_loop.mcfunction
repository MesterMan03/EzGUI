# One widget: resolve its slot, then fan it out over its cells.
function ezgui:core/ctx
execute store result score #i ezgui.tmp run data get storage ezgui:ctx i
$data modify storage ezgui:ctx w set from storage ezgui:defs menus.$(mid).pages[$(page)].widgets[$(i)]
execute store result storage ezgui:ctx cells int 1 run data get storage ezgui:ctx w.cells
execute store result storage ezgui:ctx slot int 1 run data get storage ezgui:ctx w.slot
function ezgui:menu/kind
scoreboard players set #g ezgui.tmp 0
execute store result storage ezgui:ctx g int 1 run scoreboard players get #g ezgui.tmp
function ezgui:menu/draw_cell_loop with storage ezgui:ctx
scoreboard players add #i ezgui.tmp 1
execute store result storage ezgui:ctx i int 1 run scoreboard players get #i ezgui.tmp
execute store result score #n ezgui.tmp run data get storage ezgui:ctx page_def.widgets
execute if score #i ezgui.tmp < #n ezgui.tmp run function ezgui:menu/draw_loop with storage ezgui:ctx
