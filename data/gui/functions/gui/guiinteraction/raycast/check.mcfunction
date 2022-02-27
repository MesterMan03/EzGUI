execute store success score #raycast_temp constant align y positioned ~ ~ ~ if entity @e[type=armor_stand,tag=base,distance=...1]
execute if score #raycast_temp constant matches 0 run execute store success score #temp constant align y positioned ~ ~-1 ~ if entity @e[type=armor_stand,tag=base,distance=...1]

scoreboard players add @s constant 1
execute if score @s constant matches 80.. run scoreboard players set #raycast_temp constant 2 