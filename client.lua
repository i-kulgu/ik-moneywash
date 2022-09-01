local QBCore = exports['qb-core']:GetCoreObject()
local pedman
local bagspawned
local bagModel = "prop_ld_case_01"
local baganimDict = "missheistdocksprep1hold_cellphone"
local baganimName = "hold_cellphone"

Citizen.CreateThread(function()
	RequestModel(GetHashKey(bagModel))
	while not HasModelLoaded(GetHashKey(bagModel)) do
		Citizen.Wait(100)
	end
	while not HasAnimDictLoaded(baganimDict) do
		RequestAnimDict(baganimDict)
		Citizen.Wait(100)
	end
	QBCore.Functions.TriggerCallback('ik-moneywash:server:pedcoords', function(pedloc)
		RequestModel(Config.pedmodel) while not HasModelLoaded(Config.pedmodel) do Citizen.Wait(1) end
		pedman = CreatePed(0, Config.pedmodel , pedloc.x, pedloc.y, pedloc.z, pedloc.w, false, false)
		SetEntityInvincible(pedman, true)
		bagspawned = CreateObject(GetHashKey(bagModel), pedloc.x +2, pedloc.y+2, pedloc.z, 1, 1, 1)
		Citizen.Wait(1000)
        local netid = ObjToNet(bagspawned)
		SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(bagspawned, pedman, GetPedBoneIndex(pedman, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
        TaskPlayAnim(pedman, 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(pedman, baganimDict, baganimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
		SetBlockingOfNonTemporaryEvents(pedman, true)
		FreezeEntityPosition(pedman, true)
		SetEntityNoCollisionEntity(pedman, PlayerPedId(), false)

		if Config.OpenWithItem then
			exports['qb-target']:AddCircleZone("WashingPed", vector3(pedloc.x, pedloc.y, pedloc.z), 2.0, { name="WashingPed", debugPoly=false, useZ=true, },{ options = { { event = "ik-moneywash:client:ShowMenu", icon = "fas fa-certificate", label = "Open Menu", item = Config.ItemName}, }, distance = 2.0 })
		else
			exports['qb-target']:AddCircleZone("WashingPed", vector3(pedloc.x, pedloc.y, pedloc.z), 2.0, { name="WashingPed", debugPoly=false, useZ=true, },{ options = { { event = "ik-moneywash:client:ShowMenu", icon = "fas fa-certificate", label = "Open Menu"}, }, distance = 2.0 })
		end
	end)
end)

RegisterNetEvent("ik-moneywash:client:ShowMenu", function()
    local MoneyMenu = {}
    MoneyMenu[#MoneyMenu+1] = { header = "Washing Menu", txt = "", isMenuHeader = true }
    MoneyMenu[#MoneyMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = "Close", params = { event = "ik-moneywash:client:Menu:Close" } }

    MoneyMenu[#MoneyMenu+1] = { header = "Wash Black Money", txt = "Wash black money and receive legal money" ,params = { event = "ik-moneywash:client:WashInput",}}

    exports['qb-menu']:openMenu(MoneyMenu)
end)

RegisterNetEvent("ik-moneywash:client:WashInput", function()
    local header = "<center><p><img src=nui://"..Config.img..QBCore.Shared.Items[Config.BlackMoneyName].image.." width=100px></p>"..QBCore.Shared.Items[Config.BlackMoneyName].label
	local settext = "- How much ? -"
	local NewInput = {}
	NewInput[#NewInput+1] = { type = 'number', isRequired = true, name = 'amount', text = settext }
	local dialog = exports['qb-input']:ShowInput({ header = header, submitText = "Change", inputs = NewInput })
	if dialog then
		if tonumber(dialog.amount) >= 0 then
			TriggerServerEvent("ik-moneywash:server:sellthem", dialog.amount)
		else
			QBCore.Functions.Notify("Value must be higher then 0", "error")
		end
	end
end)

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	DeletePed(pedman)
	DeleteObject(bagspawned)
end)