# AS player — /trigger ezgui.last reopens the menu this player had open last.
function ezgui:core/seed
execute unless score @s ezgui.last_session matches 1.. run tellraw @s [{"text":"[EzGUI] ","color":"aqua"},{"text":"You have not opened a menu yet.","color":"gray"}]
execute unless score @s ezgui.last_session matches 1.. run return 0
function ezgui:core/ctx
$execute store result score @s ezgui.mid run data get storage ezgui:state players.p$(pid).menu
function ezgui:menu/open with storage ezgui:ctx
