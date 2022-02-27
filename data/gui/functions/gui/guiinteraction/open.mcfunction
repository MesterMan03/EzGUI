# Executes as: any player who has the gui:opened_gui advancement
# Executes at: the player

# Reset stuff
tag @e remove openingGUI

# Mark the GUI for later use
execute positioned ~ ~1 ~ run tag @e[type=chest_minecart,tag=gui,tag=!openedGUI,limit=1,sort=nearest] add openingGUI

# Assign id to gui
execute as @e[tag=openingGUI] run function gui:generatenewid

# Change the GUI's tags
tag @e[tag=openingGUI] add openedGUI

# Teleport the GUI to the base
execute at @e[type=armor_stand,tag=base,sort=nearest,limit=1] positioned ~ ~1 ~ run tp @e[tag=openingGUI] ~ ~ ~
execute as @e[tag=openingGUI] at @s run tp @s ~ ~ ~

# Change the player's tags
tag @s add openedGUI

# Bind the gui and player
execute store result score @s openedGUIid run scoreboard players get @e[tag=openingGUI,limit=1] id

# Finishing up
advancement revoke @s only gui:opened_gui