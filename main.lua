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

-- Lua API
-----------------------------------------------------------
local _G = _G

-- WoW API
-----------------------------------------------------------
local CreateFrame = _G.CreateFrame

-- Default settings.
-----------------------------------------------------------
addon.db = {
	enableBoe = true,
	enableBoa = true,
	wipeOnLoad = true,
}

-- Addon Constants
-----------------------------------------------------------
addon.S_BOA = "BoA"
addon.S_BOE = "BoE"

-- Addon Core
addon.eventFrame = CreateFrame("Frame", addonName .. "EventFrame", UIParent)
addon.eventFrame:RegisterEvent("ADDON_LOADED")
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
				Categories:WipeCategory(L:G(addon.S_BOA))
				Categories:WipeCategory(L:G(addon.S_BOE))
			end
		end
	end
end)
