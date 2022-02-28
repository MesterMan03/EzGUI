# Reset some stuff


# Check for somebody who used /trigger openeditor
scoreboard players enable @a openeditor
execute as @a[scores={openeditor=1}] run function gui:editor/open/start
scoreboard players set @a openeditor 0

# It's particle time :D
execute at @e[tag=editormarker] run particle end_rod ~ ~ ~ 0 -0.1 0 0 1

# Give the GUIItem nbt
execute as @a[tag=editoropen] at @s if data entity @s SelectedItem unless data entity @s SelectedItem.tag.GUIItem run function gui:editor/give_guiitem

# Check for setting the command id
# - Run the actual function
execute as @a[tag=editoropen] at @s if predicate gui:ran_command_editor if data entity @s SelectedItem run function gui:editor/set_commandid

# - Reset
function gui:reset_triggers