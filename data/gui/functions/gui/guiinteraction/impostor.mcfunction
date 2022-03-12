# Teleport the player away
summon minecraft:area_effect_cloud ~ ~30 ~ {Age: -2147483648, Duration: -1, WaitTime: -2147483648, Tags: ["temp"]}
data modify entity @e[tag=temp,limit=1] Rotation set from entity @s Rotation
tp @s @e[tag=temp,limit=1]

# Add impostor tag to the player
tag @s add impostor

# Finishing up
kill @e[tag=temp]