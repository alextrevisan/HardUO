------------------------------------
-- Script Name: KalLib.lua
-- Author: Kal In Ex
-- Version: 1.1
-- Client Tested with:
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: OSI
-- Revision Date: June 15, 2012
-- Public Release: May 13, 2012
-- Purpose: Very Useful Code
-- Copyright: 2012 Kal In Ex
------------------------------------
-- http://www.easyuo.com/forum/viewtopic.php?p=401528

------------------------------------
-- Script Name: FindItems.lua
-- Author: Kal In Ex
-- Version: 4.0
-- Client Tested with: 7.0.18.1 (Patch 95)
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: OSI
-- Revision Date: May 7, 2012
-- Public Release: July 16, 2010
-- Purpose: OpenEUO version of FindItem
-- Copyright: 2010,2011 Kal In Ex
------------------------------------
-- http://www.easyuo.com/forum/viewtopic.php?t=43949

------------------------------------------
-- IMT automates calls to UO.Property() --
-- set the values to nil then re-access --
-- .Name or .Details to cause an update --
------------------------------------------
local GetBODInfo

local GIDFT = {
	["Total Resist"] = function(p)
		return
			(p["Physical Resist"] or 0) +
			(p["Fire Resist"] or 0) +
			(p["Cold Resist"] or 0) +
			(p["Poison Resist"] or 0) +
			(p["Energy Resist"] or 0)
	end}

local IMT = {}
IMT.__index = function(table,key)
	if key == "Name" or key == "Details" then
		local Name,Details
		Name,Details = UO.Property(table.ID)
		rawset(table,"Name",string.match(Name,"[%s%d]*(.+)"))
		rawset(table,"Details",Details)
	end
	if key == "Property" then
		local Property = GetItemData(table.Details)
		Property.Name = table.Name
		rawset(table,"Property",Property)
	end
	if key == "BODInfo" then
		rawset(table,"BODInfo",GetBODInfo(table.Details))
	end
	return rawget(table,key)
end

local CheckProperty = function(find,string,search)
	if find.Name == nil then
		find.Name,find.Details = UO.Property(find.ID)
	end
	if type(search[string]) ~= "table" then
		return string.find(string.lower(find[string]),string.lower(search[string]),1,true) ~= nil
	end
	for i=1,#search[string] do
		if string.find(string.lower(find[string]),string.lower(search[string][i]),1,true) ~= nil then
			return true
		end
	end
	return false
end

local CheckValue = function(find,search)
	if type(search) ~= "table" then
		return find == search
	end
	for i=1,#search do
		if find == search[i] then
			return true
		end
	end
	return false
end

local Compare = {}
Compare.ID = function(find,search) return CheckValue(find.ID,search.ID) end
Compare.Type = function(find,search) return CheckValue(find.Type,search.Type) end
Compare.Kind = function(find,search) return CheckValue(find.Kind,search.Kind) end
Compare.ContID = function(find,search) return CheckValue(find.ContID,search.ContID) end
Compare.X = function(find,search) return CheckValue(find.X,search.X) end
Compare.Y = function(find,search) return CheckValue(find.Y,search.Y) end
Compare.Z = function(find,search) return CheckValue(find.Z,search.Z) end
Compare.Stack = function(find,search) return CheckValue(find.Stack,search.Stack) end
Compare.Rep = function(find,search) return CheckValue(find.Rep,search.Rep) end
Compare.Col = function(find,search) return CheckValue(find.Col,search.Col) end
Compare.RelX = function(find,search) return CheckValue(find.RelX,search.RelX) end
Compare.RelY = function(find,search) return CheckValue(find.RelY,search.RelY) end
Compare.RelZ = function(find,search) return CheckValue(find.RelZ,search.RelZ) end
Compare.Dist = function(find,search)
	if find.Dist == nil then return false end
	if type(search.Dist) == "number" then
		return find.Dist <= search.Dist
	elseif type(search) == "table" then
		return CheckValue(find.Dist,search.Dist)
	end
end
Compare.Name = function(find,search) return CheckProperty(find,"Name",search) end
Compare.Details = function(find,search) return CheckProperty(find,"Details",search) end
Compare.Func = function(find,search)
	if type(search.Func) == "function" then
		return search.Func(find)
	end
	for i=1,#search.Func do
		if search.Func[i](find) then
			return true
		end
	end
	return false
end

local KeyCheck = {["ID"]=0,["Type"]=0,["Kind"]=0,["ContID"]=0,["X"]=0,["Y"]=0,["Z"]=0,["Stack"]=0,["Rep"]=0,["Col"]=0,["RelX"]=0,["RelY"]=0,["RelZ"]=0,["Dist"]=0}
local KeyCheckE = {["Name"]=0,["Details"]=0,["Func"]=0}

FindItems = function(t,...)
	local r = {}
	local t_key_names = {}  -- table of true "standard" item properties
	local f_key_names = {}  -- table of false "standard" properties
	local te_key_names = {} -- table of true "extra" properties
	local fe_key_names = {} -- table of false "extra" properties
	arg = table.pack(...)
	if arg.n == 1 and #arg[1] == 2 then
		arg[2] = arg[1][2]
		arg[1] = arg[1][1]
		arg.n = 2
	end
	if arg.n == 1 then
		arg[2] = {}
	end
	for k,v in pairs(arg[1]) do
		if KeyCheck[k] then
			table.insert(t_key_names,k)
		elseif KeyCheckE[k] then
			table.insert(te_key_names,k)
		end
	end
	for k,v in pairs(arg[2]) do
		if KeyCheck[k] then
			table.insert(f_key_names,k)
		elseif KeyCheckE[k] then
			table.insert(fe_key_names,k)
		end
	end
	local t_key_count = #t_key_names
	local f_key_count = #f_key_names
	local te_key_count = #te_key_names
	local fe_key_count = #fe_key_names
	for i=1,#t do
		local flag = true
		if flag == true then
			for j=1,t_key_count do
				flag = Compare[t_key_names[j]](t[i],arg[1])
				if flag == false then break end
			end
		end
		if flag == true then
			for j=1,te_key_count do
				flag = Compare[te_key_names[j]](t[i],arg[1])
				if flag == false then break end
			end
		end
		if flag == true and ( f_key_count > 0 or fe_key_count > 0 ) then
			for j=1,f_key_count do
				flag = Compare[f_key_names[j]](t[i],arg[2])
				if flag == false then break end
			end
			if flag == true and fe_key_count > 0 then
				for j=1,fe_key_count do
					flag = Compare[fe_key_names[j]](t[i],arg[2])
					if flag == false then break end
				end
			end
			if flag == false then flag = true else flag = false end
		end
		if flag == true then
			table.insert(r,t[i])
		end
	end
	return r
