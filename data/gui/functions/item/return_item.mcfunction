# Create a new item
summon item ~ ~ ~ {Tags:["temp","returnitem"],Item:{id:"minecraft:stone",Count:1b},PickupDelay:0s}

# Copy metadata from TempItem
data modify entity @e[tag=temp,limit=1] Item set from storage gui:pages TempItem
data modify entity @e[tag=temp,limit=1] Owner set from entity @s UUID

# Minecraft is stupid
tp @e[tag=temp] ~ ~.1 ~

# Set TempItem to ActualItem so it won't fire any click check function 
data storage gui:pages TempItem set from storage gui:pages ActualItem
