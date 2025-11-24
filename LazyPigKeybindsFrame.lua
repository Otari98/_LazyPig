local _G = _G or getfenv(0)

local FontstringTables = {
	["Non-Configurable Keys"] = {
		[0] = "LazyPigNCE",
		[1] = { "LazyPig_kbfs000", "Sell Grey Items/Repairs:", "Hold Alt Key while Merchant's window is open" },
		[2] = { "LazyPig_kbfs001", "Repeatable Quest Auto-Complete:", "Hold Alt Key and finish quest once to record the steps." },
		[3] = { "LazyPig_kbfs002", "Quest Auto-PickUp/Auto-Complete:", "Hold Alt Key to Pickup/Complete quests." },
	},

	["Special Key-Combinations"] = {
		[0] = "LazyPigSKCB",
		[1] = { "LazyPig_kbfs010", "Follow:", "CTRL-SHIFT" },
		[2] = { "LazyPig_kbfs011", "Inspect Player/Bid Auction:", "ALT-SHIFT" },
		[3] = { "LazyPig_kbfs012", "Send Mail/Create Auction:", "CTRL-ALT" },
		[4] = { "LazyPig_kbfs013", "Confirm Popup/Buy Auction:", "CTRL-ALT" },
		[5] = { "LazyPig_kbfs014", "Initiate-Accept Trade:", "CTRL-ALT" },
	},

	["Configurable Keys"] = {
		[0] = "LazyPigCKB",
		[1] = { "LazyPig_kbfs020", "Logout:", "" },
		[2] = { "LazyPig_kbfs021", "Unstuck", "" },
		[3] = { "LazyPig_kbfs022", "Reload UI:", "" },
		[4] = { "LazyPig_kbfs023", "Target WSG EFC/Duel Request-Cancel", "" },
		[5] = { "LazyPig_kbfs024", "Drop WSG Flag/Remove Slow Fall Buff", "" },
	},
}


local function FontstringGroup(hParent, offsetX, offsetY, sTitle, tCheck, tCol1, tCol2, bKB)
	local frame = CreateFrame("Frame", tCheck[0], hParent)
	frame:SetPoint("TOPLEFT", hParent, "TOPLEFT", offsetX, offsetY)
	frame:SetWidth(11)
	frame:SetHeight(11)

	local fs_title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	fs_title:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	fs_title:SetTextColor(1, 1, 1, 1)
	fs_title:SetText(sTitle)

	frame.fs_title = fs_title

	frame.fst = {}
	frame.fsc = {}
	
	local max_width = { 0, nil }

	for k,v in ipairs(tCheck) do
		local fst = frame:CreateFontString(v[1], "ARTWORK", "GameFontNormalSmall")
		fst:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 8, -(4+(k-1)*10))
		fst:SetText(v[2])
		fst:SetTextColor(tCol1[1], tCol1[2], tCol1[3], tCol1[4])
		local temp = fst:GetStringWidth()
		if temp > max_width[1] then 
			max_width[1] = temp
			max_width[2] = fst
		end

		frame.fst[k] = fst
	end
	for k,v in ipairs(tCheck) do
		local fsname
		if not bKB then
			fsname = v[1].."Content"
		else
			fsname = "LP_KB" .. tostring(k)
		end
		local fsc = frame:CreateFontString(fsname, "ARTWORK", "GameFontNormalSmall")
		fsc:SetPoint("LEFT", _G[v[1]], "LEFT", 16 + max_width[1], 0)
		fsc:SetText(v[3])
		fsc:SetTextColor(tCol2[1], tCol2[2], tCol2[3], tCol2[4])

		frame.fsc[k] = fsc
	end
end

local function ShowBindings(bind, fs, desc)
	local bind1, bind2 = GetBindingKey(bind)
	local fsl = _G[fs]

	local printout = nil
	if bind1 and bind2 then
		printout = "[" .. bind1 .. "/" .. bind2 .. "]"
	elseif bind1 then
		printout = "[" .. bind1 .. "]"
	elseif bind2 then
		printout = "[" .. bind2 .. "]"
	elseif desc then
		printout = "[" .. desc .. "]"
	else
		printout = "none"
		fsl:SetTextColor(1,1,1,1)
	end
	fsl:SetText(printout)
end

function LazyPig_CreateKeybindsFrame()
	-- Keybinds Frame
	local frame = CreateFrame("Frame", "LazyPigKeybindsFrame", LazyPigOptionsFrame)
	frame:SetWidth(600)
	frame:SetHeight(175)
	frame:SetFrameLevel(LazyPigOptionsFrame:GetFrameLevel() + 2)
	frame:SetPoint("TOP", LazyPigOptionsFrame, "BOTTOM", 0, 10)
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
	frame:RegisterForDrag("LeftButton")
	frame:Hide()
	frame:SetScript("OnShow", function()
		ShowBindings("LOGOUT", "LP_KB1", "CTRL+ALT+SHIFT")
		ShowBindings("UNSTUCK", "LP_KB2")
		ShowBindings("RELOAD", "LP_KB3")
		ShowBindings("DUEL", "LP_KB4")
		ShowBindings("WSGDROP", "LP_KB5")
	end)
	frame:SetScript("OnMouseDown", function()
		if arg1 == "LeftButton" and not LazyPigOptionsFrame.isMoving then
			LazyPigOptionsFrame:StartMoving()
			LazyPigOptionsFrame.isMoving = true
		end
	end)
	frame:SetScript("OnMouseUp", function()
		if arg1 == "LeftButton" and LazyPigOptionsFrame.isMoving then
			LazyPigOptionsFrame:StopMovingOrSizing()
			LazyPigOptionsFrame.isMoving = false
		end
	end)
	frame:SetScript("OnHide", function()
		if LazyPigOptionsFrame.isMoving then
			LazyPigOptionsFrame:StopMovingOrSizing()
			LazyPigOptionsFrame.isMoving = false
		end
	end)

	-- MenuTitle Frame
	local texture_title = frame:CreateTexture("LazyPigKeybindsFrameTitle")
	texture_title:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	texture_title:SetWidth(266)
	texture_title:SetHeight(58)
	texture_title:SetPoint("CENTER", LazyPigKeybindsFrame, "TOP", 0, -20)

	frame.texture_title = texture_title

	-- MenuTitle FontString
	local fs_title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	fs_title:SetPoint("CENTER", frame.texture_title, "CENTER", 0, 12)
	fs_title:SetText("LazyPig Keybinds")

	frame.fs_title = fs_title

	local st = "Non-Configurable Keys"
	frame.fsgroup_NCE = FontstringGroup(frame, 20, -25, st, FontstringTables[st], {1, .81, 0}, {1, 1, 1})
	st = "Special Key-Combinations"
	frame.fsgroup_SKCB = FontstringGroup(frame, 20, -85, st, FontstringTables[st], {1, .81, 0}, {.8, .1, .1})
	st = "Configurable Keys"
	frame.fsgroup_CKB = FontstringGroup(frame, 255, -85, st, FontstringTables[st], {1, .81, 0}, {.8, .1, .1}, true)
end