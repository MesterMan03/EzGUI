# One slot -> one widget, but only below the toolbar row. The captured stack is kept
# verbatim (id + full components) so name, lore and custom data survive untouched.
execute store result score #slot ezgui.tmp run data get storage ezgui:ctx it.Slot
execute if score #slot ezgui.tmp matches 18.. run function ezgui:editor/capture_next
data modify storage ezgui:ctx w2 set value {locked:1b,e:[{}],act:[]}
data modify storage ezgui:ctx w2.slot set from storage ezgui:ctx it.Slot
data modify storage ezgui:ctx w2.id set from storage ezgui:ctx it.id
data modify storage ezgui:ctx w2.e[0].id set from storage ezgui:ctx it.id
data modify storage ezgui:ctx w2.e[0].raw set from storage ezgui:ctx it
$data modify storage ezgui:defs menus.$(mid).pages[$(page)].widgets append from storage ezgui:ctx w2
scoreboard players add #g ezgui.tmp 1
function ezgui:editor/capture_next
