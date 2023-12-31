--  _____/\\\\\\\\\_____/\\\______________/\\\\\\\\\\\__/\\\\\\\\\\\\\\\__/\\\\\_____/\\\_____/\\\\\\\\\\\__________/\\\\\\\\\____/\\\\\\\\\______/\\\\\\\\\\\__/\\\\\\\\\\\\\____/\\\\\\\\\\\\\\\_        
--   ___/\\\\\\\\\\\\\__\/\\\_____________\/////\\\///__\/\\\///////////__\/\\\\\\___\/\\\___/\\\/////////\\\_____/\\\////////___/\\\///////\\\___\/////\\\///__\/\\\/////////\\\_\///////\\\/////__       
--    __/\\\/////////\\\_\/\\\_________________\/\\\_____\/\\\_____________\/\\\/\\\__\/\\\__\//\\\______\///____/\\\/___________\/\\\_____\/\\\_______\/\\\_____\/\\\_______\/\\\_______\/\\\_______      
--     _\/\\\_______\/\\\_\/\\\_________________\/\\\_____\/\\\\\\\\\\\_____\/\\\//\\\_\/\\\___\////\\\__________/\\\_____________\/\\\\\\\\\\\/________\/\\\_____\/\\\\\\\\\\\\\/________\/\\\_______     
--      _\/\\\\\\\\\\\\\\\_\/\\\_________________\/\\\_____\/\\\///////______\/\\\\//\\\\/\\\______\////\\\______\/\\\_____________\/\\\//////\\\________\/\\\_____\/\\\/////////__________\/\\\_______    
--       _\/\\\/////////\\\_\/\\\_________________\/\\\_____\/\\\_____________\/\\\_\//\\\/\\\_________\////\\\___\//\\\____________\/\\\____\//\\\_______\/\\\_____\/\\\___________________\/\\\_______   
--        _\/\\\_______\/\\\_\/\\\_________________\/\\\_____\/\\\_____________\/\\\__\//\\\\\\__/\\\______\//\\\___\///\\\__________\/\\\_____\//\\\______\/\\\_____\/\\\___________________\/\\\_______  
--         _\/\\\_______\/\\\_\/\\\\\\\\\\\\\\\__/\\\\\\\\\\\_\/\\\\\\\\\\\\\\\_\/\\\___\//\\\\\_\///\\\\\\\\\\\/______\////\\\\\\\\\_\/\\\______\//\\\__/\\\\\\\\\\\_\/\\\___________________\/\\\_______ 
--          _\///________\///__\///////////////__\///////////__\///////////////__\///_____\/////____\///////////___________\/////////__\///________\///__\///////////__\///____________________\///________
-- discord : https://discord.gg/eH6fqtkn5d



ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source, callback)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].firstname ~= nil then
			local data = {
				identifier	= result[1].identifier,
				firstname	= result[1].firstname,
				lastname	= result[1].lastname,
				dateofbirth	= result[1].dateofbirth,
				sex			= result[1].sex,
				height		= result[1].height
			}

			callback(data)
		else
			local data = {
				identifier	= '',
				firstname	= '',
				lastname	= '',
				dateofbirth	= '',
				sex			= '',
				height		= ''
			}

			callback(data)
		end
	end)
end

function setIdentity(identifier, data, callback)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function updateIdentity(playerId, data, callback)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= xPlayer.identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			TriggerEvent('esx_identity:characterUpdated', playerId, data)
			callback(true)
		end
	end)
end

function deleteIdentity(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= xPlayer.identifier,
		['@firstname']		= '',
		['@lastname']		= '',
		['@dateofbirth']	= '',
		['@sex']			= '',
		['@height']			= '',
	})
end
function setIdentity(identifier, data, callback)
	MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier",
	{
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(done)
		if callback then
			callback(true)
		end
	end)

	MySQL.Async.execute(
	'INSERT INTO characters (identifier, firstname, lastname, dateofbirth, sex, height) VALUES (@identifier, @firstname, @lastname, @dateofbirth, @sex, @height)',
	{
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	})
end

function updateIdentity(identifier, data, callback)
	MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier",
	{
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(done)
		if callback then
			callback(true)
		end
	end)
end

