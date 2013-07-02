------------------------------------
-- Script Name: mulhandels.lua
-- Author: Wesley Vanderzalm
-- Version: N/A
-- Client Tested with: 7.0.10.3 
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: TestServer
-- Revision Date: 
-- Public Release: N/A
-- Purpose: read information from mul files
------------------------------------
--Map 0 :Felucca  Staidx[n] Statics[n] Map[n]
--Map 1 :Trammel
--Map 2 :Ilshenar
--Map 3 :Malas
--Map 4 :Tokuno
--Map 5 :Ter Mur  

--###################################################################################
--## The following code determines if the required Junction to UO folder           ## 
--## has been created, If not, a batch file needs to be created and installed      ##  
--## The contents of this batch file are all bellow and are written at runtime     ##
--###################################################################################
function CheckJunctionInstall()
  local f = openfile(getinstalldir().."Ultima Online Classic/Login.cfg")
  if f then 
    print('Junction:"Ultima Online Classic" Installed Correctly') 
    f:close()
    return true
  end
  print('!!! Fatal Error !!! Junction:"Ultima Online Classic" Installed Incorrectly') 

  local str="set Openeuodir="..string.sub(getinstalldir(),1,string.len(getinstalldir())-1)..'\n'
  str=str..[[set Uodir=C:\Program Files (x86)\Electronic Arts\Ultima Online Classic

@echo off
color 2
title Wesley's Ultime Online Junction Installer
cls


echo Welcome to Wesley's Ultime Online Junction Installer
echo. 
echo By executing the included command line, you will be creating a link to your 
echo Ultima Online game files. This link in theory could allow OpenEUO scripts to
echo harm, change, or corrupt said files.
echo.
echo I am not responsible for the misuse of this link.
:invalid_choice
set /p choice=Install Junction? (y/n): 
if %choice%==y goto yes
if %choice%==n exit
echo invalid choice: %choice%
goto invalid_choice

:yes
cls
echo OpenEUO directory is "%Openeuodir%"  
echo Ultima Online directory is "%Uodir%"
echo.
echo "n" will allow you to input different locations.
:invalid_choice2
set /p choice=Confirm these locations! (y/n): 
if %choice%==y goto confirm
if %choice%==n goto input
echo invalid choice: %choice%
goto invalid_choice2

:input
cls
echo OK, So you want to type the directorys in? If you open this file in Notepad, 
echo you can paste the directories in the first two lines!
echo.
echo Enter OpenEUO directory (eg. "c:\Openeuo" with no quotations) 
set /p Openeuodir=OEUO:
echo Enter Ultima directory (eg. "c:\UO" with no quotations) 
set /p Uodir=UO:
goto yes

:confirm
set Openeuodir="%Openeuodir%\Ultima Online Classic"
set Uodir="%Uodir%"

MKLINK /J %Openeuodir% %Uodir%
pause
echo on]]
  local f = openfile(getinstalldir().."Scripts\\wvanderzalm\\Junction Install.bat","w+b")
  if f then 
    print('"'..getinstalldir()..'Scripts\\wvanderzalm\\Junction Install.bat" has been created') 
    f:write(str)
    f:close()
    print('Please run the file "'..getinstalldir()..'Scripts\\wvanderzalm\\Junction Install.bat"')
    print('Follow its directions as best you can, or refer to the OpenEUO forum for help.')
  else
    print('!!! Fatal Error !!! Please Create "'..getinstalldir()..'Scripts\\wvanderzalm\\Junction Install.bat"') 
  end
  stop()
end
--################################################################################### 
  if MULHANDLESINIT then return end
  CheckJunctionInstall()
  print("mulhandles.lua init")
  MULHANDLESINIT = true  

local data_Staidx,data_Statics,data_Map,data_Tile,data_Gumpidx,data_Gumpart="","","","","",""
function mulhandels_init(str)
      print("Remove me!")--after a while
end
function GetGumpIdx(n)
  local f = openfile(getinstalldir().."Ultima Online Classic/gumpidx.mul","rb")                      
  local start = 1+n*12    
  f:seek("set",start-1)
  data_Gumpidx=f:read(12) 
  f:close()                                          
  local a={string.byte(data_Gumpidx,1,13)}
  local Lookup = a[4]*16777216+a[3]*65536+a[2]*256+a[1]+1 
  local Size = a[8]*16777216+a[7]*65536+a[6]*256+a[5]
  local Height = a[10]*256+a[9]
  local Width = a[12]*256+a[11]
  return Lookup, Size, Width, Height