end

local CharPos = {}

local GetItem = function(i)
	local ID,Type,Kind,ContID,X,Y,Z,Stack,Rep,Col = UO.GetItem(i)
	local t = {ID=ID,Type=Type,Kind=Kind,ContID=ContID,X=X,Y=Y,Z=Z,Stack=Stack,Rep=Rep,Col=Col}
	if t.Kind == 1 then
		t.RelX = t.X - CharPos.X
		t.RelY = t.Y - CharPos.Y
		t.RelZ = t.Z - CharPos.Z
		t.Dist = math.max(math.abs(t.RelX),math.abs(t.RelY))
	end
	return t
end

ScanItems = function(bVisOnly,...)
	if type(bVisOnly) == "table" then
		return FindItems(bVisOnly,...)
	end
	if bVisOnly == nil then
		bVisOnly = true
	end
	local t = {}
	CharPos.X = UO.CharPosX
	CharPos.Y = UO.CharPosY
	CharPos.Z = UO.CharPosZ
	for i=0,UO.ScanItems(bVisOnly)-1 do
		local item = GetItem(i)
		setmetatable(item,IMT)
		table.insert(t,item)
	end
	if ... ~= nil then
		t = FindItems(t,...)
	end
	return t
end

ScanItemsEx = function(bVisOnly,...)
---------------------------------------------
-- make a list of all containers on screen --
---------------------------------------------
	local c = ScanConts()
---------------------------------------------------------------------
-- list all paperdoll ids they throw off the .RelX and .RelY value --
---------------------------------------------------------------------
	local PaperDolls = {}
	do
		local temp = FindConts(c,{Name="paperdoll gump"})
		for i=1,#temp do
			table.insert(PaperDolls,temp[i].ID)
		end
	end
--------------------------------------------------------------------------------
-- .Dist property of 'c' table will be distance to ground level container     --
-- .X property of 'c' table will be the world x position of that container    --
-- .Y property of 'c' table will be the world y position of that container    --
-- some containers will not have an ID and will have no .Dist,.X or .Y values --
--------------------------------------------------------------------------------
	local t = ScanItems(bVisOnly)
	for i=1,#c do
		local Parent = 0
		local SearchID = c[i].ID
		while true do
			if SearchID == nil then
				break
			end
---------------------------------------------------------
-- search for SearchID exclude IDs found on paperdolls --
---------------------------------------------------------
			local Item = FindItems(t,{ID=SearchID},{ContID=PaperDolls})
			if #Item == 0 then
				break
			end
			if Item[1].Kind == 1 then
				c[i].Dist = Item[1].Dist
				c[i].X = Item[1].X
				c[i].Y = Item[1].Y
				break
			end
			SearchID = Item[1].ContID
		end
	end
---------------------------------------------------------------
-- assign the container items X,Y,RelX, RelY and Dist values --
---------------------------------------------------------------
	for i=1,#t do
		if t[i].Kind == 0 then
			for j=1,#c do
				if t[i].ContID == c[j].ID then
					t[i].RelX = t[i].X - c[j].X
					t[i].RelY = t[i].Y - c[j].Y
					t[i].Dist = c[j].Dist
					t[i].X = c[j].X
					t[i].Y = c[j].Y
					break
				end
			end
		end
	end
-----------------------------------------------
-- search for items using supplied filter(s) --
-----------------------------------------------
	if ... ~= nil then
		t = FindItems(t,...)
	end
	return t
end

ScanInvisItems = function(...)
	local t = {}
	local t1 = {}
	CharPos.X = UO.CharPosX
	CharPos.Y = UO.CharPosY
	for i=0,UO.ScanItems(true)-1 do
		t1[UO.GetItem(i)] = 0
	end
	for i=0,UO.ScanItems(false)-1 do
		local item = GetItem(i)
		if t1[item.ID] == nil then
			setmetatable(item,IMT)
			table.insert(t,item)
		end
	end
	if ... ~= nil then
		t = FindItems(t,...)
	end
	return t
end

local IgnoreItem_sub1 = function(Table,IDType,Name)
-----------------------------------
-- is IDType a command to reset? --
-----------------------------------
	if type(IDType) == "string" and string.lower(IDType) == "reset" then
		if Name == nil then
			Table = {}
			--[[
			for k,v in pairs(Table) do
				Table[k] = nil
			end
			Table["ID"] = nil
			Table["Type"] = nil
			Table["Group"] = nil
			--]]
		else
			if Table.Group[Name] ~= nil then
				local Group = Table.Group[Name]
				for i=#Group,1,-1 do
					IgnoreItem(Table,Group[i])
				end
			end
		end
		return
	end
-----------------------------
-- is IDType a Type or ID? --
-----------------------------
	local CodeType
	if IDType < 65536 then
		CodeType = "Type"
	else
		CodeType = "ID"
	end
-----------------------------------------------
-- remove IDType from group if exists in one --
-----------------------------------------------
	if Table["Group"] == nil then
		Table.Group = {}
	end
	for GroupName,Group in pairs(Table.Group) do
		for i=1,#Group do
			if Group[i] == IDType then
				table.remove(Group,i)
			end
		end
		if #Group == 0 then
			Table.Group[GroupName] = nil
		end
	end
-------------------------------------------------------
-- remove IDType from ignore list if it exists in it --
-------------------------------------------------------
	if Table[CodeType] == nil then
		Table[CodeType] = {}
	else
		for i=1,#Table[CodeType] do
			if Table[CodeType][i] == IDType then
				table.remove(Table[CodeType],i)
				if #Table[CodeType] == 0 then
					Table[CodeType] = nil
				end
				return
			end
		end
	end
-------------------------
-- add IDType to group --
-------------------------
	if Name ~= nil then
		if Table.Group[Name] == nil then
			Table.Group[Name] = {}
		end
		table.insert(Table.Group[Name],IDType)
	end
