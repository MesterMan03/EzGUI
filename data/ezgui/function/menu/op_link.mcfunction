# Clickable URL. 1.21 uses click_event (clickEvent was removed in 1.21.5). The label
# falls back to the URL because both are prepared flat by act_loop.
execute unless data storage ezgui:ctx op.label run data modify storage ezgui:ctx label set from storage ezgui:ctx url
$tellraw @s [{"text":"[EzGUI] ","color":"aqua"},{"text":"$(label)","color":"aqua","underlined":true,"click_event":{"action":"open_url","url":"$(url)"}}]
