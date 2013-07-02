--------------------------------------
-- Script Name:
-- Author: Kal In Ex
-- Version: 1.0
-- Client Tested with:
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: OSI
-- Revision Date: March 18,2012
-- Public Release: Februrary 29, 2012
-- Purpose:
-- Copyright: Kal In Ex
--------------------------------------

--[[
	start with tinkering/blacksmithy on TC1 shard (need ingots in backpack)
	run to gargoyle city and buy a blow pipe, next stop is the bank
	when at the bank press play

	Prints the resulting table where every items data has the following format

	[0] = skillname used with DoIT() function
	[1] = name
	[2] = category
	[3] = selection
	[4] = { {skillname1,skillamt2},{skillname1,skillamt2} }
	[5] = { {matname1,matamt1},{matname2,matamt2} }
	[6] = {other1,other2}
	[7] = type or nil
--]]

require("OpenEUOLuaPlugin")
dofile(getinstalldir().."scripts/Kal In Ex/FindItems.lua")
dofile(getinstalldir().."scripts/Kal In Ex/FindConts.lua")
dofile(getinstalldir().."scripts/Kal In Ex/KalOCR.lua")
CraftInfo = dofile(getinstalldir().."scripts/Kal In Ex/CraftInfo.lua")

-- load fileaccess.lua minus the example code
do
	local file = openfile(getinstalldir().."examples/fileaccess.lua")
	local text = file:read("*a") file:close()
	dostring(string.sub(text,1,(string.find(text,"config = {",1,true))-1))
	local FuncRef = TableToString
	TableToString = function(...)
		return FuncRef(...):gsub("\r\n","\n")
	end
end

local Paperdoll
local Backpack
local BankBox
local ResourceBox
local RecipeBag
local ToolBag
local MaterialBag = {}
local DelayTime = 200

-- if client has not been resized close paperdoll
if UO.CliLeft < 560 then
	UO.Macro(9,1)
	UO.Macro(9,7)
end

-- resize and position game view
UO.CliLeft = 560
UO.CliXRes = 80

-- open paperdoll
Paperdoll = ScanConts({ID=UO.CharID,Name="paperdoll gump"})
if #Paperdoll == 0 then
	UO.Macro(8,1)
	Paperdoll = WaitConts(true,5000,{ID=UO.CharID,Name="paperdoll gump"})
	if #Paperdoll == 0 then
		print("Could not open paperdoll!")
		stop()
	end
	wait(DelayTime)
	MoveConts(590,430,40,40,{ID=UO.CharID,Name="paperdoll gump"})
	wait(1000)
end

-- open backpack
do
	local Backpack = ScanConts({ID=UO.BackpackID})
	if #Backpack == 0 then
		UO.Macro(8,7)
		Backpack = WaitConts(true,5000,{ID=UO.BackpackID})
		if #Backpack == 0 then
			print("Could not open backpack!")
			stop()
		end
		wait(DelayTime)
		MoveConts(555,235,50,20,{ID=UO.BackpackID})
		wait(1000)
	end
end

