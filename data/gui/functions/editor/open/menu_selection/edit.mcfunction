# Backup
data modify storage gui:editor BackupPages set from storage gui:pages Pages

# Edit type
scoreboard players set #editor_type constant 2

function gui:tellraw_line
tellraw @s {"text": "Click on this message to copy the command into your chat, then edit the X and Y values","color": "aqua","clickEvent": {"action": "suggest_command","value": "/data modify storage gui:editor EditingItems set from storage gui:pages Pages[{type:X,page:Y}].Items"}}
tellraw @s {"text": "If you mess up, you can open the menu again and select \"[Restore Backup]\"","color": "red"}
tellraw @s [{"text": "If you are finished,","color": "gui"}," ",{"text": "click here","underlined": true,"color": "aqua","clickEvent": {"action": "run_command","value": "/function gui:editor/open/ready_check"}}]
function gui:tellraw_line