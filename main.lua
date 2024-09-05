---@type string
local addonName = ...
---@class ns
local addon = select(2, ...)

-- BetterBags namespace
-----------------------------------------------------------
---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")
assert(BetterBags, addonName .. " requires BetterBags")

---@class Categories: AceModule
local Categories = BetterBags:GetModule('Categories')

---@class Events: AceModule
local Events = BetterBags:GetModule('Events')

-- Use the L:G() function to get the localized string.
---@class Localization: AceModule
---@field G fun(self: AceModule, key: string): string
local L = BetterBags:GetModule('Localization')

---@class Context: AceModule
---@field New fun(self: AceModule, key: string): table
local context = BetterBags:GetModule('Context')

addon.ctx = context:New('Bound_Event')

-- Lua API
-----------------------------------------------------------
local _G = _G

-- WoW API
-----------------------------------------------------------
local CreateFrame = _G.CreateFrame

-- Default settings.
-----------------------------------------------------------
addon.db = {
	enableBop = false,
	enableWoe = true,
	enableBoe = true,
	enableBoa = true,
	onlyEquippable = true,
	wipeOnLoad = true,
}

-- Addon Constants
-----------------------------------------------------------
addon.S_BOA = "BoA"
addon.S_BOE = "BoE"
addon.S_WOE = "WoE"
addon.S_BOP = "Soulbound"

-- Addon Core
addon.eventFrame = CreateFrame("Frame", addonName .. "EventFrame", UIParent)
addon.eventFrame:RegisterEvent("ADDON_LOADED")
addon.eventFrame:RegisterEvent("EQUIP_BIND_CONFIRM")
addon.eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
addon.eventFrame:SetScript("OnEvent", function(_, event, ...)
	if event == "ADDON_LOADED" then
		local name = ...
		if name == addonName then
			addon.eventFrame:UnregisterEvent("ADDON_LOADED")
			if (type(BetterBags_Bound_SavedVars) ~= "table") then BetterBags_Bound_SavedVars = {} end
			local db = BetterBags_Bound_SavedVars
			for key in pairs(addon.db) do
				--  If our option is not present, set default value
				if (db[key] == nil) then db[key] = addon.db[key] end
			end
			-- Update our reference so that changed options are saved on logout
			addon.db = db
			-- Wipe categories on load.
			if (addon.db.wipeOnLoad) then
				Categories:WipeCategory(addon.ctx:Copy(), L:G(addon.S_BOA))
				Categories:WipeCategory(addon.ctx:Copy(), L:G(addon.S_BOE))
				Categories:WipeCategory(addon.ctx:Copy(), L:G(addon.S_WOE))
			end
		end
	elseif event == "EQUIP_BIND_CONFIRM" then
		local _, itemLocation = ...
		local bag, slot = itemLocation:GetBagAndSlot()
		local id = C_Item.GetItemID(itemLocation)
		local category = addon:GetItemCategory(bag, slot, nil)
		addon.bindConfirm = { id = id, category = category }
	elseif event == "PLAYER_EQUIPMENT_CHANGED" then
		local slot, hasCurrent = ...
		-- hasCurrent is false if the slot was just equipped
		if (slot ~= nil and not hasCurrent) then
			addon:RemoveBindConfirmFromCategory(slot)
		end
	end
end)
