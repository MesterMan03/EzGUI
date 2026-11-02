# AS player — seed the macro argument surface (run once per entry point).
#
# Every macro reads ezgui:ctx and nothing else, so every key a macro may print has to
# exist before that macro runs: a macro refuses to instantiate when a key it prints is
# missing. Small merges keep it cheap, and they are only run at an entry point — never
# inside a loop, where they would wipe the scratch values the loop just prepared.
data merge storage ezgui:ctx {container:"",y:"",block:"",kiosk_state:"",floor:"",target:"",id:"",comp:""}
data merge storage ezgui:ctx {raw:"",live:"",probe:"",sound:"",hook:"",url:"",label:"",msg:""}
data merge storage ezgui:ctx {initscore:"",sname:"",m:"",score:"",toggle:"",coolscore:"",mod:""}
data merge storage ezgui:ctx {cmd:""}
data merge storage ezgui:ctx {pid:0,mid:0,page:0,session:0,slot:0,i:0,g:0,k:0}
data merge storage ezgui:ctx {s:0,cells:0,need:0,n:0,p:0,dest:0,bx:0,by:0}
data merge storage ezgui:ctx {bz:0,vraw:0,cool:0,timer:0,idx:0}
# Identity keys come from the player's own scores.
execute store result storage ezgui:ctx pid int 1 run scoreboard players get @s ezgui.pid
execute store result storage ezgui:ctx mid int 1 run scoreboard players get @s ezgui.mid
execute store result storage ezgui:ctx page int 1 run scoreboard players get @s ezgui.page
execute store result storage ezgui:ctx session int 1 run scoreboard players get @s ezgui.session
