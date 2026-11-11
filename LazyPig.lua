_G = _G or getfenv(0)
LazyPig = {}

-- Default SavedVariables
LPCONFIG = {}
LPCONFIG.DISMOUNT = true           -- Auto Dismount
LPCONFIG.AUTOSTANCE = true         -- Auto Stance
LPCONFIG.CAM = false               -- Extended camera distance
LPCONFIG.GINV = true               -- Auto accept invites from guild members
LPCONFIG.FINV = true               -- Auto accept invites from friends
LPCONFIG.SINV = false              -- Auto accept invites from strangers
LPCONFIG.DINV = true               -- Disable auto accept invite whiel in bg or in bg queue
LPCONFIG.SUMM = false              -- Auto accept summons
LPCONFIG.EBG = true                -- Auto join battleground
LPCONFIG.LBG = true                -- Auto leave battleground
LPCONFIG.QBG = true                -- Auto queue battleground
LPCONFIG.RBG = true                -- Auto release spirit in battleground
LPCONFIG.SBG = false               -- Auto decline quest sharing while in battleground
LPCONFIG.AQUE = false              -- Announce when queueing for battleground as party leader
LPCONFIG.LOOT = false              -- Position loot frame at cursor
LPCONFIG.RIGHT = true              -- Improved right click
LPCONFIG.GREEN = nil               -- [number or nil] Auto roll on green items
LPCONFIG.ZG = 1                    -- [number or nil] ZG coins/bijou auto roll
LPCONFIG.MC = nil                  -- [number or nil] MC mats auto roll
LPCONFIG.AQ = nil                  -- [number or nil] AQ scarabs/idols auto roll
LPCONFIG.SAND = 1                  -- [number or nil] Corrupted sand auto roll
LPCONFIG.ES_SHARDS = nil           -- [number or nil] Dream Shrads auto roll
LPCONFIG.NAXX = nil                -- [number or nil] Scraps auto roll
LPCONFIG.ROLLMSG = false           -- Lazy Pig Auto Roll Messages
LPCONFIG.DUEL = false              -- Auto cancel duels
LPCONFIG.SPECIALKEY = false        -- Special key combinations
LPCONFIG.WORLDDUNGEON = false      -- Mute Wolrd chat while in dungeons
LPCONFIG.WORLDRAID = false         -- Mute Wolrd chat while in raid
LPCONFIG.WORLDBG = false           -- Mute Wolrd chat while in battleground
LPCONFIG.WORLDUNCHECK = false      -- Mute Wolrd chat always
LPCONFIG.SPAM = false              -- Hide players spam messages
LPCONFIG.SPAM_UNCOMMON = false     -- Hide green items roll messages
LPCONFIG.SPAM_RARE = false         -- Hide blue items roll messages
LPCONFIG.SHIFTSPLIT = false        -- Improved stack splitting with shift
LPCONFIG.REZ = false               -- Auto accept resurrection while in raid, dungeon or bg if resurrecter is out of combat
LPCONFIG.GOSSIP = true             -- Auto proccess gossip
LPCONFIG.SALVA = nil               -- [number or nil] Autoremove Blessing of Salvation
LPCONFIG.REMOVEMANABUFFS = false   -- Autoremove Blessing of Wisdom, Arcane Intellect, Prayer of Spirit
LPCONFIG.AUTOSELL = true           -- Automatically sell grey items
LPCONFIG.AUTOREPAIR = true         -- Automatically repair

BINDING_HEADER_LP_HEADER = "_LazyPig"
BINDING_NAME_LOGOUT = "Logout"
BINDING_NAME_UNSTUCK = "Unstuck"
BINDING_NAME_RELOAD = "Reaload UI"
BINDING_NAME_DUEL = "Target WSG EFC/Duel Request-Cancel"
BINDING_NAME_WSGDROP = "Drop WSG Flag/Remove Slow Fall"
BINDING_NAME_MENU = "_LazyPig Menu"

LazyPig.Hooks = {}
LazyPig.Hooks.SelectGossipActiveQuest = SelectGossipActiveQuest
LazyPig.Hooks.SelectGossipAvailableQuest = SelectGossipAvailableQuest
LazyPig.Hooks.SelectActiveQuest = SelectActiveQuest
LazyPig.Hooks.SelectAvailableQuest = SelectAvailableQuest
LazyPig.Hooks.LootFrame_OnEvent = LootFrame_OnEvent
LazyPig.Hooks.LootFrame_Update = LootFrame_Update
LazyPig.Hooks.UseContainerItem = UseContainerItem
LazyPig.Hooks.ChatFrame_OnEvent = ChatFrame_OnEvent
LazyPig.Hooks.StaticPopup_OnShow = StaticPopup_OnShow
LazyPig.Hooks.QuestRewardItem_OnClick = QuestRewardItem_OnClick

local roster_task_refresh = 0
local last_click = 0
local delayaction = 0
local tradedelay = 0
local bgstatus = 0
local tmp_splitval = 1
local passpopup = 0
local timeLeft = 0
local updateInterval = 0.1
local ctrltime = 0
local alttime = 0
local shift_time = 0
local ctrlalttime = 0
local ctrlshifttime = 0
local altshifttime = 0
local greenrolltime = 0
local shamanTankTree = 2 -- Enhancement
local shamanTankTalent = 11 -- Spirit Armor

local selling = nil
local timer_split = nil
local player_summon_confirm = nil
local player_summon_message = nil
local player_bg_confirm = nil
local player_bg_message = nil
local afk_active = nil
local duel_active = nil
local merchantstatus = nil
local tradestatus = nil
local mailstatus = nil
local auctionstatus = nil
local auctionbrowse = nil
local bankstatus = nil
local channelstatus = nil
local battleframe = nil
local wsgefc = nil

LazyPig.ScheduleButton = {}
LazyPig.ScheduleFunction = {}
LazyPig.QuestRecord = {}
LazyPig.ActiveQuest = {}
LazyPig.AvailableQuest = {}
LazyPig.GossipOptions = {}
LazyPig.ChatMessages = {}

LazyPig.ScheduleSplit = {}
LazyPig.ScheduleSplit.active = nil
LazyPig.ScheduleSplit.sslot = {}
LazyPig.ScheduleSplit.dbag = {}
LazyPig.ScheduleSplit.dslot = {}
LazyPig.ScheduleSplit.sbag = {}
LazyPig.ScheduleSplit.count = {}
LazyPig.ScheduleSplitCount = {}

local function twipe(t)
	if not (t and type(t) == "table") then return {} end
	for k in pairs(t) do t[k] = nil end
	table.setn(t, 0)
	return t
end

function LazyPig.OnLoad()
	SelectGossipActiveQuest = LazyPig.SelectGossipActiveQuest
	SelectGossipAvailableQuest = LazyPig.SelectGossipAvailableQuest
	SelectActiveQuest = LazyPig.SelectActiveQuest
	SelectAvailableQuest = LazyPig.SelectAvailableQuest
	LootFrame_OnEvent = LazyPig.LootFrame_OnEvent
	LootFrame_Update = LazyPig.LootFrame_Update
	UseContainerItem = LazyPig.UseContainerItem
	ChatFrame_OnEvent = LazyPig.ChatFrame_OnEvent
	StaticPopup_OnShow = LazyPig.StaticPopup_OnShow
	QuestRewardItem_OnClick = LazyPig.QuestRewardItem_OnClick

	SLASH_LAZYPIG1 = "/lp"
	SLASH_LAZYPIG2 = "/lazypig"
	SlashCmdList["LAZYPIG"] = LazyPig.Command
	this:RegisterEvent("ADDON_LOADED")
	this:RegisterEvent("PLAYER_LOGIN")
	this:RegisterEvent("CHAT_MSG")
	this:RegisterEvent("CHAT_MSG_SYSTEM")
	this:RegisterEvent("PARTY_INVITE_REQUEST")
	this:RegisterEvent("CONFIRM_SUMMON")
	this:RegisterEvent("RESURRECT_REQUEST")
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
	this:RegisterEvent("BATTLEFIELDS_SHOW")
	this:RegisterEvent("GOSSIP_SHOW")
	this:RegisterEvent("QUEST_GREETING")
	this:RegisterEvent("UI_ERROR_MESSAGE")
	this:RegisterEvent("QUEST_PROGRESS")
	this:RegisterEvent("QUEST_COMPLETE")
	this:RegisterEvent("START_LOOT_ROLL")
	this:RegisterEvent("DUEL_REQUESTED")
	this:RegisterEvent("MERCHANT_SHOW")
	this:RegisterEvent("MERCHANT_CLOSED")
	this:RegisterEvent("TRADE_SHOW")
	this:RegisterEvent("TRADE_CLOSED")
	this:RegisterEvent("MAIL_SHOW")
	this:RegisterEvent("MAIL_CLOSED")
	this:RegisterEvent("AUCTION_HOUSE_SHOW")
	this:RegisterEvent("AUCTION_HOUSE_CLOSED")
	this:RegisterEvent("BANKFRAME_OPENED")
	this:RegisterEvent("BANKFRAME_CLOSED")
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	this:RegisterEvent("PLAYER_UNGHOST")
	this:RegisterEvent("PLAYER_DEAD")
	this:RegisterEvent("PLAYER_AURAS_CHANGED")
	this:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	this:RegisterEvent("UNIT_INVENTORY_CHANGED")
	this:RegisterEvent("UI_INFO_MESSAGE")
end

function LazyPig.Command()
	if LazyPigOptionsFrame:IsShown() then
		LazyPigOptionsFrame:Hide()
	else
		LazyPigOptionsFrame:Show()
	end
end

