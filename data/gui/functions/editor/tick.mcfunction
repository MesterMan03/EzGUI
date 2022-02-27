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
# - Reset
scoreboard players reset @a[tag=!editoropen] leftclick
scoreboard players reset @a[tag=!editoropen] rightclick
scoreboard players reset @a[tag=!editoropen] shiftclick
scoreboard players enable @a[tag=editoropen] leftclick
scoreboard players enable @a[tag=editoropen] rightclick
scoreboard players enable @a[tag=editoropen] shiftclick

# - Run the actual function
execute as @a[tag=editoropen] at @s if predicate gui:ran_command_editor if data entity @s SelectedItem run function gui:editor/set_commandid

# - Post-reset
scoreboard players set @a leftclick 0
scoreboard players set @a rightclick 0
scoreboard players set @a shiftclick 0