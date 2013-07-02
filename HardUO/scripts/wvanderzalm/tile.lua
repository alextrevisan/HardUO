if TILEINIT then return end 
print("Tile.lua init")
TILEINIT = true  
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")

-----------------------------------------
IgnoreLand={}
IgnoreLand[2]=true
IgnoreLand[0x1DB]=true
for i=0x1AE, 0x1B5 do IgnoreLand[i]=true end
-----------------------------------------
PersonHeight=16
StepHeight=2    
--WorldTiles={}     
--DynamicItems={}
--IgnoreDoors=false --Ghosts can set this true
--IgnoreMovableImpassables=false--Ghosts again
--IgnoreSpellFeilds=false
Flags={
  Background=       0x00000001, 
  Weapon=           0x00000002, 
  Transparent=      0x00000004, 
  Translucent=      0x00000008, 
  Wall=             0x00000010, 
  Damaging=         0x00000020, 
  Impassable=       0x00000040, 
  Wet=              0x00000080, 
  Unknown=          0x00000100, 
  Surface=          0x00000200, 
  Bridge=           0x00000400, 
  Stackable=        0x00000800,-- Generic/
  Window=           0x00001000,
  NoShoot=          0x00002000,
  PrefixA=          0x00004000, 
  PrefixAn=         0x00008000,
  Internal=         0x00010000,--(things like hair, beards, etc)
  Foliage=          0x00020000, 
  PartialHue=       0x00040000, 
  Unknown1=         0x00080000, 
  Map=              0x00100000, 
  Container=        0x00200000, 
  Wearable=         0x00400000, 
  LightSource=      0x00800000, 
  Animated=         0x01000000, 
  NoDiagonal=       0x02000000, 
  Unknown2=         0x04000000,
  Armor=            0x08000000, 
  Roof=             0x10000000, 
  Door=             0x20000000, 
  StairBack=        0x40000000, 
  StairRight=       0x80000000, 
}
Flags_enum={
  {"Background",Flags.Background}, 
  {"Weapon",Flags.Weapon}, 
  {"Transparent",Flags.Transparent}, 
  {"Translucent",Flags.Translucent}, 
  {"Wall",Flags.Wall}, 
  {"Damaging",Flags.Damaging}, 
  {"Impassable",Flags.Impassable}, 
  {"Wet",Flags.Wet}, 
  {"Unknown",Flags.Unknown}, 
  {"Surface",Flags.Surface}, 
  {"Bridge",Flags.Bridge}, 
  {"Stackable",Flags.Stackable},-- Generic/
  {"Window",Flags.Window},
  {"NoShoot",Flags.NoShoot},
  {"PrefixA",Flags.PrefixA}, 
  {"PrefixAn",Flags.PrefixAn},
  {"Internal",Flags.Internal},--(things like hair, beards, etc)
  {"Foliage",Flags.Foliage}, 
  {"PartialHue",Flags.PartialHue}, 
  {"Unknown1",Flags.Unknown1}, 
  {"Map",Flags.Map}, 
  {"Container",Flags.Container}, 
  {"Wearable",Flags.Wearable}, 
  {"LightSource",Flags.LightSource}, 
  {"Animated",Flags.Animated}, 
  {"NoDiagonal",Flags.NoDiagonal}, 
  {"Unknown2",Flags.Unknown2},
  {"Armor",Flags.Armor}, 
  {"Roof",Flags.Roof}, 
  {"Door",Flags.Door}, 
  {"StairBack",Flags.StairBack}, 
  {"StairRight",Flags.StairRight}, 
}


function Flags_print(n)
  local str=n.."  : "
  for i=1,#Flags_enum do
    if Bit.And(n,Flags_enum[i][2])~=0 then
      str=str.." "..Flags_enum[i][1]
    end  
  end
  print(str)
end

