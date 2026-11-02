# AS the container — empty first (so a half-used editor can never scatter items), then go.
data modify entity @s Items set value []
kill @s