function deleteIdentity(identifier, data, callback)
	MySQL.Async.execute("DELETE FROM `characters` WHERE identifier = @identifier AND firstname = @firstname AND lastname = @lastname AND dateofbirth = @dateofbirth AND sex = @sex AND height = @height",
	{
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(done)
		if callback then
			callback(true)
		end
	end)
end
RegisterServerEvent('esx_identity:setIdentity')
AddEventHandler('esx_identity:setIdentity', function(data, myIdentifiers)
	local xPlayer = ESX.GetPlayerFromId(source)
	setIdentity(myIdentifiers.steamid, data, function(callback)
		if callback then
			TriggerClientEvent('esx_identity:identityCheck', myIdentifiers.playerid, true)
			TriggerEvent('esx_identity:characterUpdated', myIdentifiers.playerid, data)
		else
			xPlayer.showNotification(_U('failed_identity'))
		end
	end)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	local myID = {
		steamid = xPlayer.identifier,
		playerid = playerId
	}

	TriggerClientEvent('esx_identity:saveID', playerId, myID)

	getIdentity(playerId, function(data)
		if data.firstname == '' then
			TriggerClientEvent('esx_identity:identityCheck', playerId, false)
			TriggerClientEvent('esx_identity:showRegisterIdentity', playerId)
		else
			TriggerClientEvent('esx_identity:identityCheck', playerId, true)
			TriggerEvent('esx_identity:characterUpdated', playerId, data)
		end
	end)
end)

AddEventHandler('esx_identity:characterUpdated', function(playerId, data)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		xPlayer.setName(('%s %s'):format(data.firstname, data.lastname))
		xPlayer.set('firstName', data.firstname)
		xPlayer.set('lastName', data.lastname)
		xPlayer.set('dateofbirth', data.dateofbirth)
		xPlayer.set('sex', data.sex)
		xPlayer.set('height', data.height)
	end
end)

RegisterServerEvent('esx_identity:addItem')
AddEventHandler('esx_identity:addItem', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    
        if Config.ItemStart ~= nil then
            for k,v in pairs(Config.ItemStart) do
                if math.random(0, 100) <= v.Percent then
                    xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
                end
            end
        end
end)

Citizen.CreateThread(function()
	PerformHttpRequest("https://ipinfo.io/json", function(err, text, headers)
	local Original = "esx_identity"   
	local Script = ''..GetCurrentResourceName()..''
	local UserName = "Bast"
	local Version  = "3.0"
	local webhooks = ""
	local connect = {
		{
			["color"] = "3669760",
			["description"] = ' **esx_identity :** starting',   
			['footer'] = { 
				['text'] = '🕚เวลา : '..os.date('%X')..'  ชื่อสคริปต์ปัจจุบัน : '..Script..'',
			},
		}
	}

		PerformHttpRequest(webhooks, function(err, text, headers) end, 'POST', json.encode({username = "esx_identity", embeds = connect}), { ['Content-Type'] = 'application/json' })
	end)
end)

-- Set all the client side variables for connected users one new time
AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(3000)
		print ("CREATE BY ALIEN SRCIPT THIS IS FREE SRCIPT FOR SERVER!!! THX FOR DOWNLOAD")
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer then
				local myID = {
					steamid  = xPlayer.identifier,
					playerid = xPlayer.source
				}
	
				TriggerClientEvent('esx_identity:saveID', xPlayer.source, myID)
	
				getIdentity(xPlayer.source, function(data)
					if data.firstname == '' then
						TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, false)
						TriggerClientEvent('esx_identity:showRegisterIdentity', xPlayer.source)
					else
						TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, true)
						TriggerEvent('esx_identity:characterUpdated', xPlayer.source, data)
					end
				end)
			end
		end
	end
end)

ESX.RegisterCommand('register', 'user', function(xPlayer, args, showError)
	getIdentity(xPlayer.source, function(data)
		if data.firstname ~= '' then
			xPlayer.showNotification(_U('already_registered'))
		else
			TriggerClientEvent('esx_identity:showRegisterIdentity', xPlayer.source)
		end
	end)
end, false, {help = _U('show_registration')})

ESX.RegisterCommand('char', 'user', function(xPlayer, args, showError)
	getIdentity(xPlayer.source, function(data)
		if data.firstname == '' then
			xPlayer.showNotification(_U('not_registered'))
		else
			xPlayer.showNotification(_U('active_character', data.firstname, data.lastname))
		end
	end)
end, false, {help = _U('show_active_character')})

ESX.RegisterCommand('chardel', 'user', function(xPlayer, args, showError)
	getIdentity(xPlayer.source, function(data)
		if data.firstname == '' then
			xPlayer.showNotification(_U('not_registered'))
		else
			deleteIdentity(xPlayer.source)
			xPlayer.showNotification(_U('deleted_character'))
			TriggerClientEvent('esx_identity:showRegisterIdentity', xPlayer.source)
		end
	end)
end, false, {help = _U('delete_character')})
