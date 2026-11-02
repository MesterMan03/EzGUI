# AS player — refresh the macro identity keys in ezgui:ctx.
#
# This runs inside every loop, so it only refreshes the four identity values and never
# touches the scratch keys: wiping them here would erase whatever the calling stage has
# just prepared. The full argument surface is seeded once per entry point by core/seed.
execute store result storage ezgui:ctx pid int 1 run scoreboard players get @s ezgui.pid
execute store result storage ezgui:ctx mid int 1 run scoreboard players get @s ezgui.mid
execute store result storage ezgui:ctx page int 1 run scoreboard players get @s ezgui.page
execute store result storage ezgui:ctx session int 1 run scoreboard players get @s ezgui.session