--Hybrid
MoongateLocations={
--Trammel
--Felucca
{{0,0},{4467,1283,5,0}}, --Moonglow   
{{0,1},{1336,1997,5,0}}, --Britain 
{{0,2},{1499,3771,5,0}}, --Jhelom 
{{0,3},{771,752,5,0}}, --Yew 
{{0,4},{2701,692,5,0}}, --Minoc 
{{0,5},{1828,2948,-20,0}}, --Trinsic 
{{0,6},{643,2067,5,0}}, --Skara Brae 
{{0,7},{3563,2139,34,0}}, --New Magincia 
{{0,8},{2711,2234,0,0}}, --Buccaneer's Den     
--{{0,9},{5349,3965,3,0}}, --Delucia (hybrid)


}
--[[MoongateMenuLocations={
--Trammel
{{0,0},{4467,1283,5,1}}, --Moonglow   
{{0,1},{}}, --Britain 
{{0,2},{}}, --Jhelom 
{{0,3},{}}, --Yew 
{{0,4},{}}, --Minoc 
{{0,5},{}}, --Trinsic 
{{0,6},{}}, --Skara Brae 
{{0,7},{}}, --New Magincia 
{{0,8},{}}, --New Haven 

--Felucca
{{1,0},{4467,1283,5,0}}, --Moonglow   
{{1,1},{1336,1997,5,0}}, --Britain 
{{1,2},{}}, --Jhelom 
{{1,3},{771,752,5,0}}, --Yew 
{{1,4},{}}, --Minoc 
{{1,5},{}}, --Trinsic 
{{1,6},{}}, --Skara Brae 
{{1,7},{}}, --New Magincia 
{{1,8},{}}, --Buccaneer's Den


}  ]]



function DynamicsReset() 
  if HouseItems==nil then HouseItems={} end   
  SignItems={} 
  DynamicItems={}
  DynamicsIgnoreList={}  
end
function DynamicItemSearchType(X,Y,Range)
  if DynamicItems[X] and DynamicItems[X][Y] then 
    for i=1,#DynamicItems[X][Y] do 
      if DynamicItems[X][Y][i][1]>=Range[1] and DynamicItems[X][Y][i][1]<=Range[2] then return true end
    end
  end
  return false
end     

---------------------------------------------------------------------------
--[[ Dynamics Refresh ]]---------------------------------------------------
---------------------------------------------------------------------------
-- Rebuilds a list of Dynamic Items
-- The list is populated and the following details are added to each entery 
-- DynamicItems[x][y][i]:  Cords:X/Y   Index:i
-- DynamicItems[x][y][i][1<->6]
-- [1]->  int     Type
-- [2]->  int     Z
-- [3]->  string  Name    
-- [4]->  int     Flags
-- [5]->  int     Height 
-- [6]->  int     Serial   
function DynamicsRefresh()
  local StartX=UO.CharPosX
  local StartY=UO.CharPosY  
  for x = -18,18 do --Clear old tiles in this scan area
    if DynamicItems[StartX+x] then 
      for y = -18,18 do           
        if DynamicItems[StartX+x][StartY+y] then DynamicItems[StartX+x][StartY+y]=nil end
      end
    end
  end
  DynamicItemsFull={}                                                                         --<=====
  local nCnt=UO.ScanItems(false) 
  for i=0,nCnt-1 do
    local nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
    DynamicItemsFull[i+1]={nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol}          --<=====
    local isset=false
--Ignore Things here-----------------------------------------------------------------------
    if nContID ~= 0 or nID == UO.CharID then isset=true end
    if not isset then for j=1,#DynamicsIgnoreList do if nID==DynamicsIgnoreList[j] then isset=true break end end end
    --if not isset then for j=1,#HouseItems do if IsInside(nX,nY,HouseItems[j].Area.X,HouseItems[j].Area.Y,HouseItems[j].Area.X2,HouseItems[j].Area.Y2) then isset=true break end end end
-------------------------------------------------------------------------------------------
--Basic Settings---------------------------------------------------------------------------
    if not isset then    
      local Name, Flags, Height = GetStaticTileData(nType)  
      if not DynamicItems[nX] then DynamicItems[nX]={}  end
      if not DynamicItems[nX][nY] then DynamicItems[nX][nY]={} end
      table.insert(DynamicItems[nX][nY],{nType,nZ,Name,Flags,Height,nID})
    end
-------------------------------------------------------------------------------------------
--House Settings---------------------------------------------------------------------------
    if not isset and nType==1 and nKind==1 and nStack==1 and nCol==0 then
      for j=1,#HouseItems do if HouseItems[j].ID==nID then isset=true break end end
      --Moongates Object ignore
      if not isset then for j=1,#MoongateLocations do if MoongateLocations[j][2][1]==nX and MoongateLocations[j][2][2]==nY and ( MoongateLocations[j][2][3]-20==nZ or MoongateLocations[j][2][3]-25==nZ ) then table.insert(DynamicsIgnoreList,nID) isset=true break end end end
      if not isset then table.insert(HouseItems,{ID=nID,X=nX,Y=nY,Z=nZ,State="uncertain",Area={X=0,Y=0,X2=0,Y2=0}}) end
    end 
