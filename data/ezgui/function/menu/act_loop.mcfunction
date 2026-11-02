# k walks the op list; an entry is any subset of the known op keys. Everything the op
# macros print is copied into flat keys here, BEFORE the op function is called.
execute store result score #c ezgui.tmp run data get storage ezgui:ctx act
execute if score #k ezgui.tmp >= #c ezgui.tmp run return 1
$data modify storage ezgui:ctx op set from storage ezgui:ctx act[$(k)]
execute if data storage ezgui:ctx op.score run data modify storage ezgui:ctx score set from storage ezgui:ctx op.score
execute if data storage ezgui:ctx op.toggle run data modify storage ezgui:ctx toggle set from storage ezgui:ctx op.toggle
execute if data storage ezgui:ctx op.sound run data modify storage ezgui:ctx sound set from storage ezgui:ctx op.sound
execute if data storage ezgui:ctx op.url run data modify storage ezgui:ctx url set from storage ezgui:ctx op.url
execute if data storage ezgui:ctx op.label run data modify storage ezgui:ctx label set from storage ezgui:ctx op.label
execute if data storage ezgui:ctx op.id run data modify storage ezgui:ctx id set from storage ezgui:ctx op.id
execute if data storage ezgui:ctx op.cmd run data modify storage ezgui:ctx cmd set from storage ezgui:ctx op.cmd
execute if data storage ezgui:ctx op.fn run data modify storage ezgui:ctx hook set from storage ezgui:ctx op.fn
execute if data storage ezgui:ctx op.msg run data modify storage ezgui:ctx msg set from storage ezgui:ctx op.msg
execute if data storage ezgui:ctx op.cmd run function ezgui:menu/op_cmd with storage ezgui:ctx
execute if data storage ezgui:ctx op.fn run function ezgui:menu/op_fn with storage ezgui:ctx
execute if data storage ezgui:ctx op.page run function ezgui:menu/op_page with storage ezgui:ctx
execute if data storage ezgui:ctx op.open run function ezgui:menu/op_open with storage ezgui:ctx
execute if data storage ezgui:ctx op.close run function ezgui:menu/op_close with storage ezgui:ctx
execute if data storage ezgui:ctx op.toggle run function ezgui:menu/op_toggle with storage ezgui:ctx
execute if data storage ezgui:ctx op.add run function ezgui:menu/op_add with storage ezgui:ctx
execute if data storage ezgui:ctx op.set run function ezgui:menu/op_set with storage ezgui:ctx
# a give op is emitted as id:<item>, so it is dispatched on op.id
execute if data storage ezgui:ctx op.id run function ezgui:menu/op_give with storage ezgui:ctx
execute if data storage ezgui:ctx op.sound run function ezgui:menu/op_sound with storage ezgui:ctx
execute if data storage ezgui:ctx op.msg run function ezgui:menu/op_msg with storage ezgui:ctx
execute if data storage ezgui:ctx op.url run function ezgui:menu/op_link with storage ezgui:ctx
execute if data storage ezgui:ctx op.draw run function ezgui:menu/draw with storage ezgui:ctx
scoreboard players add #k ezgui.tmp 1
execute store result storage ezgui:ctx k int 1 run scoreboard players get #k ezgui.tmp
function ezgui:menu/act_loop with storage ezgui:ctx
