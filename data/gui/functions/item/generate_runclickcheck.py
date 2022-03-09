file_name = "check_clicks_run.mcfunction"

f = open(file_name,"w")

first = """# here we only run one single line of code IF itemcheck is still alive (gui:item/run_commands kills it, so that's how we know we ran something)
# because we only run one single line instead of brute-forcing every slot in one giant function, we run overall WAY less commands
# oh and, generated via python, ofc ;)\n"""

base = "execute if entity @e[tag=itemcheck,limit=1] run function gui:item/slots/`\n"
end = "\nscoreboard players set #can_check_clicks constant 0"

if __name__=="__main__":
	f.write(first)

	for x in range(27):
		final = base.replace("`", str(x))
		f.write(final)
	
	f.write(end)