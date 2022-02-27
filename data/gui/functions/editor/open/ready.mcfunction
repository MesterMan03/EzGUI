kill @e[tag=editormarker]
execute align xyz run summon armor_stand ~1.5 ~.5 ~.5 {Marker: 1b, Invisible: 1b, Tags: ["editormarker"]}

function gui:tellraw_line
tellraw @s {"text": "The white particles show you where your chest is going to be placed","color": "aqua"}
tellraw @s {"text": "If you are happy with it, click this button: ","color": "gray","extra": [{"text": "[Open Editor]", "color": "aqua","clickEvent": {"action": "run_command","value":"/function gui:editor/open/open_check"}}]}
tellraw @s {"text": "If you don't like that place, simply run","color": "red","clickEvent": {"action": "suggest_command","value": "/trigger openeditor"}, "hoverEvent": {"action": "show_text","contents": "click on this message to run the command"},"extra":[" ",{"text":"/trigger openeditor","color": "aqua"},"!"]}
function gui:tellraw_line