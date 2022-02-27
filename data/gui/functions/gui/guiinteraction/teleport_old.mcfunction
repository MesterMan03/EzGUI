# Executes as: every player with the openedGUI tag, at: player
# When: every set ticks

# Reset stuff
tag @e remove selected

# Find the gui
execute store result score #temp constant run scoreboard players get @s openedGUIid
execute as @e[type=chest_minecart,tag=gui,tag=openedGUI] if score @s id = #temp constant run tag @s add selected

# Start raycasting into the shop
summon armor_stand ~ ~1 ~ {Small:1b,Marker:1b,Invisible:1b,Tags:["raycast"]}
data modify entity @e[tag=raycast,limit=1] Rotation set from entity @s Rotation

scoreboard players set #raycast_temp constant 0
execute as @e[tag=raycast,limit=1] at @s positioned ^ ^ ^.1 run function gui:gui/guiinteraction/raycast/step

# If there is an error
execute if score #raycast_temp constant matches 2 store result score @s constant run data get entity @s Rotation[1]
execute if score #raycast_temp constant matches 2 if score @s constant matches ..-1 at @e[type=armor_stand,tag=base,sort=nearest,limit=1] positioned ~ ~1 ~ run tp @e[tag=selected] ~ ~ ~
execute if score #raycast_temp constant matches 2 if score @s constant matches 0..20 at @e[type=armor_stand,tag=base,sort=nearest,limit=1] positioned ~ ~.5 ~ run tp @e[tag=selected] ~ ~ ~
execute if score #raycast_temp constant matches 2 if score @s constant matches 20.. at @e[type=armor_stand,tag=base,sort=nearest,limit=1] run tp @e[tag=selected] ~ ~ ~
execute if score #raycast_temp constant matches 2 run kill @e[tag=raycast]

# Otherwise
execute at @e[tag=raycast,limit=1] run tp @e[tag=selected] ~ ~ ~
execute as @e[tag=selected] at @s run tp @s ~ ~.5 ~

kill @e[tag=raycast]

# Finishing up
advancement revoke @s only gui:opened_gui