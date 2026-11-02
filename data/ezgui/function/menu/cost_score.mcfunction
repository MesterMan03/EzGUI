# Score cost check.
$execute store result score #t ezgui.amount run scoreboard players get @s $(cs)
execute if score #t ezgui.amount >= #need ezgui.tmp run return 0
scoreboard players set #ok ezgui.tmp 0
