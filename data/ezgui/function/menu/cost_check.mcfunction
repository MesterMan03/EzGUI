# The entry count is used as a score by the branch functions.
execute store result score #need ezgui.tmp run data get storage ezgui:ctx need

# Which branch? An entry with an item costs items, otherwise it costs a score.
execute if data storage ezgui:ctx ci run function ezgui:menu/cost_item with storage ezgui:ctx
execute unless data storage ezgui:ctx ci run function ezgui:menu/cost_score with storage ezgui:ctx
