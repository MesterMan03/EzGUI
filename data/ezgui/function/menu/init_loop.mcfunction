# k indexes def.init (1-based NBT list); each entry is copied flat, then used.
execute store result score #c ezgui.tmp run data get storage ezgui:ctx def.init
execute if score #k ezgui.tmp > #c ezgui.tmp run return 1
$data modify storage ezgui:ctx initscore set from storage ezgui:ctx def.init[$(k)]
function ezgui:menu/init_one with storage ezgui:ctx
scoreboard players add #k ezgui.tmp 1
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
function ezgui:menu/init_loop with storage ezgui:ctx
