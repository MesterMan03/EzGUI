# AS player — one click on the widget ctx.i.
execute if score @s ezgui.click matches 2 run return 0
scoreboard players set @s ezgui.click 2
function ezgui:menu/load_w with storage ezgui:ctx
execute if data storage ezgui:ctx w.locked run return 0
scoreboard players set #ok ezgui.tmp 1
execute if data storage ezgui:ctx w.cond run function ezgui:menu/cond with storage ezgui:ctx
execute if score #ok ezgui.tmp matches 0 run return 0
execute if data storage ezgui:ctx w.cost run function ezgui:menu/cost with storage ezgui:ctx
execute if score #ok ezgui.tmp matches 0 run return 0
execute if data storage ezgui:ctx w.cool run function ezgui:menu/cool with storage ezgui:ctx
execute if score #ok ezgui.tmp matches 0 run return 0
execute if data storage ezgui:ctx sound run function ezgui:menu/op_sound with storage ezgui:ctx
function ezgui:menu/rearm with storage ezgui:ctx
function ezgui:menu/act with storage ezgui:ctx
