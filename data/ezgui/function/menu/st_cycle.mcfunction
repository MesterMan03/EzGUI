# cycle: the score IS the option index; states 1..n hold options 0..n-1.
scoreboard players set #s ezgui.tmp 0
scoreboard players operation #s ezgui.tmp = #v ezgui.tmp
scoreboard players add #s ezgui.tmp 1
execute store result score #n ezgui.tmp run data get storage ezgui:ctx w.e
scoreboard players remove #n ezgui.tmp 1
execute if score #s ezgui.tmp > #n ezgui.tmp run scoreboard players operation #s ezgui.tmp = #n ezgui.tmp
