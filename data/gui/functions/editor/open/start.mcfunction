# Only one editor is allowed
execute if entity @a[tag=editoropen] run tellraw @s {"text": "I'm sorry, you can't have more than one editors at the same time","color": "red"}
execute unless entity @a[tag=editoropen] at @s run function gui:editor/open/menu