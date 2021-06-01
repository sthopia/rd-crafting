ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rd-crafting:checkCrafting')
AddEventHandler('rd-crafting:checkCrafting', function(itemId)
	local rendy = source
	local xPlayer = ESX.GetPlayerFromId(rendy)
	local getPlayerInv = xPlayer.getInventoryItem()
	local requiredItems = Config.ItemsCrafting[itemId].requiredItems
	local canCraft = false
	
	for k,v in pairs(requiredItems) do
		if xPlayer.getInventoryItem(v.item).count >= v.amount then
			canCraft = true
		else
			canCraft = false
			break
		end
	end
	
		if canCraft then
			TriggerClientEvent('rd-crafting:startCrafting', xPlayer.source, itemId)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Kamu Tidak Memiliki Bahan Yang Mencukupi.', length = 5000 })
		end
end)

RegisterServerEvent('rd-crafting:giveCraftedItem')
AddEventHandler('rd-crafting:giveCraftedItem', function(itemId, type)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local requiredItems = Config.ItemsCrafting[itemId].requiredItems
	for k,v in pairs(requiredItems) do
		xPlayer.removeInventoryItem(v.item, v.amount)
	end

	if Config.ItemsCrafting[itemId].SuccessRate > math.random(0, Config.ItemsCrafting[itemId].SuccessRate) then
		if Config.ItemsCrafting[itemId].isWeapon then
			xPlayer.addWeapon(itemId, 0)
		else
			xPlayer.addInventoryItem(itemId, 1)
		end
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "Kamu Berhasil Mengcrafting ", length = 5000 })
	else
		TriggerClientEvent("rd-crafting:ledakan", xPlayer.source)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Kamu Gagal Mengcrafting', length = 5000 })
	end
end)