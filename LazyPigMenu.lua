LazyPigOptions = {
	{
		text = "Green Items Roll [Ctrl + Alt]",
		exclusive = true,
		checkBoxes = {
			{ text = NEED, var = "GREEN", value = 1, tooltip = NEED },
			{ text = GREED, var = "GREEN", value = 2, tooltip = GREED },
			{ text = PASS, var = "GREEN", value = 0, tooltip = PASS },
		},
	},
	{
		text = "Zul'Gurub Roll Automation",
		exclusive = true,
		checkBoxes = {
			{ text = NEED, var = "ZG", value = 1, tooltip = NEED },
			{ text = GREED, var = "ZG", value = 2, tooltip = GREED },
			{ text = PASS, var = "ZG", value = 0, tooltip = PASS },
		},
	},
	{
		text = "Molten Core Roll Automation",
		exclusive = true,
		checkBoxes = {
			{ text = NEED, var = "MC", value = 1, tooltip = NEED },
			{ text = GREED, var = "MC", value = 2, tooltip = GREED },
			{ text = PASS, var = "MC", value = 0, tooltip = PASS },
		},
	},
	{
		text = "AQ Idols + Scarabs Automation",
		exclusive = true,
		checkBoxes = {
			{ text = NEED, var = "AQ", value = 1, tooltip = NEED },
			{ text = GREED, var = "AQ", value = 2, tooltip = GREED },
			{ text = PASS, var = "AQ", value = 0, tooltip = PASS },
		},
	},
	{
		text = "Black Morass Corrupted Sand Automation",
		exclusive = true,
		checkBoxes = {
			{ text = NEED, var = "SAND", value = 1, tooltip = NEED },
			{ text = GREED, var = "SAND", value = 2, tooltip = GREED },
			{ text = PASS, var = "SAND", value = 0, tooltip = PASS },
		},
	},
	{
		text = "Emerald Sanctum Roll Automation",
		exclusive = true,
		checkBoxes = {
			{ text = NEED, var = "ES_SHARDS", value = 1, tooltip = NEED },
			{ text = GREED, var = "ES_SHARDS", value = 2, tooltip = GREED },
			{ text = PASS, var = "ES_SHARDS", value = 0, tooltip = PASS },
		},
	},
	{
		text = "Salvation Remover",
		exclusive = true,
		checkBoxes = {
			{ text = ALWAYS, var = "SALVA", value = 1, tooltip = ALWAYS, setFunc = LazyPig_CheckSalvation },
			{ text = "Smart", var = "SALVA", value = 2, tooltip = "Warrior Shield / Druid Bear Form / Paladin Righteous Fury", setFunc = LazyPig_CheckSalvation },
		},
	},
	{
		text = "Mana Buffs Remover",
		exclusive = true,
		checkBoxes = {
			{ text = ALWAYS, var = "REMOVEMANABUFFS", value = 1, tooltip = "Remove Blessing of Wisdom / Arcane Intellect / Prayer or Spirit", setFunc = LazyPig_CheckManaBuffs },
		},
	},
	{
		text = "Group Invite Accept Rules",
		checkBoxes = {
			{ text = "GuildMates", var = "GINV", tooltip = "GuildMates" },
			{ text = "Friends", var = "FINV", tooltip = "Friends" },
			{ text = "Strangers", var = "SINV", tooltip = "Strangers" },
			{ text = "Idle while in BG or Queue", var = "DINV", tooltip = "No Auto Accept Invites while in Battleground or Queue" }
		},
	},
	{
		text = "Battlegrounds Automation",
		checkBoxes = {
			{ text = "Enter Battleground", var = "EBG", tooltip = "Enter the Battleground as soon as the queue popup" },
			{ text = "Leave Battleground", var = "LBG", tooltip = "Leave the Battleground as soon as its finished" },
			{ text = "Queue Battleground", var = "QBG", tooltip = "Join the queue as soon as the BattleMaster is right-clicked" },
			{ text = "Auto Release", var = "RBG", tooltip = "Auto Accept Release in BG" },
			{ text = "Leader Queue Announce", var = "AQUE", tooltip = "Leader Queue Announce" },
			{ text = "Block BG Quest Sharing", var = "SBG", tooltip = "Block BG Quest Sharing" }
		},
	},
	{
		text = "Chat Filter",
		checkBoxes = {
			{ text = "Players' Spam", var = "SPAM", tooltip = "Players' Spam" },
			{ text = "Uncommon Roll", var = "SPAM_UNCOMMON", tooltip = "Uncommon Roll" },
			{ text = "Rare Roll", var = "SPAM_RARE", tooltip = "Rare Roll" },
			{ text = "Poor-Common Loot", var = "SPAM_LOOT", tooltip = "Poor-Common Loot" },
			{ text = "Lazy Pig Messages", var = "ROLLMSG", tooltip = "Lazy Pig Auto Roll Messages" }
		},
	},
	{
		text = "World Chat Mute",
		checkBoxes = {
			{ text = "Dungeons", var = "WORLDDUNGEON", tooltip = "Dungeons", setFunc = LazyPig_ZoneCheck },
			{ text = "Raids", var = "WORLDRAID", tooltip = "Raids", setFunc = LazyPig_ZoneCheck },
			{ text = "Battlegrounds", var = "WORLDBG", tooltip = "Battlegrounds", setFunc = LazyPig_ZoneCheck },
			{ text = "Mute Permanently", var = "WORLDUNCHECK", tooltip = "Mute WorldChannel for good...", setFunc = LazyPig_ZoneCheck }
		},
	},
	{
		text = MISCELLANEOUS,
		checkBoxes = {
			{ text = "Summon Auto Accept", var = "SUMM", tooltip = "Summon Auto Accept", tooltipSub = "If checked summons will be accepted before they expire" },
			{ text = "Loot Window Auto Position", var = "LOOT", tooltip = "Loot Window Auto Position", tooltipSub = "Position the loot window under the mouse-cursor"},
			{ text = "Improved Right Click", var = "RIGHT", tooltip = "Improved Right Click", tooltipSub = "Right Click to Drag and Drop Items into Mail, Trade, Auction Frames", setFunc = LazyPig_MailtoCheck },
			{ text = "Easy Stack Split/Merge", var = "SHIFTSPLIT", tooltip = "Easy Stack Split/Merge (Shift + Right Click)", setFunc = LazyPig_MailtoCheck },
			{ text = "Extended Camera Distance", var = "CAM", tooltip = "Extended Camera Distance", tooltipSub = "Extend the Camera Distance to its maximum", setFunc = LazyPig_RefreshCamera },
			{ text = "Special Key Combinations", var = "SPECIALKEY", tooltip = "Special Key Combinations", tooltipSub = "Activate the Special-Key-Combinations" },
			{ text = "Duel Auto Decline", var = "DUEL", tooltip = "Duel Auto Decline (Shift to ByPass)" },
			{ text = "Instance Resurrection Auto Accept", var = "REZ", tooltip = "Instance Resurrection Auto Accept", tooltipSub = "Auto Accept Resurrection if Out of Combat" },
			{ text = "Gossip Auto Processing", var = "GOSSIP", tooltip = "Gossip Auto Processing", tooltipSub = "Skip Gossip Windows Choises from Innkeepers, Fly Masters etc." },
			{ text = "Auto Dismount", var = "DISMOUNT", tooltip = "Auto Dismount", tooltipSub = "Auto Dismount when it's required by another action" },
			{ text = "Auto Stance", var = "AUTOSTANCE", tooltip = "Auto Stance", tooltipSub = "Automatically change to required warrior stance/druid form on spell cast" },
		},
	},
}

