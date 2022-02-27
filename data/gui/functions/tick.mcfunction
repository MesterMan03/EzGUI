# Check for newly placed bases
execute as @e[type=armor_stand,tag=base] unless score @s id matches -2147483648..2147483647 run function gui:generatenewid

# Run the gui tick function
function gui:gui/tick

# Run the item tick function
execute as @a[tag=openedGUI] at @s run function gui:item/tick

# Run the editor tick function
function gui:editor/tick