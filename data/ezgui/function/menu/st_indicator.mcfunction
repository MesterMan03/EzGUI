# indicator: the first state whose "matches" range holds the score wins (0 = fallback).
scoreboard players set #s ezgui.tmp 0
scoreboard players set #k ezgui.tmp 0
execute store result storage ezgui:ctx n int 1 run data get storage ezgui:ctx w.e
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
function ezgui:menu/st_indicator_loop with storage ezgui:ctx