-------------------------------------------------------------------------------------------
--Sign Settings----------------------------------------------------------------------------
    if not isset and (nType==0x0B95 or nType==0x0B96 or (nType>=0x0BA3 and nType<=0x0C0E) or nType==0x0C43 or nType==0x0C44) and nContID==0 and nCol==0 then    
      for j=1,#SignItems do if SignItems[j].ID==nID then isset=true break end end
      if not isset then table.insert(SignItems,{ID=nID,X=nX,Y=nY,Z=nZ}) end
    end
-------------------------------------------------------------------------------------------
  end 
end       

function WorldTilesReset() WorldTiles={} end  
function TileCnt(x,y)    
  if WorldTiles[x]==nil or WorldTiles[x][y]==nil then IncludeMap8x8(x,y) end                                                   
  return table.getn(WorldTiles[x][y])
end
function GetLandTileZ(x,y) 
  if x==0 or y==0 then return false end
  if WorldTiles[x]==nil or WorldTiles[x][y]==nil then IncludeMap8x8(x,y) end
  return WorldTiles[x][y][1][2]
end         
function GetLandTileID(x,y)   
  if x==0 or y==0 then return false end
  if WorldTiles[x]==nil or WorldTiles[x][y]==nil then IncludeMap8x8(x,y) end
  return WorldTiles[x][y][1][1]
end  
function GetLandMatrixZ(x,y)  
  local zTop=GetLandTileZ(x,y)
  local zLeft=GetLandTileZ(x,y+1)
  local zRight=GetLandTileZ(x+1,y)
  local zBottom=GetLandTileZ(x+1,y+1)
  return {zTop,zRight,zBottom,zLeft}
end
function GetAverageZ(x,y)  
  if WorldTiles[x]==nil or WorldTiles[x][y]==nil then IncludeMap8x8(x,y) end
  local top=0
  local avg=0
  local zTop=GetLandTileZ(x,y)
  local zLeft=GetLandTileZ(x,y+1)
  local zRight=GetLandTileZ(x+1,y)
  local zBottom=GetLandTileZ(x+1,y+1)
  local z=zTop
  if zLeft < z then z=zLeft end
  if zRight < z then z=zRight end
  if zBottom < z then z=zBottom end
  top=zTop
  if zLeft > top then top=zLeft end
  if zRight > top then top=zRight end
  if zBottom > top then top=zBottom end
  if math.abs( zTop - zBottom ) > math.abs( zLeft - zRight ) then
    avg = FloorAverage( zLeft, zRight )
  else     
    avg = FloorAverage( zTop, zBottom )
  end                                
 return avg,z,top
end
function FloorAverage(a,b)
  local v = a + b
  --if v < 0 then v = v - 1 end
  return math.floor ( v / 2 )
end

