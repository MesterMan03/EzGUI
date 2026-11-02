# AS player — open menu ezgui.mid. Closing first guarantees a clean container, timer
# and page, and makes "open the menu I already have open" a supported operation.
function ezgui:core/seed
function ezgui:core/ensure_pid
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
execute unless data storage ezgui:ctx def run function ezgui:menu/open_missing with storage ezgui:ctx
execute if data storage ezgui:ctx def run function ezgui:menu/close with storage ezgui:ctx
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
function ezgui:menu/init_keys with storage ezgui:ctx
scoreboard players set @s ezgui.page 0
function ezgui:menu/open_start with storage ezgui:ctx
