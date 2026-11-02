# AS player — flatten the active menu + page definition into the macro context.
# Needs ctx.mid / ctx.page / ctx.pid (run ezgui:core/ctx first, every loop does).
$data modify storage ezgui:ctx def set from storage ezgui:defs menus.$(mid)
$data modify storage ezgui:ctx page_def set from storage ezgui:defs menus.$(mid).pages[$(page)]
$data modify storage ezgui:ctx target set value "entity @e[tag=ezgui.cont,tag=ezgui.p$(pid),limit=1]"
execute if data storage ezgui:ctx page_def.target run data modify storage ezgui:ctx target set from storage ezgui:ctx page_def.target
# Container description is hoisted into flat macro keys (nested paths cannot be used
# inside a macro argument).
data modify storage ezgui:ctx container set from storage ezgui:ctx def.container
data modify storage ezgui:ctx y set from storage ezgui:ctx def.y
data modify storage ezgui:ctx block set from storage ezgui:ctx def.block
data modify storage ezgui:ctx kiosk_state set from storage ezgui:ctx def.kiosk_state
execute store result storage ezgui:ctx bx int 1 run data get storage ezgui:ctx def.bx
execute store result storage ezgui:ctx by int 1 run data get storage ezgui:ctx def.by
execute store result storage ezgui:ctx bz int 1 run data get storage ezgui:ctx def.bz
data modify storage ezgui:ctx timer set from storage ezgui:ctx def.timer
data modify storage ezgui:ctx start_page set from storage ezgui:ctx def.start_page
data modify storage ezgui:ctx floor set from storage ezgui:ctx def.floor
data modify storage ezgui:ctx on_enter set from storage ezgui:ctx page_def.on_enter
data modify storage ezgui:ctx on_leave set from storage ezgui:ctx page_def.on_leave
data modify storage ezgui:ctx on_open set from storage ezgui:ctx def.on_open
data modify storage ezgui:ctx on_close set from storage ezgui:ctx def.on_close
