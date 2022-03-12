# executes as player, at: one block higher from player

# spawn gui
summon chest_minecart ~ ~ ~ {CustomDisplayTile:1b,DisplayState:{Name:"minecraft:air"},Tags:["gui","new"],NoGravity:1b,Silent:1b,Items:[{id:"minecraft:barrier",Slot:0b,Count:1b,tag:{GUIItem:1b,display:{Name:'{"text": "error :o","color": "red","bold": true,"italic": false}',Lore:['{"text": "This is a weird place, I don\'t think I\'m supposed to be here...","color": "gray"}']}}}]}

# Insert any type of gui-init commands here #

team join nopush @e[tag=new]
tag @e[tag=new] remove new