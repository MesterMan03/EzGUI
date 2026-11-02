# AS player — run the op list of the clicked widget (ctx.w.act). One generic loop and
# one small file per op kind, so a menu never needs generated commands.
scoreboard players set #k ezgui.tmp 0
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
data modify storage ezgui:ctx score set from storage ezgui:ctx w.score
data modify storage ezgui:ctx act set from storage ezgui:ctx w.act
function ezgui:menu/act_loop with storage ezgui:ctx
