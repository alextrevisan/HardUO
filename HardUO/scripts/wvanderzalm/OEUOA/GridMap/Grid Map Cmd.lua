--DirToPoint && move, Thanks to kal in ex
DirToPoint = function(...) 
  local varg = {...} 
  local x1,y1,x2,y2
  if #varg == 2 then
    x1 = UO.CharPosX
    y1 = UO.CharPosY
    x2 = varg[1] 
    y2 = varg[2] 
  else 
    x1 = varg[1] 
    y1 = varg[2] 
    x2 = varg[3] 
    y2 = varg[4] 
  end
  local d = -1 
  if x2 < x1 and y2 < y1 then d = 0 end
  if x2 == x1 and y2 < y1 then d = 1 end
  if x2 > x1 and y2 < y1 then d = 2 end
  if x2 > x1 and y2 == y1 then d = 3 end
  if x2 > x1 and y2 > y1 then d = 4 end
  if x2 == x1 and y2 > y1 then d = 5 end
  if x2 < x1 and y2 > y1 then d = 6 end
  if x2 < x1 and y2 == y1 then d = 7 end
  return d
end

function Display_Busy(X,Y,deg)
  local radius=10
  local ballradius=10     

  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY
  local Scale=Scale or 0 
  local NX=RX-RY
  local NY=RX+RY 
  local x,y=Window.X+ClientXRes-11+22*NX, Window.Y+ClientYRes-11+22*NY
  local rx,ry=0,0
  local str=""               
  rx= math.sin(math.rad(deg-10))*radius
  ry= math.cos(math.rad(deg-10))*radius
  Color =    (0   +   Bit.Shl(255,8)     +   Bit.Shl(25+math.mod(deg,360)/2,16))
  Pen.Width=5 
  Pen.Color=TransparentColorValue
  pcall(Canvas.Ellipse,x+radius+(rx-ballradius),y+radius+(ry-ballradius),x+radius+(rx+ballradius),y+radius+(ry+ballradius))

  rx= math.sin(math.rad(deg))*radius
  ry= math.cos(math.rad(deg))*radius
  Pen.Width=3 
  Pen.Color=Color
  pcall(Canvas.Ellipse,x+radius+(rx-ballradius),y+radius+(ry-ballradius),x+radius+(rx+ballradius),y+radius+(ry+ballradius))
end

function DrawThread(X,Y,Z,X2,Y2,Z2,Col,Scale,Wid)   
  if X==nil or Y==nil then return false end
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY 
  local RZ=Z - UO.CharPosZ
  local RX2=X2 - UO.CharPosX
  local RY2=Y2 - UO.CharPosY 
  local RZ2=Z2 - UO.CharPosZ
  if( 
  math.abs(RX+RY)>math.floor(ClientYRes/22) or 
  math.abs(RX)+math.abs(RY)>math.floor(ClientXRes/22) 
  ) and (
  math.abs(RX2+RY2)>math.floor(ClientYRes/22) or 
  math.abs(RX2)+math.abs(RY2)>math.floor(ClientXRes/22) 
  ) then return false end  
  local Scale=Scale or 0 
  local NX=RX-RY
  local NY=RX+RY   
  local NX2=RX2-RY2
  local NY2=RX2+RY2
  X1=Window.X+ClientXRes+22*NX
  Y1=Window.Y+ClientYRes+22*NY-4*RZ
  X2=Window.X+ClientXRes+22*NX2
  Y2=Window.Y+ClientYRes+22*NY2-4*RZ2
  Pen.Color = Col or 1   
  Pen.Width = Wid or 1
  Canvas.Line(X1,Y1,X2,Y2) 
end  
function DrawLineRelY(nY,Col,Wid)   
  if nY==nil then return false end     
 -- if nY>16 or nY<-15 then return false end   
  Pen.Color = Col or 1   
  Pen.Width = Wid or 1
  RY=nY-UO.CharPosY  
  Smod=0
  Emod=0
  SX=Window.X -44*RY +23                +ClientXRes-ClientYRes
  EX=Window.X+ClientYRes*2  -44*RY +23  +ClientXRes-ClientYRes
  if SX <Window.X then Smod=Window.X-SX end
  if EX >Window.X+ClientXRes*2 then Emod=EX-(Window.X+ClientXRes*2) end
  Canvas.Line(SX+Smod,  Window.Y+Smod, EX-Emod, Window.Y+ClientYRes*2-Emod)
