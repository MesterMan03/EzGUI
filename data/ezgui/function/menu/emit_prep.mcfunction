# AS player — flatten the selected state (ctx.s) into the flat keys emit prints.
$data modify storage ezgui:ctx e set from storage ezgui:ctx w.e[$(s)]
data modify storage ezgui:ctx id set from storage ezgui:ctx e.id
data modify storage ezgui:ctx comp set value ""
data remove storage ezgui:ctx live
data remove storage ezgui:ctx raw
execute if data storage ezgui:ctx e.c run data modify storage ezgui:ctx comp set from storage ezgui:ctx e.c
execute if data storage ezgui:ctx e.l run data modify storage ezgui:ctx live set from storage ezgui:ctx e.l
execute if data storage ezgui:ctx e.raw run data modify storage ezgui:ctx raw set from storage ezgui:ctx e.raw
# a verbatim stack (chest editor captures) wins over id + components
scoreboard players set #vraw ezgui.tmp 0
execute if data storage ezgui:ctx e.raw run scoreboard players set #vraw ezgui.tmp 1
execute store result storage ezgui:ctx vraw int 1 run scoreboard players get #vraw ezgui.tmp
scoreboard players set #vcomp ezgui.tmp 0
execute if data storage ezgui:ctx e.c run scoreboard players set #vcomp ezgui.tmp 1
