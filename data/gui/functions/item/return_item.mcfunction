tellraw @a {"nbt":"TempItem","storage": "gui:pages"}

# Check if we have a command id to run
execute if data storage gui:pages ActualItem.tag.gui.returnclick run function gui:item/clicks/return

#TO-DO: add option to not return item when an actual command is ran

# Create a new item
summon item ~ ~ ~ {Tags:["temp","returnitem"],Item:{id:"minecraft:stone",Count:1b},PickupDelay:0s}

# Copy metadata from TempItem
data modify entity @e[tag=temp,limit=1] Item set from storage gui:pages TempItem
data modify entity @e[tag=temp,limit=1] Owner set from entity @s UUID

# Minecraft is stupid
tp @e[tag=temp] ~ ~.1 ~

# Kill itemcheck, so the click check functions don't continue
kill @e[tag=itemcheck]