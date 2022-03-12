# Create a new item
summon item ~ ~ ~ {Tags:["temp","editoritem"],Item:{id:"minecraft:stone",Count:1b},PickupDelay:0s}

# Copy metadata from player
data modify entity @e[tag=temp,limit=1] Item set from entity @s SelectedItem
data modify entity @e[tag=temp,limit=1] Owner set from entity @s UUID

# first, reset anyclick
data remove entity @e[tag=temp,limit=1] Item.tag.gui.anyclick

# Add the command id
execute if score @s leftclick matches 1.. store result entity @e[tag=temp,limit=1] Item.tag.gui.leftclick int 1 run scoreboard players get @s leftclick
execute if score @s rightclick matches 1.. store result entity @e[tag=temp,limit=1] Item.tag.gui.rightclick int 1 run scoreboard players get @s rightclick
execute if score @s shiftclick matches 1.. store result entity @e[tag=temp,limit=1] Item.tag.gui.shiftclick int 1 run scoreboard players get @s shiftclick
execute if score @s returnclick matches 1.. store result entity @e[tag=temp,limit=1] Item.tag.gui.returnclick int 1 run scoreboard players get @s returnclick
execute if score @s dropclick matches 1.. store result entity @e[tag=temp,limit=1] Item.tag.gui.dropclick int 1 run scoreboard players get @s dropclick
execute if score @s dropstackclick matches 1.. store result entity @e[tag=temp,limit=1] Item.tag.gui.dropstackclick int 1 run scoreboard players get @s dropstackclick
execute if score @s fclick matches 1.. store result entity @e[tag=temp,limit=1] Item.tag.gui.fclick int 1 run scoreboard players get @s fclick

# special commands
execute if score @s returnclick matches -1 run function gui:editor/toggle_stealitem

# for anyclick
execute if score @s anyclick matches 1.. run function gui:editor/set_anyclick

# Minecraft is stupid
tp @e[tag=temp] ~ ~.1 ~

# Remove original item
item replace entity @s weapon.mainhand with air

# reset
function gui:reset_triggers