--------------------------------
-- add IDType to ignore table --
--------------------------------
	table.insert(Table[CodeType],IDType)
end

IgnoreItem = function(Table,IDTypeTable,Name)
	if type(IDTypeTable) ~= "table" then
		IgnoreItem_sub1(Table,IDTypeTable,Name)
	else
		for i=1,#IDTypeTable do
			IgnoreItem_sub1(Table,IDTypeTable[i],Name)
		end
	end
end

-----------------------------------------------------------
-- load a table with information about a bulk order deed --
-----------------------------------------------------------
GetBODInfo = function(Details)
----------------------------------
-- get the details about an BOD --
----------------------------------
	if type(Details) == "number" then
		local Name
		Name,Details = UO.Property(Details)
		if Name ~= "A Bulk Order Deed" or string.len(Details) == 0 then
			print("GetBODInfo - error item ID:"..ID.." is not a BOD")
			return nil
		end
	end
----------------------------------------------------------------------------
-- string.gfind function returns 1 line of info from the details per call --
-- then either the entire line or part of it is written to the table      --
----------------------------------------------------------------------------
	local GetLine = string.gfind(Details,"([^%c]+)%c*")
	GetLine() -- Blessed
	GetLine() -- Weight: 1 Stone
	local RetVal = {}
	RetVal["Size"] = GetLine()
	RetVal["Material"] = GetLine()
	RetVal["Quality"] = GetLine()
	RetVal["Amount"] = tonumber(string.match(GetLine(),"[%w%s]+: (%d+)"))
	for i=1,6 do
		local Line = GetLine()
		if Line == nil then
			break
		end
		RetVal[i] = {}
		RetVal[i]["Name"] = string.match(Line,"([%w%s-']+)")
		RetVal[i]["Amount"] = tonumber(string.match(Line,"[%w%s]+: (%d+)"))
	end
	return RetVal
end
------------------------------------
-- Script Name: FindConts.lua
-- Author: Kal In Ex
-- Version: 1.5
-- Client Tested with: 7.0.10.1 (Patch 95)
-- EUO version tested with: OpenEUO 0.91.0008
-- Shard OSI / FS: OSI
-- Revision Date: May 8, 2012
-- Public Release: October 26, 2010
-- Purpose: A "FindItem" for containers
-- Copyright: 2010 Kal In Ex
------------------------------------
-- http://www.easyuo.com/forum/viewtopic.php?t=45018

local CheckValue = function(bool,find,search)
	if type(search) ~= "table" then
		if find == search then
			if bool == true then return true else return false end
		end
		if bool == true then return false else return true end
	end
	for k,value in pairs(search) do
		if find == value then
			if bool == true then return true else return false end
		end
	end
	if bool == true then return false else return true end
end

FindConts = function(t,...)
	local r = {}
	local t_key_names = {}  -- table of true "standard" item properties
	local f_key_names = {}  -- table of false "standard" properties
	if arg.n == 1 and #arg[1] == 2 then
		arg[2] = arg[1][2]
		arg[1] = arg[1][1]
		arg.n = 2
	end
	if arg.n == 1 then
		arg[2] = {}
	end
	for k,v in pairs(arg[1]) do
		if string.find("|Name|X|Y|SX|SY|Kind|ID|Type|HP|","|"..k.."|",1,true) then
			table.insert(t_key_names,k)
		end
	end
	for k,v in pairs(arg[2]) do
		if string.find("|Name|X|Y|SX|SY|Kind|ID|Type|HP|","|"..k.."|",1,true) then
			table.insert(f_key_names,k)
		end
	end
	local t_key_count = #t_key_names
	local f_key_count = #f_key_names
	for i=1,#t do
		local flag = true
		if flag == true then
			for j=1,t_key_count do
				flag = CheckValue(true,t[i][t_key_names[j]],arg[1][t_key_names[j]])
				if flag == false then break end
			end
		end
		if flag == true and f_key_count > 0 then
			for j=1,f_key_count do
				flag = CheckValue(true,t[i][f_key_names[j]],arg[2][f_key_names[j]])
				if flag == false then break end
			end
			if flag == false then flag = true else flag = false end
		end
		if flag == true then
			table.insert(r,t[i])
		end
	end
	return r
end

GetCont = function(i)
	local Name,X,Y,SX,SY,Kind,ID,Type,HP = UO.GetCont(i)
	local t = {Index=i,Name=Name,X=X,Y=Y,SX=SX,SY=SY,Kind=Kind,ID=ID,Type=Type,HP=HP}
	return t
end
--[[
ScanConts_V1 = function(...)
	local t = {}
	for i=0,99 do
		local c = GetCont(i)
		if c.Name == "GameAreaEdgeGump" or c.Name == nil then
			break
		end
		table.insert(t,c)
	end
	if ... ~= nil then
		t = FindConts(t,...)
	end
	return t
end
--]]
ScanConts = function(...)
	local t = {}
	local scanlimit = 999
	local varg = {...}
	if #varg == 1 and type(varg[1]) == "number" then
		scanlimit = varg[1] - 1
		table.remove(varg,1)
	end
	if #varg == 2 and type(varg[2]) == "number" then
		scanlimit = varg[2] - 1
		table.remove(varg,2)
	end
	if #varg == 3 and type(varg[3]) == "number" then
		scanlimit = varg[3] - 1
		table.remove(varg,3)
	end
	for i=0,scanlimit do
		local c = GetCont(i)
		if c.Name == "GameAreaEdgeGump" or c.Name == nil then
			break
		end
		table.insert(t,c)
	end
	if #varg ~= 0 then
		t = FindConts(t,unpack(varg))
	end
	return t
end

WaitConts = function(bVis,Delay,...)
	local result = {}
	if bVis == true then
		local TimeOUT = getticks() + Delay
		while true do
			result = ScanConts(...)
			if #result ~= 0 or getticks() >= TimeOUT then
				return result
			end
			wait(1)
		end
		return result
	end
	if bVis == false then
		local TimeOUT = getticks() + Delay
		while true do
			result = ScanConts(...)
			if #result == 0 or getticks() >= TimeOUT then
				return result
			end
			wait(1)
		end
		return result
	end
	return result
end

