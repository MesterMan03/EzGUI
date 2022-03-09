# Run the gui tick function
function gui:gui/tick

# Run the item tick function (we run the killitems function later, for multiplayer compatibility)
execute as @a[tag=openedGUI] at @s run function gui:item/tick
function gui:item/killitems

# Run the editor tick function
function gui:editor/tick