local RSGCore = exports['rsg-core']:GetCoreObject()

RSGCore.Functions.CreateCallback('rsg-medic:server:payFortreatment', function(source, cb, amount, type)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if type == 'any' then
        local cashpay = Player.Functions.RemoveMoney('cash', amount, 'Paid For Treatment')
        local bankpay = Player.Functions.RemoveMoney('bank', amount, 'Paid For Treatment')
        if cashpay then
            cb(true)
        elseif bankpay then
            cb(true)
        else
            cb(false)
        end
    else
        local pay = Player.Functions.RemoveMoney(type, amount, 'Paid For Treatment')
        if pay then
            cb(true) 
        else
            cb(false)
        end
    end
end)