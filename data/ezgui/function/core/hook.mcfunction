# AS player — call ctx.hook and expose its return value in #r (1 = pass).
scoreboard players set #r ezgui.tmp 0
$execute store result score #r ezgui.tmp run function $(hook) with storage ezgui:ctx
