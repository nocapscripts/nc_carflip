# NoCapScripts Vehicle Flip System

Vehicle flipover script for QBCore and ESX


# Depedencies

* ox_lib


# Add qb-target function under Config.TargetBones in init.lua file
```
 {
    type = "client",
    event = "nc_carflip:flipcar",
    icon = "fas fa-car",
    label = "Flip Vehicle",
 },
```

# Add ox_target function under ox_target/client/defaults.lua file 

```
 {
        name = 'ox_target:flipcar',
        icon = 'fa-solid fa-car-flip',
        event = 'nc_carflip:flipcar',
        label = "Flip car",
        offset = vec3(0.5, 0, 0.5),
        distance = 2,
        canInteract = function(entity, distance, coords, name)
            return canInteractWithDoor(entity, coords, 5, true)
        end,
        onSelect = function(data)
            TriggerEvent('nc_carflip:flipcar')
        end
    },
```
