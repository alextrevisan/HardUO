--[[
;----------------------------------
; Script Name: FindConts.lua
; Author: Kal In Ex
; Version: 1.5
; Client Tested with: 7.0.10.1 (Patch 95)
; EUO version tested with: OpenEUO 0.91.0008
; Shard OSI / FS: OSI
; Revision Date: December 19, 2010
; Public Release: October 26, 2010
; Purpose: A "FindItem" for containers
; Copyright: 2010 Kal In Ex
;----------------------------------]]

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
	for i=1,#t do
		local flag = true
		for j=1,#t_key_names do
			flag = CheckValue(true,t[i][t_key_names[j]],arg[1][t_key_names[j]])
			if flag == false then break end
		end
		if flag == true then
			for j=1,#f_key_names do
				flag = CheckValue(false,t[i][f_key_names[j]],arg[2][f_key_names[j]])
				if flag == false then break end
			end
		end
		if flag == true then
			table.insert(r,t[i])
		end
	end
	return r
end

local GetCont = function(i)
	local t = {Index = i}
	t.Name,t.X,t.Y,t.SX,t.SY,t.Kind,t.ID,t.Type,t.HP = UO.GetCont(i)
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
