execute if data entity @e[tag=temp,limit=1] Item.tag.gui.stealitem run scoreboard players set #temp constant 1
execute unless data entity @e[tag=temp,limit=1] Item.tag.gui.stealitem run scoreboard players set #temp constant 2

execute if score #temp constant matches 1 run tellraw @s {"text": "Disabled stealitem","color": "red"}
execute if score #temp constant matches 2 run tellraw @s {"text": "Enabled stealitem","color": "green"}

execute if score #temp constant matches 1 run data remove entity @e[tag=temp,limit=1] Item.tag.gui.stealitem
execute if score #temp constant matches 2 run data modify entity @e[tag=temp,limit=1] Item.tag.gui.stealitem set value 1