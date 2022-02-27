function gui:tellraw_line
tellraw @s {"text": "Click on this message to restore the last backup","color": "aqua","clickEvent": {"action": "run_command","value": "/data modify storage gui:pages Pages set from storage gui:editor BackupPages"}}
function gui:tellraw_line