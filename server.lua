require "resources/essentialmode/lib/MySQL"
-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("ip", "db", "user", "pass")

RegisterServerEvent("mm:spawn")
AddEventHandler("mm:spawn", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local executed_query = MySQL:executeQuery("SELECT identifier FROM modelmenu WHERE identifier = '@name'", {['@name'] = target.identifier})
		local result = MySQL:getResults(executed_query, {'identifier'}, "identifier")
		if(result[1] == nil) then
			local executed_query2 = MySQL:executeQuery("INSERT INTO modelmenu(identifier) VALUES ('@name')",{['@name']= target.identifier})
			TriggerClientEvent("mm:firstspawn", source)
		else
			local model = getmodels(target.identifier)
			TriggerClientEvent("mm:changemodel", source, model)
		end
	end)
end)

function getmodels(identifier)
	local executed_query = MySQL:executeQuery("SELECT model FROM modelmenu WHERE identifier = '@name'", {['@name'] = identifier})
	local result = MySQL:getResults(executed_query, {'model'})
    local model = result[1].model
	return model
end

RegisterServerEvent("mm:savemodel")
AddEventHandler("mm:savemodel",function(model)
	TriggerEvent('es:getPlayerFromId', source, function(target)
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
