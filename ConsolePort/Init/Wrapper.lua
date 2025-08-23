CPAPI = {}

local function GetClassInfo()	return UnitClass('player') end
local function GetClassFile()   return select(2, UnitClass('player')) end
local function GetClassID() 	return select(3, UnitClass('player')) end

function CPAPI:GetPlayerCastingInfo()
	-- use UnitCastingInfo on retail
	if UnitCastingInfo then
		return UnitCastingInfo('player')
	end
	-- use CastingInfo on classic
	return CastingInfo()
end

function CPAPI:GetSpecialization()
	-- returns specializationID on retail
	if GetSpecialization then
		return GetSpecialization()
	end
	-- returns classID on classic
	return GetClassID()
end

function CPAPI:GetSpecTextureByID(ID)
	-- returns specTexture on retail
	if GetSpecializationInfoByID then
		return select(4, GetSpecializationInfoByID(ID))
	-- returns classTexture on classic
	elseif C_CreatureInfo and C_CreatureInfo.GetClassInfo then
		local classInfo = C_CreatureInfo.GetClassInfo(ID)
		if classInfo then
			return ([[Interface\ICONS\ClassIcon_%s.blp]]):format(classInfo.classFile)
		end
	end
end

function CPAPI:GetClassIcon(class)
	-- returns concatenated icons file with slicing coords
	return [[Interface\TargetingFrame\UI-Classes-Circles]], CLASS_ICON_TCOORDS[class or GetClassFile()]
end

function CPAPI:GetCharacterMetadata()
	-- returns specID, specName on retail
	if GetSpecializationInfo and GetSpecialization then
		return GetSpecializationInfo(GetSpecialization())
	end
	-- returns classID, localized class token on classic
	return GetClassID(), GetClassInfo()
end

function CPAPI:GetNumQuestWatches()
	return GetNumQuestWatches and GetNumQuestWatches() or 0
end

function CPAPI:GetNumWorldQuestWatches()
	return GetNumWorldQuestWatches and GetNumWorldQuestWatches() or 0
end

function CPAPI:GetQuestLogSpecialItemInfo(questIndex)
	if GetQuestLogSpecialItemInfo then
		return GetQuestLogSpecialItemInfo(questIndex)
	else
		-- Fallback for Classic - return nil or default values
		return nil, nil, nil, nil, nil
	end
end

function CPAPI:UnitIsBattlePet(unit)
	if UnitIsBattlePet then
		return UnitIsBattlePet(unit)
	else
		-- Fallback for Classic - battle pets don't exist
		return false
	end
end

function CPAPI:UnitThreatSituation(unit, target)
	if UnitThreatSituation then
		return UnitThreatSituation(unit, target)
	else
		-- Fallback for Classic - return 0 (no threat)
		return 0
	end
end

function CPAPI:IsXPUserDisabled()
	if IsXPUserDisabled then
		return IsXPUserDisabled()
	else
		-- Fallback for Classic - XP is always enabled
		return false
	end
end

function CPAPI:IsSpellOverlayed(spellID)
	if IsSpellOverlayed then
		return IsSpellOverlayed(spellID)
	else
		-- Fallback for Classic - no spell overlays
		return false
	end
end

function CPAPI:GetFriendshipReputation(factionID)
	if GetFriendshipReputation then
		return GetFriendshipReputation(factionID)
	else
		-- Fallback for Classic - no friendship reputation
		return nil, nil, nil, nil, nil
	end
end

function CPAPI:IsPartyLFG()
	if IsPartyLFG then
		return IsPartyLFG()
	else
		-- Fallback for Classic - no LFG system
		return false
	end
end

function CPAPI:IsInLFGDungeon()
	if IsInLFGDungeon then
		return IsInLFGDungeon()
	else
		-- Fallback for Classic - no LFG system
		return false
	end
end


-- Project identifiers, should return true or nil (nil for dynamic table insertions)
function CPAPI:IsClassicVersion()
	if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then return true end
end

function CPAPI:IsRetailVersion()
	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return true end
end