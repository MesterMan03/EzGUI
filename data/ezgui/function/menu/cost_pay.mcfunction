# The entry count is used as a score by the pay functions.
execute store result score #need ezgui.tmp run data get storage ezgui:ctx need

# Pay the entry prepared by cost_take.
execute if data storage ezgui:ctx ci run function ezgui:menu/take_item with storage ezgui:ctx
execute unless data storage ezgui:ctx ci run function ezgui:menu/take_score with storage ezgui:ctx
