# Executes as: any player who has the gui:opened_gui advancement
# Executes at: the player

# Mark the GUI for later use
execute positioned ~ ~1 ~ run tag @e[tag=gui,tag=!openedGUI,limit=1,sort=nearest] add openingGUI

# Assign id to gui
execute as @e[tag=openingGUI] run function gui:generatenewid

# Change the GUI's tags
tag @e[tag=openingGUI] add openedGUI

# Assign type value
execute as @e[tag=openingGUI,tag=!itemgui] at @s store result score @s guiType run scoreboard players get @e[tag=base,sort=nearest,limit=1] guiType

# Change the player's tags
tag @s add openedGUI

# Bind the gui and player
execute store result score @s openedGUIid run scoreboard players get @e[tag=openingGUI,limit=1] id

# Finishing up
tag @e remove openingGUI