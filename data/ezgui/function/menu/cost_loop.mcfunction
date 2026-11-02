# Check pass over the cost list. k is 1-based; the list index (k-1) is carried in
# ctx.idx, because a macro argument can only print a flat key.
execute store result score #c ezgui.tmp run data get storage ezgui:ctx cost
execute if score #k ezgui.tmp > #c ezgui.tmp run return 1
execute if score #ok ezgui.tmp matches 0 run return 1
scoreboard players operation #idx ezgui.tmp = #k ezgui.tmp
scoreboard players remove #idx ezgui.tmp 1
execute store result storage ezgui:ctx idx int 1 run scoreboard players get #idx ezgui.tmp
data remove storage ezgui:ctx ci
data remove storage ezgui:ctx cs
$execute if data storage ezgui:ctx cost[$(idx)].item run data modify storage ezgui:ctx ci set from storage ezgui:ctx cost[$(idx)].item
$execute if data storage ezgui:ctx cost[$(idx)].score run data modify storage ezgui:ctx cs set from storage ezgui:ctx cost[$(idx)].score
$execute store result storage ezgui:ctx need int 1 run data get storage ezgui:ctx cost[$(idx)].n
function ezgui:menu/cost_check
scoreboard players add #k ezgui.tmp 1
scoreboard players add #idx ezgui.tmp 1
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
execute store result storage ezgui:ctx idx int 1 run scoreboard players get #idx ezgui.tmp
function ezgui:menu/cost_loop with storage ezgui:ctx
