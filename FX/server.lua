--==--==--==--==--==--==--==--==--==--
--==================================--
--            Model Menu            --
--==================================--
--               v2.7               --
--==================================--
--            By Frazzle.           --
--==================================--
--==--==--==--==--==--==--==--==--==--

RegisterServerEvent("mm:spawn")
AddEventHandler("mm:spawn", function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(sourcePlayer)
	MySQL.Async.fetchAll("SELECT * FROM modelmenu WHERE identifier = @identifier", { ['@identifier'] = identifier}, function (result)
		if(not result[1]) then
			MySQL.Async.execute("INSERT INTO modelmenu (`identifier`) VALUES (@identifier)", { ['@identifier'] = identifier})
			--local model = getmodels(identifier)
			--TriggerClientEvent("mm:changempmodelspawn", sourcePlayer, model)
			TriggerClientEvent("mm:firstspawn", sourcePlayer)
		else
			local model = getmodels(identifier)
			if model == "mp_m_freemode_01" or model == "mp_f_freemode_01" then
				TriggerClientEvent("mm:changempmodelspawn", sourcePlayer, model)
			else
				TriggerClientEvent("mm:changemodelspawn", sourcePlayer, model)
			end
		end
	end)
end)

RegisterServerEvent("mm:otherspawn")
AddEventHandler("mm:otherspawn", function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(sourcePlayer)
	local model = getmodels(identifier)
	if model == "mp_m_freemode_01" or model == "mp_f_freemode_01" then
		TriggerClientEvent("mm:changempmodelspawn", sourcePlayer, model)
	else
		TriggerClientEvent("mm:changemodelspawn", sourcePlayer, model)
	end
end)

RegisterServerEvent("mm:checkCustomisation")
AddEventHandler("mm:checkCustomisation", function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(sourcePlayer)
	local mpmodel = getModelIsMP(identifier)
	if(mpmodel == 0) then
		TriggerClientEvent("mm:Customisationisanonono", sourcePlayer)
	else
		TriggerClientEvent("mm:Customisationisagogogo", sourcePlayer)
	end
end)

RegisterServerEvent("mm:spawn2")
AddEventHandler("mm:spawn2", function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(sourcePlayer)
	MySQL.Async.fetchAll("SELECT * FROM modelmenu WHERE identifier =@name", {['@name'] = identifier}, function (result)
		local user = {
        	hair = result[1].hair,
        	hcolour = result[1].hair_colour,
        	shirt = result[1].shirt,
        	shirt_txt = result[1].shirt_txt,
        	pants = result[1].pants,
        	pants_txt = result[1].pants_txt,
        	undershirt = result[1].undershirt,
        	undershirt_txt = result[1].undershirt_txt,
        	shoe = result[1].shoe,
        	shoe_txt = result[1].shoe_txt,
        	hand = result[1].hand,
        	mask = result[1].mask,
        	mask_txt = result[1].mask_txt,
        	head = result[1].head,
        	armour = result[1].armour,
	        armour_txt = result[1].armour_txt,
	        helmet = result[1].helmet,
        	helmet_txt = result[1].helmet_txt,
        	glasses = result[1].glasses,
        	glasses_txt = result[1].glasses_txt,
        	piercing = result[1].percing,
        	piercing_txt = result[1].percing_txt
		}
		TriggerClientEvent("mm:changeeverything_spawn", sourcePlayer, user)
		TriggerEvent('ws:giveweapons', sourcePlayer)
	end)
end)

RegisterServerEvent("mm:spawn3")
AddEventHandler("mm:spawn3", function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(sourcePlayer)
	MySQL.Async.fetchAll("SELECT * FROM modelmenu WHERE identifier =@name", {['@name'] = identifier}, function (result)
		local user = {
        	shirt = result[1].shirt,
        	shirt_txt = result[1].shirt_txt,
        	pants = result[1].pants,
        	pants_txt = result[1].pants_txt,
        	shoe = result[1].shoe,
        	shoe_txt = result[1].shoe_txt,
        	mask = result[1].mask,
        	mask_txt = result[1].mask_txt,
	        helmet = result[1].helmet,
        	helmet_txt = result[1].helmet_txt,
        	glasses = result[1].glasses,
        	glasses_txt = result[1].glasses_txt,
        	piercing = result[1].percing,
        	piercing_txt = result[1].percing_txt
		}
		TriggerClientEvent("mm:changeeverything_spawn2", sourcePlayer, user)
		TriggerEvent('ws:giveweapons', sourcePlayer)
	end)
end)

