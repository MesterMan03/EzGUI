# Radio / preset: write a constant into a score.
execute store result score #n ezgui.tmp run data get storage ezgui:ctx op.set
$scoreboard players operation @s $(score) = #n ezgui.tmp
execute if data storage ezgui:ctx op.draw run return 0
scoreboard players set #lo ezgui.tmp 0
execute store result storage ezgui:ctx lo int 1 run scoreboard players get #lo ezgui.tmp
function ezgui:menu/draw
