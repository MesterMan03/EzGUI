# AS player — /trigger ezgui.close
function ezgui:core/seed
execute unless score @s ezgui.timer matches 1.. run tellraw @s [{"text":"[EzGUI] ","color":"aqua"},{"text":"No menu is open.","color":"gray"}]
execute unless score @s ezgui.timer matches 1.. run return 0
function ezgui:menu/close with storage ezgui:ctx