-- open bank box
BankBox = ScanItems(true,{Type=3708,BagID=UO.CharID})
if #BankBox == 0 then
	local TimeOUT = getticks() + 3000
	if UO.ContType ~= 3708 then
		UO.Macro(3,0,"bank")
	end
	repeat
		wait(1)
		BankBox = ScanItems(true,{Type=3708,BagID=UO.CharID})
	until #BankBox ~= 0 or getticks() > TimeOUT
	if #BankBox == 0 then
		print("Could not open bank box!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,0,50,20,{Type=3708,ID=BankBox[1].ID})
end

-- open resource box
do
	ResourceBox = ScanItems(true,{ContID=BankBox[1].ID,Col=1193,Name="General Resources"})
	if #ResourceBox == 0 then
		UO.Macro(3,0,"give resources")
		local TimeOUT = getticks() + 1000
		repeat
			wait(1)
			ResourceBox = ScanItems(true,{ContID=BankBox[1].ID,Col=1193,Name="General Resources"})
		until #ResourceBox ~= 0 or getticks() > TimeOUT
		if #ResourceBox == 0 then
			print("Could not find resources box!")
			stop()
		end
	end
	if #ScanConts({ID=ResourceBox[1].ID}) == 0 then
		UO.LObjectID = ResourceBox[1].ID
		UO.Macro(17,0)
		if #WaitConts(true,5000,{ID=ResourceBox[1].ID}) == 0 then
			print("Error opening resource box!")
			stop()
		end
		wait(DelayTime)
		MoveConts(560,10,20,20,{ID=ResourceBox[1].ID})
		wait(1000)
	end
end

-- open tool bag
ToolBag = ScanItems(true,{ContID=ResourceBox[1].ID,Col=0,Name="Tool Bag"})
if #ToolBag == 0 then
	print("Could not find tool bag!")
	stop()
end
if #ScanConts({ID=ToolBag[1].ID}) == 0 then
	UO.LObjectID = ToolBag[1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=ToolBag[1].ID}) == 0 then
		print("Could not open tool bag!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,180,20,20,{ID=ToolBag[1].ID})
	wait(1000)
end

--[=[
-- open recipe bag
RecipeBag = ScanItems(true,{ContID=ResourceBox[1].ID,Col=2301,Name="Bag Of Recipes"})
if #RecipeBag == 0 then
	print("Could not find recipe bag!")
	stop()
end
if #ScanConts({ID=RecipeBag[1].ID}) == 0 then
	UO.LObjectID = RecipeBag[1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=RecipeBag[1].ID}) == 0 then
		print("Could not open recipe bag!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,180,20,20,{ID=RecipeBag[1].ID})
	wait(1000)
end

-- use recipe scrolls
RecipeScroll = ScanItems(true,{Type=10289,Kind=0})

local UseRecipeScrolls = function(skill,max,...)
	local varg = {...}
	local flag = false
	for i=#RecipeScroll,1,-1 do
		for j=1,#varg do
			if string.find(RecipeScroll[i].Details,"["..varg[j].."]",1,true) ~= nil then
				if flag == false and (UO.GetSkill(skill)) ~= max then
					UO.Macro(3,0,"set "..skill.." "..max)
					flag = true
					wait(1250)
				end
				UO.LObjectID = RecipeScroll[i].ID
				UO.Macro(17,0)
				wait(1250)
			end
		end
	end
	if skill ~= nil and (UO.GetSkill(skill)) ~= 0 then
		UO.Macro(3,0,"set "..skill.." 0")
		wait(1250)
	end
end

UseRecipeScrolls("blacksmith",1200,
	"Rune Carving Knife",
	"Cold Forged Blade",
	"Shard Thrasher",
	"Overseer Sundered Blade",
	"Luminous Rune Blade",
	"True Spellblade",
	"Icy Spellblade",
	"Fiery Spellblade",
	"Spellblade Of Defense",
	"True Assassin Spike",
	"Charged Assassin Spike",
	"Magekiller Assassin Spike",
	"Wounding Assassin Spike",
	"True Leafblade",
	"Luckblade",
	"Magekiller Leafblade",
	"Leafblade Of Ease",
	"Knight's War Cleaver",
	"Butcher's War Cleaver",
	"True War Cleaver",
	"Ruby Mace",
	"Emerald Mace",
	"Sapphire Mace",
	"Silver-Etched Mace",
	"Adventurer's Machete",
	"Orcish Machete",
	"Machete Of Defense",
	"Diseased Machete",
	"Runesabre",
	"Mage's Rune Blade",
	"Rune Blade Of Knowledge",
	"Corrupted Rune Blade",
	"True Radiant Scimitar",
	"Darkglow Scimitar",
	"Icy Scimitar",
	"Twinkling Scimitar",
	"Guardian Axe",
	"Singing Axe",
	"Thundering Axe",
	"Heavy Ornate Axe",
	"Serrated War Cleaver")
UseRecipeScrolls("carpentry",1000,
	"Ancient Wild Staff",
	"Phantom Staff",
	"Ironwood Crown",
	"Bramble Coat",
	"Tall Elven Bed (south)",
	"Arcane Bookshelf (south)",
	"Ornate Elven Chest (south)",
	"Elven Dresser (south)",
	"Elven Armoire (fancy)",
	"Arcanist's Wild Staff",
	"Thorned Wild Staff",
	"Hardened Wild Staff",
	"Stone Anvil (south)",
	"Tall Elven Bed (east)",
	"Arcane Bookshelf (east)",
	"Ornate Elven Chest (east)",
	"Elven Dresser (east)",
	"Ornate Elven Chair",
	"Stone Anvil (east)")
UseRecipeScrolls("fletching",1000,
	"The Night Reaper",
	"Blight Gripped Longbow",
	"Faerie Fire",
	"Silvani's Feywood Bow",
	"Mischief Maker",
	"Barbed Longbow",
	"Slayer Longbow",
	"Frozen Longbow",
	"Longbow Of Might",
	"Ranger's Shortbow",
	"Lightweight Shortbow",
	"Mystical Shortbow",
	"Assassin's Shortbow")
UseRecipeScrolls("tailoring",1200,
	"Elven Quiver",
	"Quiver Of Fire",
	"Quiver Of Ice",
	"Quiver Of Blight",
	"Quiver Of Lightning",
	"Spell Woven Britches",
	"Song Woven Mantle",
	"Stitcher's Mittens")
UseRecipeScrolls("alchemy",1000,
	"Hovering Wisp",
	"Invisibility",
	"Parasitic",
	"Darkglow")
UseRecipeScrolls(nil,nil,
	"Squirrel Statue (east)",
	"Squirrel Statue (south)",
	"Warrior Statue (east)",
	"Warrior Statue (south)")
UseRecipeScrolls("tinkering",1000,
	"Resilient Bracer",
	"Essence Of Battle",
	"Pendant Of The Magi")
UseRecipeScrolls("inscribe",1000,
	"Scrapper's Compendium")

-- open raw materials bag
MaterialBag[1] = ScanItems(true,{ContID=ResourceBox[1].ID,Col=0,Name="Raw Materials Bag"})
if #MaterialBag[1] == 0 then
	print("Could not find raw materials bag!")
	stop()
end
if #ScanConts({ID=MaterialBag[1][1].ID}) == 0 then
	UO.LObjectID = MaterialBag[1][1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=MaterialBag[1][1].ID}) == 0 then
		print("Could not open raw materials bag!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,180,20,20,{ID=MaterialBag[1][1].ID})
	wait(1000)
end

-- open bag of elven materials
MaterialBag[2] = ScanItems(true,{ContID=ResourceBox[1].ID,Col=1195,Name="Bag Of Elven Materials"})
if #MaterialBag[2] == 0 then
	print("Could not find bag of elven materials!")
	stop()
end
if #ScanConts({ID=MaterialBag[2][1].ID}) == 0 then
	UO.LObjectID = MaterialBag[2][1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=MaterialBag[2][1].ID}) == 0 then
		print("Could not open bag of elven materials!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,180,20,20,{ID=MaterialBag[2][1].ID})
	wait(1000)
end

-- open bag of imbuing materials
MaterialBag[3] = ScanItems(true,{ContID=ResourceBox[1].ID,Col=75,Name="Bag Of Imbuing Materials"})
if #MaterialBag[3] == 0 then
	print("Could not find bag of imbuing materials!")
	stop()
end
if #ScanConts({ID=MaterialBag[3][1].ID}) == 0 then
	UO.LObjectID = MaterialBag[3][1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=MaterialBag[3][1].ID}) == 0 then
		print("Could not open bag of imbuing materials!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,180,20,20,{ID=MaterialBag[3][1].ID})
	wait(1000)
end

-- open magery items box
MaterialBag[4] = ScanItems(true,{ContID=BankBox[1].ID,Col=1195,Name="Magery Items"})
if #MaterialBag[4] == 0 then
	print("Could not find magery items box!")
	stop()
end
if #ScanConts({ID=MaterialBag[4][1].ID}) == 0 then
	UO.LObjectID = MaterialBag[4][1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=MaterialBag[4][1].ID}) == 0 then
		print("Could not open magery items box!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,10,20,20,{ID=MaterialBag[4][1].ID})
	wait(1000)
end

-- open various potion kegs bag
MaterialBag[5] = ScanItems(true,{Type=3701,ContID=MaterialBag[4].ID,Col=0,Name="Various Potion Kegs"})
if #MaterialBag[5] == 0 then
	print("Could not find various potion kegs bag!")
	stop()
end
if #ScanConts({ID=MaterialBag[5][1].ID}) == 0 then
	UO.LObjectID = MaterialBag[5][1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=MaterialBag[5][1].ID}) == 0 then
		print("Could not open various potion kegs bag!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,180,50,20,{ID=MaterialBag[5][1].ID})
	wait(1000)
end

-- open spell casting stuff bag
MaterialBag[6] = ScanItems(true,{ContID=MaterialBag[4].ID,Col=1152,Name="Spell Casting Stuff"})
if #MaterialBag[6] == 0 then
	print("Could not find spell casting stuff bag!")
	stop()
end
if #ScanConts({ID=MaterialBag[6][1].ID}) == 0 then
	UO.LObjectID = MaterialBag[6][1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=MaterialBag[6][1].ID}) == 0 then
		print("Could not open spell casting stuff bag!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,180,50,20,{ID=MaterialBag[6][1].ID})
	wait(1000)
end

-- open bag of wood
MaterialBag[7] = ScanItems(true,{ContID=ResourceBox[1].ID,Col=1321,Name="Bag Of Wood"})
if #MaterialBag[7] == 0 then
	print("Could not find bag of wood!")
	stop()
end
if #ScanConts({ID=MaterialBag[7][1].ID}) == 0 then
	UO.LObjectID = MaterialBag[7][1].ID
	UO.Macro(17,0)
	if #WaitConts(true,5000,{ID=MaterialBag[7][1].ID}) == 0 then
		print("Could not open bag of wood!")
		stop()
	end
	wait(DelayTime)
	MoveConts(560,180,20,20,{ID=MaterialBag[7][1].ID})
	wait(1000)
end
--]=]

local MenuClick = function(XPos, YPos)
	repeat
		wait(1)
	until #ScanConts({SX=530,SY={497,417}}) ~= 0
	MoveConts(0,0,20,20,{SX=530,SY={497,417}})
	UO.Click(XPos,YPos,true,true,true,false)
	repeat
		wait(1)
	until #ScanConts({SX=530,SY={497,417}}) == 0
	repeat
		wait(1)
	until #ScanConts({SX=530,SY={497,417}}) ~= 0
	MoveConts(0,0,20,20,{SX=530,SY={497,417}})
end

local t = {}

-- check if the menu is open and displayed
MenuPixelTest = function()
	repeat
		wait(1)
	until UO.GetPix(65,307) == 16777215
end

SelCnt = function()
	for i=9,0,-1 do
		if UO.GetPix(237,67+i*20) == 8687244 then
			return i
		end
	end
end

DoIT = function(ToolSearch,SkillName)
	-- close menu if open
	if #ScanConts({SX=530,SY={497,417}}) ~= 0 then
		ClickConts(10,10,false,true,true,false,{SX=530,SY={497,417}})
		WaitConts(false,5000,{SX=530,SY={497,417}})
	end
	-- open menu
	local Tool = FindItems(ScanItems(true,ToolSearch),{ContID={UO.BackpackID,ToolBag[1].ID}})
	UO.LObjectID = Tool[1].ID
	UO.Macro(17,0)
	repeat
		wait(1)
	until #ScanConts({SX=530,SY={497,417}}) ~= 0
	MoveConts(0,0,20,20,{SX=530,SY={497,417}})
	--wait(DelayTime)
	MenuPixelTest()

	-- load a table with craft info

	-- count the number of categories
	local LastCatIdx
	for CatIDX=9,0,-1 do
		local y = 63+CatIDX*20
		if CatIDX == 0 then -- ""LAST TEN" category
			y = y - 3
		end
		local CatName = KalOCR.TextScan(50,y,"in",16777215)
		if CatName ~= "" then
			LastCatIdx = CatIDX
			break
		end
	end

	--print(SkillName.." #categories = "..LastCatIdx)

	-- load a table with item information
	for Cat=1,LastCatIdx do -- skipping category at index 0 = "LAST TEN"
		MenuClick(30,63+Cat*20)
		local SelCount = -1
		MenuPixelTest()
		local LastSel = SelCnt()
		for Sel=0,999 do
			-- turn to page with item...
			local ItemIdx = Sel
			while ItemIdx > 10 do
				UO.Click(385,270,true,true,true,false)
				ItemIdx = ItemIdx - 10
			end
			-- exit category loop when no more pages can turned
			if ItemIdx == 10 then
				MenuPixelTest()
				if not (UO.GetPix(405,267) == 16777215) then
					break
				end
				UO.Click(385,270,true,true,true,false)
				wait(DelayTime)
				LastSel = SelCnt()
				ItemIdx = ItemIdx - 10
			end
			if ItemIdx > LastSel then
				break
			end

			-- get detailed information
			MenuClick(495,63+(Sel%10)*20)
			MenuPixelTest()
			local SelName = KalOCR.TextScan(330,40,"in",16777215,"number")
			--local SuccessChance = KalOCR.TextScan(431,81,"in",15724502,"number")
			--local ExceptionalChance = KalOCR.TextScan(431,101,"in",15724502,"number")
			local Skill = {}
			for i=0,3 do
				local Name = KalOCR.TextScan(170,132+i*20,"in",16777215,"text")
				if Name == "" then
					break
				end
				local Value = KalOCR.TextScan(431,133+i*20,"in","15724502_16250871","number")
				Value=string.gsub(Value,"[.]","")
				Value=tonumber(Value)
				table.insert(Skill,{Name,Value})
			end
			local Material = {}
			for i=0,3 do
				local Name = KalOCR.TextScan(170,219+i*20,"in",16777215,"text")
				if Name == "" then
					break
				end
				local Value = 1
				if UO.Shard == "Alexandria" then
					Value = KalOCR.TextScan(431,220+i*20,"in",16250871,"number")
				else
					local Color = 0
					local x
					for ox=431,467 do
						x = ox
						y1 = 223 + i * 20
						y2 = 232 + i * 20
						for oy=y1,y2 do
							color=UO.GetPix(ox,oy)
							if color == 16777215 then
								break
							end
						end
						if color == 16777215 then
							break
						end
					end
					Value = KalOCR.TextScan(x,219+i*20,"in",16777215,"number")
				end
				table.insert(Material,{Name,Value})
			end
			local Other = {}
			for i=0,3 do
				local text = KalOCR.TextScan(170,302+i*20,"in","206_16777215","text")
				if text == "" then
					break
				end
				table.insert(Other,text)
			end

			table.insert(t,{[0]=SkillName,SelName,Cat,Sel,Skill,Material,Other})
			MenuClick(30,400)
		end
	end
end

local CraftTool = function(srch1,srch2,skillname,cat,sel)
	-- if tool of type srch1 exists then just return without crafting
	local Tool = FindItems(ScanItems(true,srch1),{ContID={UO.BackpackID,ToolBag[1].ID}})
	if #Tool ~= 0 then
		return true
	end
	-- tool of type srch1 was not found so use tool of type srch2 to make it
	Tool = FindItems(ScanItems(true,srch2),{ContID={UO.BackpackID,ToolBag[1].ID}})
	-- close menu if open
	if #ScanConts({SX=530,SY={497,417}}) ~= 0 then
		ClickConts(10,10,false,true,true,false,{SX=530,SY={497,417}})
		WaitConts(false,5000,{SX=530,SY={497,417}})
	end
	-- set skillname to 100%
	UO.Macro(3,0,"set "..skillname.." 1000")
	-- open menu
	UO.LObjectID = Tool[1].ID
	UO.Macro(17,0)
	repeat
		wait(1)
	until #ScanConts({SX=530,SY={497,417}}) ~= 0
	MoveConts(0,0,20,20,{SX=530,SY={497,417}})
	wait(DelayTime)
	-- set category
	MenuClick(30,63+cat*20)
	-- set page
	while sel > 9 do
		UO.Click(385,270,true,true,true,false)
		sel = sel - 10
	end
	-- craft the item
	MenuClick(232,63+sel*20)
	-- set skillname to 0%
	UO.Macro(3,0,"set "..skillname.." 0")
end

-- craft tools needed to list all skills
CraftTool({Type=2431},{Type=7864},"tinkering",3,18) -- skillet
CraftTool({Type=4032},{Type=7864},"tinkering",3,21) -- mapmaker's pen

-- if hammer is equipped then drop it in backpack...
local UnEquip = ScanItems(true,{Type=5091,ContID=UO.CharID})
for i=1,#UnEquip do
	UO.Drag(UnEquip[i].ID,1)
	UO.DropC(UO.BackpackID)
	wait(DelayTime)
	wait(1000)
end

local time = getticks()
DoIT({Type=3739},"ALCHEMY")
DoIT({Type=5091},"BLACKSMITHING")
DoIT({Type=4130},"BOWCRAFT")
DoIT({Type=4137},"CARPENTRY")
DoIT({Type=4032},"CARTOGRAPHY")
DoIT({Type=2431},"COOKING")
DoIT({Type=3722},"GLASSBLOWING")
DoIT({Type=4031},"INSCRIPTION")
DoIT({Type=4787},"MASONRY")
DoIT({Type=3997},"TAILORING")
DoIT({Type=7864},"TINKERING")
print("Time: "..getticks()-time)

-- get type codes from previous CraftInfo
for i=1,#t do
	local Name = string.lower(t[i][1])
	local Skill = string.lower(t[i][0])
	if CraftInfo[Skill][Name] and CraftInfo[Skill][Name]["type"] then
		t[i][7] = CraftInfo[Skill][Name]["type"]
	-- if type is not listed then print info about that fact
	else
		--print("need to add type info for "..Skill.." -> "..Name)
	end
end

OutputTable = function(t)
	local s = "{"
	local start = 1
	if t[0] ~= nil then
		start = 0
	end
	for i=start,#t do
		local Val = t[i]
		local Type = type(Val)
		if i == 0 then
			s = s.."[0]="
		end
		if Type == "table" then
			s = s..OutputTable(Val)
		elseif Type == "string" then
			s = s..string.format("%q",Val)
		elseif Type == "number" then
			s = s..Val
		end
		if i < #t then
			s = s..","
		end
	end
	return s.."}"
end

print("return {")
for i=1,#t do
	print("\t"..OutputTable(t[i])..",")
end
print("}")
stop()
