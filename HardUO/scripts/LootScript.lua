--------------------------------------
-- Script Name: LootScript.lua
-- Author: Kal In Ex
-- Version: 1.0
-- Client Tested with:
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: OSI
-- Revision Date: May 9,2012
-- Public Release: May 9,2012
-- Purpose: looting for unraveling
-- Copyright: Kal In Ex
--------------------------------------

--require("OpenEUOLuaPlugin")
dofile(getinstalldir().."scripts/lib/KalLib.lua")

--[[
    The LootBag is a "bag" (its roundish in shape and sold by
    provisioners cheap). IE: its not the pouch or backpack. Also
    all corpse containers should be closed before starting the
    script if you expect them to be looted by the script. I will
    likely add closing of corpse containers but have not yet...
--]]
local LootBag = ScanItems(true,{Type=3702,ContID=UO.BackpackID})
if #LootBag == 0 then
    print("Could not find loot bag in backpack!")
    stop()
end

--[[
    Script was written to loot everything that is not listed in the
    IgnoredItems table.
--]]
local IgnoredItems = {
    {Name="A Bottle Of Liquor",    Type=2459,Col=0},
    {Name="A Bottle Of Ale",    Type=2463,Col=0},
    {Name="A Bottle Of Wine",    Type=2503,Col=0},
    {Name="A Jug Of Cider",        Type=2504,Col=0},
    {Name="Cut Of Raw Ribs",    Type=2545,Col=0},
    {Name="Cut Of Ribs",        Type=2546,Col=0},
    {Name="Lantern",            Type=2597,Col=0},
    {Name="A Bola Ball",        Type=3699,Col=2220},
    {Name="Mortar And Pestle",    Type=3739,Col=2220},
    {Name="Gold",                Type=3821,Col=0},
    {Name="Empty Bottle",        Type=3854,Col=0},
    {Name="Shovel",                Type=3897,Col=0},
    {Name="Arrow",                Type=3903,Col=0},
    {Name="Daemon Blood",        Type=3965,Col=0},
    {Name="Fire Horn",            Type=4039,Col=1126},
    {Name="Iron Key",            Type=4112,Col=0},
    {Name="Cut Leather",        Type=4225,Col=0},
    {Name="Treasure Sand",        Type={4586,4587},Col=0},
    {Name="Raw Chicken Leg",    Type=5639,Col=0},
    {Name="Chicken Leg",        Type=5640,Col=0},
    {Name="Raw Leg Of Lamb",    Type=5641,Col=0},
    {Name="Leg Of Lamb",        Type=5642,Col=0},

    {Name="Skull",                Type=6882,Col=0},
    {Name="Skull",                Type=6883,Col=0},
    {Name="Skull",                Type=6884,Col=0},
    {Name="Bone Pile",            Type=6924,Col=0},
    {Name="Jaw Bone",            Type=6931,Col=0},
    {Name="Jaw Bone",            Type=6932,Col=0},
    {Name="Rib Cage",            Type=6935,Col=0},

-- Body Parts
    {Name="Arm",                Type=7389,Col=0},
    {Name="Body",                Type=7390,Col=0},
    {Name="Torso",                Type=7392,Col=0},
    {Name="Body Part",            Type=7395,Col=0},
    {Name="Arm",                Type=7397,Col=0},
    {Name="Legs",                Type=7399,Col=0},
    {Name="Torso",                Type=7400,Col=0},
    {Name="Head",                Type=7401,Col=0},
    {Name="Legs",                Type=7403,Col=0},
    {Name="Leg",                Type=7404,Col=0},
    {Name="Heart",                Type=7405,Col=0},
    {Name="Liver",                Type=7406,Col=0},
    {Name="Entrails",            Type=7407,Col=0},
    {Name="Brain",                Type=7408,Col=0},

    {Name="Untranslated Ancient Tome",                    Type=4082,Col=2405},
    {Name="Gear For Dawn's Music Box (Common)",            Type=4179,Col=2413},
--    {Name="A Tattered, Cleverly Drawn Treasure Map",    Type=5355,Col=0},
--    {Name="A Tattered, Deviously Drawn Treasure Map",    Type=5355,Col=0},
--    {Name="A Tattered, Ingeniously Drawn Treasure Map",    Type=5355,Col=0},
    {Name="Tattered Remnants Of An Ancient Scroll",        Type=5888,Col=2405},
    {Name="Ancient Pottery Fragments",                    Type=8771,Col=2417},
-- Music Instruments
    {Name="Lute",            Type=2763,Col=0},
    {Name="Lute",            Type=3763,Col=0},
-- Common Gems
    {Name="Star Sapphire",    Type=3855,Col=0},
    {Name="Emerald",        Type=3856,Col=0},
    {Name="Sapphire",        Type=3857,Col=0},
    {Name="Ruby",            Type=3859,Col=0},
    {Name="Citrine",        Type=3861,Col=0},
    {Name="Amethyst",        Type=3862,Col=0},
    {Name="Tourmaline",        Type=3864,Col=0},
    {Name="Amber",            Type=3877,Col=0},
    {Name="Diamond",        Type=3878,Col=0},
-- Necro Reagents
    {Name="Batwing",        Type=3960,Col=0},
    {Name="Pig Iron",        Type=3978,Col=0},
    {Name="Nox Crystal",    Type=3982,Col=0},
    {Name="Grave Dust",        Type=3983,Col=0},
-- Mage Reagents
    {Name="Black Pearl",    Type=3962,Col=0},
    {Name="Blood Moss",        Type=3963,Col=0},
    {Name="Garlic",            Type=3972,Col=0},
    {Name="Ginseng",        Type=3973,Col=0},
    {Name="Mandrake Root",    Type=3974,Col=0},
    {Name="Nightshade",        Type=3976,Col=0},
    {Name="Sulfurous Ash",    Type=3980,Col=0},
    {Name="Spiders' Silk",    Type=3981,Col=0},
-- Mage Scrolls
    {Name="Clumsy",            Type=7982,Col=0},
    {Name="Create Food",    Type=7983,Col=0},
    {Name="Feeblemind",        Type=7984,Col=0},
    {Name="Heal",            Type=7985,Col=0},
    {Name="Magic Arrow",    Type=7986,Col=0},
    {Name="Reactive Armor",    Type=7981,Col=0},
    {Name="Night Sight",    Type=7987,Col=0},
    {Name="Weaken",            Type=7988,Col=0},

    {Name="Agility",        Type=7989,Col=0},
    {Name="Cunning",        Type=7990,Col=0},
    {Name="Cure",            Type=7991,Col=0},
    {Name="Harm",            Type=7992,Col=0},
    {Name="Magic Trap",        Type=7993,Col=0},
    {Name="Magic Untrap",    Type=7994,Col=0},
    {Name="Protection",        Type=7995,Col=0},
    {Name="Strength",        Type=7996,Col=0},

    {Name="Bless",            Type=7997,Col=0},
    {Name="Fireball",        Type=7998,Col=0},
    {Name="Magic Lock",        Type=7999,Col=0},
    {Name="Poison",            Type=8000,Col=0},
    {Name="Telekinesis",    Type=8001,Col=0},
    {Name="Teleport",        Type=8002,Col=0},
    {Name="Unlock",            Type=8003,Col=0},
    {Name="Wall of Stone",    Type=8004,Col=0},

    {Name="Arch Cure",        Type=8005,Col=0},
    {Name="Arch Protection",Type=8006,Col=0},
    {Name="Curse",            Type=8007,Col=0},
    {Name="Fire Field",        Type=8008,Col=0},
    {Name="Greater Heal",    Type=8009,Col=0},
    {Name="Lightning",        Type=8010,Col=0},
    {Name="Mana Drain",        Type=8011,Col=0},
    {Name="Recall",            Type=8012,Col=0},

    {Name="Blade Spirits",    Type=8013,Col=0},
    {Name="Dispel Field",    Type=8014,Col=0},
    {Name="Incognito",        Type=8015,Col=0},
    {Name="Magic Reflection",Type=8016,Col=0},
    {Name="Mind Blast",        Type=8017,Col=0},
    {Name="Paralyze",        Type=8018,Col=0},
    {Name="Poison Field",    Type=8019,Col=0},
    {Name="Summon Creature",Type=8020,Col=0},

    {Name="Dispel",            Type=8021,Col=0},
    {Name="Energy Bolt",    Type=8022,Col=0},
    {Name="Explosion",        Type=8023,Col=0},
    {Name="Invisibility",    Type=8024,Col=0},
    {Name="Mark",            Type=8025,Col=0},
    {Name="Mass Curse",        Type=8026,Col=0},
    {Name="Paralyze Field",    Type=8027,Col=0},
    {Name="Reveal",            Type=8028,Col=0},

    {Name="Chain Lightning",Type=8029,Col=0},
    {Name="Energy Field",    Type=8030,Col=0},
    {Name="Flamestrike",    Type=8031,Col=0},
    {Name="Gate Travel",    Type=8032,Col=0},
    {Name="Mana Vampire",    Type=8033,Col=0},
    {Name="Mass Dispel",    Type=8034,Col=0},
    {Name="Meteor Swarm",    Type=8035,Col=0},
    {Name="Polymorph",        Type=8036,Col=0},

    {Name="Earthquake",        Type=8037,Col=0},
    {Name="Energy Vortex",    Type=8038,Col=0},
    {Name="Resurrection",    Type=8039,Col=0},
    {Name="Air Elemental",    Type=8040,Col=0},
    {Name="Summon Daemon",    Type=8041,Col=0},
    {Name="Earth Elemental",Type=8042,Col=0},
    {Name="Fire Elemental",    Type=8043,Col=0},
    {Name="Water Elemental",Type=8044,Col=0},
-- Necro Scrolls
    {Name="Animate Dead",    Type=8800,Col=0},
    {Name="Blood Oath",        Type=8801,Col=0},
    {Name="Corpse Skin",    Type=8802,Col=0},
    {Name="Curse Weapon",    Type=8803,Col=0},
    {Name="Evil Omen",        Type=8804,Col=0},
    {Name="Horrific Beast",    Type=8805,Col=0},
    {Name="Lich Form",        Type=8806,Col=0},
    {Name="Mind Rot",        Type=8807,Col=0},
    {Name="Pain Spike",        Type=8808,Col=0},
    {Name="Poison Strike",    Type=8809,Col=0},
    {Name="Strangle",        Type=8810,Col=0},
    {Name="Summon Familiar",Type=8811,Col=0},
    {Name="Vampiric Embrace",Type=8812,Col=0},
    {Name="Vengeful Spirit",Type=8813,Col=0},
    {Name="Wither",            Type=8814,Col=0},
    {Name="Wraith Form",    Type=8815,Col=0},
    {Name="Exorcism",        Type=8816,Col=0},
-- Mysticism Scrolls
    {Name="Nether Bolt",    Type=11678,Col=0},
    {Name="Healing Stone",    Type=11679,Col=0},
    {Name="Purge Magic",    Type=11680,Col=0},
    {Name="Enchant",        Type=11681,Col=0},
    {Name="Sleep",            Type=11682,Col=0},
    {Name="Eagle Strike",    Type=11683,Col=0},
    {Name="Animated Weapon",Type=11684,Col=0},
    {Name="Stone Form",        Type=11685,Col=0},



    {Name="Bombard",        Type=11689,Col=0},
    {Name="Spell Plague",    Type=11690,Col=0},
    {Name="Hail Storm",        Type=11691,Col=0},
    {Name="Nether Cyclone",    Type=11692,Col=0},
    {Name="Rising Colossus",Type=11693,Col=0},
-- Stygian Abyss Resources
--    {Name="Luminescent Fungi",        Type=12689,Col=0},
--    {Name="Dark Sapphire",            Type=12690,Col=0},
--    {Name="Turquoise",                Type=12691,Col=0},
--    {Name="Void Essence",            Type=16391,Col=2101},
--    {Name="Essence Of Persistence",    Type=22300,Col=37},
--    {Name="Essence Of Passion",        Type=22300,Col=1161},
--    {Name="Essence Of Control",        Type=22300,Col=1165},
--    {Name="Essence Of Feeling",        Type=22300,Col=52},
--    {Name="Goblin Blood",            Type=22316,Col=0},
--    {Name="Void Orb",                Type=22334,Col=0},
--    {Name="Slith Tongue",            Type=22342,Col=0},
--    {Name="Bottle Of Ichor",        Type=22344,Col=0},
--    {Name="Reflective Wolf Eye",    Type=22345,Col=0},
}

