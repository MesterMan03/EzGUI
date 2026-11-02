# AS player — snapshot the current container into this player's page state before a
# page change or close. Keyed by pid+page, so free-form containers survive page flips.
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
$execute as @e[tag=ezgui.cont,tag=ezgui.p$(pid)] run function ezgui:core/strip
$data remove storage ezgui:state players.p$(pid).items.p$(page)
$execute as @e[tag=ezgui.cont,tag=ezgui.p$(pid)] run data modify storage ezgui:state players.p$(pid).items.p$(page) set from entity @s Items
