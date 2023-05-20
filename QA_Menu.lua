local titlebar, window

local backdrop = {
  bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
  tile = true, tileSize = 32, edgeSize = 16,
  insets = { left = 5, right = 5, top = 5, bottom = 5 }
}

do -- titlebar
  titlebar = CreateFrame("Frame", "QA_Menu", UIParent)
  titlebar:SetPoint("TOP", Minimap, "BOTTOM", 0, -32)
  titlebar:SetWidth(152)
  titlebar:SetHeight(28)
  titlebar:SetBackdrop(backdrop)

  titlebar:EnableMouse(true)
  titlebar:RegisterForDrag("LeftButton")
  titlebar:SetMovable(true)
  titlebar:SetUserPlaced(true)
  titlebar:SetScript("OnDragStart", function() this:StartMoving() end)
  titlebar:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)

  titlebar.icon = CreateFrame("CheckButton", "QA_Menu_TitleIcon", titlebar, "UICheckButtonTemplate")
  titlebar.icon:SetPoint("LEFT", titlebar, "LEFT", 4, 0)
  titlebar.icon:SetWidth(20)
  titlebar.icon:SetHeight(20)
  titlebar.icon:SetChecked(true)
  titlebar.icon:SetScript("OnClick", function ()
    if this:GetChecked() then
      window:Show()
    else
      window:Hide()
    end
  end)

  titlebar.text = titlebar:CreateFontString("QA_Menu_TitleText", "OVERLAY", "GameFontNormal")
  titlebar.text:SetFont(STANDARD_TEXT_FONT, 14)
  titlebar.text:SetPoint("LEFT", titlebar, "LEFT", 28, 0)
  titlebar.text:SetText("QA Menu")

  titlebar.close = CreateFrame("Button", "QA_Menu_TitleClose", titlebar, "UIPanelCloseButton")
  titlebar.close:SetPoint("TOPRIGHT", titlebar, "TOPRIGHT", 0, 0)
  titlebar.close:SetWidth(28)
  titlebar.close:SetHeight(28)
  titlebar.close:SetBackdrop(backdrop)
  titlebar.close:SetScript("OnClick", function()
    titlebar:Hide()
  end)
end

do -- window
  window = CreateFrame("Frame", "QA_Menu", titlebar)
  titlebar.window = window
  window:SetBackdrop(backdrop)
  window:SetPoint("TOPLEFT", titlebar, "BOTTOMLEFT", 0, 7)
  window:SetPoint("TOPRIGHT", titlebar, "BOTTOMRIGHT", 0, 7)
  window:SetHeight(360)

  local position = 0
  local buttons = {
    "Recharge",
    "Decharge",
    "Money (1kG)",
    "MaxAllSkills",
    "BuyTrainerSkills"
  }

  local checkbuttons = {
    "God Mode",
    "Beastmaster",
    "Cooldown",
    "Flight Mode",
    "AutoAccept",
    "DebugTargetInfo"
  }

  local iconbuttons = {
    { "WoWpad", "Interface\\Icons\\INV_Misc_Note_03" },
    { "Script Helper", "Interface\\Icons\\INV_Misc_Bandage_07" }
  }

  for id, name in pairs(buttons) do
    window[name] = CreateFrame("Button", "QA_Menu_Button_" .. name, window, "GameMenuButtonTemplate")
    window[name]:SetPoint("TOP", window, "TOP", 0, -(position)*24-8)
    window[name]:SetWidth(128)
    window[name]:SetHeight(24)
    window[name]:SetText(name)
    position = position + 1
  end

  for id, name in pairs(checkbuttons) do
    window[name] = CreateFrame("CheckButton", "QA_Menu_Button_" .. name, window, "UICheckButtonTemplate")
    window[name]:SetPoint("TOPLEFT", window, "TOPLEFT", 12, -(position)*24-8)
    window[name]:SetWidth(28)
    window[name]:SetHeight(28)

    window[name].text = getglobal(window[name]:GetName() .. "Text")
    window[name].text:SetPoint("LEFT", window[name], "RIGHT", 4, 0)
    window[name].text:SetText(name)
    position = position + 1
  end

  for id, data in pairs(iconbuttons) do
    local name, texture = data[1], data[2]

    window[name] = CreateFrame("Button", "QA_Menu_Button_" .. name, window)
    window[name]:SetPoint("TOPLEFT", window, "TOPLEFT", 12, -(position)*24-12)
    window[name]:SetWidth(22)
    window[name]:SetHeight(22)

    window[name]:SetNormalTexture(texture)
    window[name]:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    window[name]:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")

    window[name].icon = window[name]:CreateTexture(nil, "BACKGROUND")
    window[name].icon:SetAllPoints()
    window[name].icon:SetTexture(texture)

    window[name].text = window:CreateFontString("QA_Menu_TitleText", "OVERLAY", "GameFontNormalSmall")
    window[name].text:SetPoint("LEFT", window[name], "RIGHT", 4, 0)
    window[name].text:SetText(name)
    position = position + 1
  end

  window["leftarrow"] = CreateFrame("Button", "QA_Menu_Button_LeftArrow", window)
  window["leftarrow"]:SetPoint("BOTTOMLEFT", window, "BOTTOMLEFT", 4, 4)
  window["leftarrow"]:SetWidth(28)
  window["leftarrow"]:SetHeight(28)

  window["leftarrow"]:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
  window["leftarrow"]:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
  window["leftarrow"]:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")

  window["leftarrow"].icon = window["leftarrow"]:CreateTexture(nil, "BACKGROUND")
  window["leftarrow"].icon:SetAllPoints()
  window["leftarrow"].icon:SetTexture("Interface\Buttons\UI-SpellbookIcon-PrevPage-Up")

  window["dropdown"] = CreateFrame("Frame", "QA_Menu_DropDown", window, "UIDropDownMenuTemplate")
  window["dropdown"]:SetPoint("LEFT", window["leftarrow"], "RIGHT", -20, -2)
  window["dropdown"]:SetScript("OnUpdate", function()
    UIDropDownMenu_Initialize(window["dropdown"], window["dropdown"].buttons)
    UIDropDownMenu_SetWidth(100, window["dropdown"])
    UIDropDownMenu_SetButtonWidth(100, window["dropdown"])
    UIDropDownMenu_JustifyText("RIGHT", window["dropdown"])
    UIDropDownMenu_SetSelectedID(window["dropdown"], 1, 0)
    window["dropdown"]:SetScript("OnUpdate", nil)
  end)
