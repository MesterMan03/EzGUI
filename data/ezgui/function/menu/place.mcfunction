# AS player — draw ONE cell of ctx.w at absolute slot ctx.slot.
#   1. lock the slot with the menu floor, so an empty slot can never be used
#   2. state_pick resolves which of w.e[] applies into ctx.s
#   3. prep copies that state into flat macro keys, emit writes the item
# Rule that shapes this file: a macro variable is substituted ONCE, when the
# function is called, so nothing that is printed may be computed in the same call.
#
# #lo = 1 asks for a PARTIAL refresh: only cells whose text is live (a score shown in
# the name or lore) are rewritten. Static cells keep the exact stack the client already
# has, which is what keeps a real player's click from being swallowed by a resync.
execute store result score #lo ezgui.tmp run data get storage ezgui:ctx lo
execute unless data storage ezgui:ctx w.e run return 0
function ezgui:menu/state_pick with storage ezgui:ctx
function ezgui:menu/emit_prep with storage ezgui:ctx
# A partial pass skips cells that cannot have changed: no live text and only one state
# (a plain button). Anything with several states (toggle, cycle, radio, indicator,
# progress) is repainted, because its look follows a score.
execute if score #lo ezgui.tmp matches 1 unless data storage ezgui:ctx live unless data storage ezgui:ctx k_stateful run return 0
$item replace $(target) container.$(slot) with $(floor)
function ezgui:menu/emit with storage ezgui:ctx