function LazyPig.OnUpdate(elapsed)
	timeLeft = timeLeft - elapsed
	if timeLeft > 0 then return end
	timeLeft = updateInterval

	local current_time = GetTime()
	local shiftstatus = IsShiftKeyDown()
	local ctrlstatus = IsControlKeyDown()
	local altstatus = IsAltKeyDown()

	if shiftstatus then
		shift_time = current_time
	elseif altstatus and not ctrlstatus and current_time > alttime then
		alttime = current_time + 0.75
	elseif not altstatus and ctrlstatus and current_time > ctrltime then
		ctrltime = current_time + 0.75
	elseif not altstatus and not ctrlstatus or altstatus and ctrlstatus then
		ctrltime = 0
		alttime = 0
	end
	if ctrlstatus and not shiftstatus and altstatus and current_time > ctrlalttime then
		ctrlalttime = current_time + 0.75
	elseif ctrlstatus and shiftstatus and not altstatus and current_time > ctrlshifttime then
		ctrlshifttime = current_time + 0.75
	elseif not ctrlstatus and shiftstatus and altstatus and current_time > altshifttime then
		altshifttime = current_time + 0.75
	elseif ctrlstatus and shiftstatus and altstatus then
		ctrlshifttime = 0
		ctrlalttime = 0
		altshifttime = 0
	end

	if shift_time == current_time  then
		if not (UnitExists("target") and UnitIsUnit("player", "target")) then
			--
		elseif not battleframe then
			battleframe = current_time
		elseif (current_time - battleframe) > 3 then
			--BattlefieldFrame:Show()
			battleframe = current_time
		end
	elseif battleframe then
		battleframe = nil
	end

	if LPCONFIG.SPECIALKEY then
		if ctrlstatus and shiftstatus and altstatus and current_time > delayaction then
			delayaction = current_time + 1
			local bind1, bind2 =  GetBindingKey("LOGOUT")
			if not bind1 and not bind2 then
				Logout()
			end
		elseif ctrlstatus and not shiftstatus and altstatus and not auctionstatus and not mailstatus and current_time > delayaction then
			if tradestatus then
				AcceptTrade()
			elseif not tradestatus and UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("target", "player") and not UnitIsUnit("player", "target") and CheckInteractDistance("target", 2) and (current_time + 0.25) > ctrlalttime and current_time > tradedelay then
				InitiateTrade("target")
				delayaction = current_time + 2
			end
		elseif ctrlstatus and shiftstatus and not altstatus and UnitIsPlayer("target") and UnitIsFriend("target", "player") and current_time > delayaction and (current_time + 0.25) > ctrlshifttime then
			delayaction = current_time + 1.5
			FollowUnit("target")
		elseif not ctrlstatus and shiftstatus and altstatus and UnitIsPlayer("target") and current_time > delayaction and (current_time + 0.25) > altshifttime then
			delayaction = current_time + 1.5
			InspectUnit("target")
		end

		if ctrlstatus and not shiftstatus and altstatus or passpopup > current_time then
			if current_time > delayaction and not LazyPig.BindLootOpen() and not LazyPig.RollLootOpen() and LazyPig.GreenRoll() then
				delayaction = current_time + 1
			elseif current_time > delayaction then
				for i=1,STATICPOPUP_NUMDIALOGS do
					local frame = _G["StaticPopup"..i]
					if frame:IsShown() then
						--DEFAULT_CHAT_FRAME:AddMessage(frame.which)
						if frame.which == "DEATH" and HasSoulstone() then
							_G["StaticPopup"..i.."Button2"]:Click()
							if passpopup < current_time then delayaction = current_time + 0.5 end
						elseif frame.which ~= "CONFIRM_SUMMON" and frame.which ~= "CONFIRM_BATTLEFIELD_ENTRY" and frame.which ~= "CAMP" and frame.which ~= "AREA_SPIRIT_HEAL"  then --and release and

							_G["StaticPopup"..i.."Button1"]:Click()
							if passpopup < current_time then delayaction = current_time + 0.5 end
						end
					end
				end
			end
		end

		if ctrlstatus and not shiftstatus and altstatus then
			if current_time > delayaction then
				if auctionstatus and AuctionFrameAuctions and AuctionFrameAuctions:IsVisible() and AuctionsCreateAuctionButton then
					LazyPig.ScheduleButtonClick(AuctionsCreateAuctionButton, 0)
				elseif auctionstatus and AuctionFrameBrowse and AuctionFrameBrowse:IsVisible() and BrowseBuyoutButton then
					LazyPig.ScheduleButtonClick(BrowseBuyoutButton, 0.55)
				elseif CT_MailFrame and CT_MailFrame:IsVisible() and CT_MailFrame.num > 0 and strlen(CT_MailNameEditBox:GetText()) > 0 and CT_Mail_AcceptSendFrameSendButton then
					LazyPig.ScheduleButtonClick(CT_Mail_AcceptSendFrameSendButton, 1.25)
				elseif GMailFrame and GMailFrame:IsVisible() and GMailFrame.num > 0 and strlen(GMailSubjectEditBox:GetText()) > 0 and GMailAcceptSendFrameSendButton then
					LazyPig.ScheduleButtonClick(GMailAcceptSendFrameSendButton, 1.25)
				elseif mailstatus and SendMailFrame and SendMailFrame:IsVisible() and SendMailMailButton then
					LazyPig.ScheduleButtonClick(SendMailMailButton, 0)
				elseif mailstatus and OpenMailFrame and OpenMailFrame:IsVisible() then
					if OpenMailFrame.money and OpenMailMoneyButton then
						LazyPig.ScheduleButtonClick(OpenMailMoneyButton, 0)
					elseif OpenMailPackageButton then
						LazyPig.ScheduleButtonClick(OpenMailPackageButton, 0)
					end
				end
			end
			LazyPig.AutoLeaveBG()
		elseif not ctrlstatus and shiftstatus and altstatus and current_time > delayaction then
			if auctionstatus and AuctionFrameBrowse and AuctionFrameBrowse:IsVisible() and BrowseBidButton then
				LazyPig.ScheduleButtonClick(BrowseBidButton, 0.55)
			end
		end
	end

	if merchantstatus and selling and not CursorHasItem() then
		LazyPig.GreySell()
	end

	if not QuestHaste then
		if altstatus then
			if QuestFrameDetailPanel:IsVisible() then
				AcceptQuest()
			end
		elseif LazyPig.QuestRecord["details"] then
			LazyPig.RecordQuest()
		end
	end

	if not afk_active and player_bg_confirm then
		LazyPig.CheckBgStatus()
	end

	if bgstatus ~= 0 and (bgstatus + 0.5) > current_time then
		bgstatus = 0
		LazyPig.CheckBgStatus()
		LazyPig.AutoLeaveBG()
	end

	if current_time - roster_task_refresh > 29 then
		roster_task_refresh = current_time
		GuildRoster()
		for _, messages in pairs(LazyPig.ChatMessages) do
			for text, time in pairs(messages) do
				if time + 30 < current_time then messages[text] = nil end
			end
		end
	end

	if player_summon_confirm then
		LazyPig.AutoSummon()
	end

	LazyPig.ScheduleButtonClick()
	LazyPig.ScheduleFunctionLaunch()
	LazyPig.ScheduleItemSplit()
	LazyPig.WatchSplit()
end

function LazyPig.ScheduleButtonClick(button, delay)
	local current_time = GetTime()
	if button and not LazyPig.ScheduleButton[button] then
		delay = delay or 0.75
		LazyPig.ScheduleButton[button] = current_time + delay
	else
		for blockindex,blockmatch in pairs(LazyPig.ScheduleButton) do
			if current_time < delayaction then
				LazyPig.ScheduleButton[blockindex] = nil
			elseif current_time >= blockmatch then
				blockindex:Click()
				passpopup = current_time + 0.75
				LazyPig.ScheduleButton[blockindex] = nil
			end
		end
	end
end

function LazyPig.ScheduleFunctionLaunch(func, delay)
	local current_time = GetTime()
	if func and not LazyPig.ScheduleFunction[func] then
		delay = delay or 0.75
		LazyPig.ScheduleFunction[func] = current_time + delay
	else
		for blockindex,blockmatch in pairs(LazyPig.ScheduleFunction) do
			if current_time >= blockmatch then
				blockindex()
				LazyPig.ScheduleFunction[blockindex] = nil
			end
		end
	end
end

LazyPig.ErrorDismountAndForm = {
	[SPELL_FAILED_NOT_MOUNTED] = 1,                  -- "You are mounted"
	[ERR_ATTACK_MOUNTED] = 1,                        -- "Can't attack while mounted."
	[ERR_TAXIPLAYERALREADYMOUNTED] = 1,              -- "You are already mounted! Dismount first."
	[ERR_MOUNT_SHAPESHIFTED] = 1,                    -- "You can't mount while shapeshifted!"
	[SPELL_FAILED_NOT_SHAPESHIFT] = 1,               -- "You are in shapeshift form"
	[SPELL_FAILED_NO_ITEMS_WHILE_SHAPESHIFTED] = 1,  -- "Can't use items while shapeshifted"
	[SPELL_NOT_SHAPESHIFTED] = 1,                    -- "Can't do that while shapeshifted."
	[SPELL_NOT_SHAPESHIFTED_NOSPACE] = 1,            -- "Can't do that while shapeshifted."
	[ERR_TAXIPLAYERSHAPESHIFTED] = 1,                -- "You can't take a taxi while shapeshifted!"
	[ERR_CANT_INTERACT_SHAPESHIFTED] = 1,            -- "Can't speak while shapeshifted."
	[ERR_NO_ITEMS_WHILE_SHAPESHIFTED] = 1,           -- "Can't use items while shapeshifted."
	[ERR_NOT_WHILE_SHAPESHIFTED] = 1                 -- "You can't do that while shapeshifted."
}
LazyPig.ErrorStanding = {
	[ERR_TAXINOTSTANDING] = 1,                       -- "You need to be standing to go anywhere."
	[ERR_LOOT_NOTSTANDING] = 1,                      -- "You need to be standing up to loot something!"
	[ERR_CANTATTACK_NOTSTANDING] = 1,                -- "You have to be standing to attack anything!"
	[SPELL_FAILED_NOT_STANDING] = 1                  -- "You must be standing to do that"
}

