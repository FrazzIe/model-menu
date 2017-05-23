require "resources/essentialmode/lib/MySQL"
-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("185.38.148.82", "envicto1_gta5", "envicto1_frazdaz", "wattf3004")

RegisterServerEvent("mm:spawn")
AddEventHandler("mm:spawn", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local executed_query = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier = '@name'", {['@name'] = target.identifier})
		local result = MySQL:getResults(executed_query, {'identifier'}, "identifier")

		if(result[1] == nil) then
			local executed_query2 = MySQL:executeQuery("INSERT INTO modelmenu(identifier) VALUES ('@name')",{['@name']= target.identifier})
			TriggerClientEvent("mm:firstspawn", source)
		else
			local mpmodel = getModelIsMP(target.identifier)
			if(mpmodel == 0) then
			local model = getmodels(target.identifier)
			TriggerClientEvent("mm:changemodelspawn", source, model)
			end
			if(mpmodel == 1) then
			local model = getmodels(target.identifier)
			TriggerClientEvent("mm:changempmodelspawn", source, model)
			end
		end
	end)
end)

RegisterServerEvent("mm:checkCustomisation")
AddEventHandler("mm:checkCustomisation", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local mpmodel = getModelIsMP(target.identifier)
		if(mpmodel == 0) then
			TriggerClientEvent("mm:Customisationisanonono", source)
		else
			TriggerClientEvent("mm:Customisationisagogogo", source)
		end
	end)
end)

RegisterServerEvent("mm:spawn2")
AddEventHandler("mm:spawn2", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local componentstuff = {
		mask = getmask(target.identifier),
		mask_txt = getmask_txt(target.identifier),
		hair = gethair(target.identifier),
		hcolour = gethcolour(target.identifier),
		shoe = getshoe(target.identifier),
		shoe_txt = getshoe_txt(target.identifier),
		shirt = getshirt(target.identifier),
		shirt_txt = getshirt_txt(target.identifier),
		hand = gethand(target.identifier),
		pants = getpants(target.identifier),
		pants_txt = getpants_txt(target.identifier),
		undershirt = getundershirt(target.identifier),
		undershirt_txt = getundershirt_txt(target.identifier),
		armour = getarmour(target.identifier),
		armour_txt = getarmour_txt(target.identifier),
		head = gethead(target.identifier)
		}
		TriggerClientEvent("mm:change_components_spawn", source, componentstuff)
	end)
end)

RegisterServerEvent("mm:timer")
AddEventHandler("mm:timer", function()
    SetTimeout(10500, function()
    	TriggerClientEvent("mm:timerend", source)    	
    end)
end)