end  
function DrawLineRelX(nX,Col,Wid)  
  if nX==nil then return false end     
 -- if nY>16 or nY<-15 then return false end   
  Pen.Color = Col or 1   
  Pen.Width = Wid or 1
  RX=nX-UO.CharPosX
  Smod=0
  Emod=0
  SX=Window.X+ClientXRes-ClientYRes+44*RX-25
  EX=Window.X+ClientYRes*2+ClientXRes-ClientYRes +44*RX-25
  if SX <Window.X then Smod=Window.X-SX end
  if EX >Window.X+ClientXRes*2 then Emod=EX-(Window.X+ClientXRes*2) end
  Canvas.Line(SX+Smod, Window.Y+ClientYRes*2-Smod-1, EX-Emod, Window.Y +Emod-1)
end 
function DrawSqrRelXY(X,Y,Col,Scale,Wid)
  if X==nil or Y==nil then return false end
  Pen.Color = Col or 1  
  Pen.Width = Wid or 1  
  local Scale=Scale or 0 
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY 
  if math.abs(RX+RY)>math.floor(ClientYRes/22) or math.abs(RX)+math.abs(RY)>math.floor(ClientXRes/22) then return false end             
  local NX=(RX-RY)*22
  local NY=(RX+RY)*22 
  local Left=Window.X+ClientXRes-1
  local Top=Window.Y+ClientYRes-2
  
  Canvas.Line(Left+NX,   Top+NY-1*Scale-21, Left+NX+21+Scale,   Top+NY)    --Top Right
  Canvas.Line(Left+NX-1, Top+NY-1*Scale-21, Left+NX-22-1*Scale, Top+NY)    --Top Left
  Canvas.Line(Left+NX-1, Top+NY+Scale+20,   Left+NX-22-1*Scale, Top+NY-1)  --Bottom Left
  Canvas.Line(Left+NX,   Top+NY+Scale+20,   Left+NX+21+Scale,   Top+NY-1)  --Bottom Right
  
end
function DrawArrowRelXY(X,Y,Z,X2,Y2,Col,Scale,Wid)
  if X==nil or Y==nil then return false end
  Pen.Color = Col or 1  
  Pen.Width = Wid or 1
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY  
  if math.abs(RX+RY)>math.floor(ClientYRes/22) or math.abs(RX)+math.abs(RY)>math.floor(ClientXRes/22) then return false end             
  local RZ=Z - UO.CharPosZ
  local Scale=Scale or 0 
  local NX=RX-RY
  local NY=RX+RY 
local xx=Window.X+ClientXRes-23+22*NX -- +41
local yy=Window.Y+ClientYRes-23+22*NY -4*RZ -- +41
local dir  =DirToPoint(X,Y,X2,Y2)
--zero is UP
if dir == 0 then
  yy=yy-Scale
  Canvas.Line(xx+21,yy,xx+10,yy+11)
  Canvas.Line(xx+22,yy,xx+33,yy+11)   
  Canvas.Line(xx+22,yy,xx+22,yy+21)
elseif dir == 1 then
  yy=yy-Scale
  xx=xx+Scale
  Canvas.Line(xx+42,yy,xx+42,yy+11)
  Canvas.Line(xx+42,yy,xx+31,yy)   
  Canvas.Line(xx+42,yy,xx+21,yy+21) 
elseif dir == 2 then  
  xx=xx+Scale
  Canvas.Line(xx+42,yy+20,xx+31,yy+9)
  Canvas.Line(xx+42,yy+21,xx+31,yy+32)   
  Canvas.Line(xx+22,yy+21,xx+42,yy+21)
elseif dir == 3 then      
  yy=yy+Scale
  xx=xx+Scale
  Canvas.Line(xx+42,yy+41,xx+42,yy+30)
  Canvas.Line(xx+42,yy+41,xx+31,yy+41)   
  Canvas.Line(xx+42,yy+41,xx+21,yy+20)    