function LazyPig.OnEvent(event)
	if event == "ADDON_LOADED" and arg1 == "_LazyPig" then
		this:UnregisterEvent("ADDON_LOADED")
		local title = GetAddOnMetadata("_LazyPig", "Title")
		local version = GetAddOnMetadata("_LazyPig", "Version")
		DEFAULT_CHAT_FRAME:AddMessage(title.." v"..version.."|cffffffff".." loaded, type".."|cff00eeee".." /lp".."|cffffffff for options")

	elseif event == "PLAYER_LOGIN" then
		LazyPig.CreateOptionsFrame()
		LazyPig.CreateKeybindsFrame()

		LazyPig.CheckSalvation()
		LazyPig.CheckManaBuffs()
		LazyPig.CheckBgStatus()
		LazyPig.AutoLeaveBG()
		LazyPig.AutoSummon()
		LazyPig.ScheduleFunctionLaunch(LazyPig.ZoneCheck, 6)
		LazyPig.MailtoCheck()

		if LPCONFIG.CAM then
			SetCVar("cameraDistanceMax", 50)
		end
		if LPCONFIG.LOOT then
			UIPanelWindows["LootFrame"] = nil
		end
		LazyPig.QuestRecord["index"] = 0

	elseif (event == "UNIT_INVENTORY_CHANGED" and arg1 == "player") or event == "PLAYER_AURAS_CHANGED" or (event == "UPDATE_BONUS_ACTIONBAR" and LazyPig.PlayerClass("Druid")) then
		LazyPig.CheckSalvation()
		LazyPig.CheckManaBuffs()

	elseif event == "DUEL_REQUESTED" then
		duel_active = true
		if LPCONFIG.DUEL and not IsShiftKeyDown() then
			duel_active = nil
			CancelDuel()
			UIErrorsFrame:AddMessage(arg1.." - Duel Cancelled")
		end

	elseif event == "PLAYER_DEAD" then
		if LPCONFIG.RBG and LazyPig.Battleground() then
			RepopMe()
		end

	elseif event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_UNGHOST" then
		if event == "ZONE_CHANGED_NEW_AREA" then
			tradestatus = nil
			mailstatus = nil
			auctionstatus = nil
			bankstatus = nil
			wsgefc = nil
		end

		LazyPig.ScheduleFunctionLaunch(LazyPig.ZoneCheck, 5)
		--DEFAULT_CHAT_FRAME:AddMessage(event)

	elseif event == "BANKFRAME_OPENED" then
		bankstatus = true
		tmp_splitval = 1

	elseif event == "BANKFRAME_CLOSED" then
		bankstatus = false
		LazyPig.EndSplit()

	elseif event == "AUCTION_HOUSE_SHOW" then
		auctionstatus = true
		auctionbrowse = nil
		tmp_splitval = 1

	elseif event == "AUCTION_HOUSE_CLOSED" then
		auctionstatus = false
		LazyPig.EndSplit()

	elseif event == "MAIL_SHOW" then
		mailstatus = true
		tmp_splitval = 1

	elseif event == "MAIL_CLOSED" then
		mailstatus = false
		LazyPig.EndSplit()

	elseif event == "MERCHANT_SHOW" then
		merchantstatus = true
		LazyPig.GreySell()
		LazyPig.Repair()

	elseif event == "MERCHANT_CLOSED" then
		merchantstatus = false
		selling = nil

	elseif event == "TRADE_SHOW" then
		tradestatus = true
		tmp_splitval = 1

	elseif event == "TRADE_CLOSED" then
		tradedelay = GetTime() + 1
		tradestatus = false
		LazyPig.EndSplit()

	elseif event == "START_LOOT_ROLL" then
		LazyPig.AutoRoll(arg1)

	elseif event == "UI_ERROR_MESSAGE" then
		if LazyPig.ErrorStanding[arg1] then
			SitOrStand()
		else
			if LPCONFIG.DISMOUNT and LazyPig.ErrorDismountAndForm[arg1] then
				UIErrorsFrame:Clear()
				LazyPig.Dismount()
				LazyPig.CancelShapeshiftBuff()
			end
			if LPCONFIG.AUTOSTANCE then
				LazyPig.AutoStance(arg1)
			end
		end

	elseif event == "UI_INFO_MESSAGE" then
		if arg1 == ERR_DUEL_CANCELLED then
			duel_active = nil
		end

	elseif event == "CHAT_MSG_SYSTEM" then
		if arg1 == CLEARED_DND or arg1 == CLEARED_AFK then
			afk_active = false
			LazyPig.CheckBgStatus()
		elseif string.find(arg1, string.sub(MARKED_DND, 1, string.len(MARKED_DND) - 3)) then
			afk_active = false
		elseif string.find(arg1, string.sub(MARKED_AFK, 1, string.len(MARKED_AFK) - 2)) then
			afk_active = true
			if LPCONFIG.EBG and not LazyPig.Raid() and not LazyPig.Dungeon() then
				UIErrorsFrame:AddMessage("Auto Join BG Inactive - AFK")
			end
		elseif LPCONFIG.AQUE and string.find(arg1, "Queued") and UnitIsPartyLeader("player") then
			if UnitInRaid("player") then
				SendChatMessage(arg1, "RAID")
			elseif GetNumPartyMembers() > 1 then
				SendChatMessage(arg1, "PARTY")
			end
		elseif string.find(arg1, "completed.") then
			LazyPig.FixQuest(arg1)
			LazyPig.QuestRecord["progress"] = nil
		elseif string.find(arg1, "Duel starting:") or string.find(arg1, "requested a duel") then
			duel_active = true
		elseif string.find(arg1, "in a duel") then
			duel_active = nil
		end

	elseif event == "QUEST_GREETING" then
		twipe(LazyPig.ActiveQuest)
		twipe(LazyPig.AvailableQuest)
		for i = 1, GetNumActiveQuests() do
			table.insert(LazyPig.ActiveQuest, i, GetActiveTitle(i).." "..GetActiveLevel(i))
		end
		for i = 1, GetNumAvailableQuests() do
			table.insert(LazyPig.AvailableQuest, i, GetAvailableTitle(i).." "..GetAvailableLevel(i))
		end

		LazyPig.ReplayQuest(event)

		--DEFAULT_CHAT_FRAME:AddMessage("active_: "..table.getn(ActiveQuest))
		--DEFAULT_CHAT_FRAME:AddMessage("available_: "..table.getn(AvailableQuest))

	elseif event == "GOSSIP_SHOW" then
		twipe(LazyPig.GossipOptions)
		local dsc = nil
		local selectedOption = nil
		local gossipbreak = nil
		local processgossip = LPCONFIG.GOSSIP and not IsShiftKeyDown()

		dsc, LazyPig.GossipOptions[1], _, LazyPig.GossipOptions[2], _, LazyPig.GossipOptions[3], _, LazyPig.GossipOptions[4], _, LazyPig.GossipOptions[5] = GetGossipOptions()

		LazyPig.ProcessQuests(LazyPig.ActiveQuest, GetGossipActiveQuests())
		LazyPig.ProcessQuests(LazyPig.AvailableQuest, GetGossipAvailableQuests())

		if LazyPig.QuestRecord["qnpc"] ~= UnitName("npc") then
			LazyPig.QuestRecord["index"] = 0
			LazyPig.QuestRecord["qnpc"] = UnitName("npc")
		end

		if table.getn(LazyPig.AvailableQuest) ~= 0 or table.getn(LazyPig.ActiveQuest) ~= 0 then
			gossipbreak = true
		end

		--DEFAULT_CHAT_FRAME:AddMessage("gossip: "..table.getn(GossipOptions))
		--DEFAULT_CHAT_FRAME:AddMessage("active: "..table.getn(ActiveQuest))
		--DEFAULT_CHAT_FRAME:AddMessage("available: "..table.getn(AvailableQuest))

		for i = 1, 5 do
			local option = LazyPig.GossipOptions[i]
			if not option then break end
			if option == "binder" then
				local bind = GetBindLocation()
				if not (bind == GetSubZoneText() or bind == GetZoneText() or bind == GetRealZoneText() or bind == GetMinimapZoneText()) then
					gossipbreak = true
				end
			elseif selectedOption then
				gossipbreak = true
			elseif option == "trainer" and dsc == "Reset my talents." then
				gossipbreak = false
			elseif (option == "trainer" and processgossip)
				or (option == "vendor" and processgossip)
				or (option == "battlemaster" and (LPCONFIG.QBG or processgossip))
				or (option == "gossip" and processgossip)
				or (option == "banker" and string.find(dsc, "^I would like to check my deposit box.") and processgossip)
			then
				selectedOption = i
			elseif option == "taxi" and processgossip then
				selectedOption = i
				LazyPig.Dismount()
			end
		end

		if not gossipbreak and selectedOption then
			SelectGossipOption(selectedOption)
		else
			LazyPig.ReplayQuest(event)
		end

	elseif event == "QUEST_PROGRESS" or event == "QUEST_COMPLETE" then
		LazyPig.ReplayQuest(event)

	elseif event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE" then
		--DEFAULT_CHAT_FRAME:AddMessage(event.." - "..arg1)
		LazyPig.TrackEFC(arg1)

	elseif event == "UPDATE_BATTLEFIELD_STATUS" and not afk_active or event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" and arg1 and string.find(arg1, "wins!") then
		bgstatus = GetTime()

	elseif event == "BATTLEFIELDS_SHOW" then
		LazyPig.QueueBG()

	elseif event == "CONFIRM_SUMMON" then
		LazyPig.AutoSummon()

	elseif event == "PARTY_INVITE_REQUEST" then
		local check1 = not LPCONFIG.DINV or LPCONFIG.DINV and not LazyPig.Battleground() and not LazyPig.Queue()
		local check2 = LPCONFIG.GINV and LazyPig.IsGuildMate(arg1) or LPCONFIG.FINV and LazyPig.IsFriend(arg1) or not LazyPig.IsGuildMate(arg1) and not LazyPig.IsFriend(arg1) and LPCONFIG.SINV
		if check1 and check2 then
			LazyPig.AcceptGroupInvite()
		end

	elseif event == "RESURRECT_REQUEST" and LPCONFIG.REZ then
		UIErrorsFrame:AddMessage(arg1.." - Resurrection")
		TargetByName(arg1, true)
		if GetCorpseRecoveryDelay() == 0 and (LazyPig.Raid() or LazyPig.Dungeon() or LazyPig.Battleground()) and UnitIsPlayer("target") and UnitIsVisible("target") and not UnitAffectingCombat("target") then
			AcceptResurrect()
			StaticPopup_Hide("RESURRECT_NO_TIMER")
			StaticPopup_Hide("RESURRECT_NO_SICKNESS")
			StaticPopup_Hide("RESURRECT")
		end
		TargetLastTarget()
	end
	--DEFAULT_CHAT_FRAME:AddMessage(event)
