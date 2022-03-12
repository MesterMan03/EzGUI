# reset
data remove storage gui:editor commandid

# delete anyclick
execute if data entity @s SelectedItem.tag.gui.anyclick run item modify entity @s weapon.mainhand gui:editor/remove_clicks

# show errors
function gui:editor/show_errors

# Set the command id to gui:editor commandid
execute if score @s leftclick matches 1.. store result storage gui:editor commandid.leftclick int 1 run scoreboard players get @s leftclick
execute if score @s rightclick matches 1.. store result storage gui:editor commandid.rightclick int 1 run scoreboard players get @s rightclick
execute if score @s shiftclick matches 1.. store result storage gui:editor commandid.shiftclick int 1 run scoreboard players get @s shiftclick
execute if score @s returnclick matches 1.. store result storage gui:editor commandid.returnclick int 1 run scoreboard players get @s returnclick
execute if score @s dropclick matches 1.. store result storage gui:editor commandid.dropclick int 1 run scoreboard players get @s dropclick
execute if score @s dropstackclick matches 1.. store result storage gui:editor commandid.dropstackclick int 1 run scoreboard players get @s dropstackclick
execute if score @s fclick matches 1.. store result storage gui:editor commandid.fclick int 1 run scoreboard players get @s fclick

# delete everything else if anyclick is set
execute if score @s anyclick matches 1.. run item modify entity @s weapon.mainhand gui:editor/remove_clicks
execute if score @s anyclick matches 1.. store result storage gui:editor commandid.anyclick int 1 run scoreboard players get @s anyclick

# run the item modifier
item modify entity @s weapon.mainhand gui:editor/set_commandid

# special commands
execute if score @s returnclick matches -1 run function gui:editor/toggle_stealitem

# reset
function gui:reset_triggers