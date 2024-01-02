fx_version 'cerulean'
game "gta5"

lua54 'yes'

author "Proportions#8460"
description "Money washing script"
version "v1.2"

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua',
    'locales/*.lua',
}
client_script 'client.lua'
server_script 'server.lua'
