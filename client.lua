
RegisterNetEvent('ks-carflip:flipcar')
AddEventHandler('ks-carflip:flipcar', function()
    FlipCarOver()
end)





function FlipCarOver()
    local ped = PlayerPedId()
    local pedcoords = GetEntityCoords(ped)

    VehicleData = QBCore.Functions.GetClosestVehicle()
    
    local dist = #(pedcoords - GetEntityCoords(VehicleData))
    local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'hard'}, {'x', 'x', 'x', 'x'})
    

    if dist <= 3  and IsVehicleOnAllWheels(VehicleData) == false then
        if success then
            
            RequestAnimDict('missfinale_c2ig_11')
            while not HasAnimDictLoaded("missfinale_c2ig_11") do
                Wait(10)
            end
            lib.progressCircle({
                duration = 10000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                },
                anim = {
                    dict = 'missfinale_c2ig_11',
                    clip = 'pushcar_offcliff_m'
                },
            })
            --TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            --Wait(10000)
            
            local carCoords = GetEntityRotation(VehicleData, 2)
            SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
            SetVehicleOnGroundProperly(VehicleData)
            lib.notify({
                id = '1',
                title = 'CarFlip',
                description = 'Auto taastatud',
                position = 'bottom',
                style = {
                    backgroundColor = '#141517',
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
            title = 'CarFlip',
            description = 'Auto taastamine ebaõnnestus või teie auto pole ebakorrektses asendis',
            position = 'bottom',
            style = {
                backgroundColor = '#141517',
                color = '#909296'
            },
            icon = 'warning',
            iconColor = '#C53030'
        })
        
    end
end





