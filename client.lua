local Core = nil
local framework = nil
lib.locale()

CreateThread(function()
    Wait(5)
    if GetResourceState(Config.ESXCoreName) == 'starting' or GetResourceState(Config.ESXCoreName) == 'started' then 
     framework = "ESX"
    end
 
    if GetResourceState(Config.QBFramework) == 'starting' or GetResourceState(Config.QBFramework) == 'started' then 
     framework = "QB"
    end
 
 
end)



CreateThread(function()
    Wait(5)

    if framework == "QB" then


        local Core = exports[Config.QBFramework]:GetCoreObject()


        --Fliperiino event
        RegisterNetEvent('nc_carflip:flipcar')
        AddEventHandler('nc_carflip:flipcar', function()
            print("Fliping vehicle!")
            return FlipCarOver()
        end)




        -- Fliperiino function
        function FlipCarOver()
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped)

            local VehicleData = Core.Functions.GetClosestVehicle()

            local finalDur = math.random(minDuration, maxDuration)
            
            local dist = #(pedcoords - GetEntityCoords(VehicleData))
            local success = lib.skillCheck({'easy', 'easy', {areaSize = Config.areaSize, speedMultiplier = Config.speedMultiplier}, 'hard'}, {'x', 'x', 'x', 'x'})
            

            if dist <= 3  and IsVehicleOnAllWheels(VehicleData) == false then
                if success then
                    
                    RequestAnimDict('missfinale_c2ig_11')
                    while not HasAnimDictLoaded("missfinale_c2ig_11") do
                        Wait(10)
                    end
                    lib.progressCircle({
                        label = locale('notify.fliping'),
                        duration = finalDur,
                        position = Config.position,
                        useWhileDead = Config.useWhileDead,
                        canCancel = Config.canCancel,
                        disable = {
                            car = Config.disable,
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
                        position = Config.position,
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
                    position = Config.position,
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





