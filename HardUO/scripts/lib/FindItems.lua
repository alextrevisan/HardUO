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
		local Name,Details = UO.Property(table.ID)
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