WaitCont = WaitConts

function MoveConts(XPos,YPos,GumpX,GumpY,...)
	local cont
	for try=1,2 do
		cont = ScanConts(...)
		if #cont == 0 or ( cont[1].X == XPos and cont[1].Y == YPos ) then
			break
		end
		local DestX = XPos + GumpX
		local DestY = YPos + GumpY
		local GrabX = GumpX + cont[1].X
		local GrabY = GumpY + cont[1].Y
		local CursorX = UO.CursorX
		local CursorY = UO.CursorY
		if cont[1].Index ~= 0 then
			UO.ContTop(cont[1].Index)
			wait(100)
		end
		UO.Click(DestX,DestY,true,false,true,true)
		local timeout = getticks() + 1000
		UO.Click(GrabX,GrabY,true,true,false,false)
		while true do
			UO.Click(GrabX,GrabY,true,false,false,false)
			wait(1)
			cont = ScanConts(...)
			if #cont ~= 0 and cont[1].X == XPos and cont[1].Y == YPos then
				break
			end
			if getticks() >= timeout then
				break
			end
		end
		UO.Click(DestX,DestY,true,false,true,true)
		UO.Click(CursorX,CursorY,true,false,false,true)
	end
	if #cont == 0 then
		return false
	end
	if cont[1].X ~= XPos or cont[1].Y ~= YPos then
		return false
	end
	return true
end

MoveCont = MoveConts

ClickConts = function(XPos,YPos,Left,Down,Up,MC,...)
	local cont = ScanConts(...)
	if #cont ~= 0 then
		XPos = XPos + cont[1].X
		YPos = YPos + cont[1].Y
		UO.Click(XPos,YPos,Left,Down,Up,MC)
	end
	return cont
end
------------------------------------
-- Script Name: journal.lua
-- Author: Kal In Ex
-- Version: 1.2
-- Client Tested with: 7.0.15.1 (Patch 95)
-- EUO version tested with: OpenEUO 0.91.0026
-- Shard OSI / FS: OSI
-- Revision Date: June 25,2011
-- Public Release: May 19, 2010
-- Purpose: easier journal scanning
-- Copyright: 2010,2011 Kal In Ex
------------------------------------
-- http://www.easyuo.com/forum/viewtopic.php?t=43488

journal = {}

journal.new = function()
	local state = {}
	local mt = {__index = journal}
	setmetatable(state,mt)
	state:clear()
	return state
end

journal.get = function(state)
	state.ref,state.lines = UO.ScanJournal(state.ref)
	state.index = 0
	for i=0,state.lines-1 do
		local text,col = UO.GetJournal(state.lines-i-1)
		state[i+1] = "|"..tostring(col).."|"..text.."|"
	end
end

journal.next = function(state)
	if state.index == state.lines then
		state:get()
		if state.index == state.lines then
			return nil
		end
	end
	state.index = state.index + 1
	return state[state.index]
end

journal.last = function(state)
	return state[state.index]
end

journal.find = function(state,...)
	local arg = {...}
	if type(arg[1]) == "table" then
		arg = arg[1]
	end
	while true do
		local text = state:next()
		if text == nil then
			break
		end
		for i=1,#arg do
			if string.find(text,tostring(arg[i]),1,true) ~= nil then
				return i
			end
		end
	end
	return nil
end

journal.wait = function(state,TimeOUT,...)
	TimeOUT = getticks() + TimeOUT
	repeat
		local result = state:find(...)
		if result ~= nil then
			return result
		end
		wait(1)
	until getticks() >= TimeOUT
	return nil
end

journal.clear = function(state)
	state.ref = UO.ScanJournal(0)
	state.lines = 0
	state.index = 0
end
------------------------------------
-- Script Name: CoreFunc.lua
-- Author: Kal In Ex
-- Version: 1.0
-- Client Tested with: 7.0.18.1 (Patch 95)
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: OSI
-- Revision Date: September 12, 2011
-- Public Release: September 12, 2010
-- Purpose: Less errors
-- Copyright: 2010,2011 Kal In Ex
------------------------------------
-- http://www.easyuo.com/forum/

-- Item = an item as returned by FindItems.lua
-- Dest = an item as returned by FindItems.lua
-- Func = "OnText","Type in a price" the routine has success when text is found in journal
-- Func = "OnCont",{ID=UO.LObjectID} the routine has success when a gump with an ID is found
-- Func = "OnTarget" the routine has success when UO.TargCurs == true
-- example: UseItem(Item,"OnText","use this on?") -- using a dagger
-- example: UseItem(Item,"OnTarget") -- using a dagger
-- example: MoveItem(Item,Amt,Dest) -- dropping an item onto a container
-- example: MoveItem(Item,Amt,Dest,X,Y) -- dropping an item into a container at an X,Y position
-- example: MoveItem(Item,Amt,X,Y) -- dropping an item on the ground
-- example: MoveItem(Item,Amt,X,Y,Z) -- dropping an item on the ground
-- example: MoveItem(Item,Amt,Dest,"OnText","price and description") -- stocking a vendor
-- example: Equip(Item,...) -- array of Items or ItemIDs to equip
-- NOTE: parameters for Equip can be Items and IDs

local Debug = function(...)
	-- print(...)
end

local subpack = function(t,s,e)
	local r = {}
	if s == nil then s = 1 end
	if e == nil then e = #t end
	for i=s,e do
		table.insert(r,t[i])
	end
	return r
end

do
	local BuiltIn
	BuiltIn = {
		["varg"] = {},
		["OnTarget"] = function()
			return UO.TargCurs
		end,
		["JText"] = journal:new(),
		["OnText"] = function(b)
			if b == true then
				BuiltIn.JText:clear()
			end
			return BuiltIn.JText:find(unpack(BuiltIn.varg))
		end,
		["OnCont"] = function()
			local Result = ScanConts(unpack(BuiltIn.varg))
			if #Result ~= 0 then
				return Result
			end
		end,
	}
	local ActionWaitTime = 4000  -- max time to wait for an action to complete
	local ActionTiming = 985     -- minimum time between actions
	local NextActionTime = 0     -- time to wait before doing next action
	local ActionTimeOUT = 0      -- time to wait before a moveitem failure
	local JText = journal:new()
	local varg,vcnt
	--local ActionTime = 0         -- time of last action (effectively ActionDelay - ActionTiming)
