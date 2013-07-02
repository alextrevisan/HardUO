------------------------------------
-- Script Name: FindItems.lua
-- Author: Kal In Ex
-- Version: 2.5
-- Client Tested with: 7.0.11.2 (Patch 95)
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: OSI
-- Revision Date: January 21, 2011
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
local IMT = {}
IMT.__index = function(table,key)
	--print("__index")
	if key == "Name" or key == "Details" or key == "BODInfo" then
		local Name,Details = UO.Property(table.ID)
		rawset(table,"Name",Name)
		rawset(table,"Details",Details)
		--rawset(table,"Prop",string.gsub(Name.."$"..Details.."$","\r\n","$"))
		if table.Type == 8792 then
			rawset(table,"BODInfo",GetBODInfo(table.Details))
		end
	end
	return rawget(table,key)
end

local CheckProperty = function(bool,find,string,search)
	if find.Name == nil then
		find.Name,find.Details = UO.Property(find.ID)
	end
	if type(search[string]) ~= "table" then
		if string.find(string.lower(find[string]),string.lower(search[string]),1,true) ~= nil then
			if bool == true then return true else return false end
		end
		if bool == true then return false else return true end
	end
	for i=1,#search[string] do
		if string.find(string.lower(find[string]),string.lower(search[string][i]),1,true) ~= nil then
			if bool == true then return true else return false end
		end
	end
	if bool == true then return false else return true end
end

local CheckValue = function(bool,find,search)
	if type(search) ~= "table" then
		if find == search then
			if bool == true then return true else return false end
		end
		if bool == true then return false else return true end
	end
	for i=1,#search do
		if find == search[i] then
			if bool == true then return true else return false end
		end
	end
	if bool == true then return false else return true end
end

local Compare = {}
Compare.ID = function(bool,find,search) return CheckValue(bool,find.ID,search.ID) end
Compare.Type = function(bool,find,search) return CheckValue(bool,find.Type,search.Type) end
Compare.Kind = function(bool,find,search) return CheckValue(bool,find.Kind,search.Kind) end
Compare.ContID = function(bool,find,search) return CheckValue(bool,find.ContID,search.ContID) end
Compare.X = function(bool,find,search) return CheckValue(bool,find.X,search.X) end
Compare.Y = function(bool,find,search) return CheckValue(bool,find.Y,search.Y) end
Compare.Z = function(bool,find,search) return CheckValue(bool,find.Z,search.Z) end
Compare.Stack = function(bool,find,search) return CheckValue(bool,find.Stack,search.Stack) end
Compare.Rep = function(bool,find,search) return CheckValue(bool,find.Rep,search.Rep) end
Compare.Col = function(bool,find,search) return CheckValue(bool,find.Col,search.Col) end
Compare.RelX = function(bool,find,search) return CheckValue(bool,find.RelX,search.RelX) end
Compare.RelY = function(bool,find,search) return CheckValue(bool,find.RelY,search.RelY) end
Compare.Dist = function(bool,find,search)
	if find.Dist == nil then return false end
	if type(search.Dist) == "number" then
		if find.Dist <= search.Dist then
			if bool == true then return true else return false end
		end
		if bool == false then return true else return false end
	elseif type(search) == "table" then
		return CheckValue(bool,find.Dist,search.Dist)
	end
end
Compare.Name = function(bool,find,search) return CheckProperty(bool,find,"Name",search) end
Compare.Details = function(bool,find,search) return CheckProperty(bool,find,"Details",search) end
--Compare.Prop = function(bool,find,search) return CheckProperty(bool,find,"Prop",search) end

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
		if string.find("|ID|Type|Kind|ContID|X|Y|Z|Stack|Rep|Col|RelX|RelY|Dist|","|"..k.."|",1,true) then
			table.insert(t_key_names,k)
		elseif string.find("|Name|Details|","|"..k.."|",1,true) then
			table.insert(te_key_names,k)
		end
	end
	for k,v in pairs(arg[2]) do
		if string.find("|ID|Type|Kind|ContID|X|Y|Z|Stack|Rep|Col|RelX|RelY|Dist|","|"..k.."|",1,true) then
			table.insert(f_key_names,k)
		elseif string.find("|Name|Details|","|"..k.."|",1,true) then
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
				flag = Compare[t_key_names[j]](true,t[i],arg[1])
				if flag == false then break end
			end
		end
		if flag == true and f_key_count > 0 then
		    local flag2 = true
			for j=1,f_key_count do
				flag2 = Compare[f_key_names[j]](true,t[i],arg[2])
				if flag2 == false then break end
			end
			if flag2 == true then
				flag = false
			end
		end
		if flag == true then
			for j=1,te_key_count do
				flag = Compare[te_key_names[j]](true,t[i],arg[1])
				if flag == false then break end
			end
		end
		if flag == true and fe_key_count > 0 then
			local flag2 = true
			for j=1,fe_key_count do
				flag2 = Compare[fe_key_names[j]](true,t[i],arg[2])
				if flag2 == false then break end
			end
			if flag2 == true then
				flag = false
			end
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
		--t.RelZ = t.Z - CharPos.Z
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
-----------------------------------------------
-- search for items using supplied filter(s) --
-----------------------------------------------
	if ... ~= nil then
		t = FindItems(t,...)
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
			for k,v in pairs(Table) do
				Table[k] = nil
			end
			Table["ID"] = {}
			Table["Type"] = {}
			Table["Group"] = {}
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
	for i=1,#Table[CodeType] do
		if Table[CodeType][i] == IDType then
			table.remove(Table[CodeType],i)
			return
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
local GetBODInfo = function(Details)
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
