function gui:tellraw_line
tellraw @s [{"text": "Current version:","color": "aqua"}," ",{"text": "1.1","color": "green"},"\n"]

#1.1
tellraw @s {"text": "1.1","color": "gold"}
tellraw @s ["- ",{"text": "Added return clicks:","color": "dark_green"}," ",{"text": "now you can make commands which will trigger when a player puts any item in a gui slot.","color": "gray"}]
tellraw @s ["- ",{"text": "Added item loss prevention:","color": "dark_green"}," ",{"text": "now when you put any item in the gui, it won't get lost, you will get it back instead. It can also run commands as mentioned earlier.","color": "gray"}]
tellraw @s ["- ",{"text": "Changed the click check functions:","color": "dark_green"}," ",{"text": "they are now much more human readable and optimalized! :D","color": "gray"}]
tellraw @s ["- ",{"text": "Added every item id from 1.18.2 into gui:guiitems:","color": "dark_green"}," ",{"text": "now you don't have to mess with that file, but it might show compatibility errors with older versions (1.16 for example)","color": "gray"}]

function gui:tellraw_line