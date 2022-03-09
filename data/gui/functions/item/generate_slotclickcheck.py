import os

base = """data modify storage gui:pages SlotItem set from entity @e[tag=selectedgui,limit=1] Items[{Slot:`b}]
data modify storage gui:pages ActualItem set from entity @e[tag=itemcheck,limit=1] Items[{Slot:`b}]
execute if data storage gui:pages SlotItem unless data storage gui:pages SlotItem.tag.GUIItem run function gui:item/return_item
execute if data storage gui:pages ActualItem run function gui:item/slots/final"""

if __name__=="__main__":
	try:
		os.mkdir("slots")
	except:
		pass
	
	for x in range(27):
				
		final = base.replace("`", str(x))
	
		f = open("slots/%s.mcfunction" % x,"w")
		f.write("# generated using python\n")
		f.write(final)