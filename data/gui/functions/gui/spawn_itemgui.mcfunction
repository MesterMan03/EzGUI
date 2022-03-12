# executes as player, at: one block higher from player

# spawn gui
summon chest_minecart ~ ~ ~ {CustomDisplayTile:1b,DisplayState:{Name:"minecraft:air"},Tags:["gui","new","itemgui"],NoGravity:1b,Silent:1b,Items:[{id:"minecraft:barrier",Slot:0b,Count:1b,tag:{GUIItem:1b,display:{Name:'{"text": "error :o","color": "red","bold": true,"italic": false}',Lore:['{"text": "This is a weird place, I don\'t think I\'m supposed to be here...","color": "gray"}']}}}]}

# check if player has a base gui and delete it
function gui:gui/guiinteraction/close_old

# reset player
tag @s remove openedGUI

# join gui to nopush
team join nopush @e[tag=new]

# reset
tag @e remove new