# AS player — seed every score this menu renders from (add 0 creates it if missing),
# so a widget never reads a missing score on the first open.
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
scoreboard players set #k ezgui.tmp 1
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
function ezgui:menu/init_loop with storage ezgui:ctx
