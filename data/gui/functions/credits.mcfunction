function gui:tellraw_line
tellraw @s {"text": "A giant Thank You for all these people:","color": "green"}

tellraw @s ""

tellraw @s {"text": "Fabian Weigel for suggesting the item loss prevention system!","color": "gold"}
tellraw @s {"translate":"%s for the idea of drop clicks!","color": "gold","with": [{"text": "u/THEinnin","color": "aqua","underlined": true, "clickEvent": {"action": "open_url","value": "https://www.reddit.com/user/THEinnin/"}}]}
tellraw @s {"translate": "%s for suggesting me the \"any\" clicks!","color": "gold","with":[{"text": "u/AnImpossibility","color": "aqua","underlined": true,"clickEvent": {"action": "open_url","value": "https://www.reddit.com/user/AnImpossibility/"}}]}
function gui:tellraw_line