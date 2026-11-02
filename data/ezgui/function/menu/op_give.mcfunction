# Give the item prepared in ctx.id (count from ctx.n, default 1).
execute store result score #n ezgui.tmp run data get storage ezgui:ctx op.n
execute if score #n ezgui.tmp matches ..0 run scoreboard players set #n ezgui.tmp 1
execute store result storage ezgui:ctx n int 1 run scoreboard players get #n ezgui.tmp
function ezgui:menu/give_it with storage ezgui:ctx
