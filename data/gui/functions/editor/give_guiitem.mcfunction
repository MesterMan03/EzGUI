# Create a new item
summon item ~ ~ ~ {Tags:["temp","editoritem"],Item:{id:"minecraft:stone",Count:1b},PickupDelay:0s}

# Copy metadata from player
data modify entity @e[tag=temp,limit=1] Item set from entity @s SelectedItem
data modify entity @e[tag=temp,limit=1] Owner set from entity @s UUID

# Add the GUIItem nbt
data modify entity @e[tag=temp,limit=1] Item.tag.GUIItem set value 1b

# Minecraft is stupid
tp @e[tag=temp] ~ ~.1 ~

# Remove original item
item replace entity @s weapon.mainhand with air