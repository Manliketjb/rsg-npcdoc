local RSGCore = exports['rsg-core']:GetCoreObject()
local doctors = {}
local blips = {}

local function modelrequest(model)
    Citizen.CreateThread(function()
        RequestModel(model)
    end)
end

local function GetTreatedDead()
	RSGCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] then
			RSGCore.Functions.Progressbar("progressbar", 'Getting Treated', Config.ProgressTime, false, false, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = true,
				disableCombat = true,
			}, {}, {}, {}, function()
				------ [[ Add custom revive or change event name to your medic revive event name ]] ------
				TriggerEvent('rsg-medic:clent:playerRevive')
				RSGCore.Functions.Notify('Healthy Again', 'success')
			end)
		else
			RSGCore.Functions.Notify('You don\'t need treatment', 'error')
		end
	end)
end

local function GetTreatedNormal()
	RSGCore.Functions.Progressbar("progressbar", 'Getting Treated', Config.ProgressTime, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = true,
		disableCombat = true,
	}, {}, {}, {}, function()
		------ [[ Add custom revive or change event name to your medic revive event name ]] ------
		TriggerEvent('rsg-medic:clent:playerRevive')
		RSGCore.Functions.Notify('Healthy Again', 'success')
	end)
end

RegisterNetEvent('rsg-npcdoc:client:startTreatmentCheck')
AddEventHandler('rsg-npcdoc:client:startTreatmentCheck', function()
	if Config.JobDutyCheck then
		RSGCore.Functions.TriggerCallback('rsg-medic:server:getmedics', function(mediccount)
			if mediccount < Config.MinMedics then
				if Config.OnlyDead then
					GetTreatedDead()
				else
					GetTreatedNormal()
				end
			else
				RSGCore.Functions.Notify('Too Many Medics Around', 'error')
			end 
		end)
	else
		if Config.OnlyDead then
			GetTreatedDead()
		else
			GetTreatedNormal()
		end
	end
end)

Citizen.CreateThread(function()
    for _, v in pairs(Config.Locations) do
        if v.showblip then
            blips = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blips, GetHashKey(Config.Blip.blipSprite), 1)
            SetBlipScale(blips, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, blips, Config.Blip.blipName)
        end
		if v.usePed then
			while not HasModelLoaded(GetHashKey(Config.Ped)) do
				Wait(500)
				modelrequest(GetHashKey(Config.Ped))
			end
			doctors = CreatePed(GetHashKey(Config.Ped), v.coords.x, v.coords.y, v.coords.z - 0.8, v.coords.w, true, false, 0, 0)
			while not DoesEntityExist(doctors) do
				Wait(300)
			end
			if not NetworkGetEntityIsNetworked(doctors) then
				NetworkRegisterEntityAsNetworked(doctors)
			end
			Citizen.InvokeNative(0x283978A15512B2FE, doctors, true) -- SetRandomOutfitVariation
		end

		exports['rsg-core']:createPrompt(v.prompt, vector3(v.coords.x,v.coords.y,v.coords.z), RSGCore.Shared.Keybinds['J'], 'Get Treated', {
			type = 'client',
            event = 'rsg-npcdoc:client:startTreatmentCheck',
			args = {},
		})
    end
end)

-- Cleanup
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
		for i = 1, #Config.Locations do
			exports['rsg-core']:deletePrompt(Config.Locations[i].prompt)
		end
	end
end)