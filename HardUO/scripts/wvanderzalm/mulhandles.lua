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
UOPMagicNumber = 0x0050594D 
Mulhandles_Installed=false
local dir_data=getinstalldir().."UO Data Files\\"    
local dir_art_bmp=getinstalldir().."Art.bmp"
local dir_gump_bmp=getinstalldir().."Gump.bmp"
local dir_sound_wav=getinstalldir().."Sound.wav"
local filelist={"art.mul","artidx.mul","Cliloc.enu","gumpart.mul","gumpidx.mul","metrics.txt","sound.mul","soundidx.mul","tiledata.mul"}
for i=0,5 do
  table.insert(filelist,"map"..i..".mul") 
  table.insert(filelist,"staidx"..i..".mul")   
  table.insert(filelist,"statics"..i..".mul")        
end           



local data_Staidx,data_Statics,data_Map,data_Tile,data_Gumpidx,data_Gumpart="","","","","",""                                            




function Install_Mulhandles()
  local install_OK=true
  for i=1,#filelist do
    local f = openfile(dir_data..filelist[i])
    if not f then                
      install_OK=false
      print('ERROR : Missing file ['..dir_data..filelist[i]..']') 
    else
      f:close()
    end
  end       
  if install_OK then print('Ultima Online Data Files were installed correctly') end    
  Mulhandles_Installed=install_OK
  return install_OK
end





--################################################################################### 
  if MULHANDLESINIT then return end
  --CheckJunctionInstall()
  if not Install_Mulhandles() then 
    print('FATAL ERROR : Ultima Online Data Files were NOT installed correctly!') 
    print('FATAL ERROR : Pausing!')
    pause() 
  end
  print("mulhandles.lua init")
  MULHANDLESINIT = true  


function Read(Var,Start,Len)
  if Len > 10 then print("About to multiply 256^"..(Len-1).." Contiune?") pause() end
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

function CompVer(a,b)
  if type(a)=="table" then 
  else 
    if type(a)=="string" then                                                 
      local temp={}
      for w in string.gmatch(a,"%d+") do table.insert(temp,tonumber(w)) end    
      a=temp
    elseif type(a)=="number" then a={a}
    else
      return "err"
    end    
  end
  if type(b)=="table" then
  else
    if type(b)=="string" then
      local temp={}
      for w in string.gmatch(b,"%d+") do table.insert(temp,tonumber(w)) end   
      b=temp     
    elseif type(b)=="number" then b={b}
    else
      return "err"
    end  
  end
  if #a>#b then return "err" end
  for i=1,#a do
    if a[i]<b[i] then return -1 end
    if a[i]>b[i] then return 1 end
    if i==#a then return 0 end
  end
  return "err"
end

function IsUOPFormat()     end          


function GetScreenResolution()
  local f = openfile(dir_data.."metrics.txt","rb")  
  if f==nil then return false end 
  local data=f:read("*l")       
  while data do      
    local s,e=string.find(data,"Desktop Resolution and Color Depth: ")   
    if s and e then 
      local RawRes=string.sub(data,e+1) 
      s,e=string.find(RawRes,"x")
      local Width=string.sub(RawRes,1,e-1)  
      RawRes=string.sub(RawRes,e+1)  
      s,e=string.find(RawRes,"x")
      local Height=string.sub(RawRes,1,e-1)  
      local Depth=string.sub(RawRes,e+1)
      f:close()
      return Width, Height, Depth
    end
    data=f:read("*l") 
  end
  f:close()
end

function GetGumpIdx(n)
  local f = openfile(dir_data.."gumpidx.mul","rb") 
  if f==nil then return false end                     
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
  local file = openfile(dir_data.."artidx.mul","rb")  
  if file==nil then return false end 