end
function GetLandArtIdx(n)
  local f = openfile(getinstalldir().."Ultima Online Classic/artidx.mul","rb")                      
  local start = 1+n*12 -- +0x8000   
  f:seek("set",start-1)
  data_artidx=f:read(12) 
  f:close()                                          
  local a={string.byte(data_artidx,1,13)}
  local Lookup = a[4]*16777216+a[3]*65536+a[2]*256+a[1]+1 
  local Size = a[8]*16777216+a[7]*65536+a[6]*256+a[5]
  return Lookup, Size
end
function GetStaticArtIdx(n)
  local f = openfile(getinstalldir().."Ultima Online Classic/artidx.mul","rb")                      
  local start = (0x4000+n)*12+1--0x22819+n*12 -- +0x8000   
  f:seek("set",start-1)
  data_artidx=f:read(12) 
  f:close()                                          
  local a={string.byte(data_artidx,1,13)}
  local Lookup = a[4]*16777216+a[3]*65536+a[2]*256+a[1]+1 
  local Size = a[8]*16777216+a[7]*65536+a[6]*256+a[5]
  return Lookup, Size
end
function GetBmpStart(Width,Height)  
  local zero=string.char(0) 
  local Dff=string.char(0xff)   
  local gdata="BM"
  gdata = gdata..NumberToString((Width*Height)*4+54,4)--size
  gdata=gdata..zero..zero..zero..zero.."6"..zero..zero..zero
  gdata=gdata.."("..zero..zero..zero --number of bytes in DIB header   
  gdata=gdata..NumberToString(Width,4)..NumberToString(Height,4) --height     
  gdata=gdata..""..zero --No of colour planes "1"
  gdata=gdata..string.char(32)..zero --bits per pixel "32"
  gdata=gdata..zero..zero..zero..zero
  gdata=gdata..zero..zero..zero..zero --size of raw data in array
  gdata=gdata.."Ä"..zero..zero --horizontal resolution pix/meter
  gdata=gdata.."Ä"..zero..zero --vertial resolution
  gdata=gdata..zero..zero..zero..zero --colours in palette
  gdata=gdata..zero..zero..zero..zero --important colours\
  return gdata
end
 
function bit16to32(colour)
  R=math.floor(  (Bit.And(Bit.Shr(colour,10),0x1f)*0xff/0x1f)               ) 
  G=math.floor(   Bit.Shl((Bit.And(Bit.Shr(colour,5),0x1f)*0xff/0x1f),8)    ) /256
  B=math.floor(   Bit.Shl((Bit.And(colour,0x1f)*0xff/0x1f),16)              ) /65536 
  return R,G,B 
end   
    
function GetStaticArt(n)
  local Lookup, Size =GetStaticArtIdx(n)
  local f = openfile(getinstalldir().."Ultima Online Classic/art.mul","rb")   
  f:seek("set",Lookup-1)
  data_art=f:read(Size+2000)
  f:close()
        
  local flag =Read(data_art,1,4)
  local Width=Read(data_art,5,2)
  local Height=Read(data_art,7,2)    
  local zero=string.char(0) 
  local Dff=string.char(0xff)  
  local row=""
  local y=Height-1
  local count=9  
  
  local offset={}
  
  --Build "Height" Table
  for i = 0,Height do offset[i]=Read(data_art,count,2) count=count+2 end     
  count=(offset[0]+4+Height)*2+1   
    
  local out = openfile(getinstalldir().."Art.bmp","w+b") 
  out:setvbuf ("full") 
  out:write(GetBmpStart(Width,Height))      
  --Prints entire line to black,alpha=0
  for x=1,Width do row=row..zero..zero..zero..zero end
  local oldx=0
  while y>0 do--Height do   
    local xoffset = Read(data_art,count,2)  
    local xRun= Read(data_art,count+2,2)  
    count=count+4
    
    if xRun+xoffset >2048 then out:write(row) break end  
    if xRun+xoffset~=0 then
      local newx=0
      for x=1,Width do 
        if x <= xoffset + xRun and x > xoffset then     
          local colour=Read(data_art,count,2)
          count=count+2
          --local colour=Read(data_art,count,2)
          local R,G,B=0,0,0
          if colour ~= 0 then
            R,G,B=bit16to32(colour)    
            row=string.sub(row,0,(x+oldx-1)*4)..string.char(B)..string.char(G)..string.char(R)..Dff..string.sub(row,(x+oldx)*4+1,Width*4) 
          else                                                   
            row=string.sub(row,0,(x+oldx-1)*4)..zero..zero..zero..zero..string.sub(row,(x+oldx)*4+1,Width*4) 
          end                        
          newx=x+oldx
        end
      end  
      oldx=newx
    else
      y=y-1 
      if y>0 then count=(offset[y]+4+Height)*2+1 end 
      out:write(row)
      oldx=0
      
      row=""
      for x=1,Width do row=row..zero..zero..zero..zero end
    end     
  end 
  --Adds one black line everything seems to have at the "top"
  row=""
  for x=1,Width do row=row..zero..zero..zero..zero end
  out:write(row)  
  
  out:flush()
  out:close()
