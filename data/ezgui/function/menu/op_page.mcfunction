# Page change: snapshot the current container, then enter the new page.
execute store result score #p ezgui.tmp run data get storage ezgui:ctx op.page
execute unless score #p ezgui.tmp matches 0.. run return 0
function ezgui:menu/save_containers with storage ezgui:ctx
execute store result storage ezgui:ctx dest int 1 run scoreboard players get #p ezgui.tmp
$scoreboard players set @s ezgui.page $(dest)
function ezgui:menu/page_load
