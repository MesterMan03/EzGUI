# Check for newly placed bases
execute as @e[type=armor_stand,tag=base] unless score @s id matches -2147483648..2147483647 run function gui:generatenewid

# Check if player looks at base
tag @a remove seesbase
execute as @a[gamemode=!spectator] at @s if predicate gui:seesbase run tag @s add seesbase

# Check if player left his GUI
execute as @a[tag=openedGUI,gamemode=!spectator] unless predicate gui:seesguielement run function gui:gui/guiinteraction/close_old

# Kills new guis if not good
execute as @e[type=chest_minecart,tag=gui,tag=!openedGUI] at @s positioned ~ ~-1 ~ unless entity @a[distance=...001,tag=seesbase,tag=!openedGUI] run function gui:gui/guiinteraction/close_clear

# Spawn gui
execute as @a[tag=!openedGUI,gamemode=!spectator,nbt={OnGround:1b},tag=seesbase] at @s positioned ~ ~1 ~ unless entity @e[type=chest_minecart,tag=gui,distance=...001] run summon chest_minecart ~ ~ ~ {CustomDisplayTile:1b,DisplayState:{Name:"minecraft:air"},Tags:["gui","new"],NoGravity:1b,Silent:1b,Items:[{id:"minecraft:barrier",Slot:0b,Count:1b,tag:{GUIItem:1b,display:{Name:'{"text": "error :o","color": "red","bold": true,"italic": false}',Lore:['{"text": "This is a weird place, I don\'t think I\'m supposed to be here...","color": "gray"}']}}}]}
# Insert any type of gui-init commands here #
team join nopush @e[tag=gui,tag=new]
tag @e[tag=gui,tag=new] remove new

# Check for players who opened the GUI + also check for impostors
execute as @a[tag=impostor] at @s rotated as @s run function gui:gui/guiinteraction/impostor_done
execute as @a[advancements={gui:opened_gui=true},gamemode=!spectator,tag=!openedGUI] at @s run function gui:gui/guiinteraction/open_check

# Assign type value
execute as @e[tag=gui,tag=openedGUI] at @s store result score @s guiType run scoreboard players get @e[tag=base,sort=nearest,limit=1] guiType

# Assign default(!) page value
execute as @e[tag=gui,tag=openedGUI] unless score @s guiPage matches -2147483648..2147483647 run scoreboard players set @s guiPage 0

# Teleport opened guis every set tick
scoreboard players add #teleport_tick constant 1
execute if score #teleport_tick constant >= #teleport_delay constant as @a[tag=openedGUI] at @s run function gui:gui/guiinteraction/teleport_old
execute if score #teleport_tick constant >= #teleport_delay constant run scoreboard players set #teleport_tick constant 0