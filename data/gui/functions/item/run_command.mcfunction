# Executes as: player, at: gui(!)
# The gui (if you need to access it): @e[tag=selectedgui,limit=1]
# If you run a returnitem command, the full nbt for the item: storage gui:pages TempItem
# Example command to get its data: data get storage gui:pages TempItem
# Remember: click types all have different command ids, but you can assign multiple click types to one item!
# Basic command: execute if score #command_to_run constant matches x run **anything you want here**

#-# my commands used to test the pack
execute if score #TEST_MODE constant matches 1 run function gui:item/run_command_test
#-#

# Stop click detection from continuing
data remove storage gui:pages ActualItem
kill @e[tag=itemcheck]