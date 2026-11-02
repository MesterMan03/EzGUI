# AS player — copy every hook/timer key the later macro calls print into flat keys.
data modify storage ezgui:ctx hook set from storage ezgui:ctx on_open
data modify storage ezgui:ctx timer set from storage ezgui:ctx def.timer
data modify storage ezgui:ctx start_page set from storage ezgui:ctx def.start_page
data modify storage ezgui:ctx on_enter set from storage ezgui:ctx page_def.on_enter
data modify storage ezgui:ctx on_leave set from storage ezgui:ctx page_def.on_leave
