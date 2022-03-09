function gui:tellraw_line
tellraw @s [{"text": "Current version:","color": "aqua"}," ",{"text": "1.3","color": "green"},"\n"]

#1.3
tellraw @s {"text": "1.3","color": "gold"}
tellraw @s ["- ",{"text": "Even more optimizations:","color": "dark_green"}," ",{"text": "optimized the tick function by another 10 commands!","color": "gray"}]
tellraw @s ["- ",{"text": "Bug fixes:","color": "dark_green"}," ",{"text": "fixed a nasty bug I'm too embarrased to tell.","color": "gray"}]
tellraw @s ["- ",{"text": "Added \"any\" clicks:","color": "dark_green"}," ",{"text": "they fire when... uhm.. when a player does anything really...","color": "gray"}]
tellraw @s ["- ",{"text": "Added F clicks:","color": "dark_green"}," ",{"text": "they fire when a player presses the \"F\" button on an item (essentially swapping the item to their offhand slot.","color": "gray"}]
tellraw @s ["- ",{"text": "Warning: the item from the player's offhand does get deleted, but because of a weird Minecraft bug, the item stays there.","color": "red","extra": [" ",{"text": "Note however, that this is a completely visual bug, and just \"overwriting\" the offhand slot with a different item makes the ghost item go away.","underlined": true}]}]

tellraw @s ""

#1.2
tellraw @s {"text": "1.2","color": "gold"}
tellraw @s ["- ",{"text": "Added drop clicks:","color": "dark_green"}," ",{"text": "they fire when the player throws out either one item or the whole stack.","color": "gray"}]
tellraw @s ["- ",{"text": "Completely rewrote the click detection functions:","color": "dark_green"}," ",{"text": "the logic is still somewhat the same, but it's way, WAY more optimized now!","color": "gray"}]
tellraw @s ["- ",{"text": "Lot of bug fixes:","color": "dark_green"}," ",{"text": "you don't have to think about big bugs, just literally a debug function I left in the code... (plus other good stuff :p)","color": "gray"}]

tellraw @s ""

#1.1.1 Multiplayer
tellraw @s {"text": "1.1.1 Multiplayer","color": "gold"}
tellraw @s ["- ",{"text": "Added better multiplayer support:","color": "dark_green"}," ",{"text": "less bugs, less glitches, better user experience!","color": "gray"}]
tellraw @s ["- ",{"text": "Added impostor detection:","color": "dark_green"}," ",{"text": "now players can't access other player's gui!","color": "gray"}]

tellraw @s ""

#1.1
tellraw @s {"text": "1.1","color": "gold"}
tellraw @s ["- ",{"text": "Added return clicks:","color": "dark_green"}," ",{"text": "now you can make commands which will trigger when a player puts any item in a gui slot.","color": "gray"}]
tellraw @s ["- ",{"text": "Added item loss prevention:","color": "dark_green"}," ",{"text": "now when you put any item in the gui, it won't get lost, you will get it back instead. It can also run commands as mentioned earlier.","color": "gray"}]
tellraw @s ["- ",{"text": "Changed the click check functions:","color": "dark_green"}," ",{"text": "they are now much more human readable and optimized! :D","color": "gray"}]
tellraw @s ["- ",{"text": "Added every item id from 1.18.2 into gui:guiitems:","color": "dark_green"}," ",{"text": "now you don't have to mess with that file, but it might show compatibility errors with older versions (1.16 for example)","color": "gray"}]

function gui:tellraw_line