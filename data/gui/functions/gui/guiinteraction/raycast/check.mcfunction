execute store success score #raycast_temp constant align y positioned ~ ~ ~ as @e[tag=base,distance=..1] if predicate gui:base_close
execute if score #raycast_temp constant matches 0 store success score #raycast_temp constant align y positioned ~ ~-1 ~ as @e[tag=base,distance=..1] if predicate gui:base_close
execute if score #raycast_temp constant matches 0 store success score #raycast_temp constant align y positioned ~ ~1 ~ as @e[tag=base,distance=..1] if predicate gui:base_close

scoreboard players add @s constant 1
execute if score @s constant matches 80.. run scoreboard players set #raycast_temp constant 2 