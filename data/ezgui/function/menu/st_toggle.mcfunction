# toggle: state 1 = on, state 0 = off (the score is a flag, not an index).
scoreboard players set #s ezgui.tmp 0
execute if score #v ezgui.tmp matches 1.. run scoreboard players set #s ezgui.tmp 1
