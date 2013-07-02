dofile(getinstalldir().."Scripts/wvanderzalm/Class.lua") 
Gridmap_Api = class()
function Gridmap_Api:__init()

end
function Gridmap_Api:addnode(label,x,y,z,facet,action,col,scale,width) 
setatom("MREAtom","table.insert(Nodes,{Label=\""..label.."\",X="..x..",Y="..y..",Z="..z..",Facet="..facet..",Action=\""..action.."\",Col="..col..",Scale="..scale..",Width="..width.."}) setatom('MREAtom',false)") 
table.insert(Nodes,{Label=label,X=x,Y=y,Z=z,Facet=facet,Action=action,Col=col,Scale=scale,Width=width}) 
end
function Gridmap_Api:modnode(n,...)
--x,y,z,action,col,scale,width) 
local str = ""
local varg = {...}
for i=1,#varg do
  str = str.."Nodes["..n.."]."..varg[i].." "
end
setatom("MREAtom",str.."setatom('MREAtom',false)")
dostring(str) 

end

function Gridmap_Api:deletenode(n) setatom("MREAtom","table.remove(Nodes,"..n..")") table.remove(Nodes,n) end
function Gridmap_Api:clearnodes() setatom("MREAtom","Nodes={} NodeList.ItemIndex=-1") Nodes={} end
function Gridmap_Api:openmenu() setatom("MREAtom","Editor_form.Show()") end
function Gridmap_Api:closemenu() setatom("MREAtom","Editor_form.Hide()") end
function Gridmap_Api:quit() print("Wesley's Grid Map : Shutting down!") setatom("MREAtom","Obj.Exit()") end
function Gridmap_Api:update() setatom("MREAtom","NodeListUpdate() clrscr() update=true") end

function Gridmap_Api:getnodes() 
setatom("MREAtom","setatom('MREAtom',TableToString(Nodes)) while getatom('MREAtom') do if getticks() > atomtimeout+200 then setatom('MREAtom',false) break end end")  
local atomtimeout=getticks()
while getatom("MREAtom") == "setatom('MREAtom',TableToString(Nodes)) while getatom('MREAtom') do if getticks() > atomtimeout+200 then setatom('MREAtom',false) break end end" do
  if getticks() > atomtimeout+2000 then setatom("MREAtom",false) end
end
if not getatom("MREAtom") then return false end
local temp = "Nodes="..getatom("MREAtom")
dostring(temp)
setatom("MREAtom",false)
return Nodes
end
function Gridmap_Api:getnodecnt() 
setatom("MREAtom","setatom('MREAtom',table.getn(Nodes)) while getatom('MREAtom') do if getticks() > atomtimeout+200 then setatom('MREAtom',false) break end end")  
local atomtimeout=getticks()
while getatom("MREAtom") == "setatom('MREAtom',table.getn(Nodes)) while getatom('MREAtom') do if getticks() > atomtimeout+200 then setatom('MREAtom',false) break end end" do
  if getticks() > atomtimeout+2000 then setatom("MREAtom",false) end
end
if not getatom("MREAtom") then return false end
local temp = getatom("MREAtom")
setatom("MREAtom",false)
return temp
end                    
 
function Gridmap_Api:getmousecords() 
  local P={X=math.floor((UO.CursorX-UO.CliLeft+UO.CursorY-UO.CliTop-UO.CliYRes/2-UO.CliXRes/2+22)/44),Y=math.floor((UO.CursorY-UO.CliTop-(UO.CursorX-UO.CliLeft)-UO.CliYRes/2+UO.CliXRes/2+22)/44)} 
  return P
end