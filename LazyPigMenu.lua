local LazyPigMenuObjects = {}
local LazyPigMenuStrings = {}
LazyPigMenuStrings[00] = "Need"
LazyPigMenuStrings[01] = "Greed"
LazyPigMenuStrings[02] = "Pass"
LazyPigMenuStrings[03] = "Need"
LazyPigMenuStrings[04] = "Greed"
LazyPigMenuStrings[05] = "Pass"
LazyPigMenuStrings[06] = "Need"
LazyPigMenuStrings[07] = "Greed"
LazyPigMenuStrings[08] = "Pass"
LazyPigMenuStrings[09] = "Need"
LazyPigMenuStrings[10] = "Greed"
LazyPigMenuStrings[11] = "Pass"
LazyPigMenuStrings[12] = "Need"
LazyPigMenuStrings[13] = "Greed"
LazyPigMenuStrings[14] = "Pass"
LazyPigMenuStrings[15] = "Need"
LazyPigMenuStrings[16] = "Greed"
LazyPigMenuStrings[17] = "Pass"
LazyPigMenuStrings[18] = "Need"
LazyPigMenuStrings[19] = "Greed"
LazyPigMenuStrings[20] = "Pass"
LazyPigMenuStrings[21] = "LazyPig Auto Roll Messages"
LazyPigMenuStrings[22] = "Dungeon"
LazyPigMenuStrings[23] = "Raid"
LazyPigMenuStrings[24] = "Battleground"
LazyPigMenuStrings[25] = "Mute Permanently"
LazyPigMenuStrings[26] = "Need"
LazyPigMenuStrings[27] = "Greed"
LazyPigMenuStrings[28] = "Pass"
LazyPigMenuStrings[30] = "GuildMates"
LazyPigMenuStrings[31] = "Friends"
LazyPigMenuStrings[32] = "Strangers"
LazyPigMenuStrings[33] = "Idle while in BG or Queue"
LazyPigMenuStrings[40] = "Show Friends"
LazyPigMenuStrings[41] = "Show Enemies"
LazyPigMenuStrings[42] = "Hide if Unchecked"
LazyPigMenuStrings[50] = "Enter BG"
LazyPigMenuStrings[51] = "Leave BG"
LazyPigMenuStrings[52] = "Queue BG"
LazyPigMenuStrings[53] = "Auto Release"
LazyPigMenuStrings[54] = "Leader Queue Announce"
LazyPigMenuStrings[55] = "Block BG Quest Sharing"
LazyPigMenuStrings[60] = "Always"
LazyPigMenuStrings[61] = "Smart"
LazyPigMenuStrings[62] = "Remove Wis/Int/Spirit"
LazyPigMenuStrings[63] = "Auto Stance"
LazyPigMenuStrings[70] = "Players' Spam"
LazyPigMenuStrings[71] = "Uncommon Roll"
LazyPigMenuStrings[72] = "Rare Roll"
LazyPigMenuStrings[73] = "Poor-Common-Money Loot"
LazyPigMenuStrings[90] = "Summon Auto Accept"
LazyPigMenuStrings[91] = "Loot Window Auto Position"
LazyPigMenuStrings[92] = "Improved Right Click"
LazyPigMenuStrings[93] = "Easy Split/Merge (Shift+Right_Click)"
LazyPigMenuStrings[94] = "Extended Camera Distance"
LazyPigMenuStrings[95] = "Special Key Combinations"
LazyPigMenuStrings[96] = "Duel Auto Decline (Shift to ByPass)"
LazyPigMenuStrings[97] = "Instance Resurrection Accept OOC"
LazyPigMenuStrings[98] = "Gossip Auto Processing"
LazyPigMenuStrings[100] = "Auto Dismount"
LazyPigMenuStrings[101] = "Chat Spam Filter"
LazyPigMenuStrings[102] = "Need"
LazyPigMenuStrings[103] = "Greed"
LazyPigMenuStrings[104] = "Pass"
LazyPigMenuStrings[105] = "Need"
LazyPigMenuStrings[106] = "Greed"
LazyPigMenuStrings[107] = "Pass"
LazyPigMenuStrings[108] = "Need"
LazyPigMenuStrings[109] = "Greed"
LazyPigMenuStrings[110] = "Pass"

