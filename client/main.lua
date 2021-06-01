ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

local isCrafting = false

Citizen.CreateThread(function()

    while true do
    local letSleep = true
        Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local isClose = false

		    local craft_dist = GetDistanceBetweenCoords(playerCoords, Config.CraftingLocation.x, Config.CraftingLocation.y, Config.CraftingLocation.z, 1)

            if craft_dist <= 2.0 and not isCrafting then
                isClose = true
                if ESX.PlayerData.job.name == 'cartel' or ESX.PlayerData.job.name == 'mafia' or ESX.PlayerData.job.name == 'biker' then
                Draw3DText(Config.CraftingLocation.x, Config.CraftingLocation.y, Config.CraftingLocation.z, "[E] Crafting Menu")
                if IsControlJustReleased(0, 38) then
                    CraftingMenu()
                end
            end        
            if not isClose then
                Citizen.Wait(sleep)
            end
        end

    end
end)

-- RegisterCommand('testsxp', function(source, args, rawCommand)
--     TriggerEvent("rd-crafting:ledakan")
-- end)

------------ LEDAKAN
RegisterNetEvent("rd-crafting:ledakan")
AddEventHandler("rd-crafting:ledakan", function()
    local ledak = 1
    AddExplosion(Config.CraftingLocation.x, Config.CraftingLocation.y, Config.CraftingLocation.z, ledak, 1.12, true, false, 1.23)
end)

function CraftingMenu()
	local elements = {}
	for k,v in pairs(Config.ItemsCrafting) do
		table.insert(elements, {label = v.label, value = k})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_menu', {
        title    = 'Crafting Menu',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()
		CheckCrafting(data.current.value)
    end, function(data, menu)
        menu.close()
    end) 
end

function CheckCrafting(item)
	local elements = {
        { label = "Lihat Bahan", value = "lihat_bahan" },
        { label = "Craft Item", value = "craft_item" },
    }
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_info', {
        title    = Config.ItemsCrafting[item].label .. ' Crafting Information',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()

        if data.current.value == "lihat_bahan" then
			ViewRecipe(item)
        elseif data.current.value == "craft_item" then
			TriggerServerEvent('rd-crafting:checkCrafting', item)
        end

    end, function(data, menu)
        menu.close()
    end)  
end

function ViewRecipe(item)
	local elements = {}
	for k,v in pairs(Config.ItemsCrafting[item].requiredItems) do
		table.insert(elements, {label = v.amount ..'x ' ..v.item_label})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_recipe', {
        title    = Config.ItemsCrafting[item].label .. ' Bahan',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()
    end, function(data, menu)
        menu.close()
    end) 
end

RegisterNetEvent('rd-crafting:startCrafting')
AddEventHandler('rd-crafting:startCrafting', function(item)
	isCrafting = true
	StartCrafting(item)
end)

function StartCrafting(item)
	TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = Config.ItemsCrafting[item].craftingtime,
        label = "Crafting...",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mini@repair",
            anim = "fixing_a_ped",
            flags = 49,
        }
    }, function(status)
        if not status then
        end
        isCrafting = false
        TriggerServerEvent('rd-crafting:giveCraftedItem', item)
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 1.0)
    end)
end
