local _, addon = ...
local Utils = addon.Utils
local TabContent = addon.TabContent or {}
addon.TabContent = TabContent

function TabContent.CreateEditBox(parent, name)
	local editBox = CreateFrame("EditBox", name, parent, "InputBoxTemplate")
	editBox:SetSize(380, 32)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:EnableMouse(true)
	return editBox
end

function TabContent.CreateArchonTab(dialog, tab)
	-- Mythic+ Section
	local mplusLabel = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	mplusLabel:SetPoint("TOPLEFT", addon.Config.DIALOG.PADDING.SIDE, -10)
	mplusLabel:SetText("Mythic+")

	dialog.mplusDesc = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	dialog.mplusDesc:SetPoint("TOPLEFT", mplusLabel, "BOTTOMLEFT", 0, -addon.Config.DIALOG.PADDING.LABEL)

	dialog.mplusDropdown = CreateFrame("Frame", "TalentExportDialog_MplusDropdown", tab, "UIDropDownMenuTemplate")
	dialog.mplusDropdown:SetPoint("TOPLEFT", dialog.mplusDesc, "BOTTOMLEFT", -15, -5)
	UIDropDownMenu_SetWidth(dialog.mplusDropdown, 150)
	UIDropDownMenu_Initialize(dialog.mplusDropdown, addon.DropdownManager.InitializeArchonMythicDropdown)

	dialog.mplusEdit = TabContent.CreateEditBox(tab, "TalentExportDialog_MplusEdit")
	dialog.mplusEdit:SetPoint("LEFT", dialog.mplusDropdown, "RIGHT", 10, 2)

	-- Raid Section
	local raidLabel = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	raidLabel:SetPoint("TOPLEFT", dialog.mplusEdit, "BOTTOMLEFT", -195, -addon.Config.DIALOG.SECTION_SPACING)
	raidLabel:SetText("Raid")

	dialog.raidDesc = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	dialog.raidDesc:SetPoint("TOPLEFT", raidLabel, "BOTTOMLEFT", 0, -addon.Config.DIALOG.PADDING.LABEL)

	dialog.raidDropdown = CreateFrame("Frame", "TalentExportDialog_RaidDropdown", tab, "UIDropDownMenuTemplate")
	dialog.raidDropdown:SetPoint("TOPLEFT", dialog.raidDesc, "BOTTOMLEFT", -15, -5)
	UIDropDownMenu_SetWidth(dialog.raidDropdown, 150)
	UIDropDownMenu_Initialize(dialog.raidDropdown, addon.DropdownManager.InitializeArchonRaidDropdown)

	dialog.raidEdit = TabContent.CreateEditBox(tab, "TalentExportDialog_RaidEdit")
	dialog.raidEdit:SetPoint("LEFT", dialog.raidDropdown, "RIGHT", 10, 2)

	local instructionsText = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	instructionsText:SetPoint("BOTTOM", tab, "BOTTOM", 0, 55)
	instructionsText:SetText("Select a build to copy the latest talent string | Builds as of " .. Utils.GetFormattedLocalTime(addon.ArchonMythicDB.updated))
	instructionsText:SetJustifyH("CENTER")
end