function LazyPig_GetOption(num)
	local labelString = _G[this:GetName().."Text"];
	local label = LazyPigMenuStrings[num] or "";
	LazyPigMenuObjects[num] = this

	if num == 00 and LPCONFIG.GREEN == 1
	or num == 01 and LPCONFIG.GREEN == 2
	or num == 02 and LPCONFIG.GREEN == 0
	or num == 03 and LPCONFIG.ZG == 1
	or num == 04 and LPCONFIG.ZG == 2
	or num == 05 and LPCONFIG.ZG == 0
	or num == 06 and LPCONFIG.MC == 1
	or num == 07 and LPCONFIG.MC == 2
	or num == 08 and LPCONFIG.MC == 0
	or num == 09 and LPCONFIG.AQ == 1
	or num == 10 and LPCONFIG.AQ == 2
	or num == 11 and LPCONFIG.AQ == 0
	or num == 12 and LPCONFIG.AQMOUNT == 1
	or num == 13 and LPCONFIG.AQMOUNT == 2
	or num == 14 and LPCONFIG.AQMOUNT == 0
	or num == 15 and LPCONFIG.SAND == 1
	or num == 16 and LPCONFIG.SAND == 2
	or num == 17 and LPCONFIG.SAND == 0
	or num == 18 and LPCONFIG.NAXX == 1
	or num == 19 and LPCONFIG.NAXX == 2
	or num == 20 and LPCONFIG.NAXX == 0
	or num == 21 and LPCONFIG.ROLLMSG
	or num == 22 and LPCONFIG.WORLDDUNGEON
	or num == 23 and LPCONFIG.WORLDRAID
	or num == 24 and LPCONFIG.WORLDBG
	or num == 25 and LPCONFIG.WORLDUNCHECK
	or num == 26 and LPCONFIG.BWL == 1
	or num == 27 and LPCONFIG.BWL == 2
	or num == 28 and LPCONFIG.BWL == 0
	or num == 30 and LPCONFIG.GINV
	or num == 31 and LPCONFIG.FINV
	or num == 32 and LPCONFIG.SINV
	or num == 33 and LPCONFIG.DINV
	or num == 40 and LPCONFIG.FPLATE
	or num == 41 and LPCONFIG.EPLATE
	or num == 42 and LPCONFIG.HPLATE
	or num == 50 and LPCONFIG.EBG
	or num == 51 and LPCONFIG.LBG
	or num == 52 and LPCONFIG.QBG
	or num == 53 and LPCONFIG.RBG
	or num == 54 and LPCONFIG.AQUE
	or num == 55 and LPCONFIG.SBG

	or num == 60 and LPCONFIG.SALVA == 1
	or num == 61 and LPCONFIG.SALVA == 2

	or num == 62 and LPCONFIG.REMOVEMANABUFFS == 1
	or num == 63 and LPCONFIG.AUTOSTANCE

	or num == 90 and LPCONFIG.SUMM

	or num == 70 and LPCONFIG.SPAM
	or num == 71 and LPCONFIG.SPAM_UNCOMMON
	or num == 72 and LPCONFIG.SPAM_RARE
	or num == 73 and LPCONFIG.SPAM_LOOT

	or num == 91 and LPCONFIG.LOOT
	or num == 92 and LPCONFIG.RIGHT
	or num == 93 and LPCONFIG.SHIFTSPLIT
	or num == 94 and LPCONFIG.CAM
	or num == 95 and LPCONFIG.SPECIALKEY
	or num == 96 and LPCONFIG.DUEL
	or num == 97 and LPCONFIG.REZ
	or num == 98 and LPCONFIG.GOSSIP
	or num == 100 and LPCONFIG.DISMOUNT
	or num == 101 and LPCONFIG.SPAM
	or num == 102 and LPCONFIG.WHITE_TAILORING == 1
	or num == 103 and LPCONFIG.WHITE_TAILORING == 2
	or num == 104 and LPCONFIG.WHITE_TAILORING == 0
	or num == 105 and LPCONFIG.FOOD_AND_DRINK == 1
	or num == 106 and LPCONFIG.FOOD_AND_DRINK == 2
	or num == 107 and LPCONFIG.FOOD_AND_DRINK == 0
	or num == 108 and LPCONFIG.ES_SHARDS == 1
	or num == 109 and LPCONFIG.ES_SHARDS == 2
	or num == 110 and LPCONFIG.ES_SHARDS == 0

	or nil then
		this:SetChecked(true);
	else
		this:SetChecked(nil);
	end
	labelString:SetText(label);
end

