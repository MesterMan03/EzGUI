function gui:tellraw_line
tellraw @s {"text": "How to use the GUI Editor:","color": "green"}
tellraw @s {"text": "1. Get yourself any item (if you want, you can use the /give command to give it some extra NBT, like custom name, lore or anything really), when you select it in your hand it will automatically get every necessary NBT tag","color":"gray"}
tellraw @s {"text": "2. Hold the item in your hand, then type /trigger set rightclick/leftclick/shiftclick set <command_id> to set the command id","color": "gray"}
tellraw @s {"text": "3. Put it in the chest where you want it to be","color":"gray"}
tellraw @s {"text": "Make sure to update the gui:guiitems tag with every item you used!","color": "red"}
tellraw @s {"text": "When you are done, run /function gui:editor/done","color": "gold","clickEvent": {"action": "suggest_command","value": "/function gui:editor/done"}}
function gui:tellraw_line