end

function LazyPig.StaticPopup_OnShow()
	if this.which == "QUEST_ACCEPT" and LazyPig.Battleground() and LPCONFIG.SBG then
		UIErrorsFrame:Clear()
		UIErrorsFrame:AddMessage("Quest Blocked Successfully")
		this:Hide()
	else
		LazyPig.Hooks.StaticPopup_OnShow()
	end
end

function LazyPig.MailtoCheck(msg)
	if MailTo_Option then -- to avoid conflicts with mailto addon
		local disable = LPCONFIG.RIGHT or LPCONFIG.SHIFT
		MailTo_Option.noshift = disable
		MailTo_Option.noauction = disable
		MailTo_Option.notrade = disable
		MailTo_Option.noclick = disable
		if msg then
			DEFAULT_CHAT_FRAME:AddMessage("_LazyPig: Warning Improved Right Click and Easy Split/Merge features may override MailTo addon functionality !")
		end
	end
end

function LazyPig.UpdateText(txt)
	if txt then
		LazyPigText:SetTextColor(0, 1, 0)
		LazyPigText:SetText(txt)
		LazyPigText:Show()
	else
		LazyPigText:SetText("")
		LazyPigText:Hide()
	end
end

--code taken from quickloot
function LazyPig.ItemUnderCursor()
	if not LPCONFIG.LOOT then return end
	local x, y = GetCursorPosition()
	local scale = LootFrame:GetEffectiveScale()
	x = x / scale
	y = y / scale
	LootFrame:ClearAllPoints()
	for index = 1, LOOTFRAME_NUMBUTTONS, 1 do
		local button = _G["LootButton"..index]
		if button:IsVisible() then
			x = x - 42
			y = y + 56 + (40 * index)
			LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y)
			return
		end
	end
	if LootFrameDownButton:IsVisible() then
		x = x - 158
		y = y + 223
	else
		if GetNumLootItems() == 0  then
			HideUIPanel(LootFrame)
			return
		end
		x = x - 173
		y = y + 25
	end
	LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y)
end

function LazyPig.LootFrame_OnEvent(event)
	LazyPig.Hooks.LootFrame_OnEvent(event)
	if event == "LOOT_SLOT_CLEARED" then
		LazyPig.ItemUnderCursor()
	end
end

function LazyPig.LootFrame_Update()
	LazyPig.Hooks.LootFrame_Update()
	LazyPig.ItemUnderCursor()
end

function LazyPig.IsFriend(name)
	if not (name and type(name) == "string") then return false end
	for i = 1, GetNumFriends() do
		local friendName = GetFriendInfo(i)
		if friendName and string.lower(friendName) == string.lower(name) then return true end
	end
	return false
end

function LazyPig.IsGuildMate(name)
	if not (IsInGuild() and name and type(name) == "string") then return false end
	for i = 1, GetNumGuildMembers() do
		local guildMember = GetGuildRosterInfo(i)
		if guildMember and string.lower(guildMember) == string.lower(name) then return true end
	end
	return false
end

function LazyPig.AcceptGroupInvite()
	AcceptGroup()
	StaticPopup_Hide("PARTY_INVITE")
	PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav")
	UIErrorsFrame:AddMessage("Group Auto Accept")
end

function LazyPig.AutoSummon()
	if not LPCONFIG.SUMM then return end

	local keyenter = IsAltKeyDown() and IsControlKeyDown() and not tradestatus and not mailstatus and not auctionstatus and GetTime() > delayaction and GetTime() > (tradedelay + 0.5)
	local expireTime = GetSummonConfirmTimeLeft()
	if not player_summon_message and expireTime ~= 0 then
		player_summon_message = true
		player_summon_confirm = true
		DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Auto Summon in "..math.floor(expireTime).."s", 1.0, 1.0, 0.0)
	elseif expireTime <= 3 or keyenter then
		player_summon_confirm = false
		player_summon_message = false

		for i = 1, STATICPOPUP_NUMDIALOGS do
			local frame = _G["StaticPopup"..i]
			if frame.which == "CONFIRM_SUMMON" and frame:IsShown() then
				ConfirmSummon()
				delayaction = GetTime() + 0.75
				StaticPopup_Hide("CONFIRM_SUMMON")
			end
		end
	elseif expireTime == 0 then
		player_summon_confirm = false
		player_summon_message = false
	end
end

LazyPig.BgStatus = {}
for i = 1, MAX_BATTLEFIELD_QUEUES do
    LazyPig.BgStatus[i] = { status = "", map = "", id = 0 }
end

function LazyPig.CheckBgStatus()
	local player_bg_active = false
	local player_bg_request = false

	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName, instanceID = GetBattlefieldStatus(i)
		for k in pairs(LazyPig.BgStatus[i]) do
			LazyPig.BgStatus[i][k] = nil
		end
		LazyPig.BgStatus[i]["status"] = status
		LazyPig.BgStatus[i]["map"] = mapName
		LazyPig.BgStatus[i]["id"] = instanceID

		if status == "confirm" then
			player_bg_request = true
		elseif (status == "active") and not (mapName == "Eastern Kingdoms") and not (mapName == "Kalimdor") then
			player_bg_active = true
		end
	end

	player_bg_confirm = player_bg_request

	if player_bg_message and not player_bg_active and not player_bg_request then
		player_bg_message = false
	end

	if not player_bg_active and player_bg_request then
		local index = 1
		while LazyPig.BgStatus[index] do
			if LazyPig.BgStatus[index]["status"] == "confirm" then
				LazyPig.AutoJoinBG(index, LazyPig.BgStatus[index]["map"])
			end
			index = index + 1
		end
	end
end

function LazyPig.QueueBG()
	if not LPCONFIG.QBG then return end

	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local status = GetBattlefieldStatus(i)
		if IsShiftKeyDown() and (status == "queued" or status == "confirm") then
			AcceptBattlefieldPort(i, nil)
		end
	end
	if (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) and IsPartyLeader() then
		JoinBattlefield(0, 1)
	else
		JoinBattlefield(0)
	end
	ClearTarget()
	BattlefieldFrameCancelButton:Click()
end

function LazyPig.AutoJoinBG(index, map_name)
	local keyenter = IsAltKeyDown() and IsControlKeyDown() and not tradestatus and not mailstatus and not auctionstatus and GetTime() > delayaction and GetTime() > (tradedelay + 0.5)
	if not (LPCONFIG.EBG or keyenter) then return end

	local expireTime = GetBattlefieldPortExpiration(index) / 1000
	expireTime = math.floor(expireTime)
	if not player_bg_message and expireTime > 3 and GetTime() > delayaction then
		player_bg_message = true
		DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Auto Join "..map_name.." in "..expireTime.."s", 1.0, 1.0, 0.0)
	elseif expireTime <= 3 or keyenter then
		AcceptBattlefieldPort(index, true)
		StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY")
		delayaction = GetTime() + 0.75
		if player_bg_message then
			player_bg_message = false
		end
	end
end

function LazyPig.AutoLeaveBG()
	local keyenter = IsAltKeyDown() and IsControlKeyDown()
	if not (LPCONFIG.LBG or keyenter) then return end

	local bg_winner = GetBattlefieldWinner()
	local winner_name = "Alliance"
	if bg_winner ~= nil then
		if bg_winner == 0 then winner_name = "Horde" end
		UIErrorsFrame:Clear()
		UIErrorsFrame:AddMessage(winner_name.." Wins")
		LeaveBattlefield()
	end
end

local function RollToString(roll)
	local txt = ""
	if roll == 1 then
		txt = string.upper(NEED)
	elseif roll == 2 then
		txt = string.upper(GREED)
	elseif roll == 0 then
		txt = string.upper(PASS)
	end
	return txt
end

LazyPig.ZGloot = {
	[19698] = true, -- "Zulian Coin"
	[19699] = true, -- "Razzashi Coin"
	[19700] = true, -- "Hakkari Coin"
	[19701] = true, -- "Gurubashi Coin"
	[19702] = true, -- "Vilebranch Coin"
	[19703] = true, -- "Witherbark Coin"
	[19704] = true, -- "Sandfury Coin"
	[19705] = true, -- "Skullsplitter Coin"
	[19706] = true, -- "Bloodscalp Coin"
	[19707] = true, -- "Red Hakkari Bijou"
	[19708] = true, -- "Blue Hakkari Bijou"
	[19709] = true, -- "Yellow Hakkari Bijou"
	[19710] = true, -- "Orange Hakkari Bijou"
	[19711] = true, -- "Green Hakkari Bijou"
	[19712] = true, -- "Purple Hakkari Bijou"
	[19713] = true, -- "Bronze Hakkari Bijou"
	[19714] = true, -- "Silver Hakkari Bijou"
	[19715] = true, -- "Gold Hakkari Bijou"
}

LazyPig.MCloot = {
	[11382] = true, -- "Blood of the Mountain"
	[17010] = true, -- "Fiery Core"
	[17011] = true, -- "Lava Core"
}