function getModelIsMP(identifier)
	local executed_query = MySQL:executeQuery("SELECT mpmodel FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'mpmodel'})
    local mpmodel = result[1].mpmodel
	return mpmodel
end

function getmodels(identifier)
	local executed_query = MySQL:executeQuery("SELECT model FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'model'})
    local model = result[1].model
	return model
end

function getmask(identifier)
	local executed_query = MySQL:executeQuery("SELECT mask FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'mask'})
    local mask = result[1].mask
	return mask
end

function getmask_txt(identifier)
	local executed_query = MySQL:executeQuery("SELECT mask_txt FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'mask_txt'})
    local mask_txt = result[1].mask_txt
	return mask_txt
end

function gethair(identifier)
	local executed_query = MySQL:executeQuery("SELECT hair FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'hair'})
    local hair = result[1].hair
	return hair
end

function gethcolour(identifier)
	local executed_query = MySQL:executeQuery("SELECT hair_colour FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'hair_colour'})
    local hcolour = result[1].hair_colour
	return hcolour
end

function getshirt(identifier)
	local executed_query = MySQL:executeQuery("SELECT shirt FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'shirt'})
    local shirt = result[1].shirt
	return shirt
end

function getshirt_txt(identifier)
	local executed_query = MySQL:executeQuery("SELECT shirt_txt FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'shirt_txt'})
    local shirt_txt = result[1].shirt_txt
	return shirt_txt
end

function getshoe(identifier)
	local executed_query = MySQL:executeQuery("SELECT shoe FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'shoe'})
    local shoe = result[1].shoe
	return shoe
end

function getshoe_txt(identifier)
	local executed_query = MySQL:executeQuery("SELECT shoe_txt FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'shoe_txt'})
    local shoe_txt = result[1].shoe_txt
	return shoe_txt
end

function gethand(identifier)
	local executed_query = MySQL:executeQuery("SELECT hand FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'hand'})
    local hand = result[1].hand
	return hand
end

function getpants(identifier)
	local executed_query = MySQL:executeQuery("SELECT pants FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'pants'})
    local pants = result[1].pants
	return pants
end

function getpants_txt(identifier)
	local executed_query = MySQL:executeQuery("SELECT pants_txt FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'pants_txt'})
    local pants_txt = result[1].pants_txt
	return pants_txt
end

function getundershirt(identifier)
	local executed_query = MySQL:executeQuery("SELECT undershirt FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'undershirt'})
    local undershirt = result[1].undershirt
	return undershirt
end

function getundershirt_txt(identifier)
	local executed_query = MySQL:executeQuery("SELECT undershirt_txt FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'undershirt_txt'})
    local undershirt_txt = result[1].undershirt_txt
	return undershirt_txt
end

function getarmour(identifier)
	local executed_query = MySQL:executeQuery("SELECT armour FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'armour'})
    local armour = result[1].armour
	return armour
end

function getarmour_txt(identifier)
	local executed_query = MySQL:executeQuery("SELECT armour_txt FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'armour_txt'})
    local armour_txt = result[1].armour_txt
	return armour_txt
end

function gethead(identifier)
	local executed_query = MySQL:executeQuery("SELECT head FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'head'})
    local head = result[1].head
	return head
end

RegisterServerEvent("mm:savempmodel")
AddEventHandler("mm:savempmodel",function(model)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query_mp = MySQL:executeQuery("UPDATE modelmenu SET mpmodel = 1 WHERE identifier='@user'",{['@user']= target.identifier})
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET model='@model' WHERE identifier='@user'",{['@model']= model,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changempmodel", source, model)
		else
			TriggerClientEvent("mm:changempmodel", source, model)
		end
	end)
end)

RegisterServerEvent("mm:savemodel")
AddEventHandler("mm:savemodel",function(model)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query_mp = MySQL:executeQuery("UPDATE modelmenu SET mpmodel = 0 WHERE identifier='@user'",{['@user']= target.identifier})
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET model='@model' WHERE identifier='@user'",{['@model']= model,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changemodel", source, model)
		else
			TriggerClientEvent("mm:changemodel", source, model)
		end
	end)
end)

RegisterServerEvent("mm:savemask")
AddEventHandler("mm:savemask",function(mask)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET mask='@mask' WHERE identifier='@user'",{['@mask']= mask,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changemask", source, tonumber(mask))
		else
			TriggerClientEvent("mm:changemask", source, tonumber(mask))
		end
	end)
end)

RegisterServerEvent("mm:removemask")
AddEventHandler("mm:removemask",function(mask)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET mask='@mask' WHERE identifier='@user'",{['@mask']= mask,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:maskremove", source, tonumber(mask))
		else
			TriggerClientEvent("mm:maskremove", source, tonumber(mask))
		end
	end)
end)

RegisterServerEvent("mm:savemask_txt")
AddEventHandler("mm:savemask_txt",function(mask_txt)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET mask_txt='@mask_txt' WHERE identifier='@user'",{['@mask_txt']= mask_txt,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		local maskstuff = {
		mask = getmask(target.identifier),
		mask_txt = getmask_txt(target.identifier)
		}
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changemask_txt", source, maskstuff)
		else
			TriggerClientEvent("mm:changemask_txt", source, maskstuff)
		end
	end)
end)

RegisterServerEvent("mm:savehead")
AddEventHandler("mm:savehead",function(head)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET head='@head' WHERE identifier='@user'",{['@head']= head,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changehead", source, tonumber(head))
		else
			TriggerClientEvent("mm:changehead", source, tonumber(head))
		end
	end)
end)

RegisterServerEvent("mm:savehair")
AddEventHandler("mm:savehair",function(hair)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET hair='@hair' WHERE identifier='@user'",{['@hair']= hair,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changehair", source, tonumber(hair))
		else
			TriggerClientEvent("mm:changehair", source, tonumber(hair))
		end
	end)
end)

RegisterServerEvent("mm:savehcolour")
AddEventHandler("mm:savehcolour",function(hcolour)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET hair_colour='@hcolour' WHERE identifier='@user'",{['@hcolour']= hcolour,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		local hairstuff = {
		hair = gethair(target.identifier),
		hcolour = gethcolour(target.identifier)
		}
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changehcolour", source, hairstuff)
		else
			TriggerClientEvent("mm:changehcolour", source, hairstuff)
		end
	end)
end)

RegisterServerEvent("mm:saveshirt")
AddEventHandler("mm:saveshirt",function(shirt)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET shirt='@shirt' WHERE identifier='@user'",{['@shirt']= shirt,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changeshirt", source, tonumber(shirt))
		else
			TriggerClientEvent("mm:changeshirt", source, tonumber(shirt))
		end
	end)
end)

