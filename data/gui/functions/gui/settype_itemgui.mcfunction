# executes as gui

# Find the player
execute store result score #temp constant run scoreboard players get @s id
execute store result score @s guiType as @a[gamemode=!spectator] if score @s openedGUIid = #temp constant run data get entity @s SelectedItem.tag.gui.guitype