LazyPig.AQloot = {
	[20858] = true, -- "Stone Scarab"
	[20859] = true, -- "Gold Scarab"
	[20860] = true, -- "Silver Scarab"
	[20861] = true, -- "Bronze Scarab"
	[20862] = true, -- "Crystal Scarab"
	[20863] = true, -- "Clay Scarab"
	[20864] = true, -- "Bone Scarab"
	[20865] = true, -- "Ivory Scarab"
	[20866] = true, -- "Azure Idol"
	[20867] = true, -- "Onyx Idol"
	[20868] = true, -- "Lambent Idol"
	[20869] = true, -- "Amber Idol"
	[20870] = true, -- "Jasper Idol"
	[20871] = true, -- "Obsidian Idol"
	[20872] = true, -- "Vermillion Idol"
	[20873] = true, -- "Alabaster Idol"
	[20874] = true, -- "Idol of the Sun"
	[20875] = true, -- "Idol of Night"
	[20876] = true, -- "Idol of Death"
	[20877] = true, -- "Idol of the Sage"
	[20878] = true, -- "Idol of Rebirth"
	[20879] = true, -- "Idol of Life"
	[20881] = true, -- "Idol of Strife"
	[20882] = true, -- "Idol of War"
}

LazyPig.BMloot = {
	[50203] = true, -- "Corrupted Sand"
}

LazyPig.ESloot = {
	[20381] = true, -- "Dreamscale"
	[61197] = true, -- "Fading Dream Fragment"
	[61198] = true, -- "Small Dream Shard"
}

LazyPig.NaxxLoot = {
	[22373] = true, -- "Wartorn Leather Scrap"
	[22374] = true, -- "Wartorn Chain Scrap"
	[22375] = true, -- "Wartorn Plate Scrap"
	[22376] = true, -- "Wartorn Cloth Scrap"
}

function LazyPig.AutoRoll(id)
	local rollType = nil
	local _, _, _, quality = GetLootRollItemInfo(id)
	local link = GetLootRollItemLink(id)
	local _, _, itemID = strfind(link or "", "item:(%d+)")
	itemID = tonumber(itemID)

	if not itemID then return end

	if LPCONFIG.ZG and LazyPig.ZGloot[itemID] then
		rollType = LPCONFIG.ZG
		RollOnLoot(id, LPCONFIG.ZG)
	end

	if LPCONFIG.MC and LazyPig.MCloot[itemID] then
		rollType = LPCONFIG.MC
		RollOnLoot(id, LPCONFIG.MC)
	end

	if LPCONFIG.AQ and LazyPig.AQloot[itemID] then
		rollType = LPCONFIG.AQ
		RollOnLoot(id, LPCONFIG.AQ)
	end

	if LPCONFIG.SAND and LazyPig.BMloot[itemID] then
		rollType = LPCONFIG.SAND
		RollOnLoot(id, LPCONFIG.SAND)
	end

	-- Hard coded auto need for Necrotic Runes
	if itemID == 22484 then
		rollType = 1
		RollOnLoot(id, 1)
	end
	-- Need on everything in Alterac Valley
	if LazyPig.Battleground() then
		rollType = 1
		RollOnLoot(id, 1)
	end

	if LPCONFIG.ES_SHARDS and LazyPig.ESloot[itemID] then
		rollType = LPCONFIG.ES_SHARDS
		RollOnLoot(id, LPCONFIG.ES_SHARDS)
	end

	if LPCONFIG.NAXX and LazyPig.NaxxLoot[itemID] then
		rollType = LPCONFIG.NAXX
		RollOnLoot(id, LPCONFIG.NAXX)
	end

	if LPCONFIG.ROLLMSG and type(rollType) == "number" then
		local _, _, _, hex = GetItemQualityColor(quality)
		DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Auto "..hex..RollToString(rollType).."|r "..GetLootRollItemLink(id))
	end

	-- Auto accept BoP for things that are auto rolled. Like Corrupted Sand and Necrotic Runes
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local frame = _G["StaticPopup"..i]
		if frame:IsShown() and frame.which == "CONFIRM_LOOT_ROLL" and frame.data == id and frame.data2 == rollType then
			_G["StaticPopup"..i.."Button1"]:Click()
		end
	end
end

function LazyPig.GreenRoll()
	if not LPCONFIG.GREEN then return end
	local pass = nil
	for i = 1, NUM_GROUP_LOOT_FRAMES do
		local frame = _G["GroupLootFrame"..i]
		if frame:IsVisible() then
			local id = frame.rollID
			local _, name, _, quality = GetLootRollItemInfo(id)
			if quality == 2 then
				RollOnLoot(id, LPCONFIG.GREEN)
				local _, _, _, hex = GetItemQualityColor(quality)
				greenrolltime = GetTime() + 1
				if LPCONFIG.ROLLMSG then
					DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Auto "..hex..RollToString(LPCONFIG.GREEN).." "..GetLootRollItemLink(id))
				end
				pass = true
			end
		end
	end
	return pass
end

local COLOR_COPPER = "|cffeda55f"
local COLOR_SILVER = "|cffc7c7cf"
local COLOR_GOLD = "|cffffd700"

local function MoneyToString(money)
	if not money then
		return ""
	end
	local gold = floor(abs(money / 10000))
	local silver = floor(abs(mod(money / 100, 100)))
	local copper = floor(abs(mod(money, 100)))
	return COLOR_GOLD..gold.."g|r "..COLOR_SILVER..silver.."s|r "..COLOR_COPPER..copper.."c|r"
end

local function GetNextJunkItem()
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local _, _, locked = GetContainerItemInfo(bag, slot)
			local _, itemString = LazyPig.DecodeItemLink(GetContainerItemLink(bag, slot))
			local _, _, quality, _, _, _, _, _, _, sellPrice = GetItemInfo(itemString or 0)
			if quality and quality == 0 and not locked then
				return bag, slot
			end
		end
	end
	return nil
end

function LazyPig.GreySell()
	if not LPCONFIG.AUTOSELL then return end
	if C_MerchantFrame then
		if C_MerchantFrame.GetNumJunkItems() > 0 then C_MerchantFrame.SellAllJunkItems() end
	else
		local bag, slot = GetNextJunkItem()
		if bag and slot then
			selling = true
			UseContainerItem(bag, slot)
		else
			selling = nil
		end
	end
end

function LazyPig.Repair()
	if not (LPCONFIG.AUTOREPAIR and CanMerchantRepair()) then return end
	local cost = GetRepairAllCost()
	if cost == 0 then return end
	if cost > GetMoney() then
		DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Not enough money to repair")
		return
	end
	RepairAllItems()
	DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Repaired all items for "..MoneyToString(cost))
end

function LazyPig.ProcessQuests(t, ...)
	twipe(t)
	for i = 1, table.getn(arg), 2 do
		local title, level = arg[i], arg[i + 1]
		table.insert(t, title.." "..level)
	end
	return t
end

function LazyPig.SelectGossipActiveQuest(index, norecord)
	if LazyPig.ActiveQuest[index] and not norecord then
		LazyPig.RecordQuest(LazyPig.ActiveQuest[index])
	end
	LazyPig.Hooks.SelectGossipActiveQuest(index)
end

function LazyPig.SelectGossipAvailableQuest(index, norecord)
	if LazyPig.AvailableQuest[index] and not norecord then
		LazyPig.RecordQuest(LazyPig.AvailableQuest[index])
	end
	LazyPig.Hooks.SelectGossipAvailableQuest(index)
end

function LazyPig.SelectActiveQuest(index, norecord)
	if LazyPig.ActiveQuest[index] and not norecord then
		LazyPig.RecordQuest(LazyPig.ActiveQuest[index])
	end
	LazyPig.Hooks.SelectActiveQuest(index)
end

function LazyPig.SelectAvailableQuest(index, norecord)
	if LazyPig.AvailableQuest[index] and not norecord then
		LazyPig.RecordQuest(LazyPig.AvailableQuest[index])
	end
	LazyPig.Hooks.SelectAvailableQuest(index)
end

function LazyPig.FixQuest(quest, annouce)
	if QuestHaste then
		return
	end
	if not LazyPig.QuestRecord["details"] then
		annouce = true
	end
	if UnitLevel("player") == 60 then
		if string.find(quest, "Fight for Warsong Gulch") then
			LazyPig.QuestRecord["details"] = "Fight for Warsong Gulch 60"
		elseif string.find(quest, "Battle of Warsong Gulch") then
			LazyPig.QuestRecord["details"] = "Battle of Warsong Gulch 60"
		elseif string.find(quest, "Claiming Arathi Basin") then
			LazyPig.QuestRecord["details"] = "Claiming Arathi Basin 60"
		elseif string.find(quest, "Conquering Arathi Basin") then
			LazyPig.QuestRecord["details"] = "Conquering Arathi Basin 60"
		end
	end
	if LazyPig.QuestRecord["details"] and annouce then
		UIErrorsFrame:Clear()
		UIErrorsFrame:AddMessage("Recording: "..LazyPig.QuestRecord["details"])
	end
end

function LazyPig.RecordQuest(qdetails)
	if QuestHaste then
		return
	end
	if IsAltKeyDown() and qdetails then
		if LazyPig.QuestRecord["details"] ~= qdetails then
			LazyPig.QuestRecord["details"] = qdetails
		end
		LazyPig.FixQuest(LazyPig.QuestRecord["details"], true)
	elseif not IsAltKeyDown() and LazyPig.QuestRecord["details"] then
		LazyPig.QuestRecord["details"] = nil
		LazyPig.QuestRecord.itemChoice = nil
	end
	LazyPig.QuestRecord["progress"] = true
end

function LazyPig.QuestRewardItem_OnClick()
	LazyPig.Hooks.QuestRewardItem_OnClick()
	if LazyPig.QuestRecord.details and this.type == "choice" then
		QuestRewardItemHighlight:SetPoint("TOPLEFT", this, "TOPLEFT", -8, 7)
		QuestRewardItemHighlight:Show()
		QuestFrameRewardPanel.itemChoice = this:GetID()
		LazyPig.QuestRecord.itemChoice = this:GetID()
	end
end