--[[
    This next block of code prints information about the items that have
    been found in LootBag *if* they are not ignored, but only once each time
    the script is started. This can be useful when editing the IgnoredItems list.
--]]
t = ScanItems(true,{ContID=LootBag[1].ID})
table.sort(t,function(a,b) return a.Type < b.Type end)
for i=1,#IgnoredItems do
    t = FindItems(t,{},IgnoredItems[i])
end
for i=1,#t do
    print(t[i].Type.."\t"..t[i].Col.."\t"..t[i].Name)
end

--[[
    mainloop
--]]
local IgnoredIDs = {}
repeat
    local Corpse
    local ContID
    local Items
    local TreasureSand
    local Gold
    local CorpseItems
-- search for a corpse to open
    repeat
        wait(1)
        Items = ScanItems(true)
-- unload treasure sand
        Sand = FindItems(Items,{Name={"Treasure Sand","Niporailem's Treasure"},Type={4586,4587},Col=0,ContID=UO.BackpackID})
        for i=1,#Sand do
            MoveItem(
                Sand[i],
                Sand[i].Stack,
                UO.CharPosX-2+math.random(0,4),
                UO.CharPosY-2+math.random(0,4),
                UO.CharPosZ)
        end
-- hide corpses that have been looted
        Corpse = FindItems(Items,{ID=IgnoredIDs},{Dist=2})
        for i=1,#Corpse do
            UO.HideItem(Corpse[i].ID)
        end
