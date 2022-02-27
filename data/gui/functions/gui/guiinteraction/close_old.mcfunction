# Executes as: player

# Find the gui
execute store result score #temp constant run scoreboard players get @s openedGUIid
execute as @e[type=chest_minecart,tag=gui,tag=openedGUI] if score @s id = #temp constant run tag @s add closingGUI

# Kill the gui
execute as @e[tag=closingGUI] run function gui:gui/guiinteraction/close_clear

# Unbind gui and player
scoreboard players reset @s openedGUIid

# Reset player to "unopened" state
tag @s remove openedGUI