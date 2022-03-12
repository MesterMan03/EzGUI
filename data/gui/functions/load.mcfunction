scoreboard objectives add constant dummy
scoreboard objectives add id dummy
scoreboard objectives add openedGUIid dummy

scoreboard objectives add guiType dummy
scoreboard objectives add guiPage dummy

scoreboard objectives add hitdelay dummy

scoreboard objectives add openeditor trigger
scoreboard objectives add leftclick trigger
scoreboard objectives add rightclick trigger
scoreboard objectives add shiftclick trigger
scoreboard objectives add returnclick trigger
scoreboard objectives add dropclick trigger
scoreboard objectives add dropstackclick trigger
scoreboard objectives add anyclick trigger
scoreboard objectives add fclick trigger

data merge storage gui:editor {Void:{}}

function gui:reset_scores_tags
function gui:reset_triggers

team add nopush
team modify nopush collisionRule never

kill @e[tag=editormarker]

execute as @e[tag=gui] run function gui:gui/guiinteraction/close_clear

execute at @e[tag=editorchest] if block ~ ~ ~ chest if data block ~ ~ ~ CustomName run setblock ~ ~ ~ air
kill @e[tag=editorchest]

execute as @a[gamemode=creative] run function gui:welcome_message