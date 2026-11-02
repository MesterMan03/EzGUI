# progress: cell g is lit when score >= ceil((g+1) * max / cells). State 0 is the empty
# look, so a lit cell maps to state g+1.
execute store result score #max ezgui.tmp run data get storage ezgui:ctx w.max
execute store result score #cells ezgui.tmp run data get storage ezgui:ctx w.cells
execute if score #cells ezgui.tmp matches ..0 run scoreboard players set #cells ezgui.tmp 1
execute store result score #g ezgui.tmp run data get storage ezgui:ctx g
scoreboard players add #g ezgui.tmp 1
scoreboard players operation #g ezgui.tmp *= #max ezgui.tmp
scoreboard players operation #g ezgui.tmp /= #cells ezgui.tmp
scoreboard players set #s ezgui.tmp 0
execute unless score #v ezgui.tmp >= #g ezgui.tmp run return 0
scoreboard players operation #s ezgui.tmp = #g ezgui.tmp
execute if score #s ezgui.tmp > #cells ezgui.tmp run scoreboard players operation #s ezgui.tmp = #cells ezgui.tmp
