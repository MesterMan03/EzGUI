# Flip a boolean score (0 <-> 1).
$execute store result score #v ezgui.tmp run scoreboard players get @s $(toggle)
$scoreboard players add @s $(toggle) 1
$execute if score #v ezgui.tmp matches ..0 run scoreboard players set @s $(toggle) 1
$execute if score #v ezgui.tmp matches 1.. run scoreboard players set @s $(toggle) 0
execute if data storage ezgui:ctx op.draw run return 0
scoreboard players set #lo ezgui.tmp 0
execute store result storage ezgui:ctx lo int 1 run scoreboard players get #lo ezgui.tmp
function ezgui:menu/draw