end

do -- button scripts
  -- normal buttons
  window["Recharge"]:SetScript("OnClick", function()
    DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Recharge")
  end)

  window["Decharge"]:SetScript("OnClick", function()
    DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Decharge")
  end)

  window["Money (1kG)"]:SetScript("OnClick", function()
    DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Money (1kG)")
  end)

  window["MaxAllSkills"]:SetScript("OnClick", function()
    DEFAULT_CHAT_FRAME:AddMessage("DUMMY: MaxAllSkills")
  end)

  window["BuyTrainerSkills"]:SetScript("OnClick", function()
    DEFAULT_CHAT_FRAME:AddMessage("DUMMY: BuyTrainerSkills")
  end)

  -- check buttons
  window["God Mode"]:SetScript("OnClick", function()
    if this:GetChecked() then
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Checked")
    else
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Unchecked")
    end
  end)

  window["Beastmaster"]:SetScript("OnClick", function()
    if this:GetChecked() then
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Checked")
    else
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Unchecked")
    end
  end)

  window["Cooldown"]:SetScript("OnClick", function()
    if this:GetChecked() then
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Checked")
    else
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Unchecked")
    end
  end)

  window["Flight Mode"]:SetScript("OnClick", function()
    if this:GetChecked() then
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Checked")
    else
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Unchecked")
    end
  end)

  window["AutoAccept"]:SetScript("OnClick", function()
    if this:GetChecked() then
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Checked")
    else
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Unchecked")
    end
  end)

  window["DebugTargetInfo"]:SetScript("OnClick", function()
    if this:GetChecked() then
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Checked")
    else
      DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Unchecked")
    end
  end)

  -- icon buttons
  window["WoWpad"]:SetScript("OnClick", function()
    DEFAULT_CHAT_FRAME:AddMessage("DUMMY: WoWpad")
  end)

  window["Script Helper"]:SetScript("OnClick", function()
    DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Script Helper")
  end)

  -- dropdown buttons
  window["dropdown"].buttons = function()
    UIDropDownMenu_AddButton({
      text = "Items", checked = false,
      func = function()
        UIDropDownMenu_SetSelectedID(window["dropdown"], this:GetID(), 0)
        DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Items")
      end
    })

    UIDropDownMenu_AddButton({
      text = "Units", checked = false,
      func = function()
        UIDropDownMenu_SetSelectedID(window["dropdown"], this:GetID(), 0)
        DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Items")
      end
    })

    UIDropDownMenu_AddButton({
      text = "Objects", checked = false,
      func = function()
        UIDropDownMenu_SetSelectedID(window["dropdown"], this:GetID(), 0)
        DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Items")
      end
    })

     UIDropDownMenu_AddButton({
      text = "Spells", checked = false,
      func = function()
        UIDropDownMenu_SetSelectedID(window["dropdown"], this:GetID(), 0)
        DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Items")
      end
    })
  end

  -- Left Arrow Button
  window["leftarrow"]:SetScript("OnClick", function()
    local dropdown_id = UIDropDownMenu_GetSelectedID(window["dropdown"])
    DEFAULT_CHAT_FRAME:AddMessage("DUMMY: Left-Arrow, DropDownID ".. dropdown_id)
  end)
end
