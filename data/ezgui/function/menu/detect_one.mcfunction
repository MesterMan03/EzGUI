# AS player — is widget ctx.i still sitting in its slot?
#
# "Still there" means: the slot holds an item stamped by THIS pack for THIS widget
# (same menu, same page, same widget id). Nothing else is compared:
#   • the item TYPE is deliberately ignored — a toggle/progress widget redraws in a
#     different state when its score moves, and that is not a click;
#   • an item of another page or menu is ignored too, so a page transition can never be
#     mistaken for a click;
#   • a picked-up, shift-moved or thrown-out item leaves the slot empty of that stamp,
#     which is exactly what a click is.
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
data modify storage ezgui:ctx id set from storage ezgui:ctx w.id
execute store result storage ezgui:ctx cells int 1 run data get storage ezgui:ctx w.cells
execute unless data storage ezgui:ctx id run return 0
execute store result storage ezgui:ctx slot int 1 run data get storage ezgui:ctx w.slot
scoreboard players set #g ezgui.tmp 0
execute store result storage ezgui:ctx g int 1 run scoreboard players get #g ezgui.tmp
function ezgui:menu/detect_cell_loop with storage ezgui:ctx
