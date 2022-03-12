# ---------------------------------
# commands for item guis

# check if player is holding a gui spawner item
tag @a remove holdsguispawner
execute as @a[gamemode=!spectator,tag=!editoropen,scores={hitdelay=..0}] if data entity @s SelectedItem.tag.gui.guitype run tag @s add holdsguispawner

# spawn item gui if player doesn't have one
execute as @a[gamemode=!spectator,tag=holdsguispawner,nbt={OnGround:1b}] at @s positioned ~ ~1 ~ unless entity @e[tag=itemgui,distance=...001] run function gui:gui/spawn_itemgui

# assign type value for item gui
execute as @e[tag=itemgui] run function gui:gui/settype_itemgui

# kill new item gui if player has moved
execute as @e[tag=itemgui] at @s positioned ~ ~-1 ~ unless entity @a[distance=...001,tag=holdsguispawner] run function gui:gui/guiinteraction/close_clear

# ---------------------------------
# commands for base guis

# Check if player looks at base
tag @a remove seesbase
execute as @a[gamemode=!spectator,tag=!holdsguispawner,scores={hitdelay=..0}] at @s if predicate gui:seesbase run tag @s add seesbase

# Kills new guis if not good
execute as @e[tag=gui,tag=!itemgui,tag=!openedGUI] at @s positioned ~ ~-1 ~ unless entity @a[distance=...001,tag=seesbase,tag=!openedGUI] run function gui:gui/guiinteraction/close_clear

# Spawn gui
execute as @a[tag=!openedGUI,gamemode=!spectator,nbt={OnGround:1b},tag=seesbase] at @s positioned ~ ~1 ~ unless entity @e[tag=gui,tag=!itemgui,distance=...001] run function gui:gui/spawn_basegui

# Check if player left his GUI
execute as @a[tag=openedGUI,gamemode=!spectator,tag=!holdsguispawner,tag=!seesbase] run function gui:gui/guiinteraction/close_old

# ---------------------------------
# commands for both guis

# Check for players who opened the GUI + also check for impostors
execute as @a[tag=impostor] at @s rotated as @s run function gui:gui/guiinteraction/impostor_done
execute as @a[advancements={gui:opened_gui=true},gamemode=!spectator,tag=!openedGUI] at @s run function gui:gui/guiinteraction/open_check
advancement revoke @a only gui:opened_gui

# Assign default(!) page value
execute as @e[tag=gui,tag=openedGUI] unless score @s guiPage matches -2147483648..2147483647 run scoreboard players set @s guiPage 0

# remove hitdelay
execute as @a[scores={hitdelay=1..}] run scoreboard players remove @s hitdelay 1