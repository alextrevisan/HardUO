--------------------------------------
-- Script Name: FAST OCR to get text information from UO gumps
-- Author: Kal In Ex
-- Version: 6.2 (not a final edit)
-- Client Tested with: 7.0.12.0 (Patch 95)
-- EUO version tested with: OpenEUO 0.91.0013
-- Shard OSI / FS: OSI
-- Revision Date: Februrary 27, 2011
-- Public Release: January 22, 2004
-- Purpose: get text information from gumps into EasyUO for scripting
-- Copyright: 2004-2011 Kal In Ex
--------------------------------------
-- http://www.easyuo.com/forum/viewtopic.php?t=43234

KAL = {}
KalOCR = KAL

local ScanConts = function(ContSX,ContSY)
	local X,Y,SX,SY,_
	for i=0,999 do
		_,X,Y,SX,SY,_,_,_,_ = UO.GetCont(i)
		if X == nil then
			break
		end
		if SX == ContSX and SY == ContSY then
			break
		end
	end
	if X == nil then
		return nil
	end
	return X,Y
end

KAL.GetRentalContract = function()
	--local X,Y = ScanConts(452,236)
	local X,Y = ScanConts(345,359)
	if X == nil then
		return nil
	end
	local LandlordName = KAL.TextScan(X+151,Y+59,"IN",15707788,"text")
	local ContractLength = KAL.TextScan(X+230,Y+95,"IN",524288,"text")
	local PricePerRental = tonumber(KAL.TextScan(X+231,Y+116,"IN",15707788,"number"))
	local RenewLandlord = KAL.TextScan(X+230,Y+190,"IN",524288,"text")
	local RenewRenter = KAL.TextScan(X+230,Y+210,"IN",524288,"text")
	local RenewalPrice = tonumber(KAL.TextScan(X+231,Y+251,"IN",15707788,"number"))
	return LandlordName,ContractLength,PricePerRental,RenewLandlord,RenewRenter,RenewalPrice
end

KAL.GetVendorMenu = function()
	local X,Y = ScanConts(567,205)
	if X == nil then
		return nil
	end
	local DaysPaid = tonumber(KAL.TextScan(X+301,Y+36,"IN",16250871,"number"))
	local DailyCharge = tonumber(KAL.TextScan(X+301,Y+59,"IN",16250871,"number"))
	local GoldHeld = tonumber(KAL.TextScan(X+301,Y+83,"IN",16250871,"number"))
	return DaysPaid,DailyCharge,GoldHeld
end

KAL.GetShopInfo = function()
	local X,Y = ScanConts(283,307)
	if X == nil then
		return nil
	end
	local Text = ""
	for i=1,4 do
		s = KAL.TextScan(X+92,Y+50+i*18,"in","148_2177131","text","   ")
		if s == "" then
			break
		end
		Text = Text..s.." "
	end
	local Name,Price = string.match(Text,"([^%d]-) at ([%dO]+)")
	Price = tonumber((string.gsub(Price,"O","0")))
	return Name,Price
end

--[[
KAL.GetShopInfo = function()
	local X,Y = ScanConts(283,307)
	if X == nil then
		return nil
	end
	local text = KAL.TextScan(X+92,Y+68,"in","148_2177131","text")
	local temp = KAL.TextScan(X+92,Y+86,"in","148_2177131","text")
	if temp ~= "" then text = text.." "..temp end
	local temp = KAL.TextScan(X+92,Y+104,"in","148_2177131","text")
	if temp ~= "" then text = text.." "..temp end
-- change capital O's in text to ZERO's
	local i = string.find(text,"at") or 0
	text = string.sub(text,1,i)..string.gsub(string.sub(text,i+1),"O","0")
-- get the price from text
	local price
	price = string.sub(text,(string.find(text," at ") or 0) + 4)
	price = string.sub(price,1,(string.find(price,"gp") or 0) - 1)
-- remove the price from text
	text = string.sub(text,1,(string.find(text," at ") or 0) - 1)
	return text,price
end
--]]

