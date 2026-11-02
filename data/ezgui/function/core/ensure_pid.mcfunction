# Give the executing player a permanent id the first time they use EzGUI. Entity
# containers are bound to this number, so every player owns their own menu.
execute unless score @s ezgui.pid matches 1.. run scoreboard players add #next ezgui.pid 1
execute unless score @s ezgui.pid matches 1.. run scoreboard players operation @s ezgui.pid = #next ezgui.pid
execute unless score @s ezgui.session matches 0.. run scoreboard players set @s ezgui.session 0
