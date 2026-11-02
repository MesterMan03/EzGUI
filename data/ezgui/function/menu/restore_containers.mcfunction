# AS player — put the current page's snapshot back into the container (if it had one).
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
$execute as @e[tag=ezgui.cont,tag=ezgui.p$(pid)] run data modify entity @s Items set value []
$execute if data storage ezgui:state players.p$(pid).items.p$(page) as @e[tag=ezgui.cont,tag=ezgui.p$(pid)] run data modify entity @s Items set from storage ezgui:state players.p$(pid).items.p$(page)
