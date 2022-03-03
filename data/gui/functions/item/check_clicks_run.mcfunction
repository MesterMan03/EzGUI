# here we only run one single line of code IF itemcheck is still alive (gui:item/run_commands kills it, so that's how we know we ran something)
# because we only run one single line instead of brute-forcing every slot in one giant function, we run overall WAY less commands

# oh and, generated via python, ofc ;)
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/0
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/1
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/2
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/3
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/4
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/5
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/6
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/7
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/8
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/9
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/10
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/11
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/12
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/13
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/14
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/15
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/16
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/17
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/18
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/19
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/20
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/21
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/22
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/23
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/24
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/25
execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/26

scoreboard players set #can_check_clicks constant 0