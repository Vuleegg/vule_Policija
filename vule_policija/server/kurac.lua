ESX = exports['es_extended']:getSharedObject()
local registrujem = RegisterServerEvent 
local handlujem = AddEventHandler 
local zovemserver = TriggerEvent 
local zovemklijent = TriggerClientEvent 

TriggerEvent('esx_society:registerSociety', 'police', 'police', 'society_police', 'society_police', 'society_police', {type = 'public'})

function GetNajblizeVozilo(coords, modelFilter)
    return getClosestEntity(GetAllObjects(), coords, modelFilter)
end

RegisterNetEvent('gg:vezivanje')
AddEventHandler('gg:vezivanje', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xJob = xPlayer.job
    local drugijebeniigrac = ESX.GetPlayerFromId(target)
    local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

    if xJob and xJob.name == "police" then
        if drugijebeniigrac then 
            if udaljenost < 8.0 then
                if src ~= target then
                    return TriggerClientEvent('gg:vezivanjecl', target)
                end
            end
        end
    end
     DropPlayer(src, 'Cao citeru') 
end)

RegisterNetEvent('gg:vuci')
AddEventHandler('gg:vuci', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xJob = xPlayer.job
    local drugijebeniigrac = ESX.GetPlayerFromId(target)
    local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

    if xJob and xJob.name == "police" then
        if drugijebeniigrac then 
            if udaljenost < 8.0 then
                if src ~= target then
                    return TriggerClientEvent('gg:vuci', target, src)
                end
            end
        end
    end
     DropPlayer(src, 'Cao citeru') 
end)

RegisterNetEvent('gg:staviUVozilo')
AddEventHandler('gg:staviUVozilo', function(target)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and xJob.name == "police" then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if udaljenost < 8.0 then
				if src ~= target then
					TriggerClientEvent('gg:staviUVozilo', target)
					return
				end
			end
		end
	end

	DropPlayer(src, 'Zasto pokusavas da citujes. Nije lepo to :)')
	
end)

RegisterNetEvent('gg:staviVanVozila')
AddEventHandler('gg:staviVanVozila', function(target)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and xJob.name == "police" then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if udaljenost < 8.0 then
				if src ~= target then
					TriggerClientEvent('gg:staviVanVozila', target)
					return
				end
			end
		end
	end

	DropPlayer(src, 'Zasto pokusavas da citujes. Nije lepo to :)')

end)

local function getClosestEntity(entities, coords, modelFilter, isPed)
    local distance, closestEntity, closestCoords = maxDistance or 100, nil, nil
    coords = type(coords) == 'number' and GetEntityCoords(GetPlayerPed(coords)) or vector3(coords.x, coords.y, coords.z)

    for _, entity in pairs(entities) do
        if not isPed or (isPed and not IsPedAPlayer(entity)) then
            if not modelFilter or modelFilter[GetEntityModel(entity)] then
                local entityCoords = GetEntityCoords(entity)
                local dist = #(coords - entityCoords)
                if dist < distance then
                    closestEntity, distance, closestCoords = entity, dist, entityCoords
                end
            end
        end
    end
    return NetworkGetNetworkIdFromEntity(closestEntity), distance, closestCoords
end