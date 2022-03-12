execute if data entity @s SelectedItem.tag.gui.stealitem run scoreboard players set #temp constant 1
execute unless data entity @s SelectedItem.tag.gui.stealitem run scoreboard players set #temp constant 2

execute if score #temp constant matches 1 run tellraw @s {"text": "Disabled stealitem","color": "red"}
execute if score #temp constant matches 2 run tellraw @s {"text": "Enabled stealitem","color": "green"}

execute if score #temp constant matches 1 run item modify entity @s weapon.mainhand gui:editor/disable_stealitem
execute if score #temp constant matches 2 run item modify entity @s weapon.mainhand gui:editor/enable_stealitem