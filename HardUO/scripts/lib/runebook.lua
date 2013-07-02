------------------------------------
-- Script Name: runebook.lua
-- Author: Wesley Vanderzalm
-- Version: 1.0.0
-- Client Tested with: 7.0.10.3 
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: Hybrid
-- Revision Date: 
-- Public Release: 14/01/2011
-- Purpose: controling runebooks
-- Copyright: 2011 Wesley Vanderzalm
------------------------------------
--[[
  init=Runebook(ID)
  Runebook:Open() 
  Runebook:Close()
  Runebook:Recall(index,usecharge)
  Runebook:Gate(index) 
  ]]

Runebook=class()
function Runebook:__init(ID)
  self.ID=ID
  self.SizeX=452
  self.SizeY=236
end

  function Runebook:Open()while UO.ContSizeX ~= self.SizeX or UO.ContSizeY ~= self.SizeY do DClick(self.ID) wait(150) end end  
  function Runebook:Close()if UO.ContSizeX == self.SizeX and UO.ContSizeY == self.SizeY then RClick(UO.ContPosX + self.SizeX / 2,UO.ContPosY + self.SizeY / 2) wait(150) end end
  function Runebook:Recall(index,usecharge) 
    self:Open()
    if usecharge then
      if index <= 8 then
        LClick(UO.ContPosX + 135,UO.ContPosY+55 +15*index)
      else                         
        LClick(UO.ContPosX + 295,UO.ContPosY+55 +15*(index-8))
      end
    else
      if index <= 8 then
        LClick(UO.ContPosX + 105 + 35 * ((math.mod(index,2)+index)/2),UO.ContPosY + 195)
      else                                
        LClick(UO.ContPosX + 275 + 35 * ((math.mod(index,2)+index-8)/2),UO.ContPosY + 195)
      end   
      if math.mod(index,2) == 1 then --odd 
        LClick(UO.ContPosX + 155 ,UO.ContPosY + 160)
      else                           
        LClick(UO.ContPosX + 320 ,UO.ContPosY + 160)
      end
    end
  end
  function Runebook:Gate(index) 
    self:Open()
    if index <= 8 then
      LClick(UO.ContPosX + 105 + 35 * ((math.mod(index,2)+index)/2),UO.ContPosY + 195)
    else                                
      LClick(UO.ContPosX + 275 + 35 * ((math.mod(index,2)+index-8)/2),UO.ContPosY + 195)
    end   
    if math.mod(index,2) == 1 then --odd 
      LClick(UO.ContPosX + 225 ,UO.ContPosY + 160)
    else                           
      LClick(UO.ContPosX + 385 ,UO.ContPosY + 160)
    end
  end