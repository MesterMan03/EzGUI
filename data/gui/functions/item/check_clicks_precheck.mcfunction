# executes as gui
# this function tries to check if there is a difference
# between the gui and the actual items instead of "brute forcing"
# every single slot. It also shows which slot is different to increase
# optimization by a LOT

# first we copy the *full Items nbt* to ActualPages and TempPages
data modify storage gui:pages ActualPages set from entity @e[tag=itemcheck,limit=1] Items
data modify storage gui:pages TempPages set from entity @e[tag=selectedgui,limit=1] Items

# this is how it's going to work:
# we check if we can copy from ActualPages to TempPages
# if the command fails, that means the 2 nbts are exactly the same, which is what we want to know
# generated using python