elseif dir == 4 then
  yy=yy+Scale
  Canvas.Line(xx+21,yy+41,xx+11,yy+31)
  Canvas.Line(xx+22,yy+41,xx+32,yy+31)   
  Canvas.Line(xx+22,yy+41,xx+22,yy+20)  
elseif dir == 5 then  
  yy=yy+Scale
  xx=xx-Scale
  Canvas.Line(xx+1,yy+41,xx+1,yy+30)
  Canvas.Line(xx+1,yy+41,xx+12,yy+41)   
  Canvas.Line(xx+1,yy+41,xx+22,yy+20)  
elseif dir == 6 then 
  xx=xx-Scale
  Canvas.Line(xx+1,yy+20,xx+11,yy+10)
  Canvas.Line(xx+1,yy+21,xx+11,yy+31)   
  Canvas.Line(xx+21,yy+21,xx,yy+21)  
elseif dir == 7 then 
  yy=yy-Scale
  xx=xx-Scale
  Canvas.Line(xx+1,yy,xx+12,yy)
  Canvas.Line(xx+1,yy,xx+1,yy+11)   
  Canvas.Line(xx+1,yy,xx+22,yy+21)    
end
end

function DrawAreaRelXY(X,Y,X2,Y2,Col,Scale,Wid)
  if X==nil or Y==nil or X2==nil or Y2==nil then return false end
  if X > X2 then local temp=X X=X2 X2=temp end                                       
  if Y > Y2 then local temp=Y Y=Y2 Y2=temp end
--  if math.abs(X-UO.CharPosX+Y-UO.CharPosY)>math.floor(ClientYRes/22) or math.abs(X-UO.CharPosX)+math.abs(Y-UO.CharPosY)>math.floor(ClientXRes/22) then return false end    
  local sizeX=X2-X  
  local sizeY=Y2-Y
  for LX = -1,sizeX+1 do DrawBoarderRelXYZ2(X+LX,            Y,          GetLandTileZ(X+LX,Y),          GetLandTileZ(X+LX+1,Y),          2,Col, Scale,Wid) end  
  for LX = -1,sizeX+1 do DrawBoarderRelXYZ2(X+LX,            Y+sizeY,    GetLandTileZ(X+LX,Y+sizeY+1),  GetLandTileZ(X+LX+1,Y+sizeY+1),  4,Col, Scale,Wid) end   
  for LY = -1,sizeY+1 do DrawBoarderRelXYZ2(X,            Y+LY,          GetLandTileZ(X,Y+LY),          GetLandTileZ(X,Y+LY+1),          1,Col, Scale,Wid) end     
  for LY = -1,sizeY+1 do DrawBoarderRelXYZ2(X+sizeX,      Y+LY,          GetLandTileZ(X+sizeX+1,Y+LY),  GetLandTileZ(X+sizeX+1,Y+LY+1),  3,Col, Scale,Wid) end
end

function DrawSqrRelXYZ(X,Y,Z,Col,Scale,Wid)
  if X==nil or Y==nil then return false end
  Pen.Color = Col or 1 
  Pen.Width = Wid or 1   
  local Scale=Scale or 0 
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY
  if math.abs(RX+RY)>math.floor(ClientYRes/22) or math.abs(RX)+math.abs(RY)>math.floor(ClientXRes/22) then return false end             
  local RZ=(Z-UO.CharPosZ)*4 
  local NX=(RX-RY)*22
  local NY=(RX+RY)*22 
  local Left=Window.X+ClientXRes-1
  local Top=Window.Y+ClientYRes-2
  
  Canvas.Line(Left+NX,   Top+NY-1*Scale-21, Left+NX+21+Scale,   Top+NY)    --Top Right
  Canvas.Line(Left+NX-1, Top+NY-1*Scale-21, Left+NX-22-1*Scale, Top+NY)    --Top Left
  Canvas.Line(Left+NX-1, Top+NY+Scale+20,   Left+NX-22-1*Scale, Top+NY-1)  --Bottom Left
  Canvas.Line(Left+NX,   Top+NY+Scale+20,   Left+NX+21+Scale,   Top+NY-1)  --Bottom Right
  if RZ ~= 0 then
    Canvas.Line(Left+NX,   Top+NY-1*Scale-RZ-21, Left+NX+21+Scale,   Top+NY-RZ)    --Top Right   
    Canvas.Line(Left+NX-1, Top+NY-1*Scale-RZ-21, Left+NX-22-1*Scale, Top+NY-RZ)    --Top Left
    Canvas.Line(Left+NX-1, Top+NY+Scale-RZ+20,   Left+NX-22-1*Scale, Top+NY-RZ-1)  --Bottom Left
    Canvas.Line(Left+NX,   Top+NY+Scale-RZ+20,   Left+NX+21+Scale,   Top+NY-RZ-1)  --Bottom Right
  end
