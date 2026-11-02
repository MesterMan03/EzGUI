# EzGUI core load — objectives, storage bootstrap, /reload recovery.
scoreboard objectives add ezgui.pid dummy
scoreboard objectives add ezgui.mid dummy
scoreboard objectives add ezgui.page dummy
scoreboard objectives add ezgui.timer dummy
scoreboard objectives add ezgui.click dummy
scoreboard objectives add ezgui.session dummy
scoreboard objectives add ezgui.tmp dummy
scoreboard objectives add ezgui.amount dummy
scoreboard objectives add ezgui.rand dummy
scoreboard objectives add ezgui.last_session dummy
scoreboard objectives add ezgui.open trigger
scoreboard objectives add ezgui.close trigger
scoreboard objectives add ezgui.last trigger
scoreboard objectives add ezgui.save trigger

scoreboard players set #t ezgui.tmp 0

team add ezgui.nopush
team modify ezgui.nopush collisionRule never

data merge storage ezgui:defs {menus:{}}
data merge storage ezgui:state {players:{}}
data merge storage ezgui:api {default:0}
data merge storage ezgui:ctx {pid:0,mid:0,page:0,session:0,ok:1}
# ezgui:ctx seed — the macro argument surface is created on first use (see core/ctx)
# # string defaults
# data modify storage ezgui:ctx container set value ""
# data modify storage ezgui:ctx y set value "1"
# data modify storage ezgui:ctx block set value ""
# data modify storage ezgui:ctx kiosk_state set value ""
# data modify storage ezgui:ctx floor set value ""
# data modify storage ezgui:ctx target set value ""
# data modify storage ezgui:ctx id set value ""
# data modify storage ezgui:ctx comp set value ""
# data modify storage ezgui:ctx raw set value ""
# data modify storage ezgui:ctx live set value ""
# data modify storage ezgui:ctx mod set value ""
# data modify storage ezgui:ctx probe set value ""
# data modify storage ezgui:ctx sound set value ""
# data modify storage ezgui:ctx hook set value ""
# data modify storage ezgui:ctx url set value ""
# data modify storage ezgui:ctx label set value ""
# data modify storage ezgui:ctx msg set value ""
# data modify storage ezgui:ctx initscore set value ""
# data modify storage ezgui:ctx sname set value ""
# data modify storage ezgui:ctx m set value ""
# data modify storage ezgui:ctx score set value ""
# data modify storage ezgui:ctx toggle set value ""
# data modify storage ezgui:ctx coolscore set value ""
# # numeric defaults
# data modify storage ezgui:ctx slot set value 0
# data modify storage ezgui:ctx i set value 0
# data modify storage ezgui:ctx g set value 0
# data modify storage ezgui:ctx k set value 0
# data modify storage ezgui:ctx s set value 0
# data modify storage ezgui:ctx cells set value 0
# data modify storage ezgui:ctx need set value 0
# data modify storage ezgui:ctx n set value 0
# data modify storage ezgui:ctx p set value 0
# data modify storage ezgui:ctx dest set value 0
# data modify storage ezgui:ctx bx set value 0
# data modify storage ezgui:ctx by set value 0
# data modify storage ezgui:ctx bz set value 0


# Menus left open across a reload are closed properly (on_close runs, widget items are
# swept, the container is dismantled) instead of leaving dangling state behind.
execute as @a[scores={ezgui.timer=1..}] at @s run function ezgui:menu/close with storage ezgui:ctx

# Orphaned containers are emptied before removal so nothing can ever drop on the floor.
execute as @e[tag=ezgui.cont] run data modify entity @s Items set value []
kill @e[tag=ezgui.cont]
execute as @e[type=minecraft:item,tag=ezgui.dropped] run data modify entity @s Item set value {id:"minecraft:air",count:1}
kill @e[type=minecraft:item,tag=ezgui.dropped]

# Widget items that survived in an inventory
execute as @a run function ezgui:core/sweep

scoreboard players enable @a ezgui.open
scoreboard players enable @a ezgui.close
scoreboard players enable @a ezgui.last
scoreboard players enable @a ezgui.save

tellraw @a [{"text":"[EzGUI] ","color":"aqua"},{"text":"loaded — /trigger ezgui.open","color":"gray"}]
