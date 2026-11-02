# AS player — write the prepared cell. Each variant lives in its own function: a macro
# line whose argument is empty fails to instantiate, so only one is ever called.
execute if score #vraw ezgui.tmp matches 1 run function ezgui:menu/emit_raw with storage ezgui:ctx
execute if score #vraw ezgui.tmp matches 0 if score #vcomp ezgui.tmp matches 1 run function ezgui:menu/emit_comp with storage ezgui:ctx
execute if score #vraw ezgui.tmp matches 0 if score #vcomp ezgui.tmp matches 0 run function ezgui:menu/emit_bare with storage ezgui:ctx
execute if data storage ezgui:ctx live run function ezgui:menu/live with storage ezgui:ctx