--[[  if IsUOPFormat() and file==nil then 
    file = openfile(getinstalldir().."Ultima Online Classic/artLegacyMUL.UOP","rb")   
    data_artidx=file:read(28)                
    local a={string.byte(data_artidx,1,28)}
    local MagicNumber=a[4]*0x1000000+a[3]*0x10000+a[2]*0x100+a[1]  
    local Version=a[8]*0x1000000+a[7]*0x10000+a[6]*0x100+a[5]     
    local Misc=a[12]*0x1000000+a[11]*0x10000+a[10]*0x100+a[9]     
    local StartAddress=a[20]*0x100000000000000+a[19]*0x1000000000000+a[18]*0x10000000000+a[17]*0x100000000+a[16]*0x1000000+a[15]*0x10000+a[14]*0x100+a[13]     
    local BlockSize=a[24]*0x1000000+a[23]*0x10000+a[22]*0x100+a[21]     
    local FileCount=a[28]*0x1000000+a[27]*0x10000+a[26]*0x100+a[25]   
    local EntryList={}
    local BlockList={}
    
    if MagicNumber ~= UOPMagicNumber then return false end
    NextBlockAddress=StartAddress    
    
    while NextBlockAddress ~= 0L do  
      file:seek("set",NextBlockAddress) 
      data_artidx=file:read(12+FileCount*34)                   
      local a={string.byte(data_artidx,1,12+FileCount*34)}     
      local FileCount=Read(a,1,4)    
      local NextBlockAddress=Read(a,5,8)
      
     -- table.insert(BlockList,)
      for i=0,FileCount do                         
        local Lookup=Read(a,12+i*34,)          
        local Lookup=Read(a,12+i*34,)
    
    
        table.insert(EntryList,)
    
    
      end
    end
  
  end ]]    
           

                    
  
  
  local start = 1+n*12 -- +0x8000   
  file:seek("set",start-1)
  data_artidx=file:read(12) 
  file:close()                                          
  local a={string.byte(data_artidx,1,13)}
  local Lookup = a[4]*16777216+a[3]*65536+a[2]*256+a[1]+1 
  local Size = a[8]*16777216+a[7]*65536+a[6]*256+a[5]
  return Lookup, Size
end
function GetStaticArtIdx(n)
  local f = openfile(dir_data.."artidx.mul","rb")  
  if f==nil then return false end                    
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

function GetHue(n)
  n=n-1
  local Lookup, Size =n*88+(math.floor(n/8)*4),88
  local f = openfile(dir_data.."hues.mul","rb")  
  if f==nil then return false end 
  f:seek("set",Lookup)        
  data_art=f:read(Size)     
  local ColourTable ={}
  for i=1,64,2 do --1-->66?   
    ColourTable[(i-1)/2]=Read(data_art,i,2)
  end
  local TableStart =Read(data_art,0x45,2)  
  local TableEnd =Read(data_art,0x47,2)
  f:close() 
  return ColourTable,TableStart,TableEnd
end 
function ApplyHue(ColourTable,Colour)
  return ColourTable[Bit.And(Bit.Shr(Colour,10),0x1f  )]--[Bit.And(Bit.Shr(Colour,10),0x1f  )]
end
    
function GetStaticArt(n,HueNum)
  local Lookup, Size =GetStaticArtIdx(n)
  local Hue=0 
  if HueNum and HueNum~=0 then Hue=GetHue(HueNum) end
  local f = openfile(dir_data.."art.mul","rb")      
  if f==nil then return false end
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
    
  local out = openfile(dir_art_bmp,"w+b") 
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
          local R,G,B=0,0,0   
            R,G,B=bit16to32(colour)
          if colour ~= 0 then
            if Hue~=0 then
              colour=ApplyHue(Hue,colour)
            end                
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
        
        
  local file = openfile(dir_data.."art.mul","rb")   
  if file==nil then return false end
  --[[if IsUOPFormat() and file==nil then 
    file = openfile(getinstalldir().."Ultima Online Classic/artLegacyMUL.UOP","rb")
  end  ]] 
  file:seek("set",Lookup)
  data_art=file:read(Size)
  file:close() 
       
  local out = openfile(dir_art_bmp,"w+b") 
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
end  