end  

--[[function Draw3DSqrRelXYZ(X,Y,Z,Z2,Col,Scale,Wid)
  if X==nil or Y==nil then return false end
  if math.abs(X-UO.CharPosX+Y-UO.CharPosY)>math.floor(ClientYRes/22) or math.abs(X-UO.CharPosX)+math.abs(Y-UO.CharPosY)>math.floor(ClientXRes/22) then return false end   
  Pen.Color = Col or 1 
  Pen.Width = Wid or 1
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY
  local RZ=Z - UO.CharPosZ  
  local Scale=Scale or 0 
  local NX=RX-RY
  local NY=RX+RY 
  local depth={math.floor((Z2-Z)/2),math.ceil((Z2-Z)/2)}
  
--  Canvas.Line(Window.X+ClientXRes-1+22*NX,         Window.Y+ClientYRes-23+22*NY-1*Scale,   Window.X+ClientXRes+20+22*NX+1*Scale, Window.Y+ClientYRes-2+22*NY)    
--  Canvas.Line(Window.X+ClientXRes-2+22*NX,         Window.Y+ClientYRes-23+22*NY-1*Scale,   Window.X+ClientXRes-23+22*NX-1*Scale, Window.Y+ClientYRes-2+22*NY)
--  Canvas.Line(Window.X+ClientXRes-22+22*NX-1*Scale, Window.Y+ClientYRes-2+22*NY,           Window.X+ClientXRes-1+22*NX,         Window.Y+ClientYRes+19+22*NY+1*Scale)
--  Canvas.Line(Window.X+ClientXRes-1+22*NX,         Window.Y+ClientYRes+18+22*NY+1*Scale,   Window.X+ClientXRes+20+22*NX+1*Scale, Window.Y+ClientYRes-3+22*NY) 
--  if RZ ~= 0 then
  Pen.Color = 16776960
    Canvas.Line(Window.X+ClientXRes-1+22*NX-depth[1],         Window.Y+ClientYRes-23+22*NY-1*Scale-4*RZ,   Window.X+ClientXRes+20+22*NX+1*Scale-depth[1], Window.Y+ClientYRes-2+22*NY-4*RZ)    
    Canvas.Line(Window.X+ClientXRes-2+22*NX-depth[1],         Window.Y+ClientYRes-23+22*NY-1*Scale-4*RZ,   Window.X+ClientXRes-23+22*NX-1*Scale-depth[1], Window.Y+ClientYRes-2+22*NY-4*RZ)
    Canvas.Line(Window.X+ClientXRes-22+22*NX-1*Scale-depth[1], Window.Y+ClientYRes-2+22*NY-4*RZ,           Window.X+ClientXRes-1+22*NX-depth[1],         Window.Y+ClientYRes+19+22*NY+1*Scale-4*RZ)
    Canvas.Line(Window.X+ClientXRes-1+22*NX-depth[1],         Window.Y+ClientYRes+18+22*NY+1*Scale-4*RZ,   Window.X+ClientXRes+20+22*NX+1*Scale-depth[1], Window.Y+ClientYRes-3+22*NY-4*RZ) 

   topright Canvas.Line(Window.X+ClientXRes-1+22*NX-depth[1],         Window.Y+ClientYRes-23+22*NY-1*Scale-4*RZ,   Window.X+ClientXRes+20+22*NX+1*Scale-depth[1], Window.Y+ClientYRes-2+22*NY-4*RZ)    
   topleft Canvas.Line(Window.X+ClientXRes-2+22*NX-depth[1],         Window.Y+ClientYRes-23+22*NY-1*Scale-4*RZ,   Window.X+ClientXRes-23+22*NX-1*Scale-depth[1], Window.Y+ClientYRes-2+22*NY-4*RZ)


  Pen.Color = 255
    Canvas.Line(Window.X+ClientXRes-1+22*NX+depth[2],         Window.Y+ClientYRes-23+22*NY-1*Scale-4*RZ,   Window.X+ClientXRes+20+22*NX+1*Scale+depth[2], Window.Y+ClientYRes-2+22*NY-4*RZ)    
    Canvas.Line(Window.X+ClientXRes-2+22*NX+depth[2],         Window.Y+ClientYRes-23+22*NY-1*Scale-4*RZ,   Window.X+ClientXRes-23+22*NX-1*Scale+depth[2], Window.Y+ClientYRes-2+22*NY-4*RZ)
    Canvas.Line(Window.X+ClientXRes-22+22*NX-1*Scale+depth[2], Window.Y+ClientYRes-2+22*NY-4*RZ,           Window.X+ClientXRes-1+22*NX+depth[2],         Window.Y+ClientYRes+19+22*NY+1*Scale-4*RZ)
    Canvas.Line(Window.X+ClientXRes-1+22*NX+depth[2],         Window.Y+ClientYRes+18+22*NY+1*Scale-4*RZ,   Window.X+ClientXRes+20+22*NX+1*Scale+depth[2], Window.Y+ClientYRes-3+22*NY-4*RZ) 
--  end
end   ]]
function DrawSqrRelXYZ4(X,Y,Z1,Z2,Z3,Z4,Col,Scale,Wid)
  if X==nil or Y==nil then return false end
  if type(Z1) == "table" then
    Col=Z2 or 1
    Scale=Z3 or 0
    Wid=Z4 or 1
    Z1,Z2,Z3,Z4=Z1[1],Z1[2],Z1[3],Z1[4]  
  end            
  Pen.Color = Col or 1 
  Pen.Width = Wid or 1     
  local Scale=Scale or 0 
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY 
  --if math.abs(RX+RY)>math.floor(ClientYRes*22) or math.abs(RX)+math.abs(RY)>math.floor(ClientXRes/22) then return false end                    
  local RZ1=(Z1-UO.CharPosZ)*4  
  local RZ2=(Z2-UO.CharPosZ)*4  
  local RZ3=(Z3-UO.CharPosZ)*4  
  local RZ4=(Z4-UO.CharPosZ)*4  
  local NX=(RX-RY)*22
  local NY=(RX+RY)*22 
  local Left=Window.X+ClientXRes-1
  local Top=Window.Y+ClientYRes-2    
  
  if Left+NX    < Window.X or  Left+NX    > Left+ClientXRes then return false end  
  if Top+NY-RZ1 < Window.Y or  Top+NY-RZ1 > Top+ClientYRes  then return false end
  
  
  
  
  Canvas.Pen.Style=2
  if Z1-Z4>Z2-Z3 then
    Canvas.Line(Left+NX+21+1*Scale, Top+NY-RZ2, Left-21+NX-1*Scale, Top+NY-RZ4) 
  elseif Z4-Z3~=Z1-Z2 then                                         
    Canvas.Line(Left+NX, Top+NY-RZ1-21-1*Scale, Left+NX, Top+NY-RZ3+21+1*Scale) 
 --   Canvas.Line(Left+NX-1+21, Top+NY-1*Scale-21-RZ1, Left+NX+21, Top+NY+1*Scale+20-RZ3) 
  end                                                                            
  Canvas.Pen.Style=0
   
  if not ( Drawn and Drawn[RX] and Drawn[RX][RY-1] ) then    
    Canvas.Line(Left+NX,   Top+NY-1*Scale-21-RZ1, Left+NX+21+Scale,   Top+NY-RZ2)    --Top Right
  end
  if not ( Drawn and Drawn[RX-1] and Drawn[RX-1][RY] ) then        
    Canvas.Line(Left+NX-1, Top+NY-1*Scale-21-RZ1, Left+NX-22-1*Scale, Top+NY-RZ4)    --Top Left
   end
  if not ( Drawn and Drawn[RX] and Drawn[RX][RY+1] ) then      
    Canvas.Line(Left+NX-1, Top+NY+Scale+20-RZ3,   Left+NX-22-1*Scale, Top+NY-RZ4-1)  --Bottom Left
  end
  if not ( Drawn and Drawn[RX+1] and Drawn[RX+1][RY] ) then        
    Canvas.Line(Left+NX,   Top+NY+Scale+20-RZ3,   Left+NX+21+Scale,   Top+NY-RZ2-1)  --Bottom Right
  end