--[[
	function that does nothing...
--]]
	local nilFunc = function() end
------------------------------------------------------------
-- MoveItem
------------------------------------------------------------
	local Items1 -- item list made before MoveItem
	local Items2 -- item list made during MoveItem
	local Conts1 -- cont list made after MoveItem's first call to Drag()
	local Drag = function()
		NextActionTime = getticks() + ActionTiming
		ActionTimeOUT = NextActionTime + ActionWaitTime
		JText:clear()
		UO.Drag(varg[1].ID,varg[2])
	end
	local Drop
	local Drop1 = function() if type(varg[3]) == "number" then UO.DropC(varg[3]) end end
	local Drop2 = function() UO.DropC(varg[3],varg[4],varg[5]) end
	local Drop3 = function() UO.DropG(varg[3],varg[4]) end
	local Drop4 = function() UO.DropG(varg[3],varg[4],varg[5]) end
	local Drop5 = function() UO.DropPD() end
	local DragDrop = function()
		Drag()
		Drop()
	end
	local DropKind = 0
	local Func
--[[
	turn ... into a table and do some parameter checking
--]]
	local Helper1 = function(...)
		varg = {...}
		Items1 = ScanItems(true)
		-- varg[1] must be an item structure returned by FindItems.lua
		if type(varg[1]) == "number" then
			local Item = FindItems(Items1,{ID=varg[1]})
			if #Item == 0 then
				return false
			end
			varg[1] = Item[1]
		end
		-- change drag amount when/if its greater than the stack size
		if varg[2] ~= 1 and varg[2] > varg[1].Stack then
			varg[2] = varg[1].Stack
		end
		Func = nilFunc
		for i=4,#varg do
			local Type = type(varg[i])
			if Type == "string" then
				Func = BuiltIn[varg[i]]
				Func(true)
				BuiltIn.varg = subpack(varg,i+1)
				varg = subpack(varg,1,i-1)
				break
			elseif Type == "function" then
				Func = varg[i]
				Func(true)
				varg = subpack(varg,1,i-1)
				break
			end
		end
		--if type(varg[2]) ~= "number" or varg[2] < 1 or varg[2] > varg[1].Stack then
		--	varg[2] = varg[1].Stack
		--end
	end
--[[
	true/false if ID is in backpack or sub-container of backpack
--]]
	local InBackpack = function(ID)
		local BackpackID = UO.BackpackID
		local Item = FindItems(Items1,{ID=ID})
		if #Item == 0 then
			print(
				#ScanItems(true,{ID=ID}),
				"InBackpack() - could not find item!")
		end
		while #Item ~= 0 do
			if Item[1].Kind == 1 then
				return false
			end
			if Item[1].ContID == BackpackID then
				return true
			end
			Item = FindItems(Items1,{ID=Item[1].ContID})
		end
		return false
	end
--[[
	this routine is responsible for the drag+drop and success/failure checking
--]]
	local Helper2 = function()
		--Items1 = ScanItems(true)
		while NextActionTime > getticks() do wait(1) end
		Drag()
		local CheckFor = {}

if Func ~= nilFunc then -- using user supplied function for success/failure checking
		-- user supplied function to check for success
		table.insert(CheckFor,Func)
		Debug("via user function")
		Drop()
else
		-- change in character weight
		local Weight = UO.Weight
		table.insert(CheckFor,function()
			if UO.Weight ~= Weight then
				Debug("UO.Weight ~= Weight")
				return true
			end
		end)

		-- can determine success/failure on the UO.Drag event
		if not InBackpack(varg[1].ID) then
			Debug("Detect on UO.Drag")
			--Drag()
			repeat
				Items2 = ScanItems(true)
				for i=1,#CheckFor do
					local Result = CheckFor[i](i)
					if Result then
						Drop()
						return Result
					end
				end
				local Result = JText:find(
					"perform another action",
					"You can not pick that up.",
					"cannot hold more",
					"too far away")
				if Result ~= nil then
					if Result == 1 then
						wait(100)
						Drag()
					elseif Result == 2 then
						UO.DropC(UO.CharID)
						wait(100)
						Drag()
					else
						return true
					end
				end
				wait(1)
			until ActionTimeOUT < getticks()
			return false
		end

		-- more methods must be used to determine success/failure
		Debug("Detect on DragDrop")
		--DragDrop()
		Drop()

		-- change in source stack
		table.insert(CheckFor,function()
			local Find = FindItems(Items2,{ID=varg[1].ID})
			if #Find > 0 and Find[1].Stack ~= varg[1].Stack then
				Debug("Find[1].Stack ~= varg[1].Stack")
				return true
			end
		end)

		-- dropping at X,Y position within a container

		-- change in dest stack (used when item type and dest type are the same)
		if DropKind == 0 and #FindItems(Items1,{ID=varg[3],Type=varg[1].Type}) > 0 then
			table.insert(CheckFor,function()
				local Find1 = FindItems(Items2,{ID=varg[3]})
				local Find2 = FindItems(Items1,{ID=varg[3]})
				if #Find1 ~= 0 and #Find2 ~= 0 and Find1[1].Stack ~= Find2[1].Stack then
					Debug("Find[1].Stack ~= Find[2].Stack")
					return true
				end
			end)
		end

		--Conts1 = ScanConts() -- this is used to know if a container is open

		-- change in position
		table.insert(CheckFor,function()
			local Find = FindItems(Items2,{ID=varg[1].ID})
			if #Find > 0 and (Find[1].X ~= varg[1].X or Find[1].Y ~= varg[1].Y or Find[1].ContID ~= varg[1].ContID) then
				Debug("Find[1].X ~= varg[1].X or Find[1].Y ~= varg[1].Y or Find[1].ContID ~= varg[1].ContID")
				return true
			end
		end)
end

