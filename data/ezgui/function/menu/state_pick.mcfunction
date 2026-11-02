# AS player — resolve which state of ctx.w applies into ctx.s.
#
# The kind comes from the widget's own markers (copied into ctx by load_w), never from
# "does it have a score?" — a counter, cycle or radio is driven by a score too, and
# treating those as toggles made every one of them render its ON/OFF pair.
# Every branch is a separate call, so the scores it reads are already fresh.
scoreboard players set #s ezgui.tmp 0
execute if data storage ezgui:ctx score run function ezgui:menu/st_read with storage ezgui:ctx
execute if data storage ezgui:ctx k_toggle run function ezgui:menu/st_toggle
execute if data storage ezgui:ctx k_cycle run function ezgui:menu/st_cycle
execute if data storage ezgui:ctx k_radio run function ezgui:menu/st_radio
execute if data storage ezgui:ctx k_indicator run function ezgui:menu/st_indicator_reset
execute if data storage ezgui:ctx k_progress run function ezgui:menu/st_progress with storage ezgui:ctx
execute store result storage ezgui:ctx s int 1 run scoreboard players get #s ezgui.tmp