end
function DrawCursor(X,Y,Z1,Z2,Z3,Z4,Col,Scale,Wid)
  if X==nil or Y==nil then return false end
  if type(Z1) == "table" then
    Col=Z2 or 1
    Scale=Z3 or 0
    Wid=Z4 or 1
    Z1,Z2,Z3,Z4=Z1[1],Z1[2],Z1[3],Z1[4]  
  end   
  Pen.Color = Col or 1 
  Pen.Width = Wid or 1  
  local Scale=Scale or 0 
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY
  if math.abs(RX+RY)>math.floor(ClientYRes/22) or math.abs(RX)+math.abs(RY)>math.floor(ClientXRes/22) then return false end             

  local RZ1=(Z1-UO.CharPosZ)*4   
  local RZ2=(Z2-UO.CharPosZ)*4  
  local RZ3=(Z3-UO.CharPosZ)*4  
  local RZ4=(Z4-UO.CharPosZ)*4  
  local NX=(RX-RY)*22
  local NY=(RX+RY)*22     
  local Left=Window.X+ClientXRes-1
  local Top=Window.Y+ClientYRes-2     
  
  Canvas.Line(Left+NX,   Top+NY-1*Scale-21-RZ1, Left+NX+21+Scale,   Top+NY-RZ2)    --Top Right
  Canvas.Line(Left+NX-1, Top+NY-1*Scale-21-RZ1, Left+NX-22-1*Scale, Top+NY-RZ4)    --Top Left
  Canvas.Line(Left+NX-1, Top+NY+Scale+20-RZ3,   Left+NX-22-1*Scale, Top+NY-RZ4-1)  --Bottom Left
  Canvas.Line(Left+NX,   Top+NY+Scale+20-RZ3,   Left+NX+21+Scale,   Top+NY-RZ2-1)  --Bottom Right
