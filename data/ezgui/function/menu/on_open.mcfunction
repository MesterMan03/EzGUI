# AS player — run the menu's on_open hook (ctx.hook prepared by init_keys).
$execute if function $(hook) with storage ezgui:ctx run return 0
