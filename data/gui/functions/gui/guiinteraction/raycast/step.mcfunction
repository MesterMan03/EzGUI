tp ~ ~ ~
execute if score #DEBUG_MODE constant matches 1 at @e[tag=raycast] run particle minecraft:happy_villager
function gui:gui/guiinteraction/raycast/check
execute if score #raycast_temp constant matches 0 positioned ^ ^ ^.1 run function gui:gui/guiinteraction/raycast/step