end
function DrawBoarderRelXYZ2(X,Y,Z1,Z2,n,Col,Scale,Wid)
  if X==nil or Y==nil then return false end
  n=n or 1
  Pen.Color = Col or 1 
  Pen.Width = Wid or 1    
  local Scale=Scale or 0 
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY     
  if math.abs(RX+RY)>math.floor(ClientYRes/22) or math.abs(RX)+math.abs(RY)>math.floor(ClientXRes/22) then return false end             

  local RZ1=(Z1-UO.CharPosZ)*4   
  local RZ2=(Z2-UO.CharPosZ)*4  
  local NX=(RX-RY)*22
  local NY=(RX+RY)*22     
  local Left=Window.X+ClientXRes-1
  local Top=Window.Y+ClientYRes-2   

  if n==2 then Canvas.Line(Left+NX,   Top+NY-1*Scale-21-RZ1, Left+NX+21+Scale,   Top+NY-RZ2)end    --Top Right
  if n==1 then Canvas.Line(Left+NX-1, Top+NY-1*Scale-21-RZ1, Left+NX-22-1*Scale, Top+NY-RZ2)end    --Top Left
  if n==4 then Canvas.Line(Left+NX-1, Top+NY+Scale+20-RZ2,   Left+NX-22-1*Scale, Top+NY-RZ1-1)end  --Bottom Left
  if n==3 then Canvas.Line(Left+NX,   Top+NY+Scale+20-RZ2,   Left+NX+21+Scale,   Top+NY-RZ1-1)end  --Bottom Right
