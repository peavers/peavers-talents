local addonName, addonTable = ...
local Utils = addonTable.Utils or {}
addonTable.Utils = Utils

-- Class name mappings for special cases
local CLASS_NAME_MAPPINGS = {
    ["death knight"] = "death-knight",
    ["demon hunter"] = "demon-hunter"
}

---Gets formatted player information
Utils.GetPlayerInfo = function()
    local playerName, playerRealm = UnitFullName("player")
    playerRealm = playerRealm or GetRealmName()
    local fullPlayerName = playerName .. "-" .. playerRealm
    local _, playerClass, playerClassID = UnitClass("player")

    local specIndex = GetSpecialization()
    local specName = specIndex and select(2, GetSpecializationInfo(specIndex)) or "None"

    return fullPlayerName, playerClass, playerClassID, specName
end

---Formats a class name to match the database format
Utils.FormatClassName = function(className)
    local lowercaseName = Utils.ToLowercaseAndReplaceWhitespace(className)
    return CLASS_NAME_MAPPINGS[lowercaseName] or lowercaseName
end

Utils.ToLowercaseAndReplaceWhitespace = function(str)
    return string.lower(str):gsub("%s+", " ")
end

return Utils