function LazyPig_SetOption(num)
	local checked = this:GetChecked()
	if num == 00 then
		LPCONFIG.GREEN = 1
		if not checked then LPCONFIG.GREEN = nil end
		LazyPigMenuObjects[01]:SetChecked(nil)
		LazyPigMenuObjects[02]:SetChecked(nil)
	elseif num == 01 then
		LPCONFIG.GREEN = 2
		if not checked then LPCONFIG.GREEN = nil end
		LazyPigMenuObjects[00]:SetChecked(nil)
		LazyPigMenuObjects[02]:SetChecked(nil)
	elseif num == 02 then
		LPCONFIG.GREEN = 0
		if not checked then LPCONFIG.GREEN = nil end
		LazyPigMenuObjects[00]:SetChecked(nil)
		LazyPigMenuObjects[01]:SetChecked(nil)
	elseif num == 03 then
		LPCONFIG.ZG = 1
		if not checked then LPCONFIG.ZG = nil end
		LazyPigMenuObjects[04]:SetChecked(nil)
		LazyPigMenuObjects[05]:SetChecked(nil)
	elseif num == 04 then
		LPCONFIG.ZG = 2
		if not checked then LPCONFIG.ZG = nil end
		LazyPigMenuObjects[03]:SetChecked(nil)
		LazyPigMenuObjects[05]:SetChecked(nil)
	elseif num == 05 then
		LPCONFIG.ZG = 0
		if not checked then LPCONFIG.ZG = nil end
		LazyPigMenuObjects[03]:SetChecked(nil)
		LazyPigMenuObjects[04]:SetChecked(nil)
	elseif num == 06 then
		LPCONFIG.MC = 1
		if not checked then LPCONFIG.MC = nil end
		LazyPigMenuObjects[07]:SetChecked(nil)
		LazyPigMenuObjects[08]:SetChecked(nil)
	elseif num == 07 then
		LPCONFIG.MC = 2
		if not checked then LPCONFIG.MC = nil end
		LazyPigMenuObjects[06]:SetChecked(nil)
		LazyPigMenuObjects[08]:SetChecked(nil)
	elseif num == 08 then
		LPCONFIG.MC = 0
		if not checked then LPCONFIG.MC = nil end
		LazyPigMenuObjects[06]:SetChecked(nil)
		LazyPigMenuObjects[07]:SetChecked(nil)
	elseif num == 09 then
		LPCONFIG.AQ = 1
		if not checked then LPCONFIG.AQ = nil end
		LazyPigMenuObjects[10]:SetChecked(nil)
		LazyPigMenuObjects[11]:SetChecked(nil)
	elseif num == 10 then
		LPCONFIG.AQ = 2
		if not checked then LPCONFIG.AQ = nil end
		LazyPigMenuObjects[09]:SetChecked(nil)
		LazyPigMenuObjects[11]:SetChecked(nil)
	elseif num == 11 then
		LPCONFIG.AQ = 0
		if not checked then LPCONFIG.AQ = nil end
		LazyPigMenuObjects[09]:SetChecked(nil)
		LazyPigMenuObjects[10]:SetChecked(nil)
	elseif num == 12 then
		LPCONFIG.AQMOUNT = 1
		if not checked then LPCONFIG.AQMOUNT = nil end
		LazyPigMenuObjects[13]:SetChecked(nil)
		LazyPigMenuObjects[14]:SetChecked(nil)
	elseif num == 13 then
		LPCONFIG.AQMOUNT = 2
		if not checked then LPCONFIG.AQMOUNT = nil end
		LazyPigMenuObjects[12]:SetChecked(nil)
		LazyPigMenuObjects[14]:SetChecked(nil)
	elseif num == 14 then
		LPCONFIG.AQMOUNT = 0
		if not checked then LPCONFIG.AQMOUNT = nil end
		LazyPigMenuObjects[12]:SetChecked(nil)
		LazyPigMenuObjects[13]:SetChecked(nil)
	elseif num == 15 then
		LPCONFIG.SAND = 1
		if not checked then LPCONFIG.SAND = nil end
		LazyPigMenuObjects[16]:SetChecked(nil)
		LazyPigMenuObjects[17]:SetChecked(nil)
	elseif num == 16 then
		LPCONFIG.SAND = 2
		if not checked then LPCONFIG.SAND = nil end
		LazyPigMenuObjects[15]:SetChecked(nil)
		LazyPigMenuObjects[17]:SetChecked(nil)
	elseif num == 17 then
		LPCONFIG.SAND = 0
		if not checked then LPCONFIG.SAND = nil end
		LazyPigMenuObjects[18]:SetChecked(nil)
		LazyPigMenuObjects[19]:SetChecked(nil)
	elseif num == 18 then
		LPCONFIG.NAXX = 1
		if not checked then LPCONFIG.NAXX = nil end
		LazyPigMenuObjects[19]:SetChecked(nil)
		LazyPigMenuObjects[20]:SetChecked(nil)
	elseif num == 19 then
		LPCONFIG.NAXX = 2
		if not checked then LPCONFIG.NAXX = nil end
		LazyPigMenuObjects[18]:SetChecked(nil)
		LazyPigMenuObjects[20]:SetChecked(nil)
	elseif num == 20 then
		LPCONFIG.NAXX = 0
		if not checked then LPCONFIG.NAXX = nil end
		LazyPigMenuObjects[18]:SetChecked(nil)
		LazyPigMenuObjects[19]:SetChecked(nil)
	elseif num == 21 then
		LPCONFIG.ROLLMSG = true
		if not checked then LPCONFIG.ROLLMSG = nil end
	elseif num == 22 then
		LPCONFIG.WORLDDUNGEON = true					--fixed
		if not checked then LPCONFIG.WORLDDUNGEON = nil end
		if LPCONFIG.WORLDDUNGEON or LPCONFIG.WORLDRAID or LPCONFIG.WORLDBG then
			LPCONFIG.WORLDUNCHECK = nil
			LazyPigMenuObjects[25]:SetChecked(nil)
		end
		LazyPig_ZoneCheck()
	elseif num == 23 then
		LPCONFIG.WORLDRAID = true
		if not checked then LPCONFIG.WORLDRAID = nil end
		if LPCONFIG.WORLDDUNGEON or LPCONFIG.WORLDRAID or LPCONFIG.WORLDBG then
			LPCONFIG.WORLDUNCHECK = nil
			LazyPigMenuObjects[25]:SetChecked(nil)
		end
		LazyPig_ZoneCheck()
	elseif num == 24 then
		LPCONFIG.WORLDBG = true
		if not checked then LPCONFIG.WORLDBG = nil end
		if LPCONFIG.WORLDDUNGEON or LPCONFIG.WORLDRAID or LPCONFIG.WORLDBG then
			LPCONFIG.WORLDUNCHECK = nil
			LazyPigMenuObjects[25]:SetChecked(nil)
		end
		LazyPig_ZoneCheck()
	elseif num == 25 then
		LPCONFIG.WORLDUNCHECK = true
		if not checked then
			LPCONFIG.WORLDUNCHECK = nil
		else
			LPCONFIG.WORLDDUNGEON = nil
			LPCONFIG.WORLDRAID = nil
			LPCONFIG.WORLDBG = nil


			LazyPigMenuObjects[22]:SetChecked(nil)
			LazyPigMenuObjects[23]:SetChecked(nil)
			LazyPigMenuObjects[24]:SetChecked(nil)
		end
		LazyPig_ZoneCheck()
	elseif num == 26 then
		LPCONFIG.BWL = 1
		if not checked then LPCONFIG.BWL = nil end
		LazyPigMenuObjects[27]:SetChecked(nil)
		LazyPigMenuObjects[28]:SetChecked(nil)
	elseif num == 27 then
		LPCONFIG.BWL = 2
		if not checked then LPCONFIG.BWL = nil end
		LazyPigMenuObjects[26]:SetChecked(nil)
		LazyPigMenuObjects[28]:SetChecked(nil)
	elseif num == 28 then
		LPCONFIG.BWL = 0
		if not checked then LPCONFIG.BWL = nil end
		LazyPigMenuObjects[26]:SetChecked(nil)
		LazyPigMenuObjects[27]:SetChecked(nil)
	elseif num == 30 then 								--fixed
		LPCONFIG.GINV = true
		if not checked then LPCONFIG.GINV = nil end
	elseif num == 31 then
		LPCONFIG.FINV = true
		if not checked then LPCONFIG.FINV = nil end
	elseif num == 32 then
		LPCONFIG.SINV = true
		if not checked then LPCONFIG.SINV = nil end
	elseif num == 33 then
		LPCONFIG.DINV = true
		if not checked then LPCONFIG.DINV = nil end
	elseif num == 40 then 								--fixed
		LPCONFIG.FPLATE = true
		if not checked then LPCONFIG.FPLATE = nil end
		if LPCONFIG.EPLATE and LPCONFIG.FPLATE then
			LPCONFIG.HPLATE = nil
			LazyPigMenuObjects[42]:SetChecked(nil)
		end
		LazyPig_RefreshNameplates()
	elseif num == 41 then
		LPCONFIG.EPLATE = true
		if not checked then LPCONFIG.EPLATE = nil end
		if LPCONFIG.EPLATE and LPCONFIG.FPLATE then
			LPCONFIG.HPLATE = nil
			LazyPigMenuObjects[42]:SetChecked(nil)
		end
		LazyPig_RefreshNameplates()
	elseif num == 42 then
		LPCONFIG.HPLATE = true
		if not checked then
			LPCONFIG.HPLATE = nil
		end
		if LPCONFIG.EPLATE and LPCONFIG.FPLATE then
			LPCONFIG.HPLATE = nil
			LazyPigMenuObjects[42]:SetChecked(nil)
		end
		LazyPig_RefreshNameplates()
	elseif num == 50 then --fixed
		LPCONFIG.EBG = true
		if not checked then LPCONFIG.EBG = nil end
	elseif num == 51 then
		LPCONFIG.LBG = true
		if not checked then LPCONFIG.LBG = nil end
	elseif num == 52 then
		LPCONFIG.QBG = true
		if not checked then LPCONFIG.QBG = nil end
	elseif num == 53 then
		LPCONFIG.RBG = true
		if not checked then LPCONFIG.RBG = nil end
	elseif num == 54 then
		LPCONFIG.AQUE = true
		if not checked then LPCONFIG.AQUE = nil end
	elseif num == 55 then
		LPCONFIG.SBG  = true
		if not checked then LPCONFIG.SBG  = nil end
	elseif num == 60 then
		LPCONFIG.SALVA = 1
		if not checked then LPCONFIG.SALVA = nil end
		LazyPigMenuObjects[61]:SetChecked(nil)
		LazyPig_CheckSalvation()
	elseif num == 61 then
		LPCONFIG.SALVA = 2
		if not checked then LPCONFIG.SALVA = nil end
		LazyPigMenuObjects[60]:SetChecked(nil)
		LazyPig_CheckSalvation()
	elseif num == 62 then
		LPCONFIG.REMOVEMANABUFFS = 1
		if not checked then LPCONFIG.REMOVEMANABUFFS = nil end
		LazyPig_CheckManaBuffs()
	elseif num == 63 then
		LPCONFIG.AUTOSTANCE = true
		if not checked then LPCONFIG.AUTOSTANCE = false end
	elseif num == 70 then --fixed
		LPCONFIG.SPAM = true
		if not checked then LPCONFIG.SPAM = nil end
	elseif num == 71 then
		LPCONFIG.SPAM_UNCOMMON = true
		if not checked then LPCONFIG.SPAM_UNCOMMON = nil end
	elseif num == 72 then
		LPCONFIG.SPAM_RARE	 = true
		if not checked then LPCONFIG.SPAM_RARE	 = nil end
	elseif num == 73 then
		LPCONFIG.SPAM_LOOT	 = true
		if not checked then LPCONFIG.SPAM_LOOT	 = nil end

	elseif num == 90 then
		LPCONFIG.SUMM = true
		if not checked then LPCONFIG.SUMM = nil end
	elseif num == 91 then
		LPCONFIG.LOOT = true
		if not checked then LPCONFIG.LOOT = nil end
	elseif num == 92 then
		LPCONFIG.RIGHT = true
		if not checked then LPCONFIG.RIGHT = nil end
		MailtoCheck(LPCONFIG.RIGHT)
	elseif num == 93 then--fixed
		LPCONFIG.SHIFTSPLIT = true
		if not checked then LPCONFIG.SHIFTSPLIT = nil end
		MailtoCheck(LPCONFIG.SHIFTSPLIT)
	elseif num == 94 then--fixed
		LPCONFIG.CAM = true
		if not checked then LPCONFIG.CAM = nil end
		if LPCONFIG.CAM then SetCVar("cameraDistanceMax",50) else SetCVar("cameraDistanceMaxFactor",1) SetCVar("cameraDistanceMax",15) end
	elseif num == 95 then
		LPCONFIG.SPECIALKEY = true
		if not checked then LPCONFIG.SPECIALKEY = nil end
	elseif num == 96 then
		LPCONFIG.DUEL = true
		if not checked then LPCONFIG.DUEL = nil end
		if LPCONFIG.DUEL then CancelDuel() end
	elseif num == 97 then
		LPCONFIG.REZ = true
		if not checked then LPCONFIG.REZ = nil end
	elseif num == 98 then
		LPCONFIG.GOSSIP = true
		if not checked then LPCONFIG.GOSSIP = nil end
	elseif num == 100 then
		LPCONFIG.DISMOUNT = true
		if not checked then LPCONFIG.DISMOUNT = nil end
	elseif num == 101 then
		LPCONFIG.SPAM  = true
		if not checked then LPCONFIG.SPAM  = nil end
	elseif num == 102 then
		LPCONFIG.WHITE_TAILORING = 1
		if not checked then LPCONFIG.WHITE_TAILORING = nil end
		LazyPigMenuObjects[103]:SetChecked(nil)
		LazyPigMenuObjects[104]:SetChecked(nil)
	elseif num == 103 then
		LPCONFIG.WHITE_TAILORING = 2
		if not checked then LPCONFIG.WHITE_TAILORING = nil end
		LazyPigMenuObjects[102]:SetChecked(nil)
		LazyPigMenuObjects[104]:SetChecked(nil)
	elseif num == 104 then
		LPCONFIG.WHITE_TAILORING = 0
		if not checked then LPCONFIG.WHITE_TAILORING = nil end
		LazyPigMenuObjects[102]:SetChecked(nil)
		LazyPigMenuObjects[103]:SetChecked(nil)
	elseif num == 105 then
		LPCONFIG.FOOD_AND_DRINK = 1
		if not checked then LPCONFIG.FOOD_AND_DRINK = nil end
		LazyPigMenuObjects[106]:SetChecked(nil)
		LazyPigMenuObjects[107]:SetChecked(nil)
	elseif num == 106 then
		LPCONFIG.FOOD_AND_DRINK = 2
		if not checked then LPCONFIG.FOOD_AND_DRINK = nil end
		LazyPigMenuObjects[105]:SetChecked(nil)
		LazyPigMenuObjects[107]:SetChecked(nil)
	elseif num == 107 then
		LPCONFIG.FOOD_AND_DRINK = 0
		if not checked then LPCONFIG.FOOD_AND_DRINK = nil end
		LazyPigMenuObjects[105]:SetChecked(nil)
		LazyPigMenuObjects[106]:SetChecked(nil)
	elseif num == 108 then
		LPCONFIG.ES_SHARDS = 1
		if not checked then LPCONFIG.ES_SHARDS = nil end
		LazyPigMenuObjects[109]:SetChecked(nil)
		LazyPigMenuObjects[110]:SetChecked(nil)
	elseif num == 109 then
		LPCONFIG.ES_SHARDS = 2
		if not checked then LPCONFIG.ES_SHARDS = nil end
		LazyPigMenuObjects[108]:SetChecked(nil)
		LazyPigMenuObjects[110]:SetChecked(nil)
	elseif num == 110 then
		LPCONFIG.ES_SHARDS = 0
		if not checked then LPCONFIG.ES_SHARDS = nil end
		LazyPigMenuObjects[108]:SetChecked(nil)
		LazyPigMenuObjects[109]:SetChecked(nil)
	else
		--DEFAULT_CHAT_FRAME:AddMessage("DEBUG: No num assigned - "..num)
	end
	--DEFAULT_CHAT_FRAME:AddMessage("DEBUG: Num chosen - "..num)
