# Backup
data modify storage gui:editor BackupPages set from storage gui:pages Pages

# Copy the Editor items to FinalItems
execute at @e[tag=editorchest] run data modify storage gui:editor FinalItems set from block ~ ~ ~ Items

function gui:tellraw_line
tellraw @s {"text": "Click on this message to copy the command into your chat, then edit the X and Y values","color": "aqua","clickEvent": {"action": "suggest_command","value": "/data modify storage gui:pages Pages[{type:X,page:Y}].Items set from storage gui:editor FinalItems"}}
tellraw @s {"text": "If you mess up, feel free to continue, then open the menu again and select \"[Restore Backup]\"","color": "red"}
tellraw @s [{"text": "If you are finished,","color": "gui"}," ",{"text": "click here","underlined": true,"color": "aqua","clickEvent": {"action": "run_command","value": "/function gui:editor/done_final"}}]
function gui:tellraw_line