RegisterServerEvent("mm:saveshirt_txt")
AddEventHandler("mm:saveshirt_txt",function(shirt_txt)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET shirt_txt='@shirt_txt' WHERE identifier='@user'",{['@shirt_txt']= shirt_txt,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		local shirtstuff = {
		shirt = getshirt(target.identifier),
		shirt_txt = getshirt_txt(target.identifier)
		}
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changeshirt_txt", source, shirtstuff)
		else
			TriggerClientEvent("mm:changeshirt_txt", source, shirtstuff)
		end
	end)
end)

RegisterServerEvent("mm:savehand")
AddEventHandler("mm:savehand",function(hand)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET hand='@hand' WHERE identifier='@user'",{['@hand']= hand,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changehand", source, tonumber(hand))
		else
			TriggerClientEvent("mm:changehand", source, tonumber(hand))
		end
	end)
end)

RegisterServerEvent("mm:saveshoe")
AddEventHandler("mm:saveshoe",function(shoe)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET shoe='@shoe' WHERE identifier='@user'",{['@shoe']= shoe,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changeshoe", source, tonumber(shoe))
		else
			TriggerClientEvent("mm:changeshoe", source, tonumber(shoe))
		end
	end)
end)

RegisterServerEvent("mm:saveshoe_txt")
AddEventHandler("mm:saveshoe_txt",function(shoe_txt)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET shoe_txt='@shoe_txt' WHERE identifier='@user'",{['@shoe_txt']= shoe_txt,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		local shoestuff = {
		shoe = getshoe(target.identifier),
		shoe_txt = getshoe_txt(target.identifier)
		}
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changeshoe_txt", source, shoestuff)
		else
			TriggerClientEvent("mm:changeshoe_txt", source, shoestuff)
		end
	end)
end)

RegisterServerEvent("mm:savepants")
AddEventHandler("mm:savepants",function(pants)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET pants='@pants' WHERE identifier='@user'",{['@pants']= pants,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changepants", source, tonumber(pants))
		else
			TriggerClientEvent("mm:changepants", source, tonumber(pants))
		end
	end)
end)

RegisterServerEvent("mm:savepants_txt")
AddEventHandler("mm:savepants_txt",function(pants_txt)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET pants_txt='@pants_txt' WHERE identifier='@user'",{['@pants_txt']= pants_txt,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		local pantsstuff = {
		pants = getpants(target.identifier),
		pants_txt = getpants_txt(target.identifier)
		}
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changepants_txt", source, pantsstuff)
		else
			TriggerClientEvent("mm:changepants_txt", source, pantsstuff)
		end
	end)
end)

RegisterServerEvent("mm:saveundershirt")
AddEventHandler("mm:saveundershirt",function(undershirt)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET undershirt='@undershirt' WHERE identifier='@user'",{['@undershirt']= undershirt,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changeundershirt", source, tonumber(undershirt))
		else
			TriggerClientEvent("mm:changeundershirt", source, tonumber(undershirt))
		end
	end)
end)

RegisterServerEvent("mm:saveundershirt_txt")
AddEventHandler("mm:saveundershirt_txt",function(undershirt_txt)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET undershirt_txt='@undershirt_txt' WHERE identifier='@user'",{['@undershirt_txt']= undershirt_txt,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		local undershirtstuff = {
		undershirt = getundershirt(target.identifier),
		undershirt_txt = getundershirt_txt(target.identifier)
		}
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changeundershirt_txt", source, undershirtstuff)
		else
			TriggerClientEvent("mm:changeundershirt_txt", source, undershirtstuff)
		end
	end)
