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

CPAPI.GetNumQuestWatches = function(self, ...)
	return GetNumQuestWatches and GetNumQuestWatches(...) or 0
end

CPAPI.GetNumWorldQuestWatches = function(self, ...)
	return GetNumWorldQuestWatches and GetNumWorldQuestWatches(...) or 0
end

CPAPI.GetQuestLogSpecialItemInfo = function(self, ...)
	return GetQuestLogSpecialItemInfo and GetQuestLogSpecialItemInfo(...)
end

CPAPI.UnitIsBattlePet = function(self, ...)
	return UnitIsBattlePet and UnitIsBattlePet(...)
end

CPAPI.UnitThreatSituation = function(self, ...)
	return UnitThreatSituation and UnitThreatSituation(...)
end

CPAPI.IsXPUserDisabled = function(self, ...)
	return IsXPUserDisabled and IsXPUserDisabled(...)
end

CPAPI.IsSpellOverlayed = function(self, ...)
	return IsSpellOverlayed and IsSpellOverlayed(...)
end

CPAPI.GetFriendshipReputation = function(self, ...)
	return GetFriendshipReputation and GetFriendshipReputation(...)
end

CPAPI.IsPartyLFG = function(self, ...)
	return IsPartyLFG and IsPartyLFG(...)
end

CPAPI.IsInLFGDungeon = function(self, ...)
	return IsInLFGDungeon and IsInLFGDungeon(...)
end


-- Project identifiers, should return true or nil (nil for dynamic table insertions)
CPAPI.IsClassicVersion = function(self, ...)
	if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then return true end
end

CPAPI.IsRetailVersion = function(self, ...)
	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return true end
end