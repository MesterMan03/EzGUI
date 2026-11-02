# Counter: add n and clamp to [min,max]. A negative n counts down.
execute store result score #n ezgui.tmp run data get storage ezgui:ctx op.add
execute store result score #lo ezgui.tmp run data get storage ezgui:ctx op.min
execute store result score #hi ezgui.tmp run data get storage ezgui:ctx op.max
$scoreboard players operation @s $(score) += #n ezgui.tmp
$execute if score @s $(score) > #hi ezgui.tmp run scoreboard players operation @s $(score) = #hi ezgui.tmp
$execute if score @s $(score) < #lo ezgui.tmp run scoreboard players operation @s $(score) = #lo ezgui.tmp
execute if data storage ezgui:ctx op.draw run return 0
scoreboard players set #lo ezgui.tmp 0
execute store result storage ezgui:ctx lo int 1 run scoreboard players get #lo ezgui.tmp
function ezgui:menu/draw