local MountainAndCaveTiles = {220, 221, 222, 223, 224, 225, 226, 227, 228, 229,230, 231, 236, 237, 238, 239, 240, 241, 242, 243,244, 245, 246, 247, 252, 253, 254, 255, 256, 257,258, 259, 260, 261, 262, 263, 268, 269, 270, 271,272, 273, 274, 275, 276, 277, 278, 279, 286, 287,288, 289, 290, 291, 292, 293, 294, 296, 296, 297,321, 322, 323, 324, 467, 468, 469, 470, 471, 472,473, 474, 476, 477, 478, 479, 480, 481, 482, 483,484, 485, 486, 487, 492, 493, 494, 495, 543, 544,545, 546, 547, 548, 549, 550, 551, 552, 553, 554,555, 556, 557, 558, 559, 560, 561, 562, 563, 564,565, 566, 567, 568, 569, 570, 571, 572, 573, 574,575, 576, 577, 578, 579, 581, 582, 583, 584, 585,586, 587, 588, 589, 590, 591, 592, 593, 594, 595,596, 597, 598, 599, 600, 601, 610, 611, 612, 613, 1010, 1741, 1742, 1743, 1744, 1745, 1746, 1747, 1748, 1749,1750, 1751, 1752, 1753, 1754, 1755, 1756, 1757, 1771, 1772,1773, 1774, 1775, 1776, 1777, 1778, 1779, 1780, 1781, 1782,1783, 1784, 1785, 1786, 1787, 1788, 1789, 1790, 1801, 1802,1803, 1804, 1805, 1806, 1807, 1808, 1809, 1811, 1812, 1813,1814, 1815, 1816, 1817, 1818, 1819, 1820, 1821, 1822, 1823,1824, 1831, 1832, 1833, 1834, 1835, 1836, 1837, 1838, 1839,1840, 1841, 1842, 1843, 1844, 1845, 1846, 1847, 1848, 1849,1850, 1851, 1852, 1853, 1854, 1861, 1862, 1863, 1864, 1865,1866, 1867, 1868, 1869, 1870, 1871, 1872, 1873, 1874, 1875,1876, 1877, 1878, 1879, 1880, 1881, 1882, 1883, 1884, 1981,1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991,1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001,2002, 2003, 2004, 2028, 2029, 2030, 2031, 2032, 2033, 2100,2101, 2102, 2103, 2104, 2105,0x453B, 0x453C, 0x453D, 0x453E, 0x453F, 0x4540, 0x4541,0x4542, 0x4543, 0x4544,	0x4545, 0x4546, 0x4547, 0x4548,0x4549, 0x454A, 0x454B, 0x454C, 0x454D, 0x454E,	0x454F}
local StaticCaveTiles = {1339,1340,1341,1342,1343,1344,1345,1346,1347,1348,1349,1350,1351,1352,1353,1354,1355,1356,1357,1358,1359,1361,1362,1363,1386}
local SandTiles = {22, 23, 24, 25, 26, 27, 28, 29, 30, 31,32, 33, 34, 35, 36, 37, 38, 39, 40, 41,42, 43, 44, 45, 46, 47, 48, 49, 50, 51,52, 53, 54, 55, 56, 57, 58, 59, 60, 61,62, 68, 69, 70, 71, 72, 73, 74, 75,286, 287, 288, 289, 290, 291, 292, 293, 294, 295,296, 297, 298, 299, 300, 301, 402, 424, 425, 426,427, 441, 442, 443, 444, 445, 446, 447, 448, 449,450, 451, 452, 453, 454, 455, 456, 457, 458, 459,460, 461, 462, 463, 464, 465, 642, 643, 644, 645,650, 651, 652, 653, 654, 655, 656, 657, 821, 822,823, 824, 825, 826, 827, 828, 833, 834, 835, 836,845, 846, 847, 848, 849, 850, 851, 852, 857, 858,859, 860, 951, 952, 953, 954, 955, 956, 957, 958,967, 968, 969, 970,1447, 1448, 1449, 1450, 1451, 1452, 1453, 1454, 1455,1456, 1457, 1458, 1611, 1612, 1613, 1614, 1615, 1616,1617, 1618, 1623, 1624, 1625, 1626, 1635, 1636, 1637,1638, 1639, 1640, 1641, 1642, 1647, 1648, 1649, 1650}
local DirtGreenThorn = {113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,332,333,334,335,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,622,623,624,625,626,627,628,629,630,631,632,633,638,639,640,641,804,805,806,807,808,809,810,811,812,813,814,815,816,817,818,819,820,821,822,823,824,825,826,827,828,829,830,831,832,833,834,835,836,837,838,839,840,841,842,843,844,845,846,847,848,849,850,851,852,853,854,855,856,871,872,873,874,875,876,877,878,879,880,881,882,883,884,885,886,887,888,889,890,901,902,903,904,905,906,907,908,909,910,911,912,913,914,915,916,917,918,919,920,921,922,923,924,925,926,927,928,929,930,931,932,933,934,935,936,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1351,1352,1353,1354,1355,1356,1357,1358,1359,1360,1361,1362,1363,1364,1365,1366,1431,1432,1433,1434,1435,1436,1437,1438,1439,1440,1441,1442,1443,1444,1445,1446,1571,1572,1573,1574,1575,1576,1577,1578,1579,1580,1581,1582,1583,1584,1585,1586,1586,1587,1588,1589,1590,1591,1592,1593,1594,1946,1947,1948,1949,1950,1951,1952,1953,1954,1955,1956,1957,1958,1959,1960,1961,1966,1967,1968,1969}
local FurrowsGreenThorn = {9,10,11,12,13,14,15,16,17,18,19,20,21,336,337,338,339,340,341,342,343,344,345,346,347,348}
local SwampGreenThorn = {0x9C4, 0x9EB,0x3D65, 0x3D65,0x3DC0, 0x3DD9,0x3DDB, 0x3DDC,0x3DDE, 0x3EF0,0x3FF6, 0x3FF6,0x3FFC, 0x3FFE}
local SnowGreenThorn = {0x10C, 0x10F,0x114, 0x117,0x119, 0x11D,0x179, 0x18A,0x385, 0x38C,0x391, 0x394,0x39D, 0x3A4,0x3A9, 0x3AC,0x5BF, 0x5D6,0x5DF, 0x5E2,0x745, 0x748,0x751, 0x758,0x75D, 0x760,0x76D, 0x773}
local SandGreenThorn = {0x16, 0x3A,0x44, 0x4B,0x11E, 0x121,0x126, 0x12D,0x192, 0x192,0x1A8, 0x1AB,0x1B9, 0x1D1,0x282, 0x285,0x28A, 0x291,0x335, 0x33C,0x341, 0x344,0x34D, 0x354,0x359, 0x35C,0x3B7, 0x3BE,0x3C7, 0x3CA,0x5A7, 0x5B2,0x64B, 0x652,0x657, 0x65A,0x663, 0x66A,0x66F, 0x672,0x7BD, 0x7D0}


