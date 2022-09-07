local QBCore = exports['qb-core']:GetCoreObject()

-- ########## Ped Coordinates ########## --

local hiddenped = {["coords"] = {
    [1] = vector4(145.1, 311.59, 111.14, 122.84)
    -- [1] = vector4(139.12, 324.15, 111.14, 113.1),
    -- [2] = vector4(145.1, 311.59, 111.14, 122.84)
}}

-- ########## Functions ########## --

local function getMarkedBillWorth()
    local Player = QBCore.Functions.GetPlayer(source)
    local markedbilltotal = 0
    for k, v in pairs(Player.PlayerData.items) do
        if v.name == "markedbills" then
            markedbilltotal = markedbilltotal + (v.info.worth * v.amount)
            Player.Functions.RemoveItem("markedbills", v.amount, false)
        end
    end
    info = {
        worth = markedbilltotal
    }
    Player.Functions.AddItem("markedbills", 1 , false ,info)
    return markedbilltotal
end

local function WashMarkedBills(balance, price)
    local Player = QBCore.Functions.GetPlayer(source)
    local newworth = balance - price
    local netprice = math.floor(price * Config.Percentage)
    if newworth > 0 then
        info = {
            worth = newworth
        }
        Player.Functions.RemoveItem("markedbills", 1, false)
        Player.Functions.AddItem("markedbills", 1 , false ,info)

        Player.Functions.AddMoney("cash",netprice)
        TriggerClientEvent('QBCore:Notify', source, "Washed $"..price.." black money and got $"..netprice.." back!")
    else
        Player.Functions.RemoveItem("markedbills", 1, false)
        Player.Functions.AddMoney("cash",netprice)
    end
end

-- ########## Callbacks ########## --

QBCore.Functions.CreateCallback('ik-moneywash:server:pedcoords', function(source, cb)
    local r = math.random(1,#hiddenped["coords"])
    for _,v in pairs(hiddenped) do
        pedloc = v[r]
    end
    cb(pedloc)
end)

-- ########## Events ########## --

RegisterNetEvent("ik-moneywash:server:sellthem",function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    local TotalAmount = tonumber(amount)
    if Config.BlackMoneyName == "markedbills" then
        Balance = getMarkedBillWorth()
    else
        Balance = Player.Functions.GetItemByName(Config.BlackMoneyName).amount
    end
    if Balance >= TotalAmount then
        if Config.BlackMoneyName == "markedbills" then
            WashMarkedBills(Balance,TotalAmount)
        else
			local netprice = math.floor(amount * Config.Percentage)
            if Player.Functions.RemoveItem(Config.BlackMoneyName, TotalAmount) then
                Player.Functions.AddMoney("cash",netprice)
                TriggerClientEvent('QBCore:Notify', source, "Washed $"..amount.." black money and got $"..netprice.." back!")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have that much blackmoney on you!", 'error')
    end
end)
