file_name = "reset_triggers.mcfunction"
file = open(file_name,"w")

click_types = ["left", "right", "shift", "return", "drop", "dropclick", "any", "f"]

base = """\nscoreboard players reset @a `click
scoreboard players enable @a[tag=editoropen] `click"""

if __name__=="__main__":
    file.write("# generated via python")

    for click_type in click_types:
        final = base.replace('`', click_type)
        file.write(final)