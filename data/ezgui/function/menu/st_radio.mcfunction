# radio: a shared score holds the selected value; only the matching widget lights up.
execute store result score #sel ezgui.tmp run data get storage ezgui:ctx w.value
scoreboard players set #s ezgui.tmp 0
execute if score #v ezgui.tmp = #sel ezgui.tmp run scoreboard players set #s ezgui.tmp 1
