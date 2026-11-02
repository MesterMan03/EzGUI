# Pay pass over the cost list. Only reached when every entry passed, so a click either
# pays for the whole list or for nothing.
execute store result score #c ezgui.tmp run data get storage ezgui:ctx cost
execute if score #k ezgui.tmp > #c ezgui.tmp run return 1
scoreboard players operation #idx ezgui.tmp = #k ezgui.tmp
scoreboard players remove #idx ezgui.tmp 1
execute store result storage ezgui:ctx idx int 1 run scoreboard players get #idx ezgui.tmp
data remove storage ezgui:ctx ci
data remove storage ezgui:ctx cs
$execute if data storage ezgui:ctx cost[$(idx)].item run data modify storage ezgui:ctx ci set from storage ezgui:ctx cost[$(idx)].item
$execute if data storage ezgui:ctx cost[$(idx)].score run data modify storage ezgui:ctx cs set from storage ezgui:ctx cost[$(idx)].score
$execute store result storage ezgui:ctx need int 1 run data get storage ezgui:ctx cost[$(idx)].n
function ezgui:menu/cost_pay
scoreboard players add #k ezgui.tmp 1
scoreboard players add #idx ezgui.tmp 1
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
execute store result storage ezgui:ctx idx int 1 run scoreboard players get #idx ezgui.tmp
function ezgui:menu/cost_take with storage ezgui:ctx
