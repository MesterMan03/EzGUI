# AS player — /trigger ezgui.save writes in-game layout edits back into the definitions.
function ezgui:core/seed
execute unless score @s ezgui.timer matches 1.. run return 0
function ezgui:editor/save
