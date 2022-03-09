# executes as, at: player
# executes when player threw an item out of the GUI
# item: @e[tag=threwitem]
# if you want to access the item in a better way: storage gui:pages ActualItem

# if we throw a whole stack, there won't be TempItem
execute unless data storage gui:pages SlotItem run function gui:item/clicks/dropstack

# otherwise (it's noted, that it will act like the right click bug: if we only have one item, throwing will act like we threw a stack)
execute if data storage gui:pages SlotItem run function gui:item/clicks/drop

# post-reset
data remove storage gui:pages ActualItem
data remove storage gui:pages SlotItem
kill @e[tag=threwitem]
kill @e[tag=itemcheck]