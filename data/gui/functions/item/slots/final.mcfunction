# we copy SlotItem to TempItem to not mess stuff up
data modify storage gui:pages TempItem set from storage gui:pages SlotItem

execute if score #DEBUG_MODE constant matches 1 run tellraw @a ["\nslot: ", {"nbt":"SlotItem","storage": "gui:pages"}, "\ntemp: ", {"nbt":"TempItem","storage": "gui:pages"},"\nactual: ", {"nbt":"ActualItem","storage": "gui:pages"}]

# we check if we can copy ActualItem to TempItem
# if yes, that means the slot has changed, so we can check if the player threw an item
execute store success score #changed_slot constant run data modify storage gui:pages TempItem set from storage gui:pages ActualItem
execute if score #changed_slot constant matches 1 positioned ~ ~1.31 ~ run tag @e[type=item,distance=..01,limit=1,nbt={Item:{tag:{GUIItem:1b}}}] add threwitem
execute if entity @e[tag=threwitem] run function gui:item/threw_item

# if ActualItem still exists (which would get removed by threw or return click), we continue with the click detection
execute if data storage gui:pages ActualItem run function gui:item/check_clicks_basic

# post reset
data remove storage gui:pages TempItem