function KAL.GetBodInfo(XPos,YPos,GumpSize)
	local textcolor = UO.GetPix(XPos+429,YPos+77)
	local numbercolor = UO.GetPix(XPos+422,YPos+102)
	local bodcount
	local type, item, qualtiy, material, amount, price
	local index = 0
	local items = {}
	if GumpSize == nil then
		GumpSize = 536 --(no price colum when opened from a secure)
	end
	for i=0,9 do
		item = KAL.ReadText(XPos+103,YPos+96+i*32,"IN",textcolor,"TEXT",129)
		if item == "" then break end
		type = KAL.ReadText(XPos+61,YPos+96+i*32,"IN",textcolor,"TEXT",34," ")
		if type ~= "" then
			index = index + 1
			bodcount = 0
			items[index] = {}
		end
		bodcount = bodcount + 1
		items[index][bodcount] = {}
		items[index][bodcount].Item = item
		items[index][bodcount].Type = type
		items[index][bodcount].Quality =  KAL.ReadText(XPos+235,YPos+96+i*32,"IN",textcolor,"TEXT",77)
		items[index][bodcount].Material = KAL.ReadText(XPos+316,YPos+96+i*32,"IN",textcolor,"TEXT",100)
		items[index][bodcount].Amount =   KAL.ReadText(XPos+422,YPos+97+i*32,"IN",numbercolor,"NUMBER",70)
		if GumpSize > 536 and bodcount == 1 then
			items[index][bodcount].Price = KAL.ReadText(XPos+496,YPos+97+i*32,"IN",numbercolor,"NUMBER",78)
		end
	end
	return items
end

function KAL.GetRunebook(bGetCoords)
	-- if bGetCoords == nil then bGetCoords == false end -- this is not needed
	local X,Y = ScanConts(452,236)
	if X == nil then
		return nil
	end
	local runebook = {}
--[[
	for i=0,999 do
		local Name,X,Y,SX,SY,Kind,ID,Type,HP = UO.GetCont(i)
		if Kind == nil then
			return nil
		end
		if SX == 452 and SY == 236 then
			runebook["x"] = X
			runebook["y"] = Y
			break
		end
	end
--]]
	for i=1,16 do
		if KAL.IsRuneSlotEmpty(i,X,Y) == true then
			break
		end
		runebook[i] = {}
		runebook[i]["name"] = KAL.GetRuneName(i,X,Y)
		runebook["n"] = i
--		runebook[i]["color"] = KAL.LastRuneColor
	end
	if bGetCoords == true then
		for i=1,runebook["n"] do
			local page,x,y
			if i % 2 == 1 then -- left page
				local x = runebook["x"] + 420
				local y = runebook["y"] + 20
				UO.Click(x,y,true,true,true,false)
				wait(200)
				page = KAL.TextScan(X+136,Y+81,"=",524288,"number").." "..KAL.TextScan(X+152,Y+96,"=",524288,"number")
			else -- right page
				page = KAL.TextScan(X+296,Y+81,"=",524288,"number").." "..KAL.TextScan(X+312,Y+96,"=",524288,"number")
			end
			local a,b,c,d,e,f = string.gmatch(page,"(%d+)o (%d+)'(%a) (%d+)o (%d+)'(%a)")()
			if c == "N" then y = (1624 - math.floor(4096 * (a * 60 + b) / 21600 + 4096.5)) % 4096 end
			if c == "S" then y = (1624 + math.floor(4096 * (a * 60 + b) / 21600 + 4096.5)) % 4096 end
			if f == "E" then x = (1323 + math.floor(5120 * (d * 60 + e) / 21600 + 5120.5)) % 5120 end
			if f == "W" then x = (1323 - math.floor(5120 * (d * 60 + e) / 21600 + 5120.5)) % 5120 end
			runebook[i]["x"] = x
			runebook[i]["y"] = y
		end
	end
	runebook.charges = {}
	runebook.charges[1],runebook.charges[2] = KAL.GetRunebookCharges(X,Y)
	return runebook
end

KAL.GetRuneName = function(RuneSlot,TextOrNum,...)
-- old function prototype was (RuneSlot, XPos, YPos, TextOrNum)
-- this code block lets old code continue to work...
	local varg = {...}
	if #varg == 2 then
		TextOrNum = varg[2]
	end

	local XPos,YPos = ScanConts(452,236)
	if XPos == nil then
		return nil
	end
	-- check for empty runeslot
	if KAL.IsRuneSlotEmpty(RuneSlot, XPos, YPos) == true then
		return ""
	end
	-- get black color
	local XOff = XPos + 158
	local YOff = YPos + 26
	local BlkCol = 524288 --UO.GetPix(XOff, YOff)
	-- offset to rune name text
	XOff = math.floor(((RuneSlot - 1) / 8)) * 160 + XPos + 146
	YOff = ((RuneSlot - 1) % 8) * 15 + YPos + 61
	-- get text color
	local TextCol
	local XExt = XOff + 118
	local YExt = YOff + 16
	local flag = false
	for XPix = XOff, XOff + 118 do
		for YPix = YOff + 2, YOff + 16 do
			TextCol = UO.GetPix(XPix, YPix)
			if TextCol == BlkCol then
				XPix = XPix + 1
				YPix = YPix + 1
				TextCol = UO.GetPix(XPix, YPix)
				if TextCol == BlkCol then
					XPix = XPix - 1
					TextCol = UO.GetPix(XPix, YPix)
				end
				flag = true
				break
			end
		end
		if flag == true then
			break
		end
	end
	KAL.LastRuneColor = TextCol
	return KAL.TextScan(XOff, YOff,"IN",TextCol,TextOrNum)
