base="""execute store success score #temp constant if data storage gui:pages ActualPage[{Slot:`b}] if data storage gui:pages TempPage[{Slot:`b}] run data modify storage gui:pages TempPage[{Slot:`b}] set from storage gui:pages ActualPage[{Slot:`b}]
execute if score #temp constant matches 1 run scoreboard players set #changed_slot constant `"""

for x in range(27):
	final = base.replace("`", str(x))
	print(final)