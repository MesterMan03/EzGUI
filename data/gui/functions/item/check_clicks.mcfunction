# Executes as player
# I should honestly copyright this, this is a gold piece of Minecraft history

# Spawn itemcheck
execute positioned 0 0 0 run summon chest_minecart ~ ~ ~ {CustomDisplayTile:1b,DisplayState:{Name:"minecraft:air"},Tags:["itemcheck"],NoGravity:1b,Silent:1b}

# Load the items to itemcheck
execute as @e[tag=itemcheck] run function gui:item/load_items

# The click check should reset these, but just in case
data remove storage gui:pages TempItem
data remove storage gui:pages ActualItem

# Start the magic
function gui:item/check_clicks_run

# Reset
kill @e[tag=itemcheck]