end

function KAL.IsRuneSlotEmpty(RuneSlot, XPos, YPos)
	local XPos,YPos = ScanConts(452,236)
	if XPos == nil then
		return nil
	end
	local XOff = XPos + 158
	local YOff = YPos + 26
	local BlkCol = 524288 --UO.GetPix(XOff, YOff)
	XOff = math.floor(((RuneSlot - 1) / 8)) * 160 + XPos + 146
	YOff = ((RuneSlot - 1) % 8) * 15 + YPos + 65
	if UO.GetPix(XOff, YOff) ~= BlkCol then
		return false
	end
	XOff = XOff - 1
	YOff = YOff - 4
	for ScanLine = 1, 16 do
		if UO.GetPix(XOff, YOff) == BlkCol then
			return false
		end
		YOff = YOff + 1
	end
	return true
end

function KAL.GetRuneCount()
	local XPos,YPos = ScanConts(452,236)
	if XPos == nil then
		return nil
	end
	for i=16,1,-1 do
		if not KAL.IsRuneSlotEmpty(i) then
			return i
		end
	end
	return 0
end

function KAL.GetRunebookCharges()
	local XPos,YPos = ScanConts(452,236)
	if XPos == nil then
		return nil
	end
	local XOff = XPos + 220
	local YOff = YPos + 40
	local charges = KAL.TextScan(XOff, YOff,"IN",524288,"NUMBER")
	XOff = XPos + 400
	YOff = YPos + 40
	local maxcharges = KAL.TextScan(XOff, YOff,"IN",524288,"NUMBER")
	return charges, maxcharges
end

function KAL.TextScan(XPos, YPos, PixOP, PixCmp, TextOrNum, Delim)
	local retval = ""
	local char, size
	if Delim == nil then
		Delim = "  "
	end
	repeat
		char, size = KAL.ReadChar(XPos, YPos, PixOP, PixCmp, TextOrNum)
		retval = retval .. char
		XPos = XPos + size
	until string.find(retval,Delim) ~= nil
	return string.sub(retval,1,string.find(retval,Delim)-1)
end

function KAL.ReadText(XPos, YPos, PixOP, PixCmp, TextOrNum, XOff, Delim)
	local retval = ""
	XOff = XOff + XPos
	if Delim == nil then
		Delim = "  "
	end
	repeat
		char, size = KAL.ReadChar(XPos, YPos, PixOP, PixCmp, TextOrNum)
		retval = retval .. char
		XPos = XPos + size
	until XPos > XOff
	if string.find(retval,Delim) ~= nil then
		retval = string.sub(retval,1,string.find(retval,Delim)-1)
	end
	return retval
end

function CmpPix(XPos, YPos, PixOP, PixCmp)
	if PixOP == "=" or PixOP == "==" then
		PixOP = "in"
	end
	if PixOP == "<>" then
		PixOP = "notin"
	end
--	PixOP = string.upper(PixOP)
	PixCmp = "_" .. tostring(PixCmp) .. "_"
	local PixCol = UO.GetPix(XPos,YPos)
	if PixCol == -1 then
		return false
	end
	PixCol = "_"..PixCol.."_"
	if PixOP == "in" then
		if string.find(PixCmp,PixCol) then
			return true
		end
		return false
	end
	if PixOP == "notin" then
		if string.find(PixCmp,PixCol) then
			return false
		end
		return true
	end
	error("KalOCR - pixel comparison using "..PixOP.." is undefined")
	return false
end

