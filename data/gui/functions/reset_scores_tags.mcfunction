scoreboard players reset @e id
scoreboard players reset @a openedGUIid

scoreboard players reset @a openeditor
scoreboard players reset @a leftclick
scoreboard players reset @a rightclick
scoreboard players reset @a shiftclick

scoreboard players set #curr_id id 0
scoreboard players set #can_check_clicks constant 0

scoreboard players set @a hitdelay 0

tag @e remove openedGUI
tag @a remove editoropen