function GetGump(n)
  local Lookup, Size, Width, Height = GetGumpIdx(n) 
  local file = openfile(dir_data.."gumpart.mul","rb")     
  if IsUOPFormat() or file==nil then 
    print("is uop")
    file = openfile(dir_data.."gumpartLegacyMUL.uop","rb")
  end                                                                                          
  if file==nil then print("return no gump file!") return false end
  
  
  file:seek("set",Lookup-1)
  data_Gumpart=file:read(Size)
  file:close()
  local x=1
  local count=0
  local cur=Size-3
  local zero , Dff=string.char(0) , string.char(0xff) 
  --local Dff=string.char(0xff)
  local file = openfile(dir_gump_bmp,"w+b")    
  if file==nil then return false end
  file:setvbuf ("full") 
  file:write(GetBmpStart(Width,Height))
      
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
    file:write(row)
  end  
  file:flush()
  file:close()
end
function IncludeMap8x8(x,y,f)
  if x==0 or y==0 then WorldTiles[0]={} WorldTiles[0][0]={} return false end --Not logged in
  f = f or UO.CursKind
  if f>5 then f=0 end
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
  if f>5 then f=0 end                     
  if f == 0 or f == 1 then start = (math.floor(x/8)*512+math.floor(y/8))*12 +1      
  elseif f == 2 then start = (math.floor(x/8)*200+math.floor(y/8))*12 +1  
  elseif f == 3 then start = (math.floor(x/8)*256+math.floor(y/8))*12 +1   
  elseif f == 4 then start = (math.floor(x/8)*181+math.floor(y/8))*12 +1  
  elseif f == 5 then start = (math.floor(x/8)*512+math.floor(y/8))*12 +1 
  else print("Unknown Facet!("..f..")") pause() end    
  local f = openfile(dir_data.."staidx"..f..".mul","rb")   
  if f==nil then return false end
  f:seek("set",start-1) local data_Staidx=f:read(192) f:close()
  return {string.byte(data_Staidx,1,12)}
end                                                --160x512

  
  
function GetMap(x,y,f)     
  local start = 0   
  if f>5 then f=0 end                            
  if f == 0 or f == 1 then start = (math.floor(x/8)*512+math.floor(y/8))*196 +4     
  elseif f == 2 then start = (math.floor(x/8)*200+math.floor(y/8))*196 +4 
  elseif f == 3 then start = (math.floor(x/8)*256+math.floor(y/8))*196 +4 
  elseif f == 4 then start = (math.floor(x/8)*181+math.floor(y/8))*196 +4   
  elseif f == 5 then start = (math.floor(x/8)*512+math.floor(y/8))*196 +4 
  else print("Unknown Facet!("..f..")") pause() end

  --if IsUOPFormat() then  
  local file = openfile(dir_data.."map"..f..".mul","rb") 
  if IsUOPFormat() or file==nil then 
    local block=math.modf(start/0xC4000)
    start=start+0xD88+(0xD54*math.modf(block/100))+(12*block) 
  end
  if file==nil then file = openfile(dir_data.."map"..f.."LegacyMUL.UOP","rb") end   
  if file==nil then return false end
  
  file:seek("set",start) local data_Map=file:read(192) file:close()
  return {string.byte(data_Map,1,192)}--{string.byte(data_Map,start+1,start+64*3)}
end
function GetStatics(start,ending,f)  
  if f>5 then f=0 end
  local f = openfile(dir_data.."statics"..f..".mul","rb")  
  if f==nil then return false end
  f:seek("set",start) local data_Statics=f:read(ending) f:close() 
  return {string.byte(data_Statics,1,ending)}
end
function GetLandTileData(n)                                
  local start =4 + n*30 + math.floor(n/32)*4
  local f = openfile(dir_data.."tiledata.mul","rb") 
  if f==nil then return false end
  f:seek("set",start-1) local data_Tile=f:read(34) f:close()
  local a={string.byte(data_Tile,1,34)}
  local Flags = a[5]*16777216+a[4]*65536+a[3]*256+a[2]
  if Flags == 0 then
    Flags = a[9]*16777216+a[8]*65536+a[7]*256+a[6]
  end
  local Name = ''
  local v = 12
  local x = string.find(data_Tile, '%z',v)
  if x > v then
    Name = string.sub(data_Tile,v,x-1)
  end
  return Name, Flags
