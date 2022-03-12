# Executes as: gui

# if it's an item gui
execute if entity @s[tag=itemgui] run function gui:gui/guiinteraction/close_itemgui

data modify entity @s Items set value []
kill @s