function LazyPig.ReplayQuest(event)
	if QuestHaste or not IsAltKeyDown() then
		return
	end

	if LazyPig.QuestRecord["details"] then
		UIErrorsFrame:Clear()
		UIErrorsFrame:AddMessage("Replaying: "..LazyPig.QuestRecord["details"])
	end

	if event == "GOSSIP_SHOW" then
		if LazyPig.QuestRecord["details"] then
			for blockindex,blockmatch in pairs(LazyPig.ActiveQuest) do
				if blockmatch == LazyPig.QuestRecord["details"] then
					LazyPig.Hooks.SelectGossipActiveQuest(blockindex)
					return
				end
			end
			for blockindex,blockmatch in pairs(LazyPig.AvailableQuest) do
				if blockmatch == LazyPig.QuestRecord["details"] then
					LazyPig.Hooks.SelectGossipAvailableQuest(blockindex)
					return
				end
			end
		elseif table.getn(LazyPig.ActiveQuest) == 0 and table.getn(LazyPig.AvailableQuest) == 1 or IsAltKeyDown() and table.getn(LazyPig.AvailableQuest) > 0 then
			LazyPig.SelectGossipAvailableQuest(1, true)
		elseif table.getn(LazyPig.ActiveQuest) == 1 and table.getn(LazyPig.AvailableQuest) == 0 or IsAltKeyDown() and table.getn(LazyPig.ActiveQuest) > 0 then
			local nr = table.getn(LazyPig.ActiveQuest)
			if LazyPig.QuestRecord["progress"] and (nr - LazyPig.QuestRecord["index"]) > 0 then
				--DEFAULT_CHAT_FRAME:AddMessage("++quest dec nr - "..nr.." index - "..QuestRecord["index"])
				LazyPig.QuestRecord["index"] = LazyPig.QuestRecord["index"] + 1
				nr = nr - LazyPig.QuestRecord["index"]
			end
			LazyPig.SelectGossipActiveQuest(nr, true)
		end
	elseif event == "QUEST_GREETING" then
		if LazyPig.QuestRecord["details"] then
			for blockindex,blockmatch in pairs(LazyPig.ActiveQuest) do
				if blockmatch == LazyPig.QuestRecord["details"] then
					LazyPig.Hooks.SelectActiveQuest(blockindex)
					return
				end
			end
			for blockindex,blockmatch in pairs(LazyPig.AvailableQuest) do
				if blockmatch == LazyPig.QuestRecord["details"] then
					LazyPig.Hooks.SelectAvailableQuest(blockindex)
					return
				end
			end
		elseif table.getn(LazyPig.ActiveQuest) == 0 and table.getn(LazyPig.AvailableQuest) == 1 or IsAltKeyDown() and table.getn(LazyPig.AvailableQuest) > 0 then
			LazyPig.SelectAvailableQuest(1, true)
		elseif table.getn(LazyPig.ActiveQuest) == 1 and table.getn(LazyPig.AvailableQuest) == 0 or IsAltKeyDown() and table.getn(LazyPig.ActiveQuest) > 0 then
			local nr = table.getn(LazyPig.ActiveQuest)
			if LazyPig.QuestRecord["progress"] and (nr - LazyPig.QuestRecord["index"]) > 0 then
				--DEFAULT_CHAT_FRAME:AddMessage("--quest dec nr - "..nr.." index - "..QuestRecord["index"])
				LazyPig.QuestRecord["index"] = LazyPig.QuestRecord["index"] + 1
				nr = nr - LazyPig.QuestRecord["index"]
			end
			LazyPig.SelectActiveQuest(nr, true)
		end

	elseif event == "QUEST_PROGRESS" then
		CompleteQuest()
	elseif event == "QUEST_COMPLETE" then
		if GetNumQuestChoices() == 0 then
			GetQuestReward(0)
		elseif GetNumQuestChoices() > 0 and LazyPig.QuestRecord.itemChoice then
			GetQuestReward(LazyPig.QuestRecord.itemChoice)
		end
	end
end

function LazyPig.Dismount()
	if Dismount then return Dismount() end

	if not LazyPig.DismountStrings then
		-- taken from ShaguTweaks
		-- https://github.com/shagu/ShaguTweaks/blob/master/mods/auto-dismount.lua
		LazyPig.DismountStrings = {
			"^Increases speed by (.+)%%", -- enUS
			"^Erhöht Tempo um (.+)%%", -- deDE
			"^Aumenta la velocidad en un (.+)%%", -- esES
			"^Augmente la vitesse de (.+)%%", -- frFR
			"^Скорость увеличена на (.+)%%", -- ruRU
			"^이동 속도 (.+)%%만큼 증가", -- koKR
			"^速度提高(.+)%%", -- zhCN
			-- turtle-wow
			"speed based on", "Slow and steady...", "Riding",
			"Lento y constante...", "Aumenta la velocidad según tu habilidad de Montar.",
			"根据您的骑行技能提高速度。", "根据骑术技能提高速度。", "又慢又稳......",
		}
	end
	local buff = 0
	while GetPlayerBuff(buff) >= 0 do
		LazyPig_Buff_Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
		LazyPig_Buff_Tooltip:SetPlayerBuff(GetPlayerBuff(buff))
		local desc = LazyPig_Buff_TooltipTextLeft2:GetText()
		if desc then
			for _, str in pairs(LazyPig.DismountStrings) do
				if string.find(desc, str) then return CancelPlayerBuff(buff) end
			end
		end
		buff = buff + 1
	end
end

local stancesPattern = string.gsub(SPELL_FAILED_ONLY_SHAPESHIFT, "%%s", "(.+)")

function LazyPig.AutoStance(msg)
	local _, _, stances = string.find(msg, stancesPattern)
	if not stances then return end
	for stance in string.gfind(stances, "[^,]+") do
		CastSpellByName((string.gsub(stance, "^%s*(.-)%s*$", "%1")))
	end
end

function LazyPig.DropWSGFlag_NoggBuff()
	local counter = 0
	local tooltipfind1 = "Warsong Flag"
	local tooltipfind2 = "You feel light"
	local tooltipfind3 = "Slow Fall"

	while GetPlayerBuff(counter) >= 0 do
		local index, untilCancelled = GetPlayerBuff(counter)
		LazyPig_Buff_Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
		LazyPig_Buff_Tooltip:SetPlayerBuff(index)
		local desc = LazyPig_Buff_TooltipTextLeft1:GetText()
		if string.find(desc, tooltipfind1) or string.find(desc, tooltipfind3) then
			CancelPlayerBuff(counter)
		end
		desc = LazyPig_Buff_TooltipTextLeft2:GetText()
		if string.find(desc, tooltipfind2) then
			CancelPlayerBuff(counter)
		end
		counter = counter + 1
	end
end

function LazyPig.Raid()
	local inInstance, instanceType = IsInInstance()
	return inInstance and instanceType == "raid"
end

function LazyPig.Dungeon()
	local inInstance, instanceType = IsInInstance()
	return inInstance and instanceType == "party"
end

function LazyPig.Battleground()
	local inInstance, instanceType = IsInInstance()
	return inInstance and instanceType == "pvp"
end

function LazyPig.Queue()
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName, instanceID = GetBattlefieldStatus(i)
		if status == "confirm" or status == "active" then
			return true
		end
	end
	return false
end

function LazyPig.EndSplit()
	timer_split = nil
	tmp_splitval = 1
	LazyPig.UpdateText()
end

function LazyPig.DecodeItemLink(link)
	if not link then return nil end
	local _, _, itemString, name = string.find(link, "|H(item:.*)|h%[(.*)%]|h")
	return name, itemString
end

function LazyPig.WatchSplit(enable)
	local returnval = timer_split
	if LPCONFIG.SHIFTSPLIT then
		local time = GetTime()
		local txt_show = enable
		local ctrl = IsControlKeyDown()
		local alt = IsAltKeyDown()
		local duration = 9

		if enable then
			timer_split = time + duration
		elseif timer_split then
			local boost = -0.006 * tmp_splitval + 1

			if auctionstatus then
				if AuctionFrameBrowse:IsVisible() then
					if not auctionbrowse then
						auctionbrowse = true
						LazyPig.EndSplit()
						return
					end
				else
					auctionbrowse = nil
				end
			end

			if time > timer_split or auctionstatus and AuctionFrameAuctions and not (AuctionFrameAuctions:IsVisible() or AuctionFrameBrowse:IsVisible()) or mailstatus and SendMailFrame and not SendMailFrame:IsVisible() and (not CT_MailFrame or CT_MailFrame and not CT_MailFrame:IsVisible()) and (not GMailFrame or GMailFrame and not GMailFrame:IsVisible()) then
				LazyPig.EndSplit()
			elseif (ctrl or alt) and time > last_click then
				local forcepass = (timer_split - duration + 0.6) > time
				if ctrl and alt then
					timer_split = time + duration - 1
					return
				elseif alt and ((time + 0.1) > alttime or forcepass) and tmp_splitval < 100 then
					alttime = time + 0.125
					tmp_splitval = tmp_splitval + 1
					timer_split = time + duration
					last_click = 0.109 * boost + time
					txt_show = true
				elseif ctrl and ((time + 0.1) > ctrltime or forcepass) and tmp_splitval > 1 then
					ctrltime = time + 0.125
					tmp_splitval = tmp_splitval - 1
					timer_split = time + duration
					last_click = 0.109 * boost + time
					txt_show = true
				end
			end
		elseif auctionstatus and AuctionFrameAuctions and AuctionFrameAuctions:IsVisible() or mailstatus and SendMailFrame and SendMailFrame:IsVisible() or tradestatus or bankstatus or CT_MailFrame and CT_MailFrame:IsVisible() or GMailFrame and GMailFrame:IsVisible() then
			timer_split = time + duration - 1
			txt_show = true
		end
		if txt_show then LazyPig.UpdateText("- Ctrl  "..tmp_splitval.."  Alt +") end
	end
	return returnval
end

