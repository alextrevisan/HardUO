function readOnly (t)
  local proxy = {}
  local mt = {       -- create metatable
    __index = t,
    __newindex = function (t,k,v)
      error("attempt to update a read-only table", 2)
    end
  }
  setmetatable(proxy, mt)
  return proxy
end

function class()
    local cls = {}
    cls.__index = cls
    return setmetatable(cls, {__call = function (c, ...)
        instance = setmetatable({}, cls)
        if cls.__init then
            cls.__init(instance, ...)
        end
        return instance
    end})
end
function inheritsFrom( baseClass )

    local new_class = {}
    local class_mt = { __index = new_class }
    
    function new_class:create(...)
        local newinst = {}
        setmetatable( newinst, class_mt )
        if newinst.__init then
          newinst:__init(...)
        end        
       local b_isa = false
        local cur_class = new_class
        local classlist={}
        while ( nil ~= cur_class ) do
          if cur_class.__init then
            table.insert(classlist,cur_class)
          end            
          cur_class = cur_class:superClass()
        end
        for i=table.getn(classlist),1,-1 do classlist[i].__init(newinst, ...) end
        return newinst
    end

    if nil ~= baseClass then
        setmetatable( new_class, { __index = baseClass } )
    end

    -- Implementation of additional OO properties starts here --

    -- Return the class object of the instance
    function new_class:class()
        return new_class
    end

    -- Return the super class object of the instance
    function new_class:superClass()
        return baseClass
    end

    -- Return true if the caller is an instance of theClass
    function new_class:isa( theClass )
        local b_isa = false

        local cur_class = new_class

        while ( nil ~= cur_class ) and ( false == b_isa ) do
            if cur_class == theClass then
                b_isa = true
            else
                cur_class = cur_class:superClass()
            end
        end

        return b_isa
    end

    return new_class
end

--[[
Mobile=inheritsFrom(nil)
function Mobile:__init()
  self.ID=0
  self.Type=0
  self.X=0
  self.Y=0
  self.Z=0
  self.Name="Animal"
end
function Mobile:speak() print(self.Name,self.age) end

BaseCreature=inheritsFrom(Mobile)  
function BaseCreature:__init()
--Vitals Range if unknown, int if known
  self.HitsMax={1,1}  
  self.ManaMax={1,1}
  self.StamMax={1,1}
  self.DamageMax={1,1}
--Resistance Range if unknown, int if known
  self.PhysicalResistance={1,1}
  self.FireResistance={1,1}
  self.ColdResistance={1,1}
  self.PoisonResistance={1,1}
  self.EnergyResistance={1,1}
--Damage Range if unknown, int if known
  self.PhysicalDamage={1,1}
  self.FireDamage={1,1}
  self.ColdDamage={1,1}
  self.PoisonDamage={1,1}
  self.EnergyDamage={1,1}
  self.ChaosDamage={1,1}
  self.DirectDamage={1,1}
  
  self.HitPoison="null"
  self.HitPoisonChance=0.5
  self.PoisonImmune="null"
    
  
--List of spells
  self.arSpellAttack={}
  self.arSpellDefense={}
--Taming
  self.Controlled=false      --Is controlled
  self.ControlMaster="null"  --My master
  self.ControlTarget="null"  --My Target
  self.ControlDest="null"
  self.ControlOrder="null"
  self.Stabled=false
  self.MinTameSkill="null"
  self.Tamable=false
--Summoning
  self.SummonMaster="null"
  self.Summoned=false
  self.SummonEnd="null"
  self.ControlSlots=1 --Number of control slots
  
  
  
  self.timeBardEnd="null"
  self.bBardProvoked=false
  self.bBardPacified=false
  self.bBardMaster="null"
  self.bBardTarget="null"
  self.BardImmune=false
  self.Unprovokable=false
  self.Uncalmable=false
  
  self.AI="null"
  self.Name="Dog"
  
--Bonding
  self.IsBonded=false
  self.IsDeadPet=false
  self.TBondingBegin="null"
  self.OwnerAbandonTime="null"
  self.FavoriteFood={}
  self.SubdueBeforeTame=false
  
end 
BondingEnabled=true   
function BaseCreature:speak() print(self.Name) end
function BaseCreature:IsBondable() return (BondingEnabled and not self.Summoned) end
function BaseCreature:Unprovokable() return (self.BardImmune or IsDeadPet) end
function BaseCreature:Uncalmable() return (self.BardImmune or IsDeadPet) end
--function BaseCreature:BondingBegin() self.TBondingBegin=getticks() end             
]]--