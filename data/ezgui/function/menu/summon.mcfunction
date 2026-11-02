# AS player — one entity container per player, bound to that player through the owner
# tag ezgui.p<pid>. Any number of players can run the same menu at the same time.
$summon $(container) ~ ~$(y) ~ {Tags:["ezgui.cont","ezgui.p","ezgui.new"],Invulnerable:1b,NoGravity:1b,Silent:1b,PersistenceRequired:1b,CustomNameVisible:0b,Team:"ezgui.nopush"}
$tag @e[tag=ezgui.new,limit=1] add ezgui.p$(pid)
tag @e[tag=ezgui.new] remove ezgui.new
