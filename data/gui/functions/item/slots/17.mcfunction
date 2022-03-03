# generated using python
data modify storage gui:pages TempItem set from entity @e[tag=selectedgui,limit=1] Items[{Slot:17b}]
data modify storage gui:pages ActualItem set from entity @e[tag=itemcheck,limit=1] Items[{Slot:17b}]
execute positioned ~ ~1.31 ~ run tag @e[type=item,distance=..01,limit=1,nbt={Item:{tag:{GUIItem:1b}}}] add threwitem
execute if entity @e[tag=threwitem] run function gui:item/threw_item
execute if data storage gui:pages TempItem unless data storage gui:pages TempItem.tag.GUIItem run function gui:item/return_item
execute if data storage gui:pages ActualItem run function gui:item/check_clicks_slot