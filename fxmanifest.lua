
print('ReduX Scripts - Vehicle flip started')
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'ReduX Scripts'
description 'Redux Scripts vehicle flip system'
version '1.2.0'


client_script 'client.lua'

shared_scripts {
    '@rs_base/shared/locale.lua',
    '@rs_base/import.lua', -- Default '@qb-core/import.lua'
    '@ox_lib/init.lua'
}

lua54 'yes'