end
function GetStaticTileData(n)                         
  local start = 493573 + n*41 + math.floor((n)/32)*4 
  local f = openfile(dir_data.."tiledata.mul","rb")   
  if f==nil then return false end
  if not f then return GetStaticTileData(n) end
  f:seek("set",start-1) local data_Tile=f:read(40) f:close()
  local a={string.byte(data_Tile,1,40)}--{string.byte(data_Map,start+1,start+64*3)}
  local Flags = a[4]*16777216+a[3]*65536+a[2]*256+a[1]
  local Weight=a[9]
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
    Name = string.sub(data_Tile,v,x-1)
  end
  return Name, Flags, Height, Weight, Quality
end    
---------------------------------------------------------------------------
--[[ Sounds! ]]------------------------------------------------------------
---------------------------------------------------------------------------    
function GetSoundIdx(n)
  local f = openfile(dir_data.."soundidx.mul","rb")   
  if f==nil then return false end                   
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
  local f = openfile(dir_data.."sound.mul","rb")     
  if f==nil then return false end
  f:seek("set",Lookup)
  data_sound=f:read(Size) 
  f:close() 
  local f = openfile(dir_sound_wav,"w+b") 
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

function GetString(n)
  --n=n-1
  local Lookup, Size =6,100--n*88+(math.floor(n/8)*4),88
  local f = openfile(dir_data.."Cliloc.enu","rb")   
  if f==nil then return false end
  local Table={[0]=0}
for i=1,109269 do
  f:seek("set",Lookup)        
  data_art=f:read(Size)    

  local Index =Read(data_art,1,5)   
  local TableEnd =Read(data_art,6,2)  
  local Name = ''
  Name = string.sub(data_art,8,7+TableEnd)
  Lookup=Lookup+TableEnd+7
  --if Index==3011032 then print(i) pause() end  
  if Name=="bank" then print(i) pause() end
  if Name ~= '' then Table[Index]=Name
    if Table[0]<Index then Table[0]=Index end 
  --print(i..","..Index..","..TableEnd.." :"..Name) 
  end
  end
  f:close() 
  return Table
end 






function SetMap(x,y,f,c)     
  local start = 0   
  if f>5 then f=0 end                            
  if f == 0 or f == 1 then start = (math.floor(x/8)*512+math.floor(y/8))*196 +4     
  elseif f == 2 then start = (math.floor(x/8)*200+math.floor(y/8))*196 +4 
  elseif f == 3 then start = (math.floor(x/8)*256+math.floor(y/8))*196 +4 
  elseif f == 4 then start = (math.floor(x/8)*181+math.floor(y/8))*196 +4   
  elseif f == 5 then start = (math.floor(x/8)*512+math.floor(y/8))*196 +4 
  else print("Unknown Facet!("..f..")") pause() end
  local f = openfile(dir_data.."map"..f..".mul","r+b")  
  if f==nil then return false end
  local str=''
  for i=1,#c do 
    str=str..string.char(c[i])  
  end
  print(start)
  f:seek("set",start) f:write(str) f:close()
  return true--{string.byte(data_Map,start+1,start+64*3)}
end
function SetMap8x8(x,y,f,m)
  if x==0 or y==0 then WorldTiles[0]={} WorldTiles[0][0]={} return false end --Not logged in
  f = f or UO.CursKind
  if f>5 then f=0 end
  local x8=math.floor(x/8)*8
  local y8=math.floor(y/8)*8     
  local c=GetMap(x,y,f)
  
  local xs=x-x8
  local ys=y-y8
  
  --z=c[(ys*8+xs)*3+3] 
  c[(ys*8+xs)*3+3]=m --z+m 
  --[[for i = 0,63 do
    local x,y,z = (x+math.mod(i,8)), (y+math.floor(i/8)), c[i*3+3]
    c[i*3+3]=z+5                           
   -- local id=c[i*3+2]*256+c[i*3+1]
   -- local Name, Flags = GetLandTileData(id)
   -- if z > 127 then z = z - 256 end
  end            ]]
  SetMap(x,y,f,c)
end

--SetMap8x8(1471,1667,0,5) 
--SetMap8x8(1471,1668,0,5)
 
 