Config = {}

Config.CraftingLocation = vector3(568.24, -3127.07, 18.77)

Config.ItemsCrafting = {
	['clip'] = {
		label = '	Clip',
		isWeapon = false,
		SuccessRate = 5,
		craftingtime = 10000,
		requiredItems = {
			{ item = "iron", item_label = "Besi", amount = 5 },
			{ item = "gold", item_label = "Emas", amount = 10 },
		}
	},
	['bulletproof'] = {
		label = 'Armour',
		isWeapon = false,
		SuccessRate = 20,
		craftingtime = 10000,
		requiredItems = {
			{ item = "iron", item_label = "Besi", amount = 10 },
			{ item = "gold", item_label = "Emas", amount = 15 },
		}
	},
	['weapon_revolver_mk2'] = {
		label = 'Python',
		isWeapon = true,
		SuccessRate = 20,
		craftingtime = 5000,
		requiredItems = {
			{ item = "iron", item_label = "Besi", amount = 10 },
			{ item = "gold", item_label = "Emas", amount = 15 },
		}
	},
	['weapon_pistol50'] = {
		label = 'Pistol 50',
		isWeapon = true,
		SuccessRate = 1,
		craftingtime = 5000,
		requiredItems = {
			{ item = "iron", item_label = "Besi", amount = 10 },
			{ item = "gold", item_label = "Emas", amount = 15 },
		}
	},
	['weapon_smg'] = {
		label = 'SMG',
		isWeapon = true,
		SuccessRate = 1,
		craftingtime = 5000,
		requiredItems = {
			{ item = "iron", item_label = "Besi", amount = 10 },
			{ item = "gold", item_label = "Emas", amount = 15 },
		}
	},
	['lockpick'] = {
		label = 'Lockpick',
		isWeapon = false,
		SuccessRate = 1,
		craftingtime = 5000,
		requiredItems = {
			{ item = "iron", item_label = "Besi", amount = 5 },
			{ item = "gold", item_label = "Emas", amount = 5 },
		}
	},
}