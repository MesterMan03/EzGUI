# Place down the chest
execute at @e[tag=editormarker] run setblock ~ ~ ~ chest{CustomName: '{"text":"GUI Editor","color": "green"}'}

# Copy the items if we are in edit mode
execute if score #editor_type constant matches 2 at @e[tag=editormarker,limit=1] run data modify block ~ ~ ~ Items set from storage gui:editor EditingItems

# Editorchest to delete the chest when we are done
execute at @e[tag=editormarker] run summon armor_stand ~ ~-.5 ~ {Marker: 1b, Invisible: 1b, Tags: ["editorchest"]}

# Set tags
tag @s add editoropen

# Delete editor marker
kill @e[tag=editormarker]

# Reset triggers
function gui:reset_triggers

# Display infos
function gui:editor/display_infos