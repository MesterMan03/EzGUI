# Summon/place the container, run the menu hook, then enter the start page.
execute if data storage ezgui:ctx container run function ezgui:menu/summon with storage ezgui:ctx
execute if data storage ezgui:ctx def.kiosk run function ezgui:menu/kiosk with storage ezgui:ctx
data modify storage ezgui:ctx hook set from storage ezgui:ctx on_open
execute if data storage ezgui:ctx on_open run function ezgui:menu/open_hook with storage ezgui:ctx
function ezgui:menu/init with storage ezgui:ctx
function ezgui:menu/page_load with storage ezgui:ctx
scoreboard players add @s ezgui.session 1
scoreboard players set @s ezgui.last_session 1
$execute store result storage ezgui:state players.p$(pid).menu int 1 run scoreboard players get @s ezgui.mid