function TabContent.CreateWowheadTab(dialog, tab)
	-- Mythic+ Section
	local mplusLabel = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	mplusLabel:SetPoint("TOPLEFT", addon.Config.DIALOG.PADDING.SIDE, -10)
	mplusLabel:SetText("Mythic+")

	dialog.wowheadMplusDesc = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	dialog.wowheadMplusDesc:SetPoint("TOPLEFT", mplusLabel, "BOTTOMLEFT", 0, -addon.Config.DIALOG.PADDING.LABEL)

	dialog.wowheadMplusDropdown = CreateFrame("Frame", "TalentExportDialog_WowheadMplusDropdown", tab, "UIDropDownMenuTemplate")
	dialog.wowheadMplusDropdown:SetPoint("TOPLEFT", dialog.wowheadMplusDesc, "BOTTOMLEFT", -15, -5)
	UIDropDownMenu_SetWidth(dialog.wowheadMplusDropdown, 150)
	UIDropDownMenu_Initialize(dialog.wowheadMplusDropdown, addon.DropdownManager.InitializeWowheadMythicDropdown)

	dialog.wowheadMplusEdit = TabContent.CreateEditBox(tab, "TalentExportDialog_WowheadMplusEdit")
	dialog.wowheadMplusEdit:SetPoint("LEFT", dialog.wowheadMplusDropdown, "RIGHT", 10, 2)

	-- Raid Section
	local raidLabel = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	raidLabel:SetPoint("TOPLEFT", dialog.wowheadMplusEdit, "BOTTOMLEFT", -195, -addon.Config.DIALOG.SECTION_SPACING)
	raidLabel:SetText("Raid")

	dialog.wowheadRaidDesc = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	dialog.wowheadRaidDesc:SetPoint("TOPLEFT", raidLabel, "BOTTOMLEFT", 0, -addon.Config.DIALOG.PADDING.LABEL)

	dialog.wowheadRaidDropdown = CreateFrame("Frame", "TalentExportDialog_WowheadRaidDropdown", tab, "UIDropDownMenuTemplate")
	dialog.wowheadRaidDropdown:SetPoint("TOPLEFT", dialog.wowheadRaidDesc, "BOTTOMLEFT", -15, -5)
	UIDropDownMenu_SetWidth(dialog.wowheadRaidDropdown, 150)
	UIDropDownMenu_Initialize(dialog.wowheadRaidDropdown, addon.DropdownManager.InitializeWowheadRaidDropdown)

	dialog.wowheadRaidEdit = TabContent.CreateEditBox(tab, "TalentExportDialog_WowheadRaidEdit")
	dialog.wowheadRaidEdit:SetPoint("LEFT", dialog.wowheadRaidDropdown, "RIGHT", 10, 2)

	-- Misc Section
	local miscLabel = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	miscLabel:SetPoint("TOPLEFT", dialog.wowheadRaidEdit, "BOTTOMLEFT", -195, -addon.Config.DIALOG.SECTION_SPACING)
	miscLabel:SetText("Misc")

	dialog.wowheadMiscDesc = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	dialog.wowheadMiscDesc:SetPoint("TOPLEFT", miscLabel, "BOTTOMLEFT", 0, -addon.Config.DIALOG.PADDING.LABEL)

	dialog.wowheadMiscDropdown = CreateFrame("Frame", "TalentExportDialog_WowheadMiscDropdown", tab, "UIDropDownMenuTemplate")
	dialog.wowheadMiscDropdown:SetPoint("TOPLEFT", dialog.wowheadMiscDesc, "BOTTOMLEFT", -15, -5)
	UIDropDownMenu_SetWidth(dialog.wowheadMiscDropdown, 150)
	UIDropDownMenu_Initialize(dialog.wowheadMiscDropdown, addon.DropdownManager.InitializeWowheadMiscDropdown)

	dialog.wowheadMiscEdit = TabContent.CreateEditBox(tab, "TalentExportDialog_WowheadMiscEdit")
	dialog.wowheadMiscEdit:SetPoint("LEFT", dialog.wowheadMiscDropdown, "RIGHT", 10, 2)

	local instructionsText = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	instructionsText:SetPoint("BOTTOM", tab, "BOTTOM", 0, 55)
	instructionsText:SetText("Select a build to copy the latest talent string | Builds as of " .. Utils.GetFormattedLocalTime(addon.WowheadMythicDB.updated))
	instructionsText:SetJustifyH("CENTER")
end

