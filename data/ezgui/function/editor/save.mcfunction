# AS player — capture the current page's container layout back into ezgui:defs so the
# next open (and every other player) sees it. Only pages marked editable may be saved;
# a normal menu is never mutated by an admin poking around in its chest.
function ezgui:core/ctx
function ezgui:core/t with storage ezgui:ctx
execute unless data storage ezgui:ctx page_def.editable run return 0
function ezgui:editor/capture with storage ezgui:ctx
