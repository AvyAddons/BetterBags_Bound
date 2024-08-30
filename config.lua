---@class ns
local addon = select(2, ...)

-- BetterBags namespace
-----------------------------------------------------------
---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")

---@class Categories: AceModule
---@field CreateCategory fun(self: Categories, category: CustomCategoryFilter): nil
---@field DeleteCategory fun(self: Categories, name: string): nil
---@field WipeCategory fun(self: Categories, name: string): nil
---@field ReprocessAllItems fun(self: Categories): nil
local Categories = BetterBags:GetModule('Categories')

---@class Localization: AceModule
local L = BetterBags:GetModule('Localization')

---@class Config: AceModule
---@field AddPluginConfig fun(self: Config, name: string, options: AceConfig.OptionsTable): nil
local Config = BetterBags:GetModule('Config')

---@class Events: AceModule
---@field SendMessage fun(self: Events, message: string, ...: any): nil
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
						Categories:CreateCategory({
							name = L:G(addon.S_BOE),
							itemList = {},
							save = false,
						})
						Categories:ReprocessAllItems()
					else
						Categories:DeleteCategory(L:G(addon.S_BOE))
					end
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
						Categories:CreateCategory({
							name = L:G(addon.S_WOE),
							itemList = {},
							save = false,
						})
						Categories:ReprocessAllItems()
					else
						Categories:DeleteCategory(L:G(addon.S_WOE))
					end
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
						Categories:CreateCategory({
							name = L:G(addon.S_BOA),
							itemList = {},
							save = false,
						})
						Categories:ReprocessAllItems()
					else
						Categories:DeleteCategory(L:G(addon.S_BOA))
					end
				end,
			},
			enableBop = {
				type= "toggle",
				order = 3,
				name = L:G("Category: Soulbound"),
				desc = L:G("If enabled, will categorize BoP items."),
				get = function()
					return addon.db.enableBop
				end,
				set = function(_, value)
					addon.db.enableBop = value
					if (addon.db.enableBop) then
						Categories:CreateCategory({
							name = L:G(addon.S_BOP),
							itemList = {},
							save = true,
						})
						Categories:ReprocessAllItems()
					else
						Categories:DeleteCategory(L:G(addon.S_BOP))
					end
				end,
			},
			onlyEquippable = {
				type = "toggle",
				width = "full",
				order = 10,
				name = L:G("Only Equippable"),
				desc = L:G("Only categorize equippable items. This prevents a multitude of items from being lumped into \"Warbound\"."),
				get = function()
					return addon.db.onlyEquippable
				end,
				set = function(_, value)
					addon.db.onlyEquippable = value
					if (addon.db.onlyEquippable) then
						Categories:WipeCategory(L:G(addon.S_BOA))
						Categories:WipeCategory(L:G(addon.S_BOE))
						Categories:WipeCategory(L:G(addon.S_WOE))
						Categories:ReprocessAllItems()
					end
				end,
			},
			wipeOnLoad = {
				type = "toggle",
				width = "full",
				order = 20,
				name = L:G("Wipe Categories"),
				desc = L:G("Wipe categories on load. This prevent equipped items from being categorized as Bound still. Only affects the next reload/login."),
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
