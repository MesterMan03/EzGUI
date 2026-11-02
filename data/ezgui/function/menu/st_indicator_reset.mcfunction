# An indicator widget has no threshold table: it is "on" whenever its score is not 0.
scoreboard players set #s ezgui.tmp 0
execute if score #v ezgui.tmp matches 1.. run scoreboard players set #s ezgui.tmp 1
