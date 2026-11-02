# AS player — enter ezgui.page: restore its snapshot, run its hook, repaint.
function ezgui:menu/restore_containers with storage ezgui:ctx
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
data modify storage ezgui:ctx hook set from storage ezgui:ctx on_enter
execute if data storage ezgui:ctx on_enter run function ezgui:menu/on_enter with storage ezgui:ctx
scoreboard players set #lo ezgui.tmp 0
execute store result storage ezgui:ctx lo int 1 run scoreboard players get #lo ezgui.tmp
function ezgui:menu/draw with storage ezgui:ctx
# entering a page re-arms the auto-close timer
data modify storage ezgui:ctx timer set from storage ezgui:ctx def.timer
function ezgui:menu/page_arm with storage ezgui:ctx