end

local CheckBoxTables = {
	["Green Items Roll [Ctrl-Alt]"] = {
		[0] = "LazyPigCheckboxGroupGreedRoll",
		[1] = { "LazyPigCheckbox00", "Need" },
		[2] = { "LazyPigCheckbox01", "Greed" },
		[3] = { "LazyPigCheckbox02", "Pass" }
	},
	
	["Zul'Gurub Roll Automation"] = {
		[0] = "LazyPigCheckboxGroupZGRoll",
		[1] = { "LazyPigCheckbox03", "Need" },
		[2] = { "LazyPigCheckbox04", "Greed" },
		[3] = { "LazyPigCheckbox05", "Pass" }
	},
	
	["Molten Core Roll Automation"] = {
		[0] = "LazyPigCheckboxGroupMCRoll",
		[1] = { "LazyPigCheckbox06", "Need" },
		[2] = { "LazyPigCheckbox07", "Greed" },
		[3] = { "LazyPigCheckbox08", "Pass" }
	},
	
	["AQ Idols + Scarabs Automation"] = {
		[0] = "LazyPigCheckboxGroupAQRoll",
		[1] = { "LazyPigCheckbox09", "Need" },
		[2] = { "LazyPigCheckbox10", "Greed" },
		[3] = { "LazyPigCheckbox11", "Pass" }
	},
	
	["AQ40 Blue/Green/Yel Mount Automation"] = {
		[0] = "LazyPigCheckboxGroupAQMountRoll",
		[1] = { "LazyPigCheckbox12", "Need" },
		[2] = { "LazyPigCheckbox13", "Greed" },
		[3] = { "LazyPigCheckbox14", "Pass" }
	},
	
	["Black Morass Corrupted Sand Automation"] = {
		[0] = "LazyPigCheckboxGroupSandRoll",
		[1] = { "LazyPigCheckbox15", "Need" },
		[2] = { "LazyPigCheckbox16", "Greed" },
		[3] = { "LazyPigCheckbox17", "Pass" }
	},
	
	["Naxx Roll Automation"] = {
		[0] = "LazyPigCheckboxGroupNaxxRoll",
		[1] = { "LazyPigCheckbox18", "Need" },
		[2] = { "LazyPigCheckbox19", "Greed" },
		[3] = { "LazyPigCheckbox20", "Pass" }
	},

	["World Chat Mute"] = {
		[0] = "LazyPigCheckboxGroupWorldChatMute",
		[1] = { "LazyPigCheckbox22", "Dungeons" },
		[2] = { "LazyPigCheckbox23", "Raids" },
		[3] = { "LazyPigCheckbox24", "Battlegrounds" },
		[4] = { "LazyPigCheckbox25", "Mute Permanently", "Mute the WorldChannel for good..."}
	},
	
	["BWL Sand/Ore Roll Automation"] = {
		[0] = "LazyPigCheckboxGroupBWLRoll",
		[1] = { "LazyPigCheckbox26", "Need" },
		[2] = { "LazyPigCheckbox27", "Greed" },
		[3] = { "LazyPigCheckbox28", "Pass" }
	},
	
	["Cloth Roll Automation"] = {
		[0] = "LazyPigCheckboxGroupTailoringRoll",
		[1] = { "LazyPigCheckbox102", "Need" },
		[2] = { "LazyPigCheckbox103", "Greed" },
		[3] = { "LazyPigCheckbox104", "Pass" }
	},
	
	["Food and Drink Roll Automation"] = {
		[0] = "LazyPigCheckboxGroupFoodAndDrinkRoll",
		[1] = { "LazyPigCheckbox105", "Need" },
		[2] = { "LazyPigCheckbox106", "Greed" },
		[3] = { "LazyPigCheckbox107", "Pass" }
	},
	
	["Emerald Sanctum Roll Automation"] = {
		[0] = "LazyPigCheckboxGroupEsShardsRoll",
		[1] = { "LazyPigCheckbox108", "Need" },
		[2] = { "LazyPigCheckbox109", "Greed" },
		[3] = { "LazyPigCheckbox110", "Pass" }
	},

	["Battlegrounds Automation"] = {
		[0] = "LazyPigCheckboxGroupBGAutomation",
		[1] = { "LazyPigCheckbox50", "Enter Battleground", "Enter the Battleground as soon as the queue popup" },
		[2] = { "LazyPigCheckbox51", "Leave Battleground", "Leave the Battleground as soon as it finish"},
		[3] = { "LazyPigCheckbox52", "Queue Battleground", "Join the queue as soon as the BattleMaster is right-clicked" },
		[4] = { "LazyPigCheckbox53", "Auto Release", "Auto Accept Release in BG" },
		[5] = { "LazyPigCheckbox54", "Leader Queue Announce" },
		[6] = { "LazyPigCheckbox55", "Leader Queue Announce" }
	},
	
	["Smart Salvation Remover"] = {
		[0] = "LazyPigCheckboxGroupSalvationRemover",
		[1] = { "LazyPigCheckbox60", "Always" },
		[2] = { "LazyPigCheckbox61", "Warrior Shield/Druid Bear/Paladin RF" },
	},

	["Mana Buff Remover"] = {
		[0] = "LazyPigCheckBoxGroupManaBuffRemover",
		[1] = {"LazyPigCheckbox62","Always"}
	},
	
	["Nameplates Display Rules"] = {
		[0] = "LazyPigCheckboxGroupNameplates",
		[1] = { "LazyPigCheckbox40", "Show Friends" },
		[2] = { "LazyPigCheckbox41", "Show Enemies" },
		[3] = { "LazyPigCheckbox42", "Hide if Unchecked" }
	},

	["Group Invite Accept Rules"] = {
		[0] = "LazyPigCheckboxGroupGroupInvite",
		[1] = { "LazyPigCheckbox30", "GuildMates" },
		[2] = { "LazyPigCheckbox31", "Friends" },
		[3] = { "LazyPigCheckbox32", "Strangers" },
		[4] = { "LazyPigCheckbox33", "No Auto Accept Invites while in BattleGround or Queue" }
	},

	["Single Choice Rules"] = {
		[0] = "LazyPigCheckboxGroupSingleChoice",
		[1] = { "LazyPigCheckbox90", "Summon Auto Accept", "If checked summons will be accepted before they expire" },
		[2] = { "LazyPigCheckbox91", "Loot Window Auto Position", "Position the loot window under the mouse-cursor"},
		[3] = { "LazyPigCheckbox92", "Improved Right Click", "Right Click to Drag and Drop Items into Mail, Trade, Auction Frames " },
		[4] = { "LazyPigCheckbox93", "Easy Split/Merge (Shift+Right_Click)", "???"},
		[5] = { "LazyPigCheckbox94", "Extended Camera Distance", "Extend the Camera Distance to its maximum" },
		[6] = { "LazyPigCheckbox95", "Special Key Combinations", "Activate the Special-Key-Combinations" },
		[7] = { "LazyPigCheckbox96", "Duel Auto Decline (Shift to ByPass)" },
		[8] = { "LazyPigCheckbox97", "Instance Resurrection Accept OOC", "Auto Accept Resurrection if OutOfCombat" },
		[9] = { "LazyPigCheckbox98", "Gossip Auto Processing", "Skip Gossip-Windows-Choises from Innkeepers and FlyMasters" },
		[10] = { "LazyPigCheckbox100", "Auto Dismount", "Auto-Dismount when it's required by another action" },
		[11] = { "LazyPigCheckbox63", "Auto Stance", "Automatically change to required warrior stance/druid form on spell cast" },
		--[12] = { "LazyPigCheckbox101", "Chat Spam Filter", "One minute ban for identical messages" },
		--[12] = { "LazyPigCheckbox102", "Block Battleground Quest Sharing", "Really? No more 'Stable' spam?" }
	},
	
	["Chat Filter"] = {
		[0] = "LazyPigCheckboxChatFilter",
		[1] = { "LazyPigCheckbox70", "Players' Spam" },
		[2] = { "LazyPigCheckbox71", "Uncommon Roll" },
		[3] = { "LazyPigCheckbox72", "Rare Roll" },
		[4] = { "LazyPigCheckbox73", "Poor-Common Loot" },
		[5] = { "LazyPigCheckbox21", "Lazy Pig Auto Roll Messages" }
	},
}
--Grey-Common Loot

