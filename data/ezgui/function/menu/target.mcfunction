# AS player — where the pixels go. page_def.target is a literal "entity …" or
# "block x y z" string, so every fill can be built by a macro.
$data modify storage ezgui:ctx target set value "entity @e[tag=ezgui.cont,tag=ezgui.p$(pid),limit=1]"
execute if data storage ezgui:ctx page_def.target run data modify storage ezgui:ctx target set from storage ezgui:ctx page_def.target
