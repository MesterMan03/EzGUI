# Walks this page's widgets and asks, one by one, whether the slot still holds its
# widget item. Stops as soon as a click has been handled.
execute if score @s ezgui.click matches 2 run return 1
function ezgui:core/ctx
execute store result score #i ezgui.tmp run data get storage ezgui:ctx i
$data modify storage ezgui:ctx w set from storage ezgui:defs menus.$(mid).pages[$(page)].widgets[$(i)]
execute if data storage ezgui:ctx w.click run function ezgui:menu/detect_one with storage ezgui:ctx
scoreboard players add #i ezgui.tmp 1
execute store result storage ezgui:ctx i int 1 run scoreboard players get #i ezgui.tmp
execute store result score #n ezgui.tmp run data get storage ezgui:ctx page_def.widgets
execute if score #i ezgui.tmp < #n ezgui.tmp run function ezgui:menu/detect_loop with storage ezgui:ctx
