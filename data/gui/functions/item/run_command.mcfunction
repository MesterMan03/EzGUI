# Executes as: player, at: gui(!)
# The gui (if you need to access it): @e[tag=selectedgui,limit=1]

# If you run a returnitem command, the full nbt for the item: storage gui:pages SlotItem
# Example command to get its data: data get storage gui:pages SlotItem

# Basic command: execute if score #command_to_run constant matches x run **anything you want here**

execute if score #DEBUG_MODE constant matches 1 run say run command active

# check if #command_to_run is 0 (happens only when the item has anyclick enabled)
execute if score #command_to_run constant matches 0 store result score #command_to_run constant run data get storage gui:pages ActualItem.tag.gui.anyclick
execute if score #command_to_run constant matches 0 if score #DEBUG_MODE constant matches 1 run tellraw @a {"text": "No command ids set for this click type","color": "red"}

#-# my commands used to test the pack
execute if score #TEST_MODE constant matches 1 run function gui:item/run_command_test
#-#

# Stop click detection from continuing
data remove storage gui:pages ActualItem
kill @e[tag=itemcheck]

scoreboard players set #command_to_run constant 0