function TabContent.CreateIceyVeinsTab(dialog, tab)
	-- Mythic+ Section
	local mplusLabel = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	mplusLabel:SetPoint("TOPLEFT", addon.Config.DIALOG.PADDING.SIDE, -10)
	mplusLabel:SetText("Mythic+")

	dialog.icyveinsMplusDesc = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	dialog.icyveinsMplusDesc:SetPoint("TOPLEFT", mplusLabel, "BOTTOMLEFT", 0, -addon.Config.DIALOG.PADDING.LABEL)

	dialog.icyveinsMplusDropdown = CreateFrame("Frame", "TalentExportDialog_IceveinsMplusDropdown", tab, "UIDropDownMenuTemplate")
	dialog.icyveinsMplusDropdown:SetPoint("TOPLEFT", dialog.icyveinsMplusDesc, "BOTTOMLEFT", -15, -5)
	UIDropDownMenu_SetWidth(dialog.icyveinsMplusDropdown, 150)
	UIDropDownMenu_Initialize(dialog.icyveinsMplusDropdown, addon.DropdownManager.InitializeIcyVeinsMythicDropdown)

	dialog.icyveinsMplusEdit = TabContent.CreateEditBox(tab, "TalentExportDialog_IcyVeinsMplusEdit")
	dialog.icyveinsMplusEdit:SetPoint("LEFT", dialog.icyveinsMplusDropdown, "RIGHT", 10, 2)

	-- Raid Section
	local raidLabel = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	raidLabel:SetPoint("TOPLEFT", dialog.icyveinsMplusEdit, "BOTTOMLEFT", -195, -addon.Config.DIALOG.SECTION_SPACING)
	raidLabel:SetText("Raid")

	dialog.icyveinsRaidDesc = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	dialog.icyveinsRaidDesc:SetPoint("TOPLEFT", raidLabel, "BOTTOMLEFT", 0, -addon.Config.DIALOG.PADDING.LABEL)

	dialog.icyveinsRaidDropdown = CreateFrame("Frame", "TalentExportDialog_IcyVeinsRaidDropdown", tab, "UIDropDownMenuTemplate")
	dialog.icyveinsRaidDropdown:SetPoint("TOPLEFT", dialog.icyveinsRaidDesc, "BOTTOMLEFT", -15, -5)
	UIDropDownMenu_SetWidth(dialog.icyveinsRaidDropdown, 150)
	UIDropDownMenu_Initialize(dialog.icyveinsRaidDropdown, addon.DropdownManager.InitializeIcyVeinsRaidDropdown)

	dialog.icyveinsRaidEdit = TabContent.CreateEditBox(tab, "TalentExportDialog_IcyVeinsRaidEdit")
	dialog.icyveinsRaidEdit:SetPoint("LEFT", dialog.icyveinsRaidDropdown, "RIGHT", 10, 2)

	-- Misc Section
	local miscLabel = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	miscLabel:SetPoint("TOPLEFT", dialog.icyveinsRaidEdit, "BOTTOMLEFT", -195, -addon.Config.DIALOG.SECTION_SPACING)
	miscLabel:SetText("Misc")

	dialog.icyveinsMiscDesc = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	dialog.icyveinsMiscDesc:SetPoint("TOPLEFT", miscLabel, "BOTTOMLEFT", 0, -addon.Config.DIALOG.PADDING.LABEL)

	dialog.icyveinsMiscDropdown = CreateFrame("Frame", "TalentExportDialog_IcyVeinsMiscDropdown", tab, "UIDropDownMenuTemplate")
	dialog.icyveinsMiscDropdown:SetPoint("TOPLEFT", dialog.icyveinsMiscDesc, "BOTTOMLEFT", -15, -5)
	UIDropDownMenu_SetWidth(dialog.icyveinsMiscDropdown, 150)
	UIDropDownMenu_Initialize(dialog.icyveinsMiscDropdown, addon.DropdownManager.InitializeIcyVeinsMiscDropdown)

	dialog.icyveinsMiscEdit = TabContent.CreateEditBox(tab, "TalentExportDialog_IcyVeinsMiscEdit")
	dialog.icyveinsMiscEdit:SetPoint("LEFT", dialog.icyveinsMiscDropdown, "RIGHT", 10, 2)

	local instructionsText = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	instructionsText:SetPoint("BOTTOM", tab, "BOTTOM", 0, 55)
	instructionsText:SetText("Select a build to copy the latest talent string | Builds as of " .. Utils.GetFormattedLocalTime(addon.IcyVeinsMythicDB.updated))
	instructionsText:SetJustifyH("CENTER")
end

return TabContent
