# generated using python
data modify storage gui:pages TempItem set from entity @e[tag=selectedgui,limit=1] Items[{Slot:22b}]
data modify storage gui:pages ActualItem set from entity @e[tag=itemcheck,limit=1] Items[{Slot:22b}]
execute if data storage gui:pages TempItem unless data storage gui:pages TempItem.tag.GUIItem run function gui:item/return_item
execute if data storage gui:pages ActualItem run function gui:item/check_clicks_slot