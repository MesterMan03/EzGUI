# Create mode
execute if score #editor_type constant matches 1 run function gui:editor/done_create

# Edit mode
execute if score #editor_type constant matches 2 run function gui:editor/done_edit