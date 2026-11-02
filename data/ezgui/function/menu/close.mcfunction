# AS player — close whatever is open. Idempotent, so open/close/leave paths stay simple.
execute unless score @s ezgui.timer matches 1.. run return 0
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
data modify storage ezgui:ctx hook set from storage ezgui:ctx on_leave
execute if data storage ezgui:ctx on_leave run function ezgui:menu/on_leave with storage ezgui:ctx
function ezgui:menu/save_containers with storage ezgui:ctx
data modify storage ezgui:ctx hook set from storage ezgui:ctx on_close
execute if data storage ezgui:ctx on_close run function ezgui:menu/on_close with storage ezgui:ctx
$execute as @e[tag=ezgui.cont,tag=ezgui.p$(pid)] run function ezgui:menu/dismantle
execute if data storage ezgui:ctx def.kiosk run function ezgui:menu/kiosk_teardown with storage ezgui:ctx
function ezgui:core/sweep
scoreboard players reset @s ezgui.timer
scoreboard players reset @s ezgui.page
scoreboard players reset @s ezgui.click
$execute store result storage ezgui:state players.p$(pid).page int 1 run scoreboard players get @s ezgui.page
