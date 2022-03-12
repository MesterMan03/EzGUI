execute if entity @s[nbt={SelectedItem:{Count:1b}}] if score @s rightclick matches 1.. run tellraw @s {"text": "You tried to set right click for an item stack that has only one item, but because of how Minecraft works, right clicking is not compatible with this item.","color": "red"}
execute if entity @s[nbt={SelectedItem:{Count:1b}}] if score @s rightclick matches 1.. run scoreboard players set @s rightclick 0

execute if entity @s[nbt={SelectedItem:{Count:1b}}] if score @s dropclick matches 1.. run tellraw @s {"text": "You tried to set drop click for an item stack that has only one item, but because of how Minecraft works, drop clicking is not compatible with this item.","color": "red"}
execute if entity @s[nbt={SelectedItem:{Count:1b}}] if score @s dropclick matches 1.. run scoreboard players set @s dropclick 0