end 
    
function GetLandArt(n)   
  if n>=0x4000 then return false end 
  local Lookup, Size =GetLandArtIdx(n)
  if Lookup==4294967295 then return end  
  local zero=string.char(0) 
  local Dff=string.char(0xff)  
  local array={2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,44,42,40,38,36,34,32,30,28,26,24,22,20,18,16,14,12,10,8,6,4,2}       
  local count=2024
  local row
        
        
  local f = openfile(getinstalldir().."Ultima Online Classic/art.mul","rb")   
  f:seek("set",Lookup)
  data_art=f:read(Size)
  f:close() 
       
  local out = openfile(getinstalldir().."Art.bmp","w+b") 
  out:setvbuf ("full") 
  out:write(GetBmpStart(44,44))
      
  for i = 1,22 do 
    row=""
     --Add Black
     if array[i] ~= 44 then for black=1,(22-array[i]/2) do row=zero..zero..zero..zero..row end end  
     for width=1,array[i] do
       count=count-2
       local colour=Read(data_art,count,2)
       local R,G,B=0,0,0
       if colour ~= 0 then
         R,G,B=bit16to32(colour)    
         row=string.char(B)..string.char(G)..string.char(R)..Dff..row 
       else                                                             
         row=zero..zero..zero..zero..row
       end
     end
     --Add Black
     if array[i] ~= 44 then for black=1,(22-array[i]/2) do row=zero..zero..zero..zero..row end end  
     out:write(row)
  end
  for i = 23,44 do 
    row=""
    --Add Black
    if array[i] ~= 44 then for black=1,(22-array[i]/2) do row=zero..zero..zero..zero..row end end  
    for width=1,array[i] do
      count=count-2
      local colour=Read(data_art,count,2)
      local R,G,B=0,0,0
      if colour ~= 0 then
        R,G,B=bit16to32(colour) 
        row=string.char(B)..string.char(G)..string.char(R)..Dff..row
      else                                                             
        row=zero..zero..zero..zero..row  
      end
    end
    --Add Black
    if array[i] ~= 44 then for black=1,(22-array[i]/2) do row=zero..zero..zero..zero..row end end  
    out:write(row)
  end
  out:flush()
  out:close()
  stop()    
end  

function GetGump(n)
  local Lookup, Size, Width, Height = GetGumpIdx(n) 
  local f = openfile(getinstalldir().."Ultima Online Classic/gumpart.mul","rb")  
  f:seek("set",Lookup-1)
  data_Gumpart=f:read(Size)
  f:close()
  local x=1
  local count=0
  local cur=Size-3
  local zero , Dff=string.char(0) , string.char(0xff) 
  --local Dff=string.char(0xff)
  local f = openfile(getinstalldir().."Gump.bmp","w+b")
  f:setvbuf ("full") 
  f:write(GetBmpStart(Width,Height))
      
  for y=0,Height-1 do
    x=1
    if cur-4 <= 0 then break end
    local row=""
    while x <= Width do 
      local colour=Read(data_Gumpart,cur,2)
      local cnt=Read(data_Gumpart,cur+2,2)
      local next=count+cnt      
      local R,G,B=0,0,0
      if colour ~= 0 then
        R,G,B=bit16to32(colour) 
      end
      while count < next do
        if colour==0 then row=zero..zero..zero..zero..row     --CHAGEND REVERT TO LIKE BELOW?????????????????
        else row=string.char(B)..string.char(G)..string.char(R)..Dff..row end
        count=count+1
      end   
      cur=cur-4
      x=x+cnt 
    end 
    f:write(row)
  end  
  f:flush()
  f:close()
