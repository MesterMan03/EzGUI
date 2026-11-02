# Item cost check: clear ... 0 counts without removing anything.
$execute store result score #t ezgui.amount run clear @s $(ci) 0
execute if score #t ezgui.amount >= #need ezgui.tmp run return 0
scoreboard players set #ok ezgui.tmp 0
data modify storage ezgui:ctx fail set from storage ezgui:ctx cost[0].fail