local function CheckBoxGroup(hParent, offsetX, offsetY, sTitle, tCheck)
	local frame = CreateFrame("Frame", tCheck[0], hParent)
	frame:SetPoint("TOPLEFT", hParent, "TOPLEFT", offsetX, offsetY)
	frame:SetWidth(11)
	frame:SetHeight(11)

	local fs_title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	fs_title:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	fs_title:SetTextColor(1, 1, 1, 1)
	fs_title:SetText(sTitle)

	frame.fs_title = fs_title

	frame.cb = {}

	for k,v in ipairs(tCheck) do
		local cb = CreateFrame("CheckButton", v[1], frame, "UICheckButtonTemplate")
		cb:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 8, -(4+(k-1)*14))
		cb:SetWidth(16)
		cb:SetHeight(16)
		
		if v[2] then cb.tooltipTitle = v[2] end
		if v[3] then cb.tooltipText = v[3] end

		local num = tonumber(string.sub(v[1], string.find(v[1], "%d+")))

		cb:SetScript("OnShow", function()
			LazyPig_GetOption(num)
		end)
		cb:SetScript("OnClick", function()
			LazyPig_SetOption(num);
		end)
		cb:SetScript("OnEnter", function()
			if this.tooltipTitle then
				GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT")
				GameTooltip:SetBackdropColor(.01, .01, .01, .91)
				GameTooltip:SetText(this.tooltipTitle)
				if this.tooltipText then
					GameTooltip:AddLine(this.tooltipText, 1, 1, 1, true)
				end
				GameTooltip:Show()
			end
		end)
		cb:SetScript("OnLeave", function()
			GameTooltip:Hide();
		end)

		frame.cb[k] = cb
	end

	return frame
