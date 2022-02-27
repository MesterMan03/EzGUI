# Executes as: player, at: player
# Their gui: @e[tag=selectedgui,tag=ready]

# Reset
tag @e remove selectedgui

# Find the gui
execute store result score #temp constant run scoreboard players get @s openedGUIid
execute as @e[type=chest_minecart,tag=gui,tag=openedGUI] if score @s id = #temp constant run tag @s add selectedgui

# This is the part I'm most proud of :D
execute if entity @e[tag=selectedgui,tag=ready] run function gui:item/check_clicks

# Fill up items after every item check has been done
execute as @e[tag=selectedgui] run function gui:item/load_items

# Simple shit
function gui:item/killitems

# Add the "ready" tag to guis, so the check function doesn't fire when we just spawned the chest minecart (first tick bug)
tag @e[tag=gui,tag=!ready] add ready