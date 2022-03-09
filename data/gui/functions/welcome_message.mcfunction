function gui:tellraw_line
tellraw @s {"text": "Welcome to EzGUI by Mester","color": "green","clickEvent": {"action": "open_url","value": "https://www.youtube.com/MesterMan03"},"hoverEvent": {"action": "show_text","contents": {"text": "Click on this message to check out Mester's YouTube channel"}}}
tellraw @s [{"text": "To get started, type:","color": "gray"}," ", {"text": "/trigger openeditor","color": "aqua","clickEvent": {"action": "suggest_command","value": "/trigger openeditor"}}]
tellraw @s {"text": "To have your GUI in the world, simply summon an armor stand with the \"base\" tag","color": "gray","clickEvent": {"action": "suggest_command","value": "/summon armor_stand ~ ~ ~ {Tags:[\"base\"],Invisible:1b,Invulnerable:1b}"}}
tellraw @s {"text": "Click here to see the awesome people who helped me make this datapack by giving me suggestions <3","color": "gold","clickEvent": {"action": "run_command","value": "/function gui:credits"}}
tellraw @s {"text": "Click here to check the change log! (it might contain some new features! :O)","color": "dark_green","clickEvent": {"action": "run_command","value": "/function gui:display_changelog"}}
function gui:tellraw_line