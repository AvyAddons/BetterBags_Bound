---@class ns
local addon = select(2, ...)

-- BetterBags namespace
-----------------------------------------------------------
---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")

---@class Categories: AceModule
local Categories = BetterBags:GetModule('Categories')

---@class Events: AceModule
local Events = BetterBags:GetModule('Events')

-- Use the L:G() function to get the localized string.
---@class Localization: AceModule
local L = BetterBags:GetModule('Localization')

-- Lua API
-----------------------------------------------------------
local _G = _G
local string_find = string.find

---@param inputString string
---@param patterns string[]
---@return string[]|nil
local function string_findm(inputString, patterns)
	local results   = {}
	local keys = {}

	for i = 1, #patterns do
		local patternToMatch = patterns[i]
		local start, endd = string_find(inputString, patternToMatch)
		if start ~= nil then
			results[patternToMatch] = { start, endd }
			table.insert(keys, start)
		end
	end

	if #keys == 0 then return nil end

	table.sort(keys)
	local finalArray = {}
	for i = 1, #keys do
		table.insert(finalArray, results[keys[i]])
	end
	return finalArray
end

-- WoW API
-----------------------------------------------------------
local CreateFrame = _G.CreateFrame
local C_TooltipInfo_GetBagItem = C_TooltipInfo and C_TooltipInfo.GetBagItem

--- Whether we have C_TooltipInfo APIs available
local IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE

-----------------------------------------------------------
-- Filter Setup
-----------------------------------------------------------
local BOA_STRINGS = { ITEM_ACCOUNTBOUND, ITEM_BNETACCOUNTBOUND, ITEM_BIND_TO_ACCOUNT, ITEM_BIND_TO_BNETACCOUNT }
local WOE_STRINGS = { ITEM_ACCOUNTBOUND_UNTIL_EQUIP, ITEM_BIND_TO_ACCOUNT_UNTIL_EQUIP }

-- Tooltip used for scanning.
local _SCANNER = "AVY_ScannerTooltip"

--- Get the category of an item.
---@param bagIndex number
---@param slotIndex number
---@param itemInfo ExpandedItemInfo
---@return string|nil
function addon:GetItemCategory(bagIndex, slotIndex, itemInfo)
	local category = nil

	if (IsRetail) then
		local tooltipInfo = C_TooltipInfo_GetBagItem(bagIndex, slotIndex)
		if not tooltipInfo then return end
		for i = 2, 4 do
			local line = tooltipInfo.lines[i]
			if (not line) then
				break
			end
			local bind = self:GetBindString(line.leftText)
			if (bind) then
				category = bind
				break
			end
		end
	else
		if (itemInfo.bindType == 2 or itemInfo.bindType == 3) then
			local Scanner = CreateFrame("GameTooltip", _SCANNER .. itemInfo.itemGUID, nil, "GameTooltipTemplate")
			Scanner:SetOwner(WorldFrame, "ANCHOR_NONE")
			Scanner:ClearLines()
			if bagIndex == BANK_CONTAINER then
				Scanner:SetInventoryItem("player", BankButtonIDToInvSlotID(slotIndex, nil))
			else
				Scanner:SetBagItem(bagIndex, slotIndex)
			end
			local lines = self:GetTooltipLines(Scanner)
			for _, line in ipairs(lines) do
				if (line == '') then
					break
				end
				local bind = self:GetBindString(line)
				if (bind) then
					category = bind
					break
				end
			end
			Scanner:Hide()
		end
	end
	return category
end

---@param msg string
---@return string|nil
function addon:GetBindString(msg)
	if (msg) then
		if (string_find(msg, ITEM_BIND_ON_EQUIP)) then
			return addon.S_BOE
		elseif (string_findm(msg, WOE_STRINGS)) then
			return addon.S_WOE
		elseif (string_findm(msg, BOA_STRINGS)) then
			return addon.S_BOA
		end
	end
end

---@param tooltip GameTooltip
function addon:GetTooltipLines(tooltip)
	local textLines = {}
	local regions = { tooltip:GetRegions() }
	for _, r in ipairs(regions) do
		if r:IsObjectType("FontString") then
			table.insert(textLines, r:GetText())
		end
	end
	return textLines
end

---@param category string|nil
---@return boolean
function addon:CategoryEnabled(category)
	if (category == addon.S_BOA) then
		return addon.db.enableBoa
	elseif (category == addon.S_BOE) then
		return addon.db.enableBoe
	elseif (category == addon.S_WOE) then
		return addon.db.enableWoe
	end
	return false
end

---@param data ItemData
local function CategoryFilter(data)
	local quality = data.itemInfo.itemQuality
	local bindType = data.itemInfo.bindType
	local equippable = C_Item_IsEquippableItem(data.itemInfo.itemID)

	-- Only parse items that are Common (1) and above, and are of type BoP, BoE, and BoU
	local junk = quality ~= nil and quality == 0
	if (not junk or (bindType ~= nil and bindType > 0 and bindType < 4)) then
		local category = addon:GetItemCategory(data.bagid, data.slotid, data.itemInfo)
		if (category ~= nil and addon:CategoryEnabled(category)) then
			return L:G(category)
		end
	end

	return nil
end

-- Use this API to register a function that will be called for every item in the player's bags.
-- The function you provide will be given an ItemData table, which contains all properties of an item
-- loaded from the Blizzard API. From here, you can call any custom code you want to analyze the item.
-- Your function must return a string, which is the category name that the item should be placed in.
-- If your function returns nil, the item will not be placed in any category.
-- Results of this function, including nil, are cached, so you do not need to worry about performance
-- after the first scan.
Categories:RegisterCategoryFunction("BoEBoAItemsCategoryFilter", CategoryFilter)
