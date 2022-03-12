# completely delete every other click
data remove entity @e[tag=temp,limit=1] Item.tag.gui

# add the anyclick part
execute store result entity @e[tag=temp,limit=1] Item.tag.gui.anyclick int 1 run scoreboard players get @s anyclick