end)

RegisterServerEvent("mm:removeUndershirt")
AddEventHandler("mm:removeUndershirt",function()
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET undershirt = 0 WHERE identifier='@user'",{['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("UPDATE modelmenu SET undershirt_txt = 240 WHERE identifier='@user'",{['@user']= target.identifier})
		local executed_query3 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query3, {'identifier'}, "identifier")
		local undershirtstuff = {
		undershirt = getundershirt(target.identifier),
		undershirt_txt = getundershirt_txt(target.identifier)
		}
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:undershirtremove", source, undershirtstuff)
		else
			TriggerClientEvent("mm:undershirtremove", source, undershirtstuff)
		end
	end)
end)

RegisterServerEvent("mm:removearmour")
AddEventHandler("mm:removearmour",function(armour)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET armour='@armour' WHERE identifier='@user'",{['@armour']= armour,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changerarmour", source, tonumber(armour))
		else
			TriggerClientEvent("mm:changerarmour", source, tonumber(armour))
		end
	end)
end)

RegisterServerEvent("mm:savearmour")
AddEventHandler("mm:savearmour",function(armour)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET armour='@armour' WHERE identifier='@user'",{['@armour']= armour,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changearmour", source, tonumber(armour))
		else
			TriggerClientEvent("mm:changearmour", source, tonumber(armour))
		end
	end)
end)

RegisterServerEvent("mm:savearmour_txt")
AddEventHandler("mm:savearmour_txt",function(armour_txt)
	TriggerEvent('es:getPlayerFromId', source, function(target)
		local executed_query = MySQL:executeQuery("UPDATE modelmenu SET armour_txt='@armour_txt' WHERE identifier='@user'",{['@armour_txt']= armour_txt,['@user']= target.identifier})
		local executed_query2 = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier='@user'",{['@user']= target.identifier})
		local result = MySQL:getResults(executed_query2, {'identifier'}, "identifier")
		local armourstuff = {
		armour = getarmour(target.identifier),
		armour_txt = getarmour_txt(target.identifier)
		}
		if result[1].identifier ~= nil then
			TriggerClientEvent("mm:changearmour_txt", source, armourstuff)
		else
			TriggerClientEvent("mm:changearmour_txt", source, armourstuff)
		end
	end)
end)

RegisterServerEvent("mm:wearHat") --I didn't make any of this
RegisterServerEvent("mm:wearPercing")
RegisterServerEvent("mm:wearGlasses")
RegisterServerEvent("mm:wearMask")
------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mm:wearHat", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local accessory_query = MySQL:executeQuery("SELECT * FROM modelmenu WHERE identifier = '@username'", {['@username'] = user.identifier})
        local accessory = MySQL:getResults(accessory_query, {'identifier','helmet', 'helmet_txt'}, "identifier")
        if(accessory)then
            for k,v in ipairs(accessory)do
                if v.helmet ~= nil then
                    TriggerClientEvent("mm:Hatwear", source, v)
                end
            end
        end
    end)
end)

AddEventHandler("mm:wearGlasses", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local accessory_query = MySQL:executeQuery("SELECT * FROM modelmenu WHERE identifier = '@username'", {['@username'] = user.identifier})
        local accessory = MySQL:getResults(accessory_query, {'identifier','glasses', 'glasses_txt'}, "identifier")
        if(accessory)then
            for k,v in ipairs(accessory)do
                if v.glasses ~= nil then
                    TriggerClientEvent("mm:Glasseswear", source, v)
                end
            end
        end
    end)
end)

AddEventHandler("mm:wearPercing", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local accessory_query = MySQL:executeQuery("SELECT * FROM modelmenu WHERE identifier = '@username'", {['@username'] = user.identifier})
        local accessory = MySQL:getResults(accessory_query, {'identifier','percing', 'Percing_txt'}, "identifier")
        if(accessory)then
            for k,v in ipairs(accessory)do
                if v.percing ~= nil then
                    TriggerClientEvent("mm:Percingwear", source, v)
                end
            end
        end
    end)
end)
