# Get the original and "real" count of the item for extra checks
execute store result score #original_count constant run data get storage gui:pages ActualItem.Count
execute store result score #real_count constant run data get storage gui:pages TempItem.Count

# Left click: no item in gui, and no item at player
# Unfixable bug: if there is only one of an item, right clicking will fire the left click detection
execute unless data storage gui:pages TempItem unless data entity @s Inventory[].tag.GUIItem run function gui:item/clicks/left

# Right click: item in gui, but not same amount
execute if data storage gui:pages TempItem unless score #original_count constant = #real_count constant unless score #real_count constant matches 0 run function gui:item/clicks/right

# Shift click: no item in gui, but at player
execute unless data storage gui:pages TempItem if data entity @s Inventory[].tag.GUIItem run function gui:item/clicks/shift

# Post-reset
data remove storage gui:pages TempItem
data remove storage gui:pages ActualItem