updateValue("CharPosX", UO.CharPosX)
updateValue("CharPosY", UO.CharPosY)
updateValue("CharPosZ", UO.CharPosZ)
updateValue("CharDir", UO.CharDir)
updateValue("CharStatus", UO.CharStatus)
updateValue("CharID", UO.CharID)
updateValue("CharType", UO.CharType)
updateValue("BackpackID", UO.BackpackID)
updateValue("CharName", UO.CharName)
updateValue("Sex", UO.Sex)
updateValue("Str", UO.Str)
updateValue("Dex", UO.Dex)
updateValue("Int", UO.Int)
updateValue("Hits", UO.Hits)
updateValue("MaxHits", UO.MaxHits)
updateValue("Stamina", UO.Stamina)
updateValue("MaxStam", UO.MaxStam)
updateValue("Mana", UO.Mana)
updateValue("MaxMana", UO.MaxMana)
updateValue("MaxStats", UO.MaxStats)
updateValue("Luck", UO.Luck)
updateValue("Weight", UO.Weight)
updateValue("MaxWeight", UO.MaxWeight)
updateValue("MinDmg", UO.MinDmg)
updateValue("MaxDmg", UO.MaxDmg)
updateValue("Gold", UO.Gold)
updateValue("Followers", UO.Followers)
updateValue("MaxFol", UO.MaxFol)
updateValue("AR", UO.AR)
updateValue("FR", UO.FR)
updateValue("CR", UO.CR)
updateValue("PR", UO.PR)
updateValue("ER", UO.ER)
updateValue("TP", UO.TP)
--Container Info)
updateValue("NextCPosX", UO.NextCPosX)
updateValue("NextCPosY", UO.NextCPosY)
updateValue("ContPosX", UO.ContPosX)
updateValue("ContPosY", UO.ContPosY)
updateValue("ContSizeX", UO.ContSizeX)
updateValue("ContSizeY", UO.ContSizeY)
updateValue("ContKind", UO.ContKind)
updateValue("ContName", UO.ContName)
updateValue("ContID", UO.ContID)
updateValue("ContType", UO.ContType)
--Client Info)
updateValue("CliCnt", UO.CliCnt)
updateValue("CliLang", UO.CliLang)
updateValue("CliVer", UO.CliVer)
updateValue("CliLogged", UO.CliLogged)
updateValue("CliLeft", UO.CliLeft)
updateValue("CliTop", UO.CliTop)
updateValue("CliXRes", UO.CliXRes)
updateValue("CliYRes", UO.CliYRes)
updateValue("CliTitle", UO.CliTitle)
--Last Action)
updateValue("LObjectID", UO.LObjectID)
--updateValue("LHandID", UO.LHandID)
--updateValue("RHandID", UO.RHandID)
updateValue("LObjectType", UO.LObjectType)
updateValue("LTargetID", UO.LTargetID)
updateValue("LTargetX", UO.LTargetX)
updateValue("LTargetY", UO.LTargetY)
updateValue("LTargetZ", UO.LTargetZ)
updateValue("LTargetKind", UO.LTargetKind)
updateValue("LTargetTile", UO.LTargetTile)
updateValue("LLiftedID", UO.LLiftedID)
updateValue("LLiftedKind", UO.LLiftedKind)
updateValue("LLiftedType", UO.LLiftedType)
updateValue("LSkill", UO.LSkill)
updateValue("LSpell", UO.LSpell)
updateValue("CursorX", UO.CursorX)
updateValue("CursorY", UO.CursorY)
updateValue("LHandID", UO.LHandID)
updateValue("RHandID", UO.RHandID)
updateValue("CursKind", UO.CursKind)
updateValue("TargCurs", UO.TargCurs)

--Miscellaneous Skills
--[[
temp, Alchemy = UO.GetSkill("Alch");
temp, Blacksmithy = UO.GetSkill("Blac");
temp, Bowcraft = UO.GetSkill("Bowc");
temp, Bushido = UO.GetSkill("Bush");
temp, Carpentry = UO.GetSkill("Carp");
temp, Chivalry = UO.GetSkill("Chiv");
temp, Cooking = UO.GetSkill("Cook");
temp, Fishing = UO.GetSkill("Fish");
temp, Focus = UO.GetSkill("Focu");
temp, Healing = UO.GetSkill("Heal");
temp, Herding = UO.GetSkill("Herd");
temp, Lockpicking = UO.GetSkill("Lock");
temp, Lumberjacking = UO.GetSkill("Lumb");
temp, Magery = UO.GetSkill("Mage");
temp, Meditation = UO.GetSkill("Medi");
temp, Mining = UO.GetSkill("Mini");
temp, Musicianship = UO.GetSkill("Musi");
temp, Necromancy = UO.GetSkill("Necr");
temp, Ninjitsu = UO.GetSkill("Ninj");
temp, RemoveTrap = UO.GetSkill("Remo");
temp, ResistingSpells = UO.GetSkill("Resi");
temp, Snooping = UO.GetSkill("Snoo");
temp, Stealing = UO.GetSkill("Stea");
temp, Stealth = UO.GetSkill("Stlt");
temp, Tailoring = UO.GetSkill("Tail");
temp, Tinkering = UO.GetSkill("Tink");
temp, Veterinary = UO.GetSkill("Vete");
--Combat Skills
temp, Archery = UO.GetSkill("Arch");
temp, Fencing = UO.GetSkill("Fenc");
temp, MaceFighting = UO.GetSkill("Mace");
temp, Parrying = UO.GetSkill("Parr");
temp, Swordsmanship = UO.GetSkill("Swor");
temp, Tactics = UO.GetSkill("Tact");
temp, Wrestling = UO.GetSkill("Wres");
--Actions
temp, AnimalTaming = UO.GetSkill("Anim");
temp, Begging = UO.GetSkill("Begg");
temp, Camping = UO.GetSkill("Camp");
temp, DetectingHidden = UO.GetSkill("Det");
temp, Discordance = UO.GetSkill("Disc");
temp, Hiding = UO.GetSkill("Hidi");
temp, Inscription = UO.GetSkill("Insc");
temp, Peacemaking = UO.GetSkill("Peac");
temp, Poisoning = UO.GetSkill("Pois");
temp, Provocation = UO.GetSkill("Prov");
temp, SpiritSpeak = UO.GetSkill("Spir");
temp, Tracking = UO.GetSkill("Trac");
--Lore & Knowledge
temp, Anatomy = UO.GetSkill("Anat");
temp, AnimalLore = UO.GetSkill("Anil");
temp, ArmsLore = UO.GetSkill("Arms");
temp, EvaluatingIntelligence = UO.GetSkill("Eval");
temp, ForensicEvaluation = UO.GetSkill("Fore");
temp, ItemIdentification = UO.GetSkill("Item");
temp, TasteIdentification = UO.GetSkill("Tast");
--]]