LazyPig.ItemArray = {}
function LazyPig.UseContainerItem(bagID, bagSlot)
	if LPCONFIG.SHIFTSPLIT and not CursorHasItem() and not merchantstatus and IsShiftKeyDown() and not IsAltKeyDown() then
		if (GetTime() - last_click) < 0.3 then return end
		local _, itemCount, locked = GetContainerItemInfo(bagID, bagSlot)
		if locked or not itemCount then return end
		if not LazyPig.WatchSplit(true) then return end
		last_click = GetTime()

		twipe(LazyPig.ItemArray)
		local name, id = LazyPig.DecodeItemLink(GetContainerItemLink(bagID, bagSlot))
		local _, _, _, _, _, _, maxstack = GetItemInfo(id)
		local out_slpit = tmp_splitval

		if out_slpit > maxstack then
			out_slpit = maxstack
		end

		local dcount = out_slpit
		local dbag = nil
		local dslot = nil
		local cursoritem = nil

		if itemCount < out_slpit then
			dbag, dslot = bagID, bagSlot
			dcount = out_slpit - itemCount
			cursoritem = true
		end

		if name then
			for b = 0, NUM_BAG_FRAMES do
				for s = 1, GetContainerNumSlots(b) do
					local link = GetContainerItemLink(b, s)
					local n, c, l = GetContainerItemInfo(b, s)
					if not cursoritem or cursoritem and not (b == bagID and s == bagSlot) then
						if not link and not dbag and not dslot then
							dbag, dslot = b, s
							--DEFAULT_CHAT_FRAME:AddMessage(b.." "..s.." - scan mode1")
						elseif n and n == name and not l then
							if not (itemCount < out_slpit) and not dbag and not dslot and c < out_slpit then
								dbag, dslot = b, s
								dcount = out_slpit - c
								--DEFAULT_CHAT_FRAME:AddMessage("b.." "..s.." count - "..c.." - "..scan mode2)
							elseif c ~= out_slpit or cursoritem then
								LazyPig.ItemArray[b.."_"..s] = c
							end
						end
					end
				end
			end

			if not dbag or not dslot or CursorHasItem() then return end

			local escape = 0
			while dcount > 0 do
				local sbag = nil
				local sslot = nil
				local score = nil
				local number = nil
				local index = nil

				for blockindex, blockmatch in pairs(LazyPig.ItemArray) do
					local x = nil
					local y = nil
					x = string.gsub(blockindex, "_(.+)", "")
					x = tonumber(x)
					y = string.gsub(blockindex, "(.+)_", "")
					y = tonumber(y)

					if not number or number > blockmatch or number == blockmatch and (x * 10 + y) > score then
						sbag = x
						sslot = y
						score = 10 * sbag + sslot
						number = blockmatch
						index = blockindex
					end
				end

				if sbag and sslot then
					local splitval = nil
					if (number - dcount) >= out_slpit then
						splitval = dcount
					elseif number > out_slpit then
						splitval = number - out_slpit
					elseif number < dcount then
						splitval = number
					else
						splitval = dcount
					end

					dcount = dcount - splitval
					LazyPig.ScheduleItemSplit(sbag, sslot, dbag, dslot, splitval)
					LazyPig.ItemArray[index] = nil
					--DEFAULT_CHAT_FRAME:AddMessage("Dest "..dbag.." - "..dslot.." From "..sbag.." - "..sslot.." - Count "..splitval)
				end

				if escape > 99 then
					--DEFAULT_CHAT_FRAME:AddMessage("LazPig_Split: Loop stop")
					return
				else
					escape = escape + 1
				end
			end
		end
		return
	end

	if not LPCONFIG.RIGHT then
		return LazyPig.Hooks.UseContainerItem(bagID, bagSlot)
	end

	if tradestatus and not IsShiftKeyDown() and not IsAltKeyDown() then
		PickupContainerItem(bagID, bagSlot)
		local slot = TradeFrame_GetAvailableSlot()
		if slot then ClickTradeButton(slot) end
		ClearCursor()
		return

	elseif GMailFrame and GMailFrame:IsVisible() and not CursorHasItem() then
		for i = 1, GMAIL_NUMITEMBUTTONS, 1 do
			if not _G["GMailButton"..i].item then
				if GMail:ItemIsMailable(bagID, bagSlot) then
					GMail:Print("GMail: Cannot attach item.", 1, 0.5, 0)
					return
				end
				PickupContainerItem(bagID, bagSlot)
				--GMail.hooks["PickupContainerItem"].orig(bag, item)
				GMail:MailButton_OnClick(_G["GMailButton"..i])
				GMail:UpdateItemButtons()
				return
			end
		end

	elseif CT_MailFrame and CT_MailFrame:IsVisible() and not IsShiftKeyDown() and not IsAltKeyDown() then
		if (CT_Mail_GetItemFrame(bagID, bagSlot) or (CT_Mail_addItem and CT_Mail_addItem[1] == bagID and CT_Mail_addItem[2] == bagSlot)) and not special then
			return
		end
		if not CursorHasItem() then
			CT_MailFrame.bag = bagID
			CT_MailFrame.item = bagSlot
		end
		if CT_MailFrame:IsVisible() and not CursorHasItem() then
			for i = 1, CT_MAIL_NUMITEMBUTTONS, 1 do
				if not _G["CT_MailButton"..i].item then
					local canMail = CT_Mail_ItemIsMailable(bagID, bagSlot)
					if canMail then
						DEFAULT_CHAT_FRAME:AddMessage("<CTMod> Cannot attach item, item is "..canMail, 1, 0.5, 0)
						return
					end

					CT_oldPickupContainerItem(bagID, bagSlot)
					CT_MailButton_OnClick(_G["CT_MailButton"..i])
					CT_Mail_UpdateItemButtons()
					return
				end
			end
		end

	elseif mailstatus and not IsShiftKeyDown() and not IsAltKeyDown() then
		MailFrameTab_OnClick(2)
		PickupContainerItem(bagID, bagSlot)
		ClickSendMailItemButton()
		PutItemInBackpack()
		PutItemInBag(20)
		PutItemInBag(21)
		PutItemInBag(22)
		PutItemInBag(23)
		ClearCursor()
		return

	elseif auctionstatus and not IsShiftKeyDown() and not IsAltKeyDown() then
		if AuctionFrame.selectedTab == 1 then
			BrowseName:SetText(LazyPig.DecodeItemLink(GetContainerItemLink(bagID, bagSlot)) or "")
		elseif AuctionFrame.selectedTab == 3 then
			PickupContainerItem(bagID, bagSlot)
			ClickAuctionSellItemButton()
			PutItemInBackpack()
			PutItemInBag(20)
			PutItemInBag(21)
			PutItemInBag(22)
			PutItemInBag(23)
			ClearCursor()
		end
		return
	end

	return LazyPig.Hooks.UseContainerItem(bagID, bagSlot)
end

function LazyPig.ScheduleItemSplit(sbag, sslot, dbag, dslot, count)
	if sbag and sslot and dbag and dslot and count then

		local number = nil

		for blockindex,blockmatch in pairs(LazyPig.ScheduleSplitCount) do
			if not number or number < blockindex then
				number = blockindex
			end
		end

		if not number then
			number = 1
		else
			number = number + 1
		end

		--DEFAULT_CHAT_FRAME:AddMessage("Task Count - "..number)

		LazyPig.ScheduleSplitCount[number] = true
		LazyPig.ScheduleSplit.sbag[number] = sbag
		LazyPig.ScheduleSplit.sslot[number] = sslot
		LazyPig.ScheduleSplit.dbag[number] = dbag
		LazyPig.ScheduleSplit.dslot[number] = dslot
		LazyPig.ScheduleSplit.count[number] = count

		LazyPig.ScheduleSplit.active = true

	elseif LazyPig.ScheduleSplit.active then

		local number = nil
		for blockindex,blockmatch in pairs(LazyPig.ScheduleSplitCount) do
			if not number or number > blockindex then
				number = blockindex
			end
		end

		if number then
			last_click = GetTime()
			local _, _, lock = GetContainerItemInfo(LazyPig.ScheduleSplit.dbag[number], LazyPig.ScheduleSplit.dslot[number])
			if not lock then

				--DEFAULT_CHAT_FRAME:AddMessage("Dest "..ScheduleSplit.dbag[number].." - "..ScheduleSplit.dslot[number].." From "..ScheduleSplit.sbag[number].." - "..ScheduleSplit.sslot[number].." - Count "..ScheduleSplit.count[number])

				SplitContainerItem(LazyPig.ScheduleSplit.sbag[number], LazyPig.ScheduleSplit.sslot[number], LazyPig.ScheduleSplit.count[number])
				PickupContainerItem(LazyPig.ScheduleSplit.dbag[number], LazyPig.ScheduleSplit.dslot[number])
				LazyPig.ScheduleSplitCount[number] = nil
			end
		else
			LazyPig.ScheduleSplit.active = nil
		end
	end
end

function LazyPig.RollLootOpen()
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local frame = _G["StaticPopup"..i]
		if frame:IsShown() and frame.which == "CONFIRM_LOOT_ROLL" then
			--DEFAULT_CHAT_FRAME:AddMessage("LazyPig_RollLootOpen - TRUE")
			return true
		end
	end
	return nil
end

function LazyPig.BindLootOpen()
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local frame = _G["StaticPopup"..i]
		if frame:IsShown() and frame.which == "LOOT_BIND" then
			--DEFAULT_CHAT_FRAME:AddMessage("LazyPig_BindLootOpen - TRUE")
			return true
		end
	end
	return nil
end

local process = function(ChatFrame, name)
    for index, value in pairs(ChatFrame.channelList) do
        if strupper(name) == strupper(value) then return true end
    end
    return nil
end

function LazyPig.ZoneCheck()
	local leavechat = LPCONFIG.WORLDRAID and LazyPig.Raid() or LPCONFIG.WORLDDUNGEON and LazyPig.Dungeon() or LPCONFIG.WORLDBG and LazyPig.Battleground() or LPCONFIG.WORLDUNCHECK
	for i = 1, NUM_CHAT_WINDOWS do
		local chatFrame = _G["ChatFrame"..i]
		if chatFrame:IsVisible() and not UnitIsDeadOrGhost("player") then
			local id, name = GetChannelName("world")
			if id > 0 then
				if leavechat then
					if process(chatFrame, name) then
						ChatFrame_RemoveChannel(chatFrame, name)
						channelstatus = true
						UIErrorsFrame:Clear()
						UIErrorsFrame:AddMessage("Leaving World")
					end
					return
				end
			end
			if (LPCONFIG.WORLDRAID or LPCONFIG.WORLDDUNGEON or LPCONFIG.WORLDBG) and not leavechat then
				local framename = chatFrame:GetName()
				if id == 0 then
					UIErrorsFrame:Clear()
					UIErrorsFrame:AddMessage("Joining World")
					JoinChannelByName("world", nil, chatFrame:GetID())
				else
					if (not process(chatFrame, name) or channelstatus) and framename == "ChatFrame1" then
						ChatFrame_AddChannel(chatFrame, name)
						UIErrorsFrame:Clear()
						UIErrorsFrame:AddMessage("Joining World")
						channelstatus = false
					end
				end
			end
		end
	end
end

function LazyPig.PlayerClass(class, unit)
	if class then
		unit = unit or "player"
		local _, c = UnitClass(unit)
		return c == string.upper(class)
	end
	return false
end

function LazyPig.IsBearForm()
	if GetShapeshiftFormID then
		local id = GetShapeshiftFormID()
		return id == 5 or id == 8
	end
	for i = 1, GetNumShapeshiftForms() do
		local _, name, isActive = GetShapeshiftFormInfo(i)
		if isActive and LazyPig.PlayerClass("Druid") and (name == "Bear Form" or name == "Dire Bear Form") then
			return true
		end
	end
	return false
end

function LazyPig.IsShieldEquipped()
	local name, itemString = LazyPig.DecodeItemLink(GetInventoryItemLink("player", 17))
	if itemString then
		local _, _, _, _, _, _, _, invType = GetItemInfo(itemString)
		return invType == "INVTYPE_SHIELD"
	end
	return false
end

function LazyPig.CancelShapeshiftBuff()
	if CancelShapeshiftForm then return CancelShapeshiftForm() end
	for i = 1, GetNumShapeshiftForms() do
		local _, _, isActive = GetShapeshiftFormInfo(i)
		if isActive and LazyPig.PlayerClass("Druid") then
			CastShapeshiftForm(i)
			return
		end
	end
end

function LazyPig.HasTalent(tree, talent, rank)
	if not rank then rank = 1 end
	local _, _, _, _, r = GetTalentInfo(tree, talent)
	return r >= rank
end

LazyPig.SalvationBuffs = {
	"Spell_Holy_SealOfSalvation",
	"Spell_Holy_GreaterBlessingofSalvation"
}
function LazyPig.CheckSalvation()
	if LPCONFIG.SALVA ~= 1 and LPCONFIG.SALVA ~= 2 then
		return
	end
	if LPCONFIG.SALVA == 2 then
		local warriorTank = LazyPig.IsShieldEquipped() and LazyPig.PlayerClass("Warrior")
		local druidTank = LazyPig.IsBearForm()
		local paladinTank = LazyPig.HasRighteousFury()
		local shamanTank = LazyPig.IsShieldEquipped() and LazyPig.PlayerClass("Shaman") and LazyPig.HasTalent(shamanTankTree, shamanTankTalent, 2)
		if not (warriorTank or druidTank or paladinTank or shamanTank) then
			return
		end
	end
	local counter = 0
	while GetPlayerBuff(counter) >= 0 do
		local index, untilCancelled = GetPlayerBuff(counter)
		if untilCancelled ~= 1 then
			local texture = GetPlayerBuffTexture(index)
			if texture then
				local i = 1
				while LazyPig.SalvationBuffs[i] do
					if string.find(texture, LazyPig.SalvationBuffs[i]) then
						CancelPlayerBuff(index)
						UIErrorsFrame:Clear()
						UIErrorsFrame:AddMessage("Salvation Removed")
						return
					end
					i = i + 1
				end
			end
		end
		counter = counter + 1
	end
end

function LazyPig.RefreshCamera()
	if LPCONFIG.CAM then
		SetCVar("cameraDistanceMax", 50)
	else
		SetCVar("cameraDistanceMaxFactor", 1)
		SetCVar("cameraDistanceMax", 15)
	end
end

LazyPig.ManaBuffs = {
	"Spell_Holy_SealOfWisdom",
	"Spell_Holy_GreaterBlessingofWisdom",
	"Spell_Holy_ArcaneIntellect",
	"Spell_Holy_MagicalSentry",
	"Spell_Holy_PrayerofSpirit",
	"Spell_Holy_DivineSpirit"
}
function LazyPig.CheckManaBuffs()
	if not LPCONFIG.REMOVEMANABUFFS or LazyPig.Battleground() then
		return
	end
	local counter = 0
	while GetPlayerBuff(counter) >= 0 do
		local index, untilCancelled = GetPlayerBuff(counter)
		if untilCancelled ~= 1 then
			local texture = GetPlayerBuffTexture(index)
			if texture then
				local i = 1
				while LazyPig.ManaBuffs[i] do
					if string.find(texture, LazyPig.ManaBuffs[i]) then
						CancelPlayerBuff(index)
						UIErrorsFrame:Clear()
						UIErrorsFrame:AddMessage("Intellect or Wisdom or Spirit Removed")
						return
					end
					i = i + 1
				end
			end
		end
		counter = counter + 1
	end
end

function LazyPig.ChatFrame_OnEvent(event)
	if event == "CHAT_MSG_LOOT" or event == "CHAT_MSG_MONEY" then
		local bijou = string.find(arg1, "Bijou")
		local coin = string.find(arg1, "Coin")
		local idol = string.find(arg1, "Idol")
		local scarab = string.find(arg1, "Scarab")
		local green_roll = greenrolltime > GetTime()
		local check_uncommon = LPCONFIG.SPAM_UNCOMMON and string.find(arg1, "1eff00")
		local check_rare = LPCONFIG.SPAM_RARE and string.find(arg1, "0070dd")
		local check_loot = LPCONFIG.SPAM_LOOT and (string.find(arg1, "9d9d9d") or string.find(arg1, "ffffff") or string.find(arg1, "Your share of the loot"))
		local check_money = LPCONFIG.SPAM_LOOT and string.find(arg1, "Your share of the loot")

		local check1 = string.find(arg1, "You")
		local check2 = string.find(arg1, "won") or string.find(arg1, "receive")
		local check3 = LPCONFIG.AQ and (idol or scarab)
		local check4 = LPCONFIG.ZG and (bijou or coin)
		local check5 = check1 and not check4 and not check3 and not green_roll or check2

		if not check5 and (check_uncommon or check_rare) or check_loot and not check1 or check_money then
			return
		end
	end

	if LPCONFIG.SPAM and arg2 and arg2 ~= GetUnitName("player") and not LazyPig.IsGuildMate(arg2) and not LazyPig.IsFriend(arg2) and (event == "CHAT_MSG_SAY" or event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_YELL" or event == "CHAT_MSG_EMOTE") then
		local now = GetTime()
		local chatFrameID = this:GetID()
		if not LazyPig.ChatMessages[chatFrameID] then LazyPig.ChatMessages[chatFrameID] = {} end

		for text, time in pairs(LazyPig.ChatMessages[chatFrameID]) do
			if text == arg1 and (time + 30) > now then
				-- print(format("spam in ChatFrame%d: [%s] %s", chatFrameID, arg2, arg1))
				return
			end
		end
		LazyPig.ChatMessages[chatFrameID][arg1] = now
	end

	-- suppress BigWigs spam
	if LPCONFIG.SPAM and event == "CHAT_MSG_SAY" and string.find(arg1 or "", "^Casted %u[%a%s]+ on %u[%a%s]+") then
		return
	end

	-- suppress #showtooltip spam
	if string.find(arg1 or "", "^#showtooltip") then
		return
	end

	-- suppress rested xp spam
	if string.find(arg1 or "", "=== .+ RESTED XP") and arg2 ~= UnitName("player") then
		return
	end

	LazyPig.Hooks.ChatFrame_OnEvent(event)
end

function LazyPig.TrackEFC(msg)
	if msg then
		msg = strlower(msg)

		local find0 = "captured "
		local find1 = "The "..UnitFactionGroup("player").." Flag"
		local find2 = " was picked up "
		local find3 = " was dropped "

		if string.find(msg, strlower(find1..find2)) then
			_, _, wsgefc = string.find(msg, strlower(find1..find2.."by (.+)%!"))
			--DEFAULT_CHAT_FRAME:AddMessage("ADD EFC - "..wsgefc)
		elseif string.find(msg, strlower(find1..find3)) or string.find(msg, strlower(find0..find1)) then
			wsgefc = nil
			--DEFAULT_CHAT_FRAME:AddMessage("DEL EFC")
		end
	end
end

function LazyPig.Target_EFC()
	ClearTarget()
	if wsgefc then
		TargetByName(wsgefc, true)
		UIErrorsFrame:Clear()
		if not UnitExists("target") then
			UIErrorsFrame:AddMessage("OUT OF RANGE - EFC - "..strupper(wsgefc))
		elseif strlower(GetUnitName("target")) == wsgefc then
			local class, classFileName = UnitClass("target")
			local color = RAID_CLASS_COLORS[classFileName]
			UIErrorsFrame:AddMessage(strupper(class.." - EFC - "..wsgefc), color.r, color.g, color.b)
		end
	end
end

function LazyPig.Duel_EFC()
	if GetRealZoneText() == "Warsong Gulch" then
		LazyPig.Target_EFC()
	else
		local duel = nil
		for i = 1, STATICPOPUP_NUMDIALOGS do
			local frame = _G["StaticPopup"..i]
			if frame:IsShown() then
				if frame.which == "DUEL_REQUESTED" then
					duel = true
				end
			end
		end
		if duel_active or duel then
			CancelDuel()
		elseif UnitExists("target") and UnitIsFriend("target", "player") then
			StartDuel(GetUnitName("target"))
		end
	end
end

function LazyPig.HasRighteousFury()
	if not LazyPig.PlayerClass("Paladin") then return false end
	local counter = 0
	while GetPlayerBuff(counter) >= 0 do
		local index, untilCancelled = GetPlayerBuff(counter)
		if untilCancelled == 1 then
			local texture = GetPlayerBuffTexture(index)
			if texture and string.find(texture, "Spell_Holy_SealOfFury") then
				return true
			end
		end
		counter = counter + 1
	end
	return false
end