RegisterServerEvent("mm:timer")
AddEventHandler("mm:timer", function()
	local sourcePlayer = tonumber(source)
    SetTimeout(10500, function()
    	TriggerClientEvent("mm:timerend", sourcePlayer)    	
    end)
end)
	
RegisterServerEvent("mm:timer2")
AddEventHandler("mm:timer2", function()
	local sourcePlayer = tonumber(sourcePlayer)
    SetTimeout(10500, function()
    	TriggerClientEvent("mm:timerend2", sourcePlayer)    	
    end)
end)

function nameJob(id)
  return MySQL.Sync.fetchScalar("SELECT job_name FROM jobs WHERE job_id = @namejob", {['@namejob'] = id})
end

function getModelIsMP(identifier)
	return MySQL.Sync.fetchScalar("SELECT mpmodel FROM modelmenu WHERE identifier = @name", {['@name'] = identifier})
end

function getmodels(identifier)
	return MySQL.Sync.fetchScalar("SELECT model FROM modelmenu WHERE identifier = @name", {['@name'] = identifier})
end

function getpolicemodels(identifier)
	return MySQL.Sync.fetchScalar("SELECT copmodel FROM modelmenu WHERE identifier = @name", {['@name'] = identifier})
end

RegisterServerEvent("mm:savempmodel")
AddEventHandler("mm:savempmodel",function(model)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(sourcePlayer)
	MySQL.Sync.execute("UPDATE modelmenu SET mpmodel = 1, model=@model WHERE identifier=@user",{['@model']= model,['@user']= identifier})
	TriggerClientEvent("mm:changempmodel", sourcePlayer, model)
end)

RegisterServerEvent("mm:savemodel")
AddEventHandler("mm:savemodel",function(model, user)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(sourcePlayer)
	MySQL.Sync.execute("UPDATE modelmenu SET mpmodel = 0,model=@model, mask=@mask, mask_txt=@mtxt, shirt=@shirt, shirt_txt=@stxt, shoe=@shoe, shoe_txt=@shtxt, pants=@pants, pants_txt=@ptxt, helmet=@helmet, helmet_txt=@htxt, glasses=@glasses, glasses_txt=@gtxt, percing=@piercing, percing_txt=@petxt WHERE identifier=@user",{['@model']= model,['@mask']= user.mask,['@mtxt']= user.mask_txt,['@shirt']= user.shirt,['@stxt']= user.shirt_txt,['@shoe']= user.shoe,['@shtxt']= user.shoe_txt,['@pants']= user.pants,['@ptxt']= user.pants_txt,['@helmet']= user.helmet,['@htxt']= user.helmet_txt,['@glasses']= user.glasses,['@gtxt']= user.glasses_txt,['@piercing']= user.piercing,['@petxt']= user.piercing_txt,['@user']= identifier})
	--TriggerClientEvent("mm:changemodel", source, model)
end)

RegisterServerEvent("mm:saveeverything")
AddEventHandler("mm:saveeverything",function(user)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(sourcePlayer)
	MySQL.Sync.execute("UPDATE modelmenu SET armour=@armour, armour_txt=@atxt, head=@head, mask=@mask, mask_txt=@mtxt, hair=@hair, hair_colour=@hcolour, shirt=@shirt, shirt_txt=@stxt, hand=@hand, shoe=@shoe, shoe_txt=@shtxt, pants=@pants, pants_txt=@ptxt, undershirt=@undershirt, undershirt_txt=@ustxt, helmet=@helmet, helmet_txt=@htxt, glasses=@glasses, glasses_txt=@gtxt, percing=@piercing, percing_txt=@petxt WHERE identifier=@user",{['@armour']= user.armour,['@atxt']= user.armour_txt,['@head']= user.head,['@mask']= user.mask,['@mtxt']= user.mask_txt,['@hair']= user.hair,['@hcolour']= user.hcolour,['@shirt']= user.shirt,['@stxt']= user.shirt_txt,['@hand']= user.hand,['@shoe']= user.shoe,['@shtxt']= user.shoe_txt,['@pants']= user.pants,['@ptxt']= user.pants_txt,['@undershirt']= user.undershirt,['@ustxt']= user.undershirt_txt,['@helmet']= user.helmet,['@htxt']= user.helmet_txt,['@glasses']= user.glasses,['@gtxt']= user.glasses_txt,['@piercing']= user.piercing,['@petxt']= user.piercing_txt,['@user']= identifier})
	TriggerClientEvent("mm:changeeverything", sourcePlayer, user)
end)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end