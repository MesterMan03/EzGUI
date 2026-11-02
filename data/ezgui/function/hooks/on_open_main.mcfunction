# AS player — seed the shop currency the first time a player opens the hub.
execute unless score @s ezgui.coins matches -2147483648..2147483647 run scoreboard players set @s ezgui.coins 100
scoreboard objectives add ezgui.coins dummy
