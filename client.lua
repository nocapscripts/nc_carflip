local Core = nil -- NOT NEEDED ??
local framework = "NONE"
local cfg = lib.require('config')
local minDuration = cfg.minDuration
local maxDuration = cfg.maxDuration
lib.locale(cfg.locale) -- LANG


function DebugPrint(message)
    print("^2[nc_carflip]^0 " .. message)
end

CreateThread(function()
    Wait(5)
    if cfg.core == 'qb-core' then
        if GetResourceState(cfg.QBFramework) == 'starting' or GetResourceState(cfg.QBFramework) == 'started' then
            framework = "QB"
        end
    elseif cfg.core == 'es_extended' then
        if GetResourceState(cfg.ESXCoreName) == 'starting' or GetResourceState(cfg.ESXCoreName) == 'started' then
            framework = "ESX"
        end
    elseif cfg.core == 'ncfw' then
        if GetResourceState(cfg.NCFWCoreName) == 'starting' or GetResourceState(cfg.NCFWCoreName) == 'started' then
            framework = "NCFW"
        end
    end
end)



CreateThread(function()
    Wait(5)

    if framework == "QB" then -- FOR QB FRAMEWORK
        local Core = exports[cfg.QBFramework]:GetCoreObject()


        --Fliperiino event
        RegisterNetEvent('nc_carflip:flipcar')
        AddEventHandler('nc_carflip:flipcar', function()
            DebugPrint("Fliping vehicle!")
            return FlipCarOver()
        end)




        -- Fliperiino function
        function FlipCarOver()
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped)

            local VehicleData = Core.Functions.GetClosestVehicle()

            local finalDur = math.random(minDuration, maxDuration)

            local dist = #(pedcoords - GetEntityCoords(VehicleData))
            local success = lib.skillCheck(
                { 'easy', 'easy', { areaSize = cfg.areaSize, speedMultiplier = cfg.speedMultiplier }, 'easy' },
                { 'x', 'x', 'x', 'x' })


            if dist <= 3 and IsVehicleOnAllWheels(VehicleData) == false then
                if success then
                    RequestAnimDict('missfinale_c2ig_11')
                    while not HasAnimDictLoaded("missfinale_c2ig_11") do
                        Wait(10)
                    end
                    lib.progressCircle({
                        label = locale('notify.fliping'),
                        duration = finalDur,
                        position = cfg.position,
                        useWhileDead = cfg.useWhileDead,
                        canCancel = cfg.canCancel,
                        disable = {
                            car = cfg.disable,
                        },
                        anim = {
                            dict = 'missfinale_c2ig_11',
                            clip = 'pushcar_offcliff_m'
                        },
                    })

                    local carCoords = GetEntityRotation(VehicleData, 2)
                    SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
                    SetVehicleOnGroundProperly(VehicleData)
                    lib.notify({
                        id = '1',
                        title = locale('notify.title'),
                        description = locale('notify.desc'),
                        position = cfg.position,
                        style = {
                            backgroundColor = '#243661',
                            color = '#909296'
                        },
                        icon = 'car',
                        iconColor = '#C53030'
                    })
                    ClearPedTasks(ped)
                end
            elseif IsVehicleOnAllWheels(VehicleData) ~= false then
                lib.notify({
                    id = '1',
                    title = locale('notify.title'),
                    description = locale('notify.fail'),
                    position = cfg.position,
                    style = {
                        backgroundColor = '#243661',
                        color = '#D2D2D2'
                    },
                    icon = 'warning',
                    iconColor = '#C53030'
                })
            end
        end
    elseif framework == "ESX" then -- FOR ESX FRAMEWORK
        local Core = exports[cfg.ESXCoreName]:getSharedObject()
        local PlayerData, PlayerJob = {}, {}, {}

        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
            PlayerData = xPlayer
            PlayerJob = xPlayer.job
        end)


        --Fliperiino event
        RegisterNetEvent('nc_carflip:flipcar')
        AddEventHandler('nc_carflip:flipcar', function()
            DebugPrint("Fliping vehicle!")

            return FlipCarOver()
        end)




        -- Fliperiino function can be better
        function FlipCarOver()
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped)

            local VehicleData = Core.Game.GetClosestVehicle()
            print(json.encode(VehicleData))

            local finalDur = math.random(minDuration, maxDuration)

            local dist = #(pedcoords - GetEntityCoords(VehicleData))
            local success = lib.skillCheck(
                { 'easy', 'easy', { areaSize = cfg.areaSize, speedMultiplier = cfg.speedMultiplier }, 'hard' },
                { 'x', 'x', 'x', 'x' })


            if dist <= 3 and IsVehicleOnAllWheels(VehicleData) == false then
                if success then
                    RequestAnimDict('missfinale_c2ig_11')
                    while not HasAnimDictLoaded("missfinale_c2ig_11") do
                        Wait(10)
                    end
                    lib.progressCircle({
                        label = locale('notify.fliping'),
                        duration = finalDur,
                        position = cfg.position,
                        useWhileDead = cfg.useWhileDead,
                        canCancel = cfg.canCancel,
                        disable = {
                            car = cfg.disable,
                        },
                        anim = {
                            dict = 'missfinale_c2ig_11',
                            clip = 'pushcar_offcliff_m'
                        },
                    })

                    local carCoords = GetEntityRotation(VehicleData, 2)
                    SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
                    SetVehicleOnGroundProperly(VehicleData)
                    lib.notify({
                        id = '1',
                        title = locale('notify.title'),
                        description = locale('notify.desc'),
                        position = cfg.position,
                        style = {
                            backgroundColor = '#243661',
                            color = '#909296'
                        },
                        icon = 'car',
                        iconColor = '#C53030'
                    })
                    ClearPedTasks(ped)
                end
            elseif IsVehicleOnAllWheels(VehicleData) ~= false then
                lib.notify({
                    id = '1',
                    title = locale('notify.title'),
                    description = locale('notify.fail'),
                    position = cfg.position,
                    style = {
                        backgroundColor = '#243661',
                        color = '#D2D2D2'
                    },
                    icon = 'warning',
                    iconColor = '#C53030'
                })
            end
        end
    elseif framework == "NCFW" then
        local Core = exports[cfg.NCFWCoreName]:getSharedObject()
        local PlayerData, PlayerJob, PlayerGang = {}, {}, {}

        RegisterNetEvent('nc:playerLoaded')
        AddEventHandler('nc:playerLoaded', function(xPlayer, isNew, skin)
            PlayerData = xPlayer
            PlayerJob = xPlayer.job
            PlayerGang = xPlayer.gang
        end)


        --Fliperiino event
        RegisterNetEvent('nc_carflip:flipcar')
        AddEventHandler('nc_carflip:flipcar', function()
            DebugPrint("Fliping vehicle!")

            return FlipCarOver()
        end)




        -- Fliperiino function
        function FlipCarOver()
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped)

            local VehicleData = Core.Game.GetClosestVehicle()
            print(json.encode(VehicleData))

            local finalDur = math.random(minDuration, maxDuration)

            local dist = #(pedcoords - GetEntityCoords(VehicleData))
            local success = lib.skillCheck(
                { 'easy', 'easy', { areaSize = cfg.areaSize, speedMultiplier = cfg.speedMultiplier }, 'hard' },
                { 'x', 'x', 'x', 'x' })


            if dist <= 3 and IsVehicleOnAllWheels(VehicleData) == false then
                if success then
                    RequestAnimDict('missfinale_c2ig_11')
                    while not HasAnimDictLoaded("missfinale_c2ig_11") do
                        Wait(10)
                    end
                    lib.progressCircle({
                        label = locale('notify.fliping'),
                        duration = finalDur,
                        position = cfg.position,
                        useWhileDead = cfg.useWhileDead,
                        canCancel = cfg.canCancel,
                        disable = {
                            car = cfg.disable,
                        },
                        anim = {
                            dict = 'missfinale_c2ig_11',
                            clip = 'pushcar_offcliff_m'
                        },
                    })

                    local carCoords = GetEntityRotation(VehicleData, 2)
                    SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
                    SetVehicleOnGroundProperly(VehicleData)
                    lib.notify({
                        id = '1',
                        title = locale('notify.title'),
                        description = locale('notify.desc'),
                        position = cfg.position,
                        style = {
                            backgroundColor = '#243661',
                            color = '#909296'
                        },
                        icon = 'car',
                        iconColor = '#C53030'
                    })
                    ClearPedTasks(ped)
                end
            elseif IsVehicleOnAllWheels(VehicleData) ~= false then
                lib.notify({
                    id = '1',
                    title = locale('notify.title'),
                    description = locale('notify.fail'),
                    position = cfg.position,
                    style = {
                        backgroundColor = '#243661',
                        color = '#D2D2D2'
                    },
                    icon = 'warning',
                    iconColor = '#C53030'
                })
            end
        end
    end
end)
