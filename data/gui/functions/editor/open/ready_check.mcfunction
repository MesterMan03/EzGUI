execute if entity @s[tag=editoropen] run tellraw @s {"text": "I'm sorry, you're already in the editor","color": "red"}
execute unless entity @s[tag=editoropen] run function gui:editor/open/ready