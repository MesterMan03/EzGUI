# Walks ctx.live: each step copies the modifier id into ctx.mod, then applies it in a
# separate call so the macro sees the fresh value.
execute store result score #c ezgui.tmp run data get storage ezgui:ctx live
execute if score #k ezgui.tmp >= #c ezgui.tmp run return 1
$data modify storage ezgui:ctx mod set from storage ezgui:ctx live[$(k)]
function ezgui:menu/live_apply with storage ezgui:ctx
scoreboard players add #k ezgui.tmp 1
function ezgui:menu/live_loop with storage ezgui:ctx
