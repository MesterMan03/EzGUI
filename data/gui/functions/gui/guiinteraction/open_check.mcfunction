# Check for the sus
tag @s add selectedplayer
execute as @e[tag=gui,limit=1,sort=nearest] if entity @s[tag=openedGUI] as @a[tag=selectedplayer] run function gui:gui/guiinteraction/impostor
execute as @e[tag=gui,limit=1,sort=nearest] unless entity @s[tag=openedGUI] as @a[tag=selectedplayer] run function gui:gui/guiinteraction/open
tag @s remove selectedplayer