end

function DrawStringRelXYZ(X,Y,Z,str,Col,FontSize)   
  if X==nil or Y==nil then return false end
  Canvas.Font.Color = Col or 255
  Canvas.Font.Size = FontSize or 12
  local RX=X - UO.CharPosX
  local RY=Y - UO.CharPosY         
  --if math.abs(RX+RY)>math.floor(ClientYRes/22) or math.abs(RX)+math.abs(RY)>math.floor(ClientXRes/22) then return false end             
  local RZ=(Z-UO.CharPosZ)*4
  local NX=(RX-RY)*22
  local NY=(RX+RY)*22     
  local Left=Window.X+ClientXRes-1
  local Top=Window.Y+ClientYRes-2    
  if Left+NX    < Window.X or  Left+NX    > Left+ClientXRes then return false end  
  if Top+NY-RZ < Window.Y or  Top+NY-RZ > Top+ClientYRes  then return false end                                                                     
  Canvas.Text(Left+NX-6,         Top+NY-RZ-10,tostring(str))
end
function DrawCharRelXYZ(X,Y,Z,str,Col,FontSize) DrawStringRelXYZ(X,Y,Z,tostring(Z),Col,FontSize) end
function DrawCharRelXY(X,Y,str,Col,FontSize) DrawCharRelXYZ(X,Y,UO.CharPosZ,str,Col,FontSize) end
function DrawStringRelXY(X,Y,str,Col,FontSize) DrawStringRelXYZ(X,Y,UO.CharPosZ,str,Col,FontSize) end

function DrawResource(X,Y,Size,Col,Scale,Wid)
  if X==nil or Y==nil then return false end
  local RX=math.floor(X/Size)*Size -- UO.CharPosX
  local RY=math.floor(Y/Size)*Size -- UO.CharPosY    
  DrawAreaRelXY(RX,RY,RX+Size-1,RY+Size-1,Col,Scale,Wid)
end 
     
function DrawResourceGrid(Size,Col,Wid)    
  local RX=math.floor(UO.CharPosX/Size)*Size -- UO.CharPosX
  local RY=math.floor(UO.CharPosY/Size)*Size -- UO.CharPosY  
for i=-1,2 do DrawLineRelX(RX + Size*i,Col,Wid) end               
for i=-1,2 do DrawLineRelY(RY + Size*i,Col,Wid) end     
end


function GetCursorGameXY()
  local P={X=math.floor((UO.CursorX-UO.CliLeft+UO.CursorY-UO.CliTop-ClientYRes-ClientXRes+22)/44),Y=math.floor((UO.CursorY-UO.CliTop-(UO.CursorX-UO.CliLeft)-ClientYRes+ClientXRes+22)/44)}
  return P
end
function AddNode(sAction,list,col,scale,x,y,z)
  col = col or 255                   
  local MousePos=GetCursorGameXY() 
  table.insert(list,
    {
      X=x or UO.CharPosX+MousePos.X,
      Y=y or UO.CharPosY+MousePos.Y,   
      Z=z or UO.CharPosZ+MousePos.Z,
      Action=sAction,
      Col=col,
      Scale=scale or -2
    }
  )
  NodeListUpdate()   
  update=true   
end

--Radar
function DrawRadar8x8(X,Y)
        local rx=X*8-math.mod(UO.CharPosX,8)
        local ry=Y*8-math.mod(UO.CharPosY,8)

  local x=Window.X-UO.CliLeft+Radar.X+140+rx-ry
  local y=Window.Y-UO.CliTop+Radar.Y+140+rx+ry
  Canvas.Line(x,y,x+8,y+8)            
  Canvas.Line(x+8,y+8,x,y+16) 
  Canvas.Line(x,y+16,x-8,y+8)   
  Canvas.Line(x-8,y+8,x,y)
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
  for k,v in pairs(t) do
    s = s..spc.."  ["..ToStr(k).."] = "..ToStr(v,TblToStr,spc)..",\r\n"
  end
  return s..spc.."}"
end

----------------------------------------

function TableToString(table)
  return TblToStr(table,"")
end       --