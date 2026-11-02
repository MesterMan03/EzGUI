# Condition gate. w.cond names a function that runs AS the player and passes by
# returning 1 (fail = 0): a menu can test anything the game can express and the
# runtime never grows a command parser.
scoreboard players set #ok ezgui.tmp 1
data modify storage ezgui:ctx hook set from storage ezgui:ctx w.cond
function ezgui:menu/cond_call with storage ezgui:ctx
execute if score #r ezgui.tmp matches 1.. run return 0
scoreboard players set #ok ezgui.tmp 0
execute unless data storage ezgui:ctx w.fail run return 0
data modify storage ezgui:ctx fail set from storage ezgui:ctx w.fail
function ezgui:menu/fail with storage ezgui:ctx
