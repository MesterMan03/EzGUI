# Walks the captured items and appends one widget per filled slot. The toolbar row
# (slot >= 18) is reserved: it belongs to the editor UI, never to the saved page.
execute store result score #c ezgui.tmp run data get storage ezgui:ctx items
execute if score #i ezgui.tmp >= #c ezgui.tmp run return 1
function ezgui:core/ctx
data remove storage ezgui:ctx it
$data modify storage ezgui:ctx it set from storage ezgui:ctx items[$(i)]
execute unless data storage ezgui:ctx it.id run function ezgui:editor/capture_next
execute if data storage ezgui:ctx it.id run function ezgui:editor/capture_one with storage ezgui:ctx
function ezgui:editor/capture_next
scoreboard players add #i ezgui.tmp 1
function ezgui:editor/capture_loop with storage ezgui:ctx