-- search for unlooted nearby corpse
        Corpse = FindItems(Items,{Type=8198,Dist=2},{ID=IgnoredIDs})
    until #Corpse ~= 0
-- add corpse ID to IgnoredIDs list
    table.insert(IgnoredIDs,Corpse[1].ID)
-- the corpse containers ID will be the newly opened corpse container
    do
        -- make a list of all open corpse containers
        local IGN = ScanConts({Type=8198})
        IGN.ID = {}
        for i=1,#IGN do
            table.insert(IGN.ID,IGN[i].ID)
        end
        -- the corpse is open when a new corpse container notin IGN is found
        UseItem(Corpse[1],function() return #ScanConts({Type=8198},{ID=IGN.ID}) > 0 end)
        ContID = ScanConts({Type=8198},{ID=IGN.ID})
    end
    if #ContID == 0 then
        print("No Corpse container Found!")
    else
        wait(500)
-- move gold to BackpackID
        Items = ScanItems(true)
        Gold = FindItems(Items,{Type=3821,ContID=ContID[1].ID})
        for i=1,#Gold do
            MoveItem(Gold[1].ID,Gold[1].Stack,UO.BackpackID)
        end
-- pick the corpse clean
        CorpseItems = FindItems(Items,{ContID=ContID[1].ID})
        for i=1,#IgnoredItems do
            CorpseItems = FindItems(CorpseItems,{},IgnoredItems[i])
        end
        for i=1,#CorpseItems do
            MoveItem(CorpseItems[i].ID,CorpseItems[i].Stack,LootBag[1].ID)
        end
    end
until false

stop()
