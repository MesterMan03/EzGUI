# AS player — repaint the whole open page. Widgets are a list in the definition and are
# walked by ONE macro loop: adding widgets never adds a generated command.
# ctx.lo selects the mode: 0 = full repaint (page change, click handled, editor edit),
# 1 = live-text-only refresh (the once-a-second counter refresh).
function ezgui:menu/target with storage ezgui:ctx
scoreboard players set #i ezgui.tmp 0
execute store result storage ezgui:ctx i int 1 run scoreboard players get #i ezgui.tmp
execute store result score #n ezgui.tmp run data get storage ezgui:ctx page_def.widgets
execute if score #n ezgui.tmp matches 1.. run function ezgui:menu/draw_loop with storage ezgui:ctx