function KAL.ReadChar(XPos, YPos, PixOP, PixCmp, TextOrNum)
	PixOP = string.lower(PixOP)
	if CmpPix(XPos, YPos+5, PixOP, PixCmp) then
		if CmpPix(XPos, YPos+13, PixOP, PixCmp) then
			if CmpPix(XPos, YPos+4, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+3, PixOP, PixCmp) then
					if CmpPix(XPos, YPos+2, PixOP, PixCmp) then
						return "[",4
					end
					if CmpPix(XPos, YPos+15, PixOP, PixCmp) then
						return "|",2
					end
					return "(",4
				end
				if CmpPix(XPos+2, YPos+4, PixOP, PixCmp) then
					if CmpPix(XPos+2, YPos+8, PixOP, PixCmp) then
						if CmpPix(XPos+2, YPos+13, PixOP, PixCmp) then
							if CmpPix(XPos+4, YPos+5, PixOP, PixCmp) then
								return "B",8
							end
							return "E",7
						end
						return "F",7
					end
					if CmpPix(XPos+2, YPos+9, PixOP, PixCmp) then
						if CmpPix(XPos+2, YPos+10, PixOP, PixCmp) then
							return "R",8
						end
						return "P",8
					end
					if CmpPix(XPos, YPos+7, PixOP, PixCmp) then
						return "D",8
					end
					return "%",10
				end
				if CmpPix(XPos+2, YPos+8, PixOP, PixCmp) then
					if CmpPix(XPos+2, YPos+6, PixOP, PixCmp) then
						if CmpPix(XPos, YPos+7, PixOP, PixCmp) then
							return "N",8
						end
						return "X",8
					end
					if CmpPix(XPos+2, YPos+9, PixOP, PixCmp) then
						return "K",8
					end
					return "H",8
				end
				if CmpPix(XPos, YPos+11, PixOP, PixCmp) then
					if CmpPix(XPos+2, YPos+5, PixOP, PixCmp) then
						return "M",10
					end
					if CmpPix(XPos+2, YPos+13, PixOP, PixCmp) then
						return "L",7
					end
					return "I",3
				end
				return "!",3
			end
			if CmpPix(XPos+2, YPos+11, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+6, PixOP, PixCmp) then
					if CmpPix(XPos, YPos+8, PixOP, PixCmp) then
						return "k",6
					end
					return "2",8
				end
				return ">",8
			end
			if CmpPix(XPos+2, YPos+8, PixOP, PixCmp) then
				if CmpPix(XPos+2, YPos+13, PixOP, PixCmp) then
					return "b",6
				end
				return "h",6
			end
			if CmpPix(XPos, YPos+7, PixOP, PixCmp) then
				return "l",3
			end
			return "i",3
		end
		if CmpPix(XPos, YPos+11, PixOP, PixCmp) then
			if CmpPix(XPos+3, YPos+8, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+7, PixOP, PixCmp) then
					if CmpPix(XPos, YPos+4, PixOP, PixCmp) then
						return "5",8
					end
					if CmpPix(XPos, YPos+8, PixOP, PixCmp) then
						return "G",8
					end
					return "S",8
				end
				if CmpPix(XPos, YPos+10, PixOP, PixCmp) then
					return "8",8
				end
				return "3",8
			end
			if CmpPix(XPos+4, YPos+5, PixOP, PixCmp) then
				if CmpPix(XPos+3, YPos+9, PixOP, PixCmp) then
					return "Q",9
				end
				if CmpPix(XPos+5, YPos+8, PixOP, PixCmp) then
					if TextOrNum ~= nil and string.lower(TextOrNum) == "number" then
						return "0",8
					end
					return "O",8
				end
				return "C",8
			end
			if CmpPix(XPos, YPos+4, PixOP, PixCmp) then
				return "U",8
			end
			return "6",8
		end
		if CmpPix(XPos+2, YPos+9, PixOP, PixCmp) then
			if CmpPix(XPos, YPos+4, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+7, PixOP, PixCmp) then
					if CmpPix(XPos+6, YPos+4, PixOP, PixCmp) then
						return "V",8
					end
					return "W",12
				end
				return "Y",9
			end
			if CmpPix(XPos, YPos+6, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+7, PixOP, PixCmp) then
					return "9",8
				end
				return "?",7
			end
			return "1",4
		end
		if CmpPix(XPos+1, YPos+6, PixOP, PixCmp) then
			if CmpPix(XPos, YPos+4, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+6, PixOP, PixCmp) then
					return "4",8
				end
				return "'",3
			end
			return "\\",9
		end
		if CmpPix(XPos, YPos+6, PixOP, PixCmp) then
			if CmpPix(XPos+1, YPos+4, PixOP, PixCmp) then
				return "`",3
			end
			return '"',4
		end
		return "7",8
	end
	if CmpPix(XPos, YPos+9, PixOP, PixCmp) then
		if CmpPix(XPos+4, YPos+13, PixOP, PixCmp) then
			if CmpPix(XPos, YPos+8, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+12, PixOP, PixCmp) then
					if CmpPix(XPos, YPos+13, PixOP, PixCmp) then
						if CmpPix(XPos+5, YPos+8, PixOP, PixCmp) then
							return "m",9
						end
						return "n",6
					end
					return "y",6
				end
				if CmpPix(XPos, YPos+7, PixOP, PixCmp) then
					return "@",12
				end
				if CmpPix(XPos, YPos+10, PixOP, PixCmp) then
					return "w",8
				end
				return "x",6
			end
			if CmpPix(XPos+2, YPos+11, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+10, PixOP, PixCmp) then
					return "e",6
				end
				return "<",8
			end
			if CmpPix(XPos+3, YPos+14, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+15, PixOP, PixCmp) then
					return "g",6
				end
				return "q",6
			end
			if CmpPix(XPos+3, YPos+5, PixOP, PixCmp) then
				return "d",6
			end
			return "a",6
		end
		if CmpPix(XPos, YPos+12, PixOP, PixCmp) then
			if CmpPix(XPos, YPos+13, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+6, PixOP, PixCmp) then
					return "A",8
				end
				if CmpPix(XPos, YPos+14, PixOP, PixCmp) then
					return "p",6
				end
				return "r",6
			end
			if CmpPix(XPos, YPos+8, PixOP, PixCmp) then
				return "u",6
			end
			if CmpPix(XPos+3, YPos+11, PixOP, PixCmp) then
				return "o",6
			end
			return "c",6
		end
		if CmpPix(XPos, YPos+8, PixOP, PixCmp) then
			if CmpPix(XPos, YPos+10, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+11, PixOP, PixCmp) then
					return "v",6
				end
				return "^",10
			end
			return "+",7
		end
		if CmpPix(XPos, YPos+10, PixOP, PixCmp) then
			return "s",6
		end
		if CmpPix(XPos+1, YPos+4, PixOP, PixCmp) then
			return "{",5
		end
		return "-",6
	end
	if CmpPix(XPos+1, YPos+13, PixOP, PixCmp) then
		if CmpPix(XPos, YPos+13, PixOP, PixCmp) then
			if CmpPix(XPos+1, YPos+11, PixOP, PixCmp) then
				if CmpPix(XPos, YPos+4, PixOP, PixCmp) then
					return "Z",8
				end
				return "z",6
			end
			if CmpPix(XPos, YPos+12, PixOP, PixCmp) then
				if CmpPix(XPos+1, YPos+14, PixOP, PixCmp) then
					return ",",3
				end
				return ".",3
			end
			return "j",6
		end
		if CmpPix(XPos, YPos+11, PixOP, PixCmp) then
			if CmpPix(XPos, YPos+6, PixOP, PixCmp) then
				return ";",3
			end
			if CmpPix(XPos+1, YPos+5, PixOP, PixCmp) then
				return "&",11
			end
			return "J",8
		end
		if CmpPix(XPos, YPos+2, PixOP, PixCmp) then
			return ")",4
		end
		if CmpPix(XPos, YPos+3, PixOP, PixCmp) then
			return "}",5
		end
		return "f",6
	end
	if CmpPix(XPos+2, YPos+9, PixOP, PixCmp) then
		if CmpPix(XPos+1, YPos+10, PixOP, PixCmp) then
			if CmpPix(XPos, YPos+8, PixOP, PixCmp) then
				return "t",6
			end
			if CmpPix(XPos, YPos+10, PixOP, PixCmp) then
				return "#",12
			end
			return "/",9
		end
		if CmpPix(XPos, YPos+2, PixOP, PixCmp) then
			return "]",5
		end
		if CmpPix(XPos, YPos+4, PixOP, PixCmp) then
			return "T",7
		end
		return "$",9
	end
	if CmpPix(XPos+1, YPos+11, PixOP, PixCmp) then
		if CmpPix(XPos, YPos+4, PixOP, PixCmp) then
			return "*",10
		end
		if CmpPix(XPos, YPos+6, PixOP, PixCmp) then
			return ":",3
		end
		return "=",6
	end
	if CmpPix(XPos, YPos+1, PixOP, PixCmp) then
		return "~",6
	end
	if CmpPix(XPos, YPos+15, PixOP, PixCmp) then
		return '_',8
	end
	return " ",8
end
