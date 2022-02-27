# Backup
data modify storage gui:editor BackupPages set from storage gui:pages Pages

function gui:tellraw_line
tellraw @s {"text": "Click on this message to copy the command into your chat, then edit the X and Y values","color": "aqua","clickEvent": {"action": "suggest_command","value": "/data remove storage gui:pages Pages[{type:X,page:Y}]"}}
tellraw @s {"text": "If you mess up, you can open the menu again and select \"[Restore Backup]\"","color": "red"}
function gui:tellraw_line