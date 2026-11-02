# Cost gate. w.cost is a list of entries, each either {item,n} or {score,n}.
#
# Both passes are list-driven: cost_loop/cost_take walk it, prepare the entry into flat
# keys (ci / cs / need — the only way a macro can print them) and then hand over to
# cost_check/cost_pay, which pick the item or the score branch from the DEFINITION
# ("does this entry have an item?"), never from the flattened copy.
scoreboard players set #ok ezgui.tmp 1
data modify storage ezgui:ctx cost set from storage ezgui:ctx w.cost
scoreboard players set #k ezgui.tmp 1
scoreboard players set #idx ezgui.tmp 0
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
execute store result storage ezgui:ctx idx int 1 run scoreboard players get #idx ezgui.tmp
scoreboard players get #k ezgui.tmp
function ezgui:menu/cost_loop with storage ezgui:ctx
execute if score #ok ezgui.tmp matches 0 run return 0
scoreboard players set #k ezgui.tmp 1
scoreboard players set #idx ezgui.tmp 0
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
execute store result storage ezgui:ctx idx int 1 run scoreboard players get #idx ezgui.tmp
function ezgui:menu/cost_take with storage ezgui:ctx
