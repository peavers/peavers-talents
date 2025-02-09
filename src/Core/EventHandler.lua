local _, addon = ...
local Utils = addon.Utils
local EventHandler = addon.EventHandler or {}
addon.EventHandler = EventHandler

local talentFrame
local isTWW = select(4, GetBuildInfo()) >= 110000
local talentUI = isTWW and "Blizzard_PlayerSpells" or "Blizzard_ClassTalentUI"

-- Track if version check is initialized
local versionCheckInitialized = false

local function initializeVersionCheck()
    if not versionCheckInitialized and addon.VersionCheck then
        Utils.Debug("Initializing version check")
        addon.VersionCheck:Initialize()
        versionCheckInitialized = true
    end
end

function EventHandler.Initialize()
    local eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("ADDON_LOADED")
    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    eventFrame:RegisterEvent("CHAT_MSG_ADDON")
    eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
    eventFrame:RegisterEvent("GUILD_ROSTER_UPDATE")
    eventFrame:RegisterEvent("GROUP_JOINED")
    eventFrame:RegisterEvent("PLAYER_GUILD_UPDATE")
    eventFrame:SetScript("OnEvent", EventHandler.OnEvent)

    -- Try to initialize version check
    initializeVersionCheck()
end

function EventHandler.OnEvent(self, event, arg1, ...)
    if event == "ADDON_LOADED" then
        if arg1 == talentUI then
            Utils.Debug("Talent UI loaded")
            talentFrame = isTWW and PlayerSpellsFrame.TalentsFrame or ClassTalentFrame.TalentsTab
            EventHandler.CreateExportButton()
        end
        -- Try to initialize version check after any addon loads
        initializeVersionCheck()
    elseif event == "PLAYER_ENTERING_WORLD" then
        Utils.Debug("Player entering world")
        if not C_AddOns.IsAddOnLoaded(talentUI) then
            UIParentLoadAddOn(talentUI)
        end

        -- Broadcast version if initialized
        if versionCheckInitialized and addon.VersionCheck then
            addon.VersionCheck:BroadcastVersion()
        end
    elseif event == "CHAT_MSG_ADDON" then
        -- Handle addon messages if initialized
        if versionCheckInitialized and addon.VersionCheck then
            addon.VersionCheck:HandleAddonMessage(arg1, ...)
        end
    elseif event == "GROUP_ROSTER_UPDATE" or event == "GROUP_JOINED" or event == "PLAYER_GUILD_UPDATE" then
        -- Broadcast version when group composition changes or we join a new group
        if versionCheckInitialized and addon.VersionCheck then
            addon.VersionCheck:BroadcastVersion()
        end
    end
end

function EventHandler.CreateExportButton()
    local exportButton = CreateFrame("Button", "TalentExportButton", talentFrame, "UIPanelButtonTemplate")
    exportButton:SetSize(addon.Config.DIALOG.IMPORT_BUTTON.WIDTH, addon.Config.DIALOG.IMPORT_BUTTON.HEIGHT)
    exportButton:SetText("Builds")
    exportButton:SetPoint("LEFT", talentFrame.SearchBox, "RIGHT", 10, 0)
    exportButton:SetScript("OnClick", addon.ShowExportDialog)
    Utils.Debug("Export button created")
end

return EventHandler
