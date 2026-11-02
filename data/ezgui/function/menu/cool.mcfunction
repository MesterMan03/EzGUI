# Cooldown gate. The score is armed only AFTER condition + cost passed, so a failed
# gate never starts a cooldown.
execute store result score #c ezgui.tmp run data get storage ezgui:ctx w.cool
execute if score #c ezgui.tmp matches ..0 run return 0
$execute store result score #v ezgui.tmp run scoreboard players get @s $(coolscore)
execute if score #v ezgui.tmp matches 1.. run tellraw @s [{"text":"[EzGUI] ","color":"aqua"},{"text":"Please wait...","color":"red"}]
execute if score #v ezgui.tmp matches 1.. run scoreboard players set #ok ezgui.tmp 0
execute if score #v ezgui.tmp matches 1.. run return 0
function ezgui:menu/cool_arm with storage ezgui:ctx
