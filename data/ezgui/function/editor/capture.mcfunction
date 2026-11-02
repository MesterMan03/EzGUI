# Turn the container's current contents into a *widget layout*: every filled slot
# becomes a locked display widget that copies the item the admin placed, which is
# exactly what a chest-editor should produce (layout first, actions attached after).
# The whole page is rewritten, so removed items disappear from the menu too.
$execute as @e[tag=ezgui.cont,tag=ezgui.p$(pid)] run function ezgui:core/strip
$data modify storage ezgui:defs menus.$(mid).pages[$(page)].widgets set value []
$execute as @e[tag=ezgui.cont,tag=ezgui.p$(pid)] run data modify storage ezgui:ctx items set from entity @s Items
scoreboard players set #i ezgui.tmp 0
scoreboard players set #g ezgui.tmp 0
function ezgui:editor/capture_loop with storage ezgui:ctx
$execute store result storage ezgui:defs menus.$(mid).pages[$(page)].n int 1 run scoreboard players get #g ezgui.tmp
tellraw @s [{"text":"[EzGUI] ","color":"aqua"},{"text":"Layout saved.","color":"green"}]