function LazyPig_CreateOptionsFrame()
	-- Option Frame
	local frame = CreateFrame("Frame", "LazyPigOptionsFrame", UIParent)
	tinsert(UISpecialFrames,"LazyPigOptionsFrame")
	frame:SetFrameStrata("DIALOG")
	frame:SetWidth(500)
	frame:SetHeight(630)
	frame:SetPoint("CENTER", UIParent, 0, 80)
	frame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	})
	frame:SetBackdropColor(0, 0, 0, .8)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetClampedToScreen(false)
	frame:RegisterForDrag("LeftButton")
	frame:Hide()
	frame:SetScript("OnMouseDown", function()
		if arg1 == "LeftButton" and not this.isMoving then
			this:StartMoving();
			this.isMoving = true;
		end
	end)
	frame:SetScript("OnMouseUp", function()
		if arg1 == "LeftButton" and this.isMoving then
			this:StopMovingOrSizing();
			this.isMoving = false;
		end
	end)
	frame:SetScript("OnHide", function()
		if this.isMoving then
			this:StopMovingOrSizing();
			this.isMoving = false;
		end
	end)

	-- MenuTitle Frame
	local texture_title = frame:CreateTexture("LazyPigOptionsFrameTitle")
	texture_title:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header", true);
	texture_title:SetWidth(296)
	texture_title:SetHeight(58)
	texture_title:SetPoint("CENTER", frame, "TOP", 0, -20)

	frame.texture_title = texture_title

	-- MenuTitle FontString
	local fs_title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	local LP_VERSION = GetAddOnMetadata("_LazyPig", "Version")
	fs_title:SetPoint("CENTER", frame.texture_title, "CENTER", 0, 12)
	fs_title:SetText("LazyPig Options")
	
	local versionText = frame:CreateFontString("$parentVersionText", "ARTWORK", "GameFontNormalSmall")
	versionText:SetPoint("TOPLEFT", frame, 20, -20)
	versionText:SetText("version: "..LP_VERSION)

	frame.fs_title = fs_title

	-- Close Setting Window Button
	local btn_close = CreateFrame("Button", "LazyPigOptionsFrameCloseButton", frame, "UIPanelCloseButton")
	btn_close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -12, -12)
	btn_close:SetWidth(32)
	btn_close:SetHeight(32)
	
	frame.btn_close = btn_close

	frame.btn_close:SetScript("OnClick", function()
		this:GetParent():Hide()
			LazyPigKeybindsFrame:Hide()
	end)

	-- Keybinds Window Button
	local btn_keybinds = CreateFrame("Button", "LazyPigOptionsFrameKeibindsButton", frame, "UIPanelButtonTemplate2")
	btn_keybinds:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -33, 18)
	btn_keybinds:SetWidth(120)
	btn_keybinds:SetHeight(20)
	btn_keybinds:SetText(KEY_BINDINGS)
	btn_keybinds:SetTextColor(1, 1, 1)
	frame.btn_keybinds = btn_keybinds

	frame.btn_keybinds:SetScript("OnClick", function()
		if LazyPigKeybindsFrame:IsShown() then
			LazyPigKeybindsFrame:Hide()
		else
			LazyPigKeybindsFrame:Show()
		end
	end)

	local height = 16
	local offsetX, offsetY = 30, -45
	local index = 1
	for i = 1, getn(LazyPigOptions) do
		if i == 10 then
			offsetX, offsetY = offsetX + 240, -45
		end
		
		-- Check box group title
		local fontString = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		fontString:SetPoint("TOPLEFT", frame, "TOPLEFT", offsetX, offsetY - 5)
		fontString:SetTextColor(1, 1, 1, 1)
		fontString:SetText(LazyPigOptions[i].text)
		
		offsetY = offsetY - height
		
		for j = 1, getn(LazyPigOptions[i].checkBoxes) do
			local checkBox = CreateFrame("CheckButton", "$parentCheckBox"..index, frame, "UICheckButtonTemplate")
			local checkBoxText = _G[checkBox:GetName().."Text"]
			
			checkBox:SetPoint("TOPLEFT", frame, "TOPLEFT", offsetX + 5, offsetY)
			checkBox:SetWidth(16)
			checkBox:SetHeight(16)
			checkBoxText:SetText(LazyPigOptions[i].checkBoxes[j].text)
			checkBox.textR, checkBox.textG, checkBox.textB = checkBoxText:GetTextColor()
			
			-- Makes text clickable
			checkBox:SetHitRectInsets(0, -(checkBoxText:GetWidth() + 5), 0, 0)
			
			LazyPigOptions[i].checkBoxes[j].frame = checkBox
			checkBox.tooltip = LazyPigOptions[i].checkBoxes[j].tooltip
			checkBox.tooltipSub = LazyPigOptions[i].checkBoxes[j].tooltipSub
			checkBox.var = LazyPigOptions[i].checkBoxes[j].var
			checkBox.value = LazyPigOptions[i].checkBoxes[j].value
			checkBox.exclusive = LazyPigOptions[i].exclusive
			checkBox.checkBoxes = LazyPigOptions[i].checkBoxes
			checkBox.setFunc = LazyPigOptions[i].checkBoxes[j].setFunc

			checkBox:SetScript("OnShow", function()
				local value = this.value or true
				if LPCONFIG[this.var] == value then
					this:SetChecked(true)
					if this.exclusive then
						for _, data in pairs(this.checkBoxes) do
							if data.frame ~= this then
								data.frame:SetChecked(false)
							end
						end
					end
				else
					this:SetChecked(false)
				end
			end)

			checkBox:SetScript("OnClick", function()
				if this.exclusive then
					for _, data in pairs(this.checkBoxes) do
						if data.frame ~= this then
							data.frame:SetChecked(false)
						end
					end
				end
				local value = this.value or true
				if type(value) == "boolean" then
					LPCONFIG[this.var] = not LPCONFIG[this.var]
					-- this:SetChecked(LPCONFIG[this.var])
				elseif type(value) == "number" then
					LPCONFIG[this.var] = this:GetChecked() and this.value or nil
					-- this:SetChecked(LPCONFIG[this.var] == 0 and true or LPCONFIG[this.var])
				end
				if this.setFunc then
					this.setFunc()
				end
				PlaySound("igMainMenuOptionCheckBoxOn")
			end)

			checkBox:SetScript("OnEnter", function()
				_G[this:GetName().."Text"]:SetTextColor(1, 1, 1)
				if this.tooltip then
					GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT")
					GameTooltip:SetBackdropColor(.01, .01, .01, .91)
					GameTooltip:SetText(this.tooltip, nil, nil, nil, 1, true)
					if this.tooltipSub then
						GameTooltip:AddLine(this.tooltipSub, 1, 1, 1, true)
					end
					GameTooltip:Show()
				end
			end)

			checkBox:SetScript("OnLeave", function()
				_G[this:GetName().."Text"]:SetTextColor(this.textR, this.textG, this.textB)
				GameTooltip:Hide()
			end)

			offsetY = offsetY - height
			index = index + 1
		end
	end

	return frame
end
