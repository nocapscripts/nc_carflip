
print('NoCapScripts - Vehicle flip started')
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'NoCapScripts'
description 'NoCapScripts vehicle flip system'
version '2.0.0'


client_script 'client.lua'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',


    'lang/en.lua',
    'lang/*.lua'
}

files {
    'locales/et.json',
    'locales/en.json',
}

lua54 'yes'
