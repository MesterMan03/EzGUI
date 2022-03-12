# Create a new item
execute unless data storage gui:pages ActualItem.tag.gui.stealitem run summon item ~ ~ ~ {Tags:["temp","returnitem"],Item:{id:"minecraft:stone",Count:1b},PickupDelay:0s}

# Copy metadata from SlotItem
data modify entity @e[tag=temp,limit=1] Item set from storage gui:pages SlotItem
data modify entity @e[tag=temp,limit=1] Owner set from entity @s UUID

# Minecraft is stupid
tp @e[tag=temp] ~ ~.1 ~

# Check if we have a command id to run
execute if data storage gui:pages ActualItem.tag.gui.returnclick run function gui:item/clicks/return
execute if data storage gui:pages ActualItem.tag.gui.anyclick run function gui:item/clicks/return

# Reset Temp and ActualItem and also kill itemcheck, so click check functions won't continue
data remove storage gui:pages ActualItem
data remove storage gui:pages SlotItem
kill @e[tag=itemcheck]