end

function LazyPig_CreateOptionsFrame()
	-- Option Frame
	local frame = CreateFrame("Frame", "LazyPigOptionsFrame", UIParent)
	tinsert(UISpecialFrames,"LazyPigOptionsFrame")
	frame:SetFrameStrata("DIALOG")
	frame:SetWidth(640)
	frame:SetHeight(660)
	frame:SetPoint("CENTER", UIParent)
	frame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	});
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
	fs_title:SetText("LazyPig Options v" .. LP_VERSION)

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
	local btn_keybinds = CreateFrame("Button", "LazyPigOptionsFrameKeibindsButton", frame, "GameMenuButtonTemplate")
	btn_keybinds:SetPoint("TOPLEFT", frame, "TOPLEFT", 33, -18)
	btn_keybinds:SetWidth(120)
	btn_keybinds:SetHeight(20)
	btn_keybinds:SetFont("Fonts\\FRIZQT__.TTF", 8)
	btn_keybinds:SetText("Show Keybinds")

	frame.btn_keybinds = btn_keybinds

	frame.btn_keybinds:SetScript("OnClick", function()
		if this:GetText() == "Show Keybinds" then
			LazyPigKeybindsFrame:Show()
			this:SetText("Hide Keybinds")
		else
			LazyPigKeybindsFrame:Hide()
			this:SetText("Show Keybinds")
		end
	end)

	local str = "Green Items Roll [Ctrl-Alt]"
	frame.cbgroup_greedroll = CheckBoxGroup(frame, 20, -45, str, CheckBoxTables[str])
	
	local str = "Zul'Gurub Roll Automation"
	frame.cbgroup_zgroll = CheckBoxGroup(frame, 20, -105, str, CheckBoxTables[str])
	
	local str = "Molten Core Roll Automation"
	frame.cbgroup_aq = CheckBoxGroup(frame, 20, -165, str, CheckBoxTables[str])
	
	local str = "AQ Idols + Scarabs Automation"
	frame.cbgroup_aq = CheckBoxGroup(frame, 20, -225, str, CheckBoxTables[str])
	
	local str = "AQ40 Blue/Green/Yel Mount Automation"
	frame.cbgroup_aq = CheckBoxGroup(frame, 20, -285, str, CheckBoxTables[str])
	
	local str = "Black Morass Corrupted Sand Automation"
	frame.cbgroup_sand = CheckBoxGroup(frame, 20, -345, str, CheckBoxTables[str])
	
	local str = "Naxx Roll Automation"
	frame.cbgroup_naxx = CheckBoxGroup(frame, 20, -405, str, CheckBoxTables[str])

	local str = "BWL Sand/Ore Roll Automation"
	frame.cbgroup_bwl = CheckBoxGroup(frame, 20, -465, str, CheckBoxTables[str])

	local str = "Emerald Sanctum Roll Automation"
	frame.cbgroup_es = CheckBoxGroup(frame, 20, -525, str, CheckBoxTables[str])

	local str = "Food and Drink Roll Automation"
	frame.cbgroup_foodanddrink = CheckBoxGroup(frame, 250, -45, str, CheckBoxTables[str])

	local str = "Cloth Roll Automation"
	frame.cbgroup_tailoring = CheckBoxGroup(frame, 250, -107, str, CheckBoxTables[str])

	local str = "Smart Salvation Remover"
	frame.cbgroup_salvationremover = CheckBoxGroup(frame, 250, -169, str, CheckBoxTables[str])

	local str = "Group Invite Accept Rules"
	frame.cbgroup_groupinvite = CheckBoxGroup(frame, 250, -215, str, CheckBoxTables[str])

	local str = "Battlegrounds Automation"
	frame.cbgroup_bgautomation = CheckBoxGroup(frame, 250, -292, str, CheckBoxTables[str])
	
	local str = "Nameplates Display Rules"
	frame.cbgroup_nameplates = CheckBoxGroup(frame, 250, -397, str, CheckBoxTables[str])
	
	local str = "Single Choice Rules"
	frame.cbgroup_singlechoise = CheckBoxGroup(frame, 250, -465, str, CheckBoxTables[str])
	
	local str = "World Chat Mute"
	frame.cbgroup_worldchatmute = CheckBoxGroup(frame, 450, -45, str, CheckBoxTables[str])
	
	local str = "Chat Filter"
	frame.cbgroup_chatfilter = CheckBoxGroup(frame, 450, -125, str, CheckBoxTables[str])

	local str = "Mana Buff Remover"
	frame.cbgroup_manabuffremover = CheckBoxGroup(frame,450,-220,str,CheckBoxTables[str])

	return frame

end
