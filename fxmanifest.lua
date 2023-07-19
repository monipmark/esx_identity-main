fx_version 'adamant'

game 'gta5'

description 'ESX Identity'

version '0.1a'

author "create by alien city devloper"

server_scripts {
	'@es_extended/locale.lua',
	--'@oxmysql/lib/MySQL.lua', --if you use oxmysql
	--'@mongodb/lib/MongoDB.lua', -- if you use mongodb
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'locales/cs.lua',
	'locales/de.lua',
	'locales/th.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/cs.lua',
	'locales/de.lua',
	'locales/th.lua',
	'config.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css'
}

dependency 'es_extended'
