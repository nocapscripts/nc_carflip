fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'KnownScripts'
description 'An carflipper'
version '1.0.0'


client_script 'client.lua'

shared_scripts {
    '@Framework/imports.lua',
    '@ox_lib/init.lua'
}

lua54 'yes'