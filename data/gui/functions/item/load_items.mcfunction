# Executes as: gui, itemcheck (used in the item check functions)
# Use this command if you want to add another page: 
# execute if score @e[tag=selectedgui,limit=1] guiType matches X if score @e[tag=selectedgui,limit=1] guiPage matches Y run data modify entity @s Items set from storage gui:pages Pages[{type:X,page:Y}].Items