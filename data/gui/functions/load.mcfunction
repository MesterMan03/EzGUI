scoreboard objectives add constant dummy
scoreboard objectives add id dummy
scoreboard objectives add openedGUIid dummy

scoreboard objectives add guiType dummy
scoreboard objectives add guiPage dummy

scoreboard objectives add openeditor trigger
scoreboard objectives add leftclick trigger
scoreboard objectives add rightclick trigger
scoreboard objectives add shiftclick trigger

function gui:reset_all

# Set the tick delay between old gui teleports here
scoreboard players set #teleport_delay constant 3

team add nopush
team modify nopush collisionRule never

kill @e[tag=raycast]
kill @e[tag=editormarker]

execute at @e[tag=editorchest] if block ~ ~ ~ chest if data block ~ ~ ~ CustomName run setblock ~ ~ ~ air
kill @e[tag=editorchest]

execute as @a[gamemode=creative] run function gui:welcome_message