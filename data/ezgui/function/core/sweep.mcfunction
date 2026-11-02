# AS player — remove widget items that leaked into the inventory. The predicate only
# matches gadgets stamped by this pack, so real loot is never touched.
clear @s *[custom_data~{ezgui:{w:1}}]