--[[
		-- change of dest property
		if DropKind == 0 then
			table.insert(CheckFor,function()
				local Name,Details = UO.Property(varg[3])
				local Find2 = FindItems(Items1,{ID=varg[3]})
				if #Find2 ~= 0 and (Find2[1].Name ~= Name or Find2[1].Details ~= Details) then
					return true
				end
			end)
		end
		-- change of source contid property
		if varg[1].Kind == 0 then
			table.insert(CheckFor,function()
				local Name,Details = UO.Property(varg[1].ContID)
				local Find2 = FindItems(Items1,{ID=varg[1].ContID})
				if #Find2 ~= 0 and (Find2[1].Name ~= Name or Find2[1].Details ~= Details) then
					return true
				end
			end)
		end
--]]
		repeat
			Items2 = ScanItems(true)
			for i=1,#CheckFor do
				local Result = CheckFor[i](i)
				if Result then
					return Result
				end
			end
			local Result = JText:find(
				"perform another action",
				"cannot hold more",
				"too far away")
			if Result ~= nil then
				if Result == 1 then
					wait(100)
					DragDrop()
				else
					return true
				end
			end
			wait(1)
		until ActionTimeOUT < getticks()
		return false
	end
--[[
	3 {Item,Stack,DestID}
	X		4 {Item,Stack,DestID,Func}
	5 {Item,Stack,DestID,X,Y}
	X		6 {Item,Stack,DestID,X,Y,Func}
--]]
	local MoveItemC = function()
		--print("MoveItemC")
		-- varg[3] must be a number before calling MoveItemC
		if type(varg[3]) == "table" then
			varg[3] = varg[3].ID
		end
		if #varg == 3 then
			Drop = Drop1
		else
			Drop = Drop2
		end
		return Helper2()
	end
--[[
	4 {Item,Stack,X,Y}
	X		5 {Item,Stack,X,Y,Func}
	5 {Item,Stack,X,Y,Z}
	X		6 {Item,Stack,X,Y,Z,Func}
--]]
	local MoveItemG = function()
		--print("MoveItemG")
		if #varg == 4 then
			Drop = Drop3
		else
			Drop = Drop4
		end
		return Helper2()
	end
	local MoveItemPD = function()
		Drop = Drop5
		return Helper2()
	end
	MoveItem = function(...)
		Helper1(...)
		if type(varg[3]) == "string" then
			return MoveItemPD()
		end
		if type(varg[3]) == "table" or varg[3] > 32767 then
			return MoveItemC()
		end
		return MoveItemG()
	end
------------------------------------------------------------
-- UseItem
------------------------------------------------------------
	local UseIt = function()
		NextActionTime = getticks() + ActionTiming
		ActionTimeOUT = NextActionTime + ActionWaitTime
		JText:clear()
		UO.LObjectID = varg[1].ID
		UO.Macro(17,0)
	end
--[[
	{Item,Func}
--]]
	local Helper3 = function(Item)
		if type(Item) == "number" then
			return Item
		end
		return Item.ID
	end
	UseItem = function(...)
		varg = {...}
		if type(varg[1]) == "number" then
			varg[1] = {ID=varg[1]}
		end
		Func = nilFunc
		if #varg > 1 then
			Func = varg[2]
			if type(Func) == "string" then
				Func = BuiltIn[Func]
			end
			BuiltIn.varg = subpack(varg,3)
		elseif Func == nil then
			Func = nilFunc
		end

		while NextActionTime > getticks() do wait(1) end
		UseIt()

		repeat
			local Result = Func()
			if Result then
				return Result
			end
			local Result = JText:find(
				"perform another action",
				"too far away",
				"can't reach that")
			if Result ~= nil then
				if Result == 1 then
					wait(100)
					UseIt()
				end
				if Result > 1 then
					return false
				end
			end
			wait(1)
		until ActionTimeOUT < getticks()
		return false
	end
------------------------------------------------------------
-- Equip
------------------------------------------------------------
	local Helper4 = function()
		NextActionTime = getticks() + ActionTiming
		ActionTimeOUT = NextActionTime + ActionWaitTime
		JText:clear()
		UO.Equip(unpack(varg))
		print("Equip")
	end
	Equip = function(...)
		varg = {...}
		local temp = {}
		for i=1,#varg do
			local t = type(varg[i])
			if t == "number" then
				temp[varg[i]] = 0
			else
				temp[varg[i].ID] = 0
			end
		end
		local Items1 = ScanItems(false,{},{ContID=UO.CharID})
		varg = {}
		for k,v in pairs(temp) do
			local Item = FindItems(Items1,{ID=k})
			if #Item ~= 0 then
				table.insert(varg,k)
			end
		end
		if #varg == 0 then
			return true
		end
		while NextActionTime > getticks() do wait(1) end
		Helper4()
		repeat
			Items1 = ScanItems(false,{ID=varg,ContID=BackpackID})
			if #Items1 ~= #varg then
				return true
			end
			local Result = JText:find(
				"perform another action")
			if Result ~= nil then
				if Result == 1 then
					wait(100)
					Helper4()
				end
			end
			wait(1)
		until ActionTimeOUT < getticks()
		return false
	end
------------------------------------------------------------
-- TargetID,TargetLoc,TargetRelLoc,TargetRes,TargetRelRes
------------------------------------------------------------
	local LastTarget
	LastTarget = function()
		UO.Macro(22,0)
		for i=1,10 do
			if not UO.TargCurs then
				return
			end
			wait(1)
		end
		LastTarget()
	end
	TargetID = function(...)
		varg = {...}
		if type(varg[1]) == "number" then
			varg[1] = {ID=varg[1]}
		end
		UO.LTargetKind = 1
		UO.LTargetID = varg[1].ID
		LastTarget()
	end
	TargetLoc = function(...)
		varg = {...}
		UO.LTargetKind = 2
		UO.LTargetX = varg[1]
		UO.LTargetY = varg[2]
		UO.LTargetZ = varg[3]
		LastTarget()
	end
	TargetRelLoc = function(...)
		varg = {...}
		return TargetLoc(
			varg[1] + UO.CharPosX,
			varg[2] + UO.CharPosY,
			varg[3] + UO.CharPosZ)
	end
	TargetRes = function(...)
		varg = {...}
		UO.LTargetKind = 3
		UO.LTargetX = varg[1]
		UO.LTargetY = varg[2]
		UO.LTargetZ = varg[3]
		UO.LTargetTile = varg[4]
		LastTarget()
	end
	TargetRelRes = function(...)
		varg = {...}
		return TargetRes(
			varg[1] + UO.CharPosX,
			varg[2] + UO.CharPosY,
			varg[3] + UO.CharPosZ,
			varg[4])
	end
