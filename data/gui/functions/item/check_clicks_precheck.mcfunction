# executes as gui
# this function tries to check if there is a difference
# between the gui and the actual items instead of "brute forcing"
# every single slot. It also shows which slot is different to increase
# optimization by a LOT

# first we copy the *full Items nbt* to ActualPage and TempPage
data modify storage gui:pages ActualPage set from entity @e[tag=itemcheck,limit=1] Items
data modify storage gui:pages TempPage set from entity @e[tag=selectedgui,limit=1] Items

# this is how it's going to work:
# we check if we can copy from ActualPage to TempPage
# if the command fails, that means the 2 nbts are exactly the same, which is what we want to know
# generated using python

execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:0b}] if data storage gui:pages TempPage[{Slot:0b}] run data modify storage gui:pages TempPage[{Slot:0b}] set from storage gui:pages ActualPage[{Slot:0b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 0
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:1b}] if data storage gui:pages TempPage[{Slot:1b}] run data modify storage gui:pages TempPage[{Slot:1b}] set from storage gui:pages ActualPage[{Slot:1b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 1
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:2b}] if data storage gui:pages TempPage[{Slot:2b}] run data modify storage gui:pages TempPage[{Slot:2b}] set from storage gui:pages ActualPage[{Slot:2b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 2
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:3b}] if data storage gui:pages TempPage[{Slot:3b}] run data modify storage gui:pages TempPage[{Slot:3b}] set from storage gui:pages ActualPage[{Slot:3b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 3
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:4b}] if data storage gui:pages TempPage[{Slot:4b}] run data modify storage gui:pages TempPage[{Slot:4b}] set from storage gui:pages ActualPage[{Slot:4b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 4
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:5b}] if data storage gui:pages TempPage[{Slot:5b}] run data modify storage gui:pages TempPage[{Slot:5b}] set from storage gui:pages ActualPage[{Slot:5b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 5
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:6b}] if data storage gui:pages TempPage[{Slot:6b}] run data modify storage gui:pages TempPage[{Slot:6b}] set from storage gui:pages ActualPage[{Slot:6b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 6
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:7b}] if data storage gui:pages TempPage[{Slot:7b}] run data modify storage gui:pages TempPage[{Slot:7b}] set from storage gui:pages ActualPage[{Slot:7b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 7
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:8b}] if data storage gui:pages TempPage[{Slot:8b}] run data modify storage gui:pages TempPage[{Slot:8b}] set from storage gui:pages ActualPage[{Slot:8b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 8
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:9b}] if data storage gui:pages TempPage[{Slot:9b}] run data modify storage gui:pages TempPage[{Slot:9b}] set from storage gui:pages ActualPage[{Slot:9b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 9
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:10b}] if data storage gui:pages TempPage[{Slot:10b}] run data modify storage gui:pages TempPage[{Slot:10b}] set from storage gui:pages ActualPage[{Slot:10b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 10
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:11b}] if data storage gui:pages TempPage[{Slot:11b}] run data modify storage gui:pages TempPage[{Slot:11b}] set from storage gui:pages ActualPage[{Slot:11b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 11
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:12b}] if data storage gui:pages TempPage[{Slot:12b}] run data modify storage gui:pages TempPage[{Slot:12b}] set from storage gui:pages ActualPage[{Slot:12b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 12
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:13b}] if data storage gui:pages TempPage[{Slot:13b}] run data modify storage gui:pages TempPage[{Slot:13b}] set from storage gui:pages ActualPage[{Slot:13b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 13
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:14b}] if data storage gui:pages TempPage[{Slot:14b}] run data modify storage gui:pages TempPage[{Slot:14b}] set from storage gui:pages ActualPage[{Slot:14b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 14
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:15b}] if data storage gui:pages TempPage[{Slot:15b}] run data modify storage gui:pages TempPage[{Slot:15b}] set from storage gui:pages ActualPage[{Slot:15b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 15
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:16b}] if data storage gui:pages TempPage[{Slot:16b}] run data modify storage gui:pages TempPage[{Slot:16b}] set from storage gui:pages ActualPage[{Slot:16b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 16
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:17b}] if data storage gui:pages TempPage[{Slot:17b}] run data modify storage gui:pages TempPage[{Slot:17b}] set from storage gui:pages ActualPage[{Slot:17b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 17
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:18b}] if data storage gui:pages TempPage[{Slot:18b}] run data modify storage gui:pages TempPage[{Slot:18b}] set from storage gui:pages ActualPage[{Slot:18b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 18
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:19b}] if data storage gui:pages TempPage[{Slot:19b}] run data modify storage gui:pages TempPage[{Slot:19b}] set from storage gui:pages ActualPage[{Slot:19b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 19
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:20b}] if data storage gui:pages TempPage[{Slot:20b}] run data modify storage gui:pages TempPage[{Slot:20b}] set from storage gui:pages ActualPage[{Slot:20b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 20
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:21b}] if data storage gui:pages TempPage[{Slot:21b}] run data modify storage gui:pages TempPage[{Slot:21b}] set from storage gui:pages ActualPage[{Slot:21b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 21
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:22b}] if data storage gui:pages TempPage[{Slot:22b}] run data modify storage gui:pages TempPage[{Slot:22b}] set from storage gui:pages ActualPage[{Slot:22b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 22
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:23b}] if data storage gui:pages TempPage[{Slot:23b}] run data modify storage gui:pages TempPage[{Slot:23b}] set from storage gui:pages ActualPage[{Slot:23b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 23
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:24b}] if data storage gui:pages TempPage[{Slot:24b}] run data modify storage gui:pages TempPage[{Slot:24b}] set from storage gui:pages ActualPage[{Slot:24b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 24
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:25b}] if data storage gui:pages TempPage[{Slot:25b}] run data modify storage gui:pages TempPage[{Slot:25b}] set from storage gui:pages ActualPage[{Slot:25b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 25
execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:26b}] if data storage gui:pages TempPage[{Slot:26b}] run data modify storage gui:pages TempPage[{Slot:26b}] set from storage gui:pages ActualPage[{Slot:26b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant 26