# Remove chest
execute at @e[tag=editorchest] run setblock ~ ~ ~ air

# Delete editorchest
kill @e[tag=editorchest]

# Reset other scores
scoreboard players reset #editor_type constant

# Remove editoropen tag
tag @s remove editoropen