local _, Cell = ...
local L = Cell.L
local F = Cell.funcs

local optionsFrame = Cell:CreateFrame("CellOptionsFrame", Cell.frames.mainFrame, 397, 300)
Cell.frames.optionsFrame = optionsFrame
optionsFrame:SetPoint("BOTTOMLEFT", Cell.frames.mainFrame, "TOPLEFT", 0, 16)
optionsFrame:SetFrameStrata("MEDIUM")

-------------------------------------------------
-- button group
-------------------------------------------------
local appearanceBtn = Cell:CreateButton(optionsFrame, L["Appearance"], "red-hover", {100, 20}, nil, "CELL_FONT_WIDGET_TITLE", "CELL_FONT_WIDGET_TITLE_DISABLE")
local clickCastingBtn = Cell:CreateButton(optionsFrame, L["Click-Casting"], "green-hover", {100, 20}, nil, "CELL_FONT_WIDGET_TITLE", "CELL_FONT_WIDGET_TITLE_DISABLE")
local indicatorsBtn = Cell:CreateButton(optionsFrame, L["Indicators"], "blue-hover", {100, 20}, nil, "CELL_FONT_WIDGET_TITLE", "CELL_FONT_WIDGET_TITLE_DISABLE")
local debuffsBtn = Cell:CreateButton(optionsFrame, L["Debuffs"], "yellow-hover", {100, 20}, nil, "CELL_FONT_WIDGET_TITLE", "CELL_FONT_WIDGET_TITLE_DISABLE")
local aboutBtn = Cell:CreateButton(optionsFrame, L["About"], "class-hover", {50, 18}, nil, "CELL_FONT_WIDGET", "CELL_FONT_WIDGET_DISABLE")

appearanceBtn:SetPoint("BOTTOMLEFT", optionsFrame, "TOPLEFT", 0, -1)
clickCastingBtn:SetPoint("LEFT", appearanceBtn, "RIGHT", -1, 0)
indicatorsBtn:SetPoint("LEFT", clickCastingBtn, "RIGHT", -1, 0)
debuffsBtn:SetPoint("LEFT", indicatorsBtn, "RIGHT", -1, 0)
aboutBtn:SetPoint("TOPRIGHT", optionsFrame, "BOTTOMRIGHT", 0, 1)

appearanceBtn.target = "appearance"
clickCastingBtn.target = "clickcasting"
indicatorsBtn.target = "indicators"
debuffsBtn.target = "debuffs"
aboutBtn.target = "about"

local lastShownTab
local function ShowTab(tab)
    if lastShownTab ~= tab then
        Cell:FireEvent("ShowOptionsTab", tab)
        lastShownTab = tab
    end
end

local buttonGroup = Cell:CreateButtonGroup(ShowTab, appearanceBtn, clickCastingBtn, indicatorsBtn, debuffsBtn, aboutBtn)

function F:ShowOptionsFrame()
    if InCombatLockdown() then
        F:Print(L["Can't change options in combat."])
        return
    end

    if optionsFrame:IsShown() then
        optionsFrame:Hide()
        return
    end

    if not lastShownTab then
        ShowTab("appearance")
        buttonGroup.HighlightButton("appearance")
    end
    
    optionsFrame:Show()
end

optionsFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
optionsFrame:SetScript("OnEvent", function()
    optionsFrame:Hide()
end)