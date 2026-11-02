execute if score #s ezgui.tmp matches 1.. run return 1
execute store result score #c ezgui.tmp run data get storage ezgui:ctx n
execute if score #k ezgui.tmp >= #c ezgui.tmp run return 1
$data modify storage ezgui:ctx m set from storage ezgui:ctx w.e[$(k)].matches
function ezgui:menu/st_indicator_test with storage ezgui:ctx
scoreboard players add #k ezgui.tmp 1
function ezgui:menu/st_indicator_loop with storage ezgui:ctx