end

MoveItemC = MoveItem
MoveItemG = MoveItem
-- CastSpell(NAME,ID) .. Target spell onto an ID
-- CastSpell(NAME,X,Y,Z .. Target spell onto a location
-- CastSpell(NAME,true) .. Cast spell and wait for mana drop
-- CastSpell(NAME,false) .. Cast spell and return immediately
-- CastSpell(NAME) .. same as CastSpell(NAME,false)

CastSpell = function(Spell,...)
	--SetLastError("")
	local Journal = journal.new()
	local varg = {...}
	if Spell ~= nil then
		if type(Spell) == "string" then
			local index = string.find(	"clumsy|create food|feeblemind|heal|magic arrow|night sight|reactive armor|weaken|agility|cunning|cure|harm|magic trap|magic untrap|protection|strength|bless|fireball|magic lock|poison|telekinesis|teleport|unlock|wall of stone|arch cure|arch protection|curse|fire field|greater heal|lightning|mana drain|recall|blade spirits|dispel field|incognito|magic reflection|mind blast|paralyze|poison field|summon creature|dispel|energy bolt|explosion|invisibility|mark|mass curse|paralyze field|reveal|chain lightning|energy field|flame strike|gate travel|mana vampire|mass dispel|meteor swarm|polymorph|earthquake|energy vortex|resurrection|air elemental|summon daemon|earth elemental|fire elemental|water elemental|animate dead|blood oath|corpse skin|curse weapon|evil omen|horrific beast|lich form|mind rot|pain spike|poison strike|strangle|summon familure|vampiric embrace|vengeful spirit|wither|wraith form|exorcism|honorable execution|confidence|evasion|counter attack|lightning strike|momentum strike|cleanse by fire|close wounds|consecrate weapon|dispel evil|divine fury|enemy of one|holy light|noble sacrifice|remove curse|sacred journey|focus attack|death strike|animal form|ki attack|surprise attack|backstab|shadowjump|mirror image|arcane circle|gift of renewal|immolating weapon|attunement|thunderstorm|nature's fury|summon fey|summon fiend|reaper form|wildfire|essence of wind|dryad allure|ethereal voyage|word of death|gift of life|arcane empowerment|nether bolt|healing stone|purge magic|enchant|sleep|eagle strike|animated weapon|stone form|spell trigger|mass sleep|cleansing winds|bombard|spell plague|hail storm|nether cyclone|rising colossus|arcane circle|gift of renewal|immolating weapon|attunement|thunderstorm|nature's sury|summon fey|summon fiend|reaper form|wildfire|essence of wind|dryad allure|ethereal voyage|word of death|gift of life|arcane empowerment|",string.lower(Spell))
			Spell = 0 + string.sub(		"000____001_________002________003__004_________005_________006____________007____008_____009_____010__011__012________013__________014________015______016___017______018________019____020_________021______022____023___________024_______025_____________026___027________028__________029_______030________031____032___________033__________034_______035______________036________037______038__________039_____________040____041_________042_______043__________044__045________046____________047____048_____________049__________050__________051_________052__________053_________054__________055_______056________057___________058__________059___________060___________061_____________062____________063_____________101__________102________103_________104__________105_______106____________107_______108______109________110___________111______112_____________113______________114_____________115____116_________117______145_________________146________147_____148____________149______________150_____________201_____________202__________203_______________204_________205_________206__________207________208_____________209__________210____________245__________246__________247_________248_______249_____________250______251________252__________601___________602_____________603_______________604________605__________606___________607________608__________609_________610______611_____________612__________613_____________614___________615__________616________________678_________679___________680_________681_____682___683__________684_____________685________686___________687________688_____________689_____690__________691________692____________693_____________601___________602_____________603_______________604________605__________606___________607________608__________609_________610______611_____________612__________613_____________614___________615__________616________________",index,index+2)
		end
		UO.Macro(15,Spell)
		-- spell cast return immediately
		if #varg == 0 then
			return true
		end
	end
	-- target item
	if type(varg[1]) ~= "function" then
		if #varg == 1 then
			if varg[1] == false then
				return true
			end
			if varg[1] ~= true then
				UO.LTargetID = varg[1]
				UO.LTargetKind = 1
			end
	-- target found
		elseif #varg == 3 then
			UO.LTargetX = varg[1]
			UO.LTargetY = varg[2]
			UO.LTargetZ = varg[3]
			UO.LTargetKind = 2
		end
	end
	for i=1,50 do
		if UO.TargCurs == false then
			break
		end
		wait(1)
	end
	local Mana = UO.Mana
	local Ticks = getticks()
	local CastTimeOUT = Ticks + 1000  -- if char has not started casting by now FAIL
	local FuncTimeOUT = Ticks + 6000 -- 5000 is 6000 max before a TimeOUT
	wait(50)
	while true do
		local Result =  Journal:find(
			"More reagents are needed", -- {CHARNAME}: More reagents are needed for this spell.
			"Target cannot be seen.",   -- Target cannot be seen.
			"Target is too far away.",  -- Target is too far away.
			"The spell fizzles",        -- {CHARNAME}: The Spell fizzles.
			"Insufficient mana",        -- {CHARNAME}: Insufficient mana for this spell.
			"You cannot teleport",      -- You cannot teleport from here to the destination.
			--"You cannot teleport",    -- You cannot teleport into that area.
			"There is already",         -- There is already a gate there.
			"I cannot gate travel",     -- {CHARNAME}: I cannot gate travel from that obkect.
			"You have not yet recover", -- You have not yet recovered from casting a spell.
			"Something is blocking",    -- Something is blocking the location.
			"You are already casting",  -- You are already casting a spell.
			"Cannot teleport to that")  -- You are already casting a spell.
		if Result ~= nil then
			--SetLastError(Journal:last())
			return false, Journal:last()
		end
		if UO.TargCurs == true and varg[1] ~= true then
			if type(varg[1]) == "function" then
				varg[1]()
			end
			UO.Macro(22,0)
			while UO.TargCurs == true do
				wait(1)
			end
		end
		local Temp = UO.Mana
		if Temp > Mana then
			Mana = Temp
		end
		if Temp < Mana then
			return true,""
		end
		Ticks = getticks()
		if Ticks > FuncTimeOUT then
			break
		end
		if Ticks > CastTimeOUT then
			break
		else
			local CharStatus = UO.CharStatus
			if #CharStatus > 0 and string.find(CharStatus,"A",1,true) ~= nil then
				CastTimeOUT = FuncTimeOUT
			end
		end
		wait(1)
	end
	--SetLastError("castspell.lua - CastSpell timed out")
	return false,""
end

------------------------------------
-- Script Name: GetItemData.lua
-- Author: Kal In Ex
-- Version: 1.2
-- Client Tested with: 7.0.18.1 (Patch 95)
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: OSI
-- Revision Date: May 22, 2012
-- Public Release: May 10, 2012
-- Purpose:
-- Copyright: 2012 Kal In Ex
------------------------------------
-- http://www.easyuo.com/forum/viewtopic.php?t=43949

local GIDFT = {
	["Total Resist"] = function(p)
		return
			(p["Physical Resist"] or 0) +
			(p["Fire Resist"] or 0) +
			(p["Cold Resist"] or 0) +
			(p["Poison Resist"] or 0) +
			(p["Energy Resist"] or 0)
	end}

local GIDMT = {
	__index = function(t,n)
		for k,v in pairs(t) do
			if string.lower(n) == string.lower(k) then
				return v
			end
		end
		if GIDFT[n] ~= nil then
			return GIDFT[n](t)
		end
		for k,v in pairs(GIDFT) do
			if string.lower(n) == string.lower(k) then
				return GIDFT[k](t)
			end
		end
	end}

GetItemData = function(s)
	local p = {}
	local f = string.gmatch(s.."\r\n","([^%c]+)\r\n")
	repeat
		local l = f()
		if l == nil then break end
		local t = string.match(l,"%s*([%a%s-\"*]+)")
		if string.sub(t,-1,-1) == "-" then
			t = string.sub(t,1,-2)
		end
		if string.sub(t,-1,-1) == " " then
			t = string.sub(t,1,-2)
		end
		local s,e = string.find(l,t,1,true)
		l = string.sub(l,1,s-1)..string.sub(l,e+1,-1)
		local f = string.gmatch(l,"([%d,-]+)")
		local v = f()
		if v ~= nil then
			v = tonumber((string.gsub(v,",","")))
		else
			v = string.match(l,"[^%a]*([%a%s-\"*]+)")
			if v == nil then
				v = true
			end
		end
		p[t] = v
	until false
	setmetatable(p,GIDMT)
	return p
end
------------------------------------
-- Script Name: Popup.lua
-- Author: Kal In Ex
-- Version: 1.0
-- Client Tested with: 7.0.12.0
-- OpenEUO version tested with: 0.91.0013
-- Shard OSI / FS: OSI
-- Revision Date: February 14, 2011
-- Public Release: February 14, 2011
-- Purpose: Using UO.Popup
-- Copyright: 2011 Kal In Ex
------------------------------------

Popup = function(...)
	local varg = {...}
	local nvar = #varg
	if nvar == 1 then
		varg[2] = 0
		varg[3] = 0
		varg[4] = 1
	end
	if nvar == 2 then
		varg[4] = varg[2]
		varg[2] = 0
		varg[3] = 0
	end
	if nvar == 3 then
		varg[4] = 1
	end
	if varg[1] ~= nil then
		UO.Popup(varg[1],varg[2],varg[3])
		local TimeOUT = getticks() + 5000
		repeat
			wait(1)
			if getticks() > TimeOUT then
				return false
			end
		until UO.ContName == "normal gump" and UO.ContPosX == varg[2] and UO.ContPosY == varg[3]
	end
	if nvar ~= 1 and varg[4] ~= nil then
		local ClickX = varg[2] + 18
		local ClickY = varg[3] + 18 * varg[4]
		UO.Click(ClickX,ClickY,true,true,true,false)
	end
	return true
end
----------------------------------------
-- Cheffe's File Access Functions ------
----------------------------------------

function LoadData(fn)
  local f,e = openfile(fn,"rb")         --r means read-only (default)
  if f then                             --anything other than nil/false evaluates to true
    local s = f:read("*a")              --*a means read all
    f:close()
    return s
  else                                  --if openfile fails it returns nil plus an error message
    error(e,2)                          --stack level 2, error should be reported
  end                                   --from where LoadData() was called!
end

----------------------------------------

function SaveData(fn,s)
  local f,e = openfile(fn,"w+b")        --w+ means overwrite
  if f then
    f:write(s)
    f:close()
  else
    error(e,2)
  end
end

----------------------------------------
-- Cheffe's Table Converter Functions --
----------------------------------------

local function ToStr(value,func,spc)
  local t = type(value)                 --get type of value
  if t=="string" then
    return string.format("%q",value):gsub("\\\n","\\n"):gsub("\r","\\r")
  end
  if t=="table" then
    if func then
      return func(value,spc.."  ")
    else
      error("Tables not allowed as keys!",2)
    end
  end
  if t=="number" or t=="boolean" or t=="nil" then
    return tostring(value)
  end
  error("Cannot convert unknown type to string!",2)
end

----------------------------------------

local function TblToStr(t,spc)
  local s = "{\r\n"
	-- Kal In Ex modified this routine so that it uses tabs instead of "  "
	-- for spc. The key and value pairs are also written to the string
	-- sorted instead of letting the lua pairs function set the order =>
	local sorted_pairs = {}
	for k,v in pairs(t) do
		table.insert(sorted_pairs,k)
	end
	table.sort(sorted_pairs,
		function(a,b)
			local ta,tb = type(a), type(b)
			if ta == tb then
				return a < b
			end
			if ta == "string" then
				return true
			end
			return false
		end)
	for i=1,#sorted_pairs do
		local k = sorted_pairs[i]
		local v = t[k]
		s = s..spc.."  ["..ToStr(k).."] = "..ToStr(v,TblToStr,spc)..",\r\n"
	end
	return s..spc.."}"
end

----------------------------------------

function TableToString(table)
  return TblToStr(table,"")
end

----------------------------------------
----------------------------------------
----------------------------------------

do
	local _ = TableToString
	TableToString = function(...)
		return (string.gsub(_(...),"\r\n","\r"))
	end
end
