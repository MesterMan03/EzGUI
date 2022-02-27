# Backup
data modify storage gui:editor BackupPages set from storage gui:pages Pages

# Copy the Editor items to FinalItems
execute at @e[tag=editorchest,limit=1] run data modify storage gui:editor FinalItems set from block ~ ~ ~ Items

function gui:tellraw_line
tellraw @s {"text": "Click on the messages in order to copy commands into your chat, then edit the X and Y values to whatever you want","color": "aqua"}
tellraw @s {"text": "1. Command","color": "gray","clickEvent": {"action": "suggest_command","value": "/data modify storage gui:pages Pages append value {type:X,page:Y}"}}
tellraw @s {"text": "2. Command","color": "gray","clickEvent": {"action": "suggest_command","value": "/data modify storage gui:pages Pages[{type:X,page:Y}].Items set from storage gui:editor FinalItems"}}
tellraw @s {"text": "If you mess up, feel free to continue, then open the menu again and select \"[Restore Backup]\"","color": "red"}
tellraw @s [{"text": "If you are finished,","color": "gui"}," ",{"text": "click here","underlined": true,"color": "aqua","clickEvent": {"action": "run_command","value": "/function gui:editor/done_final"}}]
function gui:tellraw_line