end


function Read(Var,Start,Len)
  if Len > 4 then print("About to multiply 256^"..(Len-1).." Contiune?") pause() end
  local val=0
  local data={string.byte(Var,Start,Start+Len)}
  for i=Len,1,-1 do val=val+data[i]*math.pow(256,i-1) end
  return val
end
function NumberToString(IN,Len)
  local Len=Len or 1
  local OUT,I,Dig="",0,0 
  while IN>0 do
    I=I+1
    IN,Dig=math.floor(IN/256),math.mod(IN,256)
    OUT=OUT..string.char(Dig) 
  end
  if I<Len then
    for i=1,Len-I do OUT=OUT..string.char(0) end   
  end
  return OUT     
end               

function IncludeMap8x8(x,y,f)
  if x==0 or y==0 then WorldTiles[0]={} WorldTiles[0][0]={} return false end --Not logged in
  f = f or UO.CursKind
  local x=math.floor(x/8)*8
  local y=math.floor(y/8)*8     
  local c=GetMap(x,y,f)  
  for i = 0,63 do
    local x,y,z = (x+math.mod(i,8)), (y+math.floor(i/8)), c[i*3+3]                           
    local id=c[i*3+2]*256+c[i*3+1]
    local Name, Flags = GetLandTileData(id)
    if z > 127 then z = z - 256 end
    if not WorldTiles[x] then WorldTiles[x]={}  end
    WorldTiles[x][y]={}
    WorldTiles[x][y][1]={id,z,Name,Flags,0}
  end 
  local a=GetStaidx(x,y,f)
  if (a[4]~=255) then 
    local b=GetStatics((a[4]*16777216+a[3]*65536+a[2]*256+a[1]),(a[8]*16777216+a[7]*65536+a[6]*256+a[5]),f)
    local nCnt = table.getn(b)
    for i=1,nCnt,7 do
      local id=b[i+1]*256+b[i]
      local x,y,z = x+b[i+2], y+b[i+3], b[i+4] 
      local Name, Flags, Height = GetStaticTileData(id)
      if z > 127 then z = z - 256 end 
      table.insert(WorldTiles[x][y],{id,z,Name,Flags,Height})
    end
  end 
end
function GetStaidx(x,y,f)                                          
  local start = 0                           
  if f == 0 or f == 1 then start = (math.floor(x/8)*512+math.floor(y/8))*12 +1      
  elseif f == 2 then start = (math.floor(x/8)*200+math.floor(y/8))*12 +1  
  elseif f == 3 then start = (math.floor(x/8)*256+math.floor(y/8))*12 +1   
  elseif f == 4 then start = (math.floor(x/8)*181+math.floor(y/8))*12 +1  
  elseif f == 5 then start = (math.floor(x/8)*512+math.floor(y/8))*12 +1 
  else print("Unknown Facet!") pause() end    
  local f = openfile(getinstalldir().."Ultima Online Classic/staidx"..f..".mul","rb") 
  f:seek("set",start-1) local data_Staidx=f:read(192) f:close()
  return {string.byte(data_Staidx,1,12)}
end                                                --160x512
function GetMap(x,y,f)     
  local start = 0                               
  if f == 0 or f == 1 then start = (math.floor(x/8)*512+math.floor(y/8))*196 +4     
  elseif f == 2 then start = (math.floor(x/8)*200+math.floor(y/8))*196 +4 
  elseif f == 3 then start = (math.floor(x/8)*256+math.floor(y/8))*196 +4 
  elseif f == 4 then start = (math.floor(x/8)*181+math.floor(y/8))*196 +4   
  elseif f == 5 then start = (math.floor(x/8)*512+math.floor(y/8))*196 +4 
  else print("Unknown Facet!") pause() end
  local f = openfile(getinstalldir().."Ultima Online Classic/map"..f..".mul","rb") 
  f:seek("set",start) local data_Map=f:read(192) f:close()
  return {string.byte(data_Map,1,192)}--{string.byte(data_Map,start+1,start+64*3)}
