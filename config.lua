return {
    locale = 'en',

    core = 'es_extended', -- choose core between 'qb-core' and 'es_extended' or 'ncfw'

    QBFramework = 'qb-core', -- custom resource exports name
    ESXCoreName = 'es_extended', -- custom resource exports name default: 'es_extended'
    NCFWCoreName = 'ncfw', -- custom resource exports name default: 'es_extended'

    -- OX SETTINGS

    position = 'bottom', -- ui position
    minDuration = 5000, -- minimum duration in milliseconds
    maxDuration = 10000, -- maximum duration in milliseconds
    canCancel = false, -- whether the notification can be cancelled
    useWhileDead = false, -- whether the notification can be used while dead
    disable = true, -- whether the notification is disabled
    areaSize = 30, -- area size in pixels
    speedMultiplier = 1, -- speed multiplier for skills
}
