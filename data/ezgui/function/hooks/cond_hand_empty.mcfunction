# AS player — passes (returns 1) when the main hand is empty.
execute unless items entity @s weapon.mainhand * run return 1
return 0
