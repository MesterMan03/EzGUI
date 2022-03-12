function gui:tellraw_line
tellraw @s {"text": "How to use the GUI Editor:","color": "green"}
tellraw @s {"text": "1. Get yourself any item (if you want, you can use the /give command to give it some extra NBT, like custom name, lore or anything really). When you hold it in your hand it will automatically get every necessary NBT tag","color":"gray"}
tellraw @s {"text": "2. Hold the item in your hand, then type /trigger set rightclick/leftclick/shiftclick/returnclick/drop(stack)click/anyclick/fclick set <command_id> to set the command id","color": "gray"}
tellraw @s {"text": "3. Put the final item in the chest where you want it to be","color":"gray"}
tellraw @s {"text": "When you are done, run /function gui:editor/done","color": "aqua","clickEvent": {"action": "suggest_command","value": "/function gui:editor/done"}}
tellraw @s {"translate": "If you want to exit without saving your progress, run %s","color": "red","with":[{"text": "/function gui:editor/done_final","color": "aqua","clickEvent": {"action": "suggest_command","value": "/function gui:editor/done_final"}}]}

tellraw @s ""

tellraw @s {"text": "Special controls","color": "gold"}
tellraw @s {"text": "- To toggle steal item, hold an item and set returnclick to -1","color": "gold"}
function gui:tellraw_line