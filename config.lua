---@class ns
local addon = select(2, ...)

-- BetterBags namespace
-----------------------------------------------------------
---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")

---@class Categories: AceModule
local Categories = BetterBags:GetModule('Categories')

---@class Localization: AceModule
local L = BetterBags:GetModule('Localization')

---@class Config: AceModule
local Config = BetterBags:GetModule('Config')

---@class Events: AceModule
local Events = BetterBags:GetModule('Events')

---@class Items: AceModule
local Items = BetterBags:GetModule('Items')

local options = {
	boundOptions = {
		type = "group",
		name = L:G("Boe & BoA"),
		order = 0,
		inline = true,
		args = {
			enableBoe = {
				type = "toggle",
				order = 0,
				name = L:G("Category: BoE"),
				desc = L:G("If enabled, will categorize BoE items."),
				get = function()
					return addon.db.enableBoe
				end,
				set = function(_, value)
					addon.db.enableBoe = value
					if (addon.db.enableBoe) then
						Categories:CreateCategory(L:G(addon.S_BOE))
						Categories:WipeCategory(L:G(addon.S_BOE))
					else
						Categories:WipeCategory(L:G(addon.S_BOE))
						Categories:DeleteCategory(L:G(addon.S_BOE))
					end
					Events:SendMessage('bags/FullRefreshAll')
				end,
			},
			enableWoe = {
				type = "toggle",
				order = 1,
				name = L:G("Category: WoE"),
				desc = L:G("If enabled, will categorize WoE items."),
				get = function()
					return addon.db.enableWoe
				end,
				set = function(_, value)
					addon.db.enableWoe = value
					if (addon.db.enableWoe) then
						Categories:CreateCategory(L:G(addon.S_WOE))
						Categories:WipeCategory(L:G(addon.S_WOE))
					else
						Categories:WipeCategory(L:G(addon.S_WOE))
						Categories:DeleteCategory(L:G(addon.S_WOE))
					end
					Events:SendMessage('bags/FullRefreshAll')
				end,
			},
			enableBoa = {
				type = "toggle",
				order = 2,
				name = L:G("Category: BoA"),
				desc = L:G("If enabled, will categorize BoA items."),
				get = function()
					return addon.db.enableBoa
				end,
				set = function(_, value)
					addon.db.enableBoa = value
					if (addon.db.enableBoa) then
						Categories:CreateCategory(L:G(addon.S_BOA))
						Categories:WipeCategory(L:G(addon.S_BOA))
					else
						Categories:WipeCategory(L:G(addon.S_BOA))
						Categories:DeleteCategory(L:G(addon.S_BOA))
					end
					Events:SendMessage('bags/FullRefreshAll')
				end,
			},
			onlyEquippable = {
				type = "toggle",
				width = "full",
				order = 3,
				name = L:G("Only Equippable"),
				desc = L:G("Only categorize equippable items. This prevents a multitude of items from being lumped into \"Warbound\". Requires a reload."),
				get = function()
					return addon.db.onlyEquippable
				end,
				set = function(_, value)
					addon.db.onlyEquippable = value
				end,
			},
			wipeOnLoad = {
				type = "toggle",
				width = "full",
				order = 4,
				name = L:G("Wipe Categories"),
				desc = L:G("Wipe categories on load. This prevent equipped items from being categorized as Bound still. Requires a reload."),
				get = function()
					return addon.db.wipeOnLoad
				end,
				set = function(_, value)
					addon.db.wipeOnLoad = value
				end,
			},
		}
	}
}

Config:AddPluginConfig(L:G("Bound"), options)
