# generated using python
data modify storage gui:pages SlotItem set from entity @e[tag=selectedgui,limit=1] Items[{Slot:7b}]
data modify storage gui:pages ActualItem set from entity @e[tag=itemcheck,limit=1] Items[{Slot:7b}]
execute if data storage gui:pages SlotItem unless data storage gui:pages SlotItem.tag.GUIItem run function gui:item/return_item
execute if data storage gui:pages ActualItem run function gui:item/slots/final