function FindResourceTile(x,y,res)
  local list = GetTiles(x,y)
  local rlist= {}
  if list == false then
    return false
  end
  for i=1,list.Cnt do
    if isResource(list[i],res,i~=1) then 
      local a=list[i] 
      a.X=list.X 
      a.Y=list.Y 
      a.Z= list[i].Z 
      a.Terrain=i==1
      a.Type=list[i].Type 
      a.Next=rlist
      rlist=a 
    end
  end
  if rlist.Next==nil then return false end
  return rlist  
end

function FindTopTileZ(x,y)
  list = GetTiles(x,y)
  if list == false then
    return false
  end
  local Z=-999
  for i=1,list.Cnt do
    if list[i].Z > Z then Z = list[i].Z end
    if i == list.Cnt then return Z end
  end
end


function isResource(tTile,Type,bStatic)
  if not Type then
    return false
  end 
  if string.lower(Type) == 'ore' then
    if bStatic then ----------Expan this to outside Quarries 
      local Cnt = table.getn(StaticCaveTiles)       
      for i=1,Cnt do if StaticCaveTiles[i] == tTile.Type then return true end end 
    else
      local Cnt=table.getn(MountainAndCaveTiles)
      for i=1,Cnt do if MountainAndCaveTiles[i] == tTile.Type then return true end end     
    end  
    return false 
  elseif string.lower(Type) == 'sand' then
    for i=1,table.getn(SandTiles) do if SandTiles[i] == tTile.Type then return true end end
  elseif string.lower(Type) == 'wood' then
    if string.find(tTile.Name,'tree') and tTile.Name ~= 'willow tree' and tTile.Name ~= 'Yew tree' and tTile.Name ~= 'potted tree' and tTile.Name ~= "o'hii tree" then return true else return false end
  elseif string.lower(Type) == 'greenthorn' then
    for i=1,table.getn(FurrowsGreenThorn) do
      if FurrowsGreenThorn[i] == tTile.Type then return "furrows" end
    end  
    for i=1,table.getn(DirtGreenThorn) do
      if DirtGreenThorn[i] == tTile.Type then return "dirt" end
    end  
    for i=1,table.getn(SandGreenThorn) do
      if SandGreenThorn[i] == tTile.Type then return "sand" end
    end  
    for i=1,table.getn(SnowGreenThorn) do
      if SnowGreenThorn[i] == tTile.Type then return "snow" end
    end  
    for i=1,table.getn(SwampGreenThorn) do
      if SwampGreenThorn[i] == tTile.Type then return "swamp" end
    end 
    return false  
  elseif string.lower(Type) == 'fish' then 
    return isWet(tTile.Flags)
  end
end
        
function isPassible(nFlags) if Bit.And(nFlags,Flags.Impassable) ~= 0 then return false end return true end   
function isWet(nFlags) if Bit.And(nFlags,Flags.Wet) ~= 0 then return true end return false end
function isWall(nFlags) if Bit.And(nFlags,Flags.Wall) ~= 0 then return true end return false end 
function isNoShoot(nFlags) if Bit.And(nFlags,Flags.NoShoot) ~= 0 then return true end return false end 
function isDamaging(nFlags) if Bit.And(nFlags,Flags.Damaging) ~= 0 then return true end return false end   
function isBridge(nFlags) if Bit.And(nFlags,Flags.Bridge) ~= 0 then return true end return false end
function isDoor(nFlags) if Bit.And(nFlags,Flags.Door) ~= 0 then return true end return false end

function GetTiles(X,Y)
  local list = {}
  local nCnt = TileCnt(X,Y)
  if nCnt <= 0 then
    return false
  end
  list.Cnt = nCnt
  list.X = X
  list.Y = Y
  for i=1,nCnt do
    list[i]={}
    list[i].Type = WorldTiles[X][Y][i][1]
    list[i].Z = WorldTiles[X][Y][i][2]
    list[i].Name = WorldTiles[X][Y][i][3]
    list[i].Flags = WorldTiles[X][Y][i][4]
  end  
  return list
end
DynamicsReset(true)
WorldTilesReset()