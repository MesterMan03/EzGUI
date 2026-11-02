# AS player — refresh only the cells whose text is live (scores in name/lore).
scoreboard players set #lo ezgui.tmp 1
execute store result storage ezgui:ctx lo int 1 run scoreboard players get #lo ezgui.tmp
function ezgui:menu/draw with storage ezgui:ctx
scoreboard players set #lo ezgui.tmp 0
execute store result storage ezgui:ctx lo int 1 run scoreboard players get #lo ezgui.tmp