end
function GetStatics(start,ending,f)
  local f = openfile(getinstalldir().."Ultima Online Classic/statics"..f..".mul","rb")
  f:seek("set",start) local data_Statics=f:read(ending) f:close() 
  return {string.byte(data_Statics,1,ending)}
end
function GetLandTileData(n)                                
  local start =4 + n*30 + math.floor(n/32)*4
  local f = openfile(getinstalldir().."Ultima Online Classic/tiledata.mul","rb") 
  f:seek("set",start-1) local data_Tile=f:read(34) f:close()
  local a={string.byte(data_Tile,1,34)}
  local Flags = a[5]*16777216+a[4]*65536+a[3]*256+a[2]
  if Flags == 0 then
    Flags = a[9]*16777216+a[8]*65536+a[7]*256+a[6]
  end
  local Name = ''
  local v = 11
  local x = string.find(data_Tile, '%z',v)
  if x > v then
    Name = string.sub(data_Tile,v,x)
  end
  return Name, Flags
end

function GetStaticTileData(n)                         
  local start = 493573 + n*41 + math.floor((n)/32)*4 
  local f = openfile(getinstalldir().."Ultima Online Classic/tiledata.mul","rb") 
  f:seek("set",start-1) local data_Tile=f:read(40) f:close()
  local a={string.byte(data_Tile,1,40)}--{string.byte(data_Map,start+1,start+64*3)}
  local Flags = a[4]*16777216+a[3]*65536+a[2]*256+a[1]
  local Weight=a[3]
  local Quality=a[10]
  --local Unknown=a[12]*256+a[11]
  --local Unknown1=a[13]
  --local Quantity=a[14]
  --local AnimID=a[16]*256+a[15]
  --local Unknown2=a[17]
  --local Hue=a[18]
  --local Unknown3=a[20]*256+a[19]
  local Height=a[21]
  local Name = ''
  local v = 22
  local x = string.find(data_Tile, '%z',22)
  if x and x > v then
    Name = string.sub(data_Tile,v,x)
  end
  return Name, Flags, Height, Weight, Quality
end     

---------------------------------------------------------------------------
--[[ Sounds! ]]------------------------------------------------------------
---------------------------------------------------------------------------    
function GetSoundIdx(n)
  local f = openfile(getinstalldir().."Ultima Online Classic/soundidx.mul","rb")                      
  local start = n*12   
  f:seek("set",start)
  data_soundidx=f:read(12) 
  f:close()                                          
  local a={string.byte(data_soundidx,1,13)}
  local Lookup = a[4]*16777216+a[3]*65536+a[2]*256+a[1] 
  local Size = a[8]*16777216+a[7]*65536+a[6]*256+a[5]
  local Index = a[10]*256+a[9] 
  return Lookup, Size, Index
end
function GetSound(n)
  local Lookup,Size=GetSoundIdx(n)                            
  local f = openfile(getinstalldir().."Ultima Online Classic/sound.mul","rb")  
  f:seek("set",Lookup)
  data_sound=f:read(Size) 
  f:close() 
  local f = openfile(getinstalldir().."sound.wav","w+b") 
  f:setvbuf ("full")      
  local Name=string.sub(data_sound,1,16)          
  local zero=string.char(0x0)
  local sdata="RIFF"..NumberToString(Size+4,4)
  sdata=sdata.."WAVEfmt"..string.char(0x20)..string.char(0x10)..zero..zero..zero..string.char(0x1)..zero
  sdata=sdata..string.char(0x1)..zero..string.char(0x22)..string.char(0x56)..zero..zero..string.char(0x44)
  sdata=sdata..string.char(0xAC)..zero..zero..string.char(0x2)..zero..string.char(0x10)..zero
  sdata=sdata.."data"..NumberToString(Size-32,4)
  sdata=sdata..string.char(0x49)..string.char(0x10)..string.char(0x40)..zero
  sdata=sdata..string.char(0x40)..string.char(0x94)..string.char(0x40)..zero
  f:write(sdata) 
  f:write(string.sub(data_sound,41,string.len(data_sound)))
  f:flush()
  f:close()  
  local Duration=(Size-40)*8/352000
  return Name, Duration
end
 