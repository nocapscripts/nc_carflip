
print('NoCapScripts - Vehicle flip started')
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'NoCapScripts'
description 'NoCapScripts vehicle flip system'
version '1.2.0'


client_script 'client.lua'

shared_scripts {
    'shared/config.lua',
    '@ox_lib/init.lua',


    'lang/en.lua',
    'lang/*.lua'
}

files {
    'locales/*.json',
}

lua54 'yes'
