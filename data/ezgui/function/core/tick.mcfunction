# EzGUI core tick — runs once per game tick (data/minecraft/tags/function/tick.json).
execute as @a[scores={ezgui.timer=1..}] run scoreboard players remove @s ezgui.timer 1
execute as @a[scores={ezgui.timer=0}] at @s run function ezgui:menu/close with storage ezgui:ctx

scoreboard players enable @a ezgui.open
scoreboard players enable @a ezgui.close
scoreboard players enable @a ezgui.last
scoreboard players enable @a ezgui.save
execute as @a[scores={ezgui.open=1..}] at @s run function ezgui:api/open_trigger
execute as @a[scores={ezgui.close=1..}] at @s run function ezgui:api/close_trigger
execute as @a[scores={ezgui.last=1..}] at @s run function ezgui:api/last_trigger with storage ezgui:ctx
execute as @a[scores={ezgui.save=1..}] at @s run function ezgui:api/save_trigger
scoreboard players set @a[scores={ezgui.open=1..}] ezgui.open 0
scoreboard players set @a[scores={ezgui.close=1..}] ezgui.close 0
scoreboard players set @a[scores={ezgui.last=1..}] ezgui.last 0
scoreboard players set @a[scores={ezgui.save=1..}] ezgui.save 0

execute as @a[scores={ezgui.timer=1..}] at @s run function ezgui:core/seed
execute as @a[scores={ezgui.timer=1..}] at @s run function ezgui:menu/player_tick

# Widget items that were thrown out of a menu are cleaned up every tick.
execute as @e[type=minecraft:item,tag=ezgui.dropped] run function ezgui:menu/drop
