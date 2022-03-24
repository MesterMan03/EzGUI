# Executes as player
# I should honestly copyright this, this is a gold piece of Minecraft history

# Spawn itemcheck
execute positioned 0 0 0 run summon chest_minecart ~ ~ ~ {CustomDisplayTile:1b,DisplayState:{Name:"minecraft:air"},Tags:["itemcheck"],NoGravity:1b,Silent:1b}

# Load the items to itemcheck
execute as @e[tag=itemcheck] run function gui:item/load_items

# The click check should reset these, but just in case
data remove storage gui:pages SlotItem
data remove storage gui:pages ActualItem

# Start the m a g i c
# - precheck to see if anything has changed
scoreboard players set #can_check_clicks constant 0
data modify storage gui:pages ActualPage set from entity @e[tag=itemcheck,limit=1] Items
data modify storage gui:pages TempPage set from entity @e[tag=selectedgui,limit=1] Items
execute store success score #can_check_clicks constant run data modify storage gui:pages TempPage set from storage gui:pages ActualPage

# - the idea is that we first check if anything has changed, cutting down the number of functions to run by a lot
execute if score #can_check_clicks constant matches 1 run function gui:item/check_clicks_run

# - post-reset
data remove storage gui:pages ActualPage
data remove storage gui:pages TempPage

# Reset
kill @e[tag=itemcheck]