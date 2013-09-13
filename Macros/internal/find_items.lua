------------------------------------
-- Script Name: FindItem.lua
-- Author: Kal In Ex
-- Version: 1.1
-- Client Tested with: 7.0.18.1 (Patch 95)
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: OSI
-- Revision Date: February 5, 2013
-- Public Release: February 5, 2013
-- Purpose: OpenEUO version of FindItem
-- Copyright: 2013 Kal In Ex
------------------------------------
 
do
	local Cnt1
	local Cnt2
	local Tbl
	local UO_ScanItems = UO.ScanItems

	local ScanItems = function(b)
		Cnt1 = UO_ScanItems(b)
		Cnt2 = -1
		return Cnt1
	end

	local FindItems = function(f)
		local Ret = {}
		if Cnt2 == -1 then
				Tbl = {}
				for Index=0,Cnt1-1 do
						local ID,Type,Kind,ContID,X,Y,Z,Stack,Rep,Col = UO.GetItem(Index)
						Tbl[Index] = {Index=Index,ID=ID,Type=Type,Kind=Kind,ContID=ContID,X=X,Y=Y,Z=Z,Stack=Stack,Rep=Rep,Col=Col}
				end
				Cnt2 = Cnt1
		end
		for Index=0,Cnt1-1 do
				if f(Tbl[Index]) then
						table.insert(Ret,Tbl[Index])
				end
		end
		return Ret
	end

-- make local functions global
	_G["ScanItems"] = ScanItems
	_G["FindItems"] = FindItem
end