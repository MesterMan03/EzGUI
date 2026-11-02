
# AS player, once per tick while a menu is open: keep the container bound to the player,
# look for a click, sweep leaked widget items, and refresh the live text once a second.
#
# The repaint is deliberately NOT every tick: rewriting container items every tick makes
# the client resync its copy of the window continuously, and real clicks that land in
# that window are dropped. One refresh per second keeps counters fresh and leaves 19 of
# 20 ticks untouched, so a player's click always lands.
function ezgui:core/seed
function ezgui:core/ensure_pid
# Only a player with an open menu and a known menu id is ticked.
execute unless score @s ezgui.mid matches 1.. run return 0
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
scoreboard players set @s ezgui.click 0
execute if data storage ezgui:ctx def.container run function ezgui:menu/follow with storage ezgui:ctx
scoreboard players set #i ezgui.tmp 0
execute store result storage ezgui:ctx i int 1 run scoreboard players get #i ezgui.tmp
execute store result score #n ezgui.tmp run data get storage ezgui:ctx page_def.widgets
execute if score #n ezgui.tmp matches 1.. run function ezgui:menu/detect_loop with storage ezgui:ctx
function ezgui:core/sweep
# A handled click repaints everything (the item must come back at once). The once-a-
# second refresh only touches cells with live text — rewriting static cells would make
# the client resync its window for no reason.
execute if score @s ezgui.click matches 2 run function ezgui:menu/draw
scoreboard players add @s ezgui.live 1
execute if score @s ezgui.live matches 20.. run scoreboard players set @s ezgui.live 0
execute if score @s ezgui.live matches 0 run function ezgui:menu/draw_live
