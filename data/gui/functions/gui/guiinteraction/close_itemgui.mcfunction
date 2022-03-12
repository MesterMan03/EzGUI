# executes as gui

# Find the player
execute store result score #temp constant run scoreboard players get @s id
execute store result score @s guiType as @a[gamemode=!spectator] if score @s openedGUIid = #temp constant run tag @s add selected

# remove openedGUI tag
tag @a[tag=selected] remove openedGUI

# unbind gui and player
scoreboard players reset @a[tag=selected] openedGUIid

# reset
tag @a remove selected