local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Model Menu",
    menu_subtitle = "Categories",
    color_r = 30,
    color_g = 144,
    color_b = 255,
}
local c_options = {
    armour = 0,   
    armour_txt = 0,
    hair = 0,
    hcolour = 0,
    shirt = 0,
    shirt_txt = 0,
    pants = 0,
    pants_txt = 0,
    undershirt = 0,
    undershirt_txt = 0,
    shoes = 0,
    shoes_txt = 0,
    hand = 0,
    mask = 0,
    mask_txt = 0,
    head = 0
}
mp_check = false
shirt_help = false
model_info = false
texture_help = false
secondsRemaining = 0
secondsRemaining2 = 0

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent("mm:spawn")
end)

RegisterNetEvent("mm:changemodel")
AddEventHandler("mm:changemodel",function(model)
    changemodel(model,nil)
	Notify("~r~Model loaded")	
end)

RegisterNetEvent("mm:changempmodel")
AddEventHandler("mm:changempmodel",function(model)
    changempmodel(model,nil)
    TriggerServerEvent("mm:spawn2")
	Notify("~r~MP Model loaded")
end)

RegisterNetEvent("mm:changemodelspawn")
AddEventHandler("mm:changemodelspawn",function(model)
    changemodel(model,nil)
	Notify("~r~Model loaded")
end)

RegisterNetEvent("mm:changempmodelspawn")
AddEventHandler("mm:changempmodelspawn",function(model)
    changempmodel(model,nil)
	Notify("~r~MP Model loaded")
	TriggerServerEvent("mm:spawn2")
end)

RegisterNetEvent("mm:firstspawn")
AddEventHandler("mm:firstspawn",function()
    Notify("~g~Change your character at any clothing store!")
end)

RegisterNetEvent("mm:changeeverything_spawn") --Sets mask and texture when spawned
AddEventHandler("mm:changeeverything_spawn",function(user)
    c_options.armour = user.armour
    c_options.armour_txt = user.armour_txt
    c_options.hair = user.hair
    c_options.hcolour = user.hcolour
    c_options.shirt = user.shirt
    c_options.shirt_txt = user.shirt_txt
    c_options.pants = user.pants
    c_options.pants_txt = user.pants_txt
    c_options.undershirt = user.undershirt
    c_options.undershirt_txt = user.undershirt_txt
    c_options.shoes = user.shoe
    c_options.shoes_txt = user.shoe_txt
    c_options.hand = user.hand
    c_options.mask = user.mask
    c_options.mask_txt = user.mask
    c_options.head = user.head
    SetPedComponentVariation(GetPlayerPed(-1), 0, tonumber(user.head), 0, 0) 
    SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(user.mask), tonumber(user.mask_txt), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(user.hair), tonumber(user.hcolour), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 6, tonumber(user.shoe), tonumber(user.shoe_txt), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 11, 0, 240, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 240, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 11, tonumber(user.shirt), tonumber(user.shirt_txt), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 3, tonumber(user.hand), 0, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 4, tonumber(user.pants), tonumber(user.pants_txt), 0)    
    SetPedComponentVariation(GetPlayerPed(-1), 8, tonumber(user.undershirt), tonumber(user.undershirt_txt), 0)    
    SetPedComponentVariation(GetPlayerPed(-1), 9, tonumber(user.armour), tonumber(user.armour_txt), 0)
end)
RegisterNetEvent("mm:changeeverything") --Sets mask and texture when spawned
AddEventHandler("mm:changeeverything",function(user)
    SetPedComponentVariation(GetPlayerPed(-1), 0, tonumber(user.head), 0, 0) 
    SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(user.mask), tonumber(user.mask_txt), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(user.hair), tonumber(user.hcolour), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 6, tonumber(user.shoe), tonumber(user.shoe_txt), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 11, 0, 240, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 240, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 11, tonumber(user.shirt), tonumber(user.shirt_txt), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 3, tonumber(user.hand), 0, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 4, tonumber(user.pants), tonumber(user.pants_txt), 0)    
    SetPedComponentVariation(GetPlayerPed(-1), 8, tonumber(user.undershirt), tonumber(user.undershirt_txt), 0)    
    SetPedComponentVariation(GetPlayerPed(-1), 9, tonumber(user.armour), tonumber(user.armour_txt), 0)
end)

function changemodel(model)
	
	local modelhashed = GetHashKey(model)

	RequestModel(modelhashed)
	while not HasModelLoaded(modelhashed) do 
	    RequestModel(modelhashed)
	    Citizen.Wait(0)
	end

	SetPlayerModel(PlayerId(), modelhashed)
	SetPedRandomComponentVariation(GetPlayerPed(-1), true)
	local a = "" -- nil doesnt work
	SetModelAsNoLongerNeeded(modelhashed)
    mp_check = false
end

function changempmodel(model)
	
	local modelhashed = GetHashKey(model)

	RequestModel(modelhashed)
	while not HasModelLoaded(modelhashed) do 
	    RequestModel(modelhashed)
	    Citizen.Wait(0)
	end

	SetPlayerModel(PlayerId(), modelhashed)
	local a = "" -- nil doesnt work
	SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 0)
	if model == 'mp_f_freemode_01' then
		SetPedComponentVariation(GetPlayerPed(-1), 0, 34, 0, 0)
	end
	SetModelAsNoLongerNeeded(modelhashed)
    mp_check = true
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function savemodel(model)
	TriggerServerEvent("mm:savemodel", model)
end

function savempmodel(model)
	TriggerServerEvent("mm:savempmodel", model)
end
function checkCustomisation()
    TriggerServerEvent("mm:checkCustomisation")
end
RegisterNetEvent("mm:Customisationisagogogo")
AddEventHandler("mm:Customisationisagogogo",function()
    Customisation()
    mp_check = true
end)
RegisterNetEvent("mm:Customisationisanonono")
AddEventHandler("mm:Customisationisanonono",function()
    mp_check = false
    model_info = true
    secondsRemaining = 10
    TriggerServerEvent("mm:timer")
end)

RegisterNetEvent("mm:timerend")
AddEventHandler("mm:timerend",function()
    model_info = false
end)

RegisterNetEvent("mm:timerend2")
AddEventHandler("mm:timerend2",function()
    mp_check_message = false
end)

function Main()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~E ~w~to ~g~open~w~/~r~close~w~!")
    Notify("~w~Press ~g~F ~w~to ~g~save~w~!")
    options.menu_title = "Model Menu"
    options.menu_subtitle = "Categories"
    ClearMenu()
	Menu.addButton("Customisation", "checkCustomisation", nil)
    Menu.addButton("Male models", "MaleMenu", nil)
    Menu.addButton("Female Models", "FemaleMenu", nil)
    Menu.addButton("EMS Models","EMSMenu",nil)
    Menu.addButton("Animals", "AnimalMenu", nil)
    Menu.addButton("Others", "OtherMenu", nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 1/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 1 of 16"
    ClearMenu()
    Menu.addButton(male_models[Menu.buttonCount+1], "savemodel", male_models[Menu.buttonCount+1])
    Menu.addButton(male_models[Menu.buttonCount+1], "savemodel", male_models[Menu.buttonCount+1])
    Menu.addButton(male_models[Menu.buttonCount+1], "savemodel", male_models[Menu.buttonCount+1])
    Menu.addButton(male_models[Menu.buttonCount+1], "savemodel", male_models[Menu.buttonCount+1])
    Menu.addButton(male_models[Menu.buttonCount+1], "savemodel", male_models[Menu.buttonCount+1])
    Menu.addButton(male_models[Menu.buttonCount+1], "savemodel", male_models[Menu.buttonCount+1])
    Menu.addButton(male_models[Menu.buttonCount+1], "savemodel", male_models[Menu.buttonCount+1])
    Menu.addButton(male_models[Menu.buttonCount+1], "savemodel", male_models[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu2",nil)
    Menu.addButton("Previous Page","MaleMenu16",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 2/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 2 of 16"
    ClearMenu()
    Menu.addButton(male_models2[Menu.buttonCount+1], "savemodel", male_models2[Menu.buttonCount+1])
    Menu.addButton(male_models2[Menu.buttonCount+1], "savemodel", male_models2[Menu.buttonCount+1])
    Menu.addButton(male_models2[Menu.buttonCount+1], "savemodel", male_models2[Menu.buttonCount+1])
    Menu.addButton(male_models2[Menu.buttonCount+1], "savemodel", male_models2[Menu.buttonCount+1])
    Menu.addButton(male_models2[Menu.buttonCount+1], "savemodel", male_models2[Menu.buttonCount+1])
    Menu.addButton(male_models2[Menu.buttonCount+1], "savemodel", male_models2[Menu.buttonCount+1])
    Menu.addButton(male_models2[Menu.buttonCount+1], "savemodel", male_models2[Menu.buttonCount+1])
    Menu.addButton(male_models2[Menu.buttonCount+1], "savemodel", male_models2[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu3",nil)
    Menu.addButton("Previous Page","MaleMenu",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 3/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 3 of 16"
    ClearMenu()
    Menu.addButton(male_models3[Menu.buttonCount+1], "savemodel", male_models3[Menu.buttonCount+1])
    Menu.addButton(male_models3[Menu.buttonCount+1], "savemodel", male_models3[Menu.buttonCount+1])
    Menu.addButton(male_models3[Menu.buttonCount+1], "savemodel", male_models3[Menu.buttonCount+1])
    Menu.addButton(male_models3[Menu.buttonCount+1], "savemodel", male_models3[Menu.buttonCount+1])
    Menu.addButton(male_models3[Menu.buttonCount+1], "savemodel", male_models3[Menu.buttonCount+1])
    Menu.addButton(male_models3[Menu.buttonCount+1], "savemodel", male_models3[Menu.buttonCount+1])
    Menu.addButton(male_models3[Menu.buttonCount+1], "savemodel", male_models3[Menu.buttonCount+1])
    Menu.addButton(male_models3[Menu.buttonCount+1], "savemodel", male_models3[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu4",nil)
    Menu.addButton("Previous Page","MaleMenu2",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 4/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 4 of 16"
    ClearMenu()
    Menu.addButton(male_models4[Menu.buttonCount+1], "savemodel", male_models4[Menu.buttonCount+1])
    Menu.addButton(male_models4[Menu.buttonCount+1], "savemodel", male_models4[Menu.buttonCount+1])
    Menu.addButton(male_models4[Menu.buttonCount+1], "savemodel", male_models4[Menu.buttonCount+1])
    Menu.addButton(male_models4[Menu.buttonCount+1], "savemodel", male_models4[Menu.buttonCount+1])
    Menu.addButton(male_models4[Menu.buttonCount+1], "savemodel", male_models4[Menu.buttonCount+1])
    Menu.addButton(male_models4[Menu.buttonCount+1], "savemodel", male_models4[Menu.buttonCount+1])
    Menu.addButton(male_models4[Menu.buttonCount+1], "savemodel", male_models4[Menu.buttonCount+1])
    Menu.addButton(male_models4[Menu.buttonCount+1], "savemodel", male_models4[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu5",nil)
    Menu.addButton("Previous Page","MaleMenu3",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 5/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu5()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 5 of 16"
    ClearMenu()
    Menu.addButton(male_models5[Menu.buttonCount+1], "savemodel", male_models5[Menu.buttonCount+1])
    Menu.addButton(male_models5[Menu.buttonCount+1], "savemodel", male_models5[Menu.buttonCount+1])
    Menu.addButton(male_models5[Menu.buttonCount+1], "savemodel", male_models5[Menu.buttonCount+1])
    Menu.addButton(male_models5[Menu.buttonCount+1], "savemodel", male_models5[Menu.buttonCount+1])
    Menu.addButton(male_models5[Menu.buttonCount+1], "savemodel", male_models5[Menu.buttonCount+1])
    Menu.addButton(male_models5[Menu.buttonCount+1], "savemodel", male_models5[Menu.buttonCount+1])
    Menu.addButton(male_models5[Menu.buttonCount+1], "savemodel", male_models5[Menu.buttonCount+1])
    Menu.addButton(male_models5[Menu.buttonCount+1], "savemodel", male_models5[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu6",nil)
    Menu.addButton("Previous Page","MaleMenu4",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 6/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu6()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 6 of 16"
    ClearMenu()
    Menu.addButton(male_models6[Menu.buttonCount+1], "savemodel", male_models6[Menu.buttonCount+1])
    Menu.addButton(male_models6[Menu.buttonCount+1], "savemodel", male_models6[Menu.buttonCount+1])
    Menu.addButton(male_models6[Menu.buttonCount+1], "savemodel", male_models6[Menu.buttonCount+1])
    Menu.addButton(male_models6[Menu.buttonCount+1], "savemodel", male_models6[Menu.buttonCount+1])
    Menu.addButton(male_models6[Menu.buttonCount+1], "savemodel", male_models6[Menu.buttonCount+1])
    Menu.addButton(male_models6[Menu.buttonCount+1], "savemodel", male_models6[Menu.buttonCount+1])
    Menu.addButton(male_models6[Menu.buttonCount+1], "savemodel", male_models6[Menu.buttonCount+1])
    Menu.addButton(male_models6[Menu.buttonCount+1], "savemodel", male_models6[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu7",nil)
    Menu.addButton("Previous Page","MaleMenu5",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 7/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu7()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 7 of 16"
    ClearMenu()
    Menu.addButton(male_models7[Menu.buttonCount+1], "savemodel", male_models7[Menu.buttonCount+1])
    Menu.addButton(male_models7[Menu.buttonCount+1], "savemodel", male_models7[Menu.buttonCount+1])
    Menu.addButton(male_models7[Menu.buttonCount+1], "savemodel", male_models7[Menu.buttonCount+1])
    Menu.addButton(male_models7[Menu.buttonCount+1], "savemodel", male_models7[Menu.buttonCount+1])
    Menu.addButton(male_models7[Menu.buttonCount+1], "savemodel", male_models7[Menu.buttonCount+1])
    Menu.addButton(male_models7[Menu.buttonCount+1], "savemodel", male_models7[Menu.buttonCount+1])
    Menu.addButton(male_models7[Menu.buttonCount+1], "savemodel", male_models7[Menu.buttonCount+1])
    Menu.addButton(male_models7[Menu.buttonCount+1], "savemodel", male_models7[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu8",nil)
    Menu.addButton("Previous Page","MaleMenu6",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 8/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu8()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 8 of 16"
    ClearMenu()
    Menu.addButton(male_models8[Menu.buttonCount+1], "savemodel", male_models8[Menu.buttonCount+1])
    Menu.addButton(male_models8[Menu.buttonCount+1], "savemodel", male_models8[Menu.buttonCount+1])
    Menu.addButton(male_models8[Menu.buttonCount+1], "savemodel", male_models8[Menu.buttonCount+1])
    Menu.addButton(male_models8[Menu.buttonCount+1], "savemodel", male_models8[Menu.buttonCount+1])
    Menu.addButton(male_models8[Menu.buttonCount+1], "savemodel", male_models8[Menu.buttonCount+1])
    Menu.addButton(male_models8[Menu.buttonCount+1], "savemodel", male_models8[Menu.buttonCount+1])
    Menu.addButton(male_models8[Menu.buttonCount+1], "savemodel", male_models8[Menu.buttonCount+1])
    Menu.addButton(male_models8[Menu.buttonCount+1], "savemodel", male_models8[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu9",nil)
    Menu.addButton("Previous Page","MaleMenu7",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 9/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu9()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 9 of 16"
    ClearMenu()
    Menu.addButton(male_models9[Menu.buttonCount+1], "savemodel", male_models9[Menu.buttonCount+1])
    Menu.addButton(male_models9[Menu.buttonCount+1], "savemodel", male_models9[Menu.buttonCount+1])
    Menu.addButton(male_models9[Menu.buttonCount+1], "savemodel", male_models9[Menu.buttonCount+1])
    Menu.addButton(male_models9[Menu.buttonCount+1], "savemodel", male_models9[Menu.buttonCount+1])
    Menu.addButton(male_models9[Menu.buttonCount+1], "savemodel", male_models9[Menu.buttonCount+1])
    Menu.addButton(male_models9[Menu.buttonCount+1], "savemodel", male_models9[Menu.buttonCount+1])
    Menu.addButton(male_models9[Menu.buttonCount+1], "savemodel", male_models9[Menu.buttonCount+1])
    Menu.addButton(male_models9[Menu.buttonCount+1], "savemodel", male_models9[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu10",nil)
    Menu.addButton("Previous Page","MaleMenu8",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 10/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu10()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 10 of 16"
    ClearMenu()
    Menu.addButton(male_models10[Menu.buttonCount+1], "savemodel", male_models10[Menu.buttonCount+1])
    Menu.addButton(male_models10[Menu.buttonCount+1], "savemodel", male_models10[Menu.buttonCount+1])
    Menu.addButton(male_models10[Menu.buttonCount+1], "savemodel", male_models10[Menu.buttonCount+1])
    Menu.addButton(male_models10[Menu.buttonCount+1], "savemodel", male_models10[Menu.buttonCount+1])
    Menu.addButton(male_models10[Menu.buttonCount+1], "savemodel", male_models10[Menu.buttonCount+1])
    Menu.addButton(male_models10[Menu.buttonCount+1], "savemodel", male_models10[Menu.buttonCount+1])
    Menu.addButton(male_models10[Menu.buttonCount+1], "savemodel", male_models10[Menu.buttonCount+1])
    Menu.addButton(male_models10[Menu.buttonCount+1], "savemodel", male_models10[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu11",nil)
    Menu.addButton("Previous Page","MaleMenu9",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 11/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu11()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 11 of 16"
    ClearMenu()
    Menu.addButton(male_models11[Menu.buttonCount+1], "savemodel", male_models11[Menu.buttonCount+1])
    Menu.addButton(male_models11[Menu.buttonCount+1], "savemodel", male_models11[Menu.buttonCount+1])
    Menu.addButton(male_models11[Menu.buttonCount+1], "savemodel", male_models11[Menu.buttonCount+1])
    Menu.addButton(male_models11[Menu.buttonCount+1], "savemodel", male_models11[Menu.buttonCount+1])
    Menu.addButton(male_models11[Menu.buttonCount+1], "savemodel", male_models11[Menu.buttonCount+1])
    Menu.addButton(male_models11[Menu.buttonCount+1], "savemodel", male_models11[Menu.buttonCount+1])
    Menu.addButton(male_models11[Menu.buttonCount+1], "savemodel", male_models11[Menu.buttonCount+1])
    Menu.addButton(male_models11[Menu.buttonCount+1], "savemodel", male_models11[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu12",nil)
    Menu.addButton("Previous Page","MaleMenu10",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 12/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu12()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 12 of 16"
    ClearMenu()
    Menu.addButton(male_models12[Menu.buttonCount+1], "savemodel", male_models12[Menu.buttonCount+1])
    Menu.addButton(male_models12[Menu.buttonCount+1], "savemodel", male_models12[Menu.buttonCount+1])
    Menu.addButton(male_models12[Menu.buttonCount+1], "savemodel", male_models12[Menu.buttonCount+1])
    Menu.addButton(male_models12[Menu.buttonCount+1], "savemodel", male_models12[Menu.buttonCount+1])
    Menu.addButton(male_models12[Menu.buttonCount+1], "savemodel", male_models12[Menu.buttonCount+1])
    Menu.addButton(male_models12[Menu.buttonCount+1], "savemodel", male_models12[Menu.buttonCount+1])
    Menu.addButton(male_models12[Menu.buttonCount+1], "savemodel", male_models12[Menu.buttonCount+1])
    Menu.addButton(male_models12[Menu.buttonCount+1], "savemodel", male_models12[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu13",nil)
    Menu.addButton("Previous Page","MaleMenu11",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 13/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu13()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 13 of 16"
    ClearMenu()
    Menu.addButton(male_models13[Menu.buttonCount+1], "savemodel", male_models13[Menu.buttonCount+1])
    Menu.addButton(male_models13[Menu.buttonCount+1], "savemodel", male_models13[Menu.buttonCount+1])
    Menu.addButton(male_models13[Menu.buttonCount+1], "savemodel", male_models13[Menu.buttonCount+1])
    Menu.addButton(male_models13[Menu.buttonCount+1], "savemodel", male_models13[Menu.buttonCount+1])
    Menu.addButton(male_models13[Menu.buttonCount+1], "savemodel", male_models13[Menu.buttonCount+1])
    Menu.addButton(male_models13[Menu.buttonCount+1], "savemodel", male_models13[Menu.buttonCount+1])
    Menu.addButton(male_models13[Menu.buttonCount+1], "savemodel", male_models13[Menu.buttonCount+1])
    Menu.addButton(male_models13[Menu.buttonCount+1], "savemodel", male_models13[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu14",nil)
    Menu.addButton("Previous Page","MaleMenu12",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 14/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu14()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 14 of 16"
    ClearMenu()
    Menu.addButton(male_models14[Menu.buttonCount+1], "savemodel", male_models14[Menu.buttonCount+1])
    Menu.addButton(male_models14[Menu.buttonCount+1], "savemodel", male_models14[Menu.buttonCount+1])
    Menu.addButton(male_models14[Menu.buttonCount+1], "savemodel", male_models14[Menu.buttonCount+1])
    Menu.addButton(male_models14[Menu.buttonCount+1], "savemodel", male_models14[Menu.buttonCount+1])
    Menu.addButton(male_models14[Menu.buttonCount+1], "savemodel", male_models14[Menu.buttonCount+1])
    Menu.addButton(male_models14[Menu.buttonCount+1], "savemodel", male_models14[Menu.buttonCount+1])
    Menu.addButton(male_models14[Menu.buttonCount+1], "savemodel", male_models14[Menu.buttonCount+1])
    Menu.addButton(male_models14[Menu.buttonCount+1], "savemodel", male_models14[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu15",nil)
    Menu.addButton("Previous Page","MaleMenu13",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 15/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu15()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 15 of 16"
    ClearMenu()
    Menu.addButton(male_models15[Menu.buttonCount+1], "savemodel", male_models15[Menu.buttonCount+1])
    Menu.addButton(male_models15[Menu.buttonCount+1], "savemodel", male_models15[Menu.buttonCount+1])
    Menu.addButton(male_models15[Menu.buttonCount+1], "savemodel", male_models15[Menu.buttonCount+1])
    Menu.addButton(male_models15[Menu.buttonCount+1], "savemodel", male_models15[Menu.buttonCount+1])
    Menu.addButton(male_models15[Menu.buttonCount+1], "savemodel", male_models15[Menu.buttonCount+1])
    Menu.addButton(male_models15[Menu.buttonCount+1], "savemodel", male_models15[Menu.buttonCount+1])
    Menu.addButton(male_models15[Menu.buttonCount+1], "savemodel", male_models15[Menu.buttonCount+1])
    Menu.addButton(male_models15[Menu.buttonCount+1], "savemodel", male_models15[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu16",nil)
    Menu.addButton("Previous Page","MaleMenu14",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Male Menu Page 16/16
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleMenu16()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Male Models            Page 16 of 16"
    ClearMenu()
    Menu.addButton(male_models16[Menu.buttonCount+1], "savemodel", male_models16[Menu.buttonCount+1])
    Menu.addButton(male_models16[Menu.buttonCount+1], "savemodel", male_models16[Menu.buttonCount+1])
    Menu.addButton(male_models16[Menu.buttonCount+1], "savemodel", male_models16[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleMenu",nil)
    Menu.addButton("Previous Page","MaleMenu15",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 1/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 1 of 9"
    ClearMenu()
    Menu.addButton(female_models[Menu.buttonCount+1], "savemodel", female_models[Menu.buttonCount+1])
    Menu.addButton(female_models[Menu.buttonCount+1], "savemodel", female_models[Menu.buttonCount+1])
    Menu.addButton(female_models[Menu.buttonCount+1], "savemodel", female_models[Menu.buttonCount+1])
    Menu.addButton(female_models[Menu.buttonCount+1], "savemodel", female_models[Menu.buttonCount+1])
    Menu.addButton(female_models[Menu.buttonCount+1], "savemodel", female_models[Menu.buttonCount+1])
    Menu.addButton(female_models[Menu.buttonCount+1], "savemodel", female_models[Menu.buttonCount+1])
    Menu.addButton(female_models[Menu.buttonCount+1], "savemodel", female_models[Menu.buttonCount+1])
    Menu.addButton(female_models[Menu.buttonCount+1], "savemodel", female_models[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu2",nil)
    Menu.addButton("Previous Page","FemaleMenu9",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 2/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 2 of 9"
    ClearMenu()
    Menu.addButton(female_models2[Menu.buttonCount+1], "savemodel", female_models2[Menu.buttonCount+1])
    Menu.addButton(female_models2[Menu.buttonCount+1], "savemodel", female_models2[Menu.buttonCount+1])
    Menu.addButton(female_models2[Menu.buttonCount+1], "savemodel", female_models2[Menu.buttonCount+1])
    Menu.addButton(female_models2[Menu.buttonCount+1], "savemodel", female_models2[Menu.buttonCount+1])
    Menu.addButton(female_models2[Menu.buttonCount+1], "savemodel", female_models2[Menu.buttonCount+1])
    Menu.addButton(female_models2[Menu.buttonCount+1], "savemodel", female_models2[Menu.buttonCount+1])
    Menu.addButton(female_models2[Menu.buttonCount+1], "savemodel", female_models2[Menu.buttonCount+1])
    Menu.addButton(female_models2[Menu.buttonCount+1], "savemodel", female_models2[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu3",nil)
    Menu.addButton("Previous Page","FemaleMenu",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 3/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 3 of 9"
    ClearMenu()
    Menu.addButton(female_models3[Menu.buttonCount+1], "savemodel", female_models3[Menu.buttonCount+1])
    Menu.addButton(female_models3[Menu.buttonCount+1], "savemodel", female_models3[Menu.buttonCount+1])
    Menu.addButton(female_models3[Menu.buttonCount+1], "savemodel", female_models3[Menu.buttonCount+1])
    Menu.addButton(female_models3[Menu.buttonCount+1], "savemodel", female_models3[Menu.buttonCount+1])
    Menu.addButton(female_models3[Menu.buttonCount+1], "savemodel", female_models3[Menu.buttonCount+1])
    Menu.addButton(female_models3[Menu.buttonCount+1], "savemodel", female_models3[Menu.buttonCount+1])
    Menu.addButton(female_models3[Menu.buttonCount+1], "savemodel", female_models3[Menu.buttonCount+1])
    Menu.addButton(female_models3[Menu.buttonCount+1], "savemodel", female_models3[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu4",nil)
    Menu.addButton("Previous Page","FemaleMenu2",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 4/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 4 of 9"
    ClearMenu()
    Menu.addButton(female_models4[Menu.buttonCount+1], "savemodel", female_models4[Menu.buttonCount+1])
    Menu.addButton(female_models4[Menu.buttonCount+1], "savemodel", female_models4[Menu.buttonCount+1])
    Menu.addButton(female_models4[Menu.buttonCount+1], "savemodel", female_models4[Menu.buttonCount+1])
    Menu.addButton(female_models4[Menu.buttonCount+1], "savemodel", female_models4[Menu.buttonCount+1])
    Menu.addButton(female_models4[Menu.buttonCount+1], "savemodel", female_models4[Menu.buttonCount+1])
    Menu.addButton(female_models4[Menu.buttonCount+1], "savemodel", female_models4[Menu.buttonCount+1])
    Menu.addButton(female_models4[Menu.buttonCount+1], "savemodel", female_models4[Menu.buttonCount+1])
    Menu.addButton(female_models4[Menu.buttonCount+1], "savemodel", female_models4[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu5",nil)
    Menu.addButton("Previous Page","FemaleMenu3",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 5/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu5()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 5 of 9"
    ClearMenu()
    Menu.addButton(female_models5[Menu.buttonCount+1], "savemodel", female_models5[Menu.buttonCount+1])
    Menu.addButton(female_models5[Menu.buttonCount+1], "savemodel", female_models5[Menu.buttonCount+1])
    Menu.addButton(female_models5[Menu.buttonCount+1], "savemodel", female_models5[Menu.buttonCount+1])
    Menu.addButton(female_models5[Menu.buttonCount+1], "savemodel", female_models5[Menu.buttonCount+1])
    Menu.addButton(female_models5[Menu.buttonCount+1], "savemodel", female_models5[Menu.buttonCount+1])
    Menu.addButton(female_models5[Menu.buttonCount+1], "savemodel", female_models5[Menu.buttonCount+1])
    Menu.addButton(female_models5[Menu.buttonCount+1], "savemodel", female_models5[Menu.buttonCount+1])
    Menu.addButton(female_models5[Menu.buttonCount+1], "savemodel", female_models5[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu6",nil)
    Menu.addButton("Previous Page","FemaleMenu4",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 6/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu6()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 6 of 9"
    ClearMenu()
    Menu.addButton(female_models6[Menu.buttonCount+1], "savemodel", female_models6[Menu.buttonCount+1])
    Menu.addButton(female_models6[Menu.buttonCount+1], "savemodel", female_models6[Menu.buttonCount+1])
    Menu.addButton(female_models6[Menu.buttonCount+1], "savemodel", female_models6[Menu.buttonCount+1])
    Menu.addButton(female_models6[Menu.buttonCount+1], "savemodel", female_models6[Menu.buttonCount+1])
    Menu.addButton(female_models6[Menu.buttonCount+1], "savemodel", female_models6[Menu.buttonCount+1])
    Menu.addButton(female_models6[Menu.buttonCount+1], "savemodel", female_models6[Menu.buttonCount+1])
    Menu.addButton(female_models6[Menu.buttonCount+1], "savemodel", female_models6[Menu.buttonCount+1])
    Menu.addButton(female_models6[Menu.buttonCount+1], "savemodel", female_models6[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu7",nil)
    Menu.addButton("Previous Page","FemaleMenu5",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 7/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu7()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 7 of 9"
    ClearMenu()
    Menu.addButton(female_models7[Menu.buttonCount+1], "savemodel", female_models7[Menu.buttonCount+1])
    Menu.addButton(female_models7[Menu.buttonCount+1], "savemodel", female_models7[Menu.buttonCount+1])
    Menu.addButton(female_models7[Menu.buttonCount+1], "savemodel", female_models7[Menu.buttonCount+1])
    Menu.addButton(female_models7[Menu.buttonCount+1], "savemodel", female_models7[Menu.buttonCount+1])
    Menu.addButton(female_models7[Menu.buttonCount+1], "savemodel", female_models7[Menu.buttonCount+1])
    Menu.addButton(female_models7[Menu.buttonCount+1], "savemodel", female_models7[Menu.buttonCount+1])
    Menu.addButton(female_models7[Menu.buttonCount+1], "savemodel", female_models7[Menu.buttonCount+1])
    Menu.addButton(female_models7[Menu.buttonCount+1], "savemodel", female_models7[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu8",nil)
    Menu.addButton("Previous Page","FemaleMenu6",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 8/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu8()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 8 of 9"
    ClearMenu()
    Menu.addButton(female_models8[Menu.buttonCount+1], "savemodel", female_models8[Menu.buttonCount+1])
    Menu.addButton(female_models8[Menu.buttonCount+1], "savemodel", female_models8[Menu.buttonCount+1])
    Menu.addButton(female_models8[Menu.buttonCount+1], "savemodel", female_models8[Menu.buttonCount+1])
    Menu.addButton(female_models8[Menu.buttonCount+1], "savemodel", female_models8[Menu.buttonCount+1])
    Menu.addButton(female_models8[Menu.buttonCount+1], "savemodel", female_models8[Menu.buttonCount+1])
    Menu.addButton(female_models8[Menu.buttonCount+1], "savemodel", female_models8[Menu.buttonCount+1])
    Menu.addButton(female_models8[Menu.buttonCount+1], "savemodel", female_models8[Menu.buttonCount+1])
    Menu.addButton(female_models8[Menu.buttonCount+1], "savemodel", female_models8[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu9",nil)
    Menu.addButton("Previous Page","FemaleMenu7",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Female Menu Page 9/9
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleMenu9()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Female Models           Page 9 of 9"
    ClearMenu()
    Menu.addButton(female_models9[Menu.buttonCount+1], "savemodel", female_models9[Menu.buttonCount+1])
    Menu.addButton(female_models9[Menu.buttonCount+1], "savemodel", female_models9[Menu.buttonCount+1])
    Menu.addButton(female_models9[Menu.buttonCount+1], "savemodel", female_models9[Menu.buttonCount+1])
    Menu.addButton(female_models9[Menu.buttonCount+1], "savemodel", female_models9[Menu.buttonCount+1])
    Menu.addButton(female_models9[Menu.buttonCount+1], "savemodel", female_models9[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleMenu",nil)
    Menu.addButton("Previous Page","FemaleMenu8",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--COP/EMS/MARINES/SHERIFF/SECURITY Menu        Page 1/4
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMSMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "EMS                     Page 1 of 4"
    ClearMenu()
    Menu.addButton(ems_models[Menu.buttonCount+1], "savemodel", ems_models[Menu.buttonCount+1])
    Menu.addButton(ems_models[Menu.buttonCount+1], "savemodel", ems_models[Menu.buttonCount+1])
    Menu.addButton(ems_models[Menu.buttonCount+1], "savemodel", ems_models[Menu.buttonCount+1])
    Menu.addButton(ems_models[Menu.buttonCount+1], "savemodel", ems_models[Menu.buttonCount+1])
    Menu.addButton(ems_models[Menu.buttonCount+1], "savemodel", ems_models[Menu.buttonCount+1])
    Menu.addButton(ems_models[Menu.buttonCount+1], "savemodel", ems_models[Menu.buttonCount+1])
    Menu.addButton(ems_models[Menu.buttonCount+1], "savemodel", ems_models[Menu.buttonCount+1])
    Menu.addButton(ems_models[Menu.buttonCount+1], "savemodel", ems_models[Menu.buttonCount+1])
    Menu.addButton("Next Page","EMSMenu2",nil)
    Menu.addButton("Previous Page","EMSMenu4",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--COP/EMS/MARINES/SHERIFF/SECURITY Menu        Page 2/4
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMSMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "EMS                     Page 2 of 4"
    ClearMenu()
    Menu.addButton(ems_models2[Menu.buttonCount+1], "savemodel", ems_models2[Menu.buttonCount+1])
    Menu.addButton(ems_models2[Menu.buttonCount+1], "savemodel", ems_models2[Menu.buttonCount+1])
    Menu.addButton(ems_models2[Menu.buttonCount+1], "savemodel", ems_models2[Menu.buttonCount+1])
    Menu.addButton(ems_models2[Menu.buttonCount+1], "savemodel", ems_models2[Menu.buttonCount+1])
    Menu.addButton(ems_models2[Menu.buttonCount+1], "savemodel", ems_models2[Menu.buttonCount+1])
    Menu.addButton(ems_models2[Menu.buttonCount+1], "savemodel", ems_models2[Menu.buttonCount+1])
    Menu.addButton(ems_models2[Menu.buttonCount+1], "savemodel", ems_models2[Menu.buttonCount+1])
    Menu.addButton(ems_models2[Menu.buttonCount+1], "savemodel", ems_models2[Menu.buttonCount+1])
    Menu.addButton("Next Page","EMSMenu3",nil)
    Menu.addButton("Previous Page","EMSMenu",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--COP/EMS/MARINES/SHERIFF/SECURITY Menu        Page 3/4
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMSMenu3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "EMS                     Page 3 of 4"
    ClearMenu()
    Menu.addButton(ems_models3[Menu.buttonCount+1], "savemodel", ems_models3[Menu.buttonCount+1])
    Menu.addButton(ems_models3[Menu.buttonCount+1], "savemodel", ems_models3[Menu.buttonCount+1])
    Menu.addButton(ems_models3[Menu.buttonCount+1], "savemodel", ems_models3[Menu.buttonCount+1])
    Menu.addButton(ems_models3[Menu.buttonCount+1], "savemodel", ems_models3[Menu.buttonCount+1])
    Menu.addButton(ems_models3[Menu.buttonCount+1], "savemodel", ems_models3[Menu.buttonCount+1])
    Menu.addButton(ems_models3[Menu.buttonCount+1], "savemodel", ems_models3[Menu.buttonCount+1])
    Menu.addButton(ems_models3[Menu.buttonCount+1], "savemodel", ems_models3[Menu.buttonCount+1])
    Menu.addButton(ems_models3[Menu.buttonCount+1], "savemodel", ems_models3[Menu.buttonCount+1])
    Menu.addButton("Next Page","EMSMenu4",nil)
    Menu.addButton("Previous Page","EMSMenu2",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--COP/EMS/MARINES/SHERIFF/SECURITY Menu        Page 4/4
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMSMenu4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "EMS                     Page 4 of 4"
    ClearMenu()
    Menu.addButton(ems_models4[Menu.buttonCount+1], "savemodel", ems_models4[Menu.buttonCount+1])
    Menu.addButton(ems_models4[Menu.buttonCount+1], "savemodel", ems_models4[Menu.buttonCount+1])
    Menu.addButton(ems_models4[Menu.buttonCount+1], "savemodel", ems_models4[Menu.buttonCount+1])
    Menu.addButton(ems_models4[Menu.buttonCount+1], "savemodel", ems_models4[Menu.buttonCount+1])
    Menu.addButton(ems_models4[Menu.buttonCount+1], "savemodel", ems_models4[Menu.buttonCount+1])
    Menu.addButton(ems_models4[Menu.buttonCount+1], "savemodel", ems_models4[Menu.buttonCount+1])
    Menu.addButton("Next Page","EMSMenu",nil)
    Menu.addButton("Previous Page","EMSMenu3",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Animal Menu Page 1/2
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AnimalMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Animal Models           Page 1 of 2"
    ClearMenu()
    Menu.addButton(animal_models[Menu.buttonCount+1], "savemodel", animal_models[Menu.buttonCount+1])
    Menu.addButton(animal_models[Menu.buttonCount+1], "savemodel", animal_models[Menu.buttonCount+1])
    Menu.addButton(animal_models[Menu.buttonCount+1], "savemodel", animal_models[Menu.buttonCount+1])
    Menu.addButton(animal_models[Menu.buttonCount+1], "savemodel", animal_models[Menu.buttonCount+1])
    Menu.addButton(animal_models[Menu.buttonCount+1], "savemodel", animal_models[Menu.buttonCount+1])
    Menu.addButton(animal_models[Menu.buttonCount+1], "savemodel", animal_models[Menu.buttonCount+1])
    Menu.addButton(animal_models[Menu.buttonCount+1], "savemodel", animal_models[Menu.buttonCount+1])
    Menu.addButton(animal_models[Menu.buttonCount+1], "savemodel", animal_models[Menu.buttonCount+1])
    Menu.addButton("Next Page","AnimalMenu2",nil)
    Menu.addButton("Previous Page","AnimalMenu2",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Animal Menu Page 2/2
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AnimalMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Animal Models           Page 2 of 2"
    ClearMenu()
    Menu.addButton(animal_models2[Menu.buttonCount+1], "savemodel", animal_models2[Menu.buttonCount+1])
    Menu.addButton(animal_models2[Menu.buttonCount+1], "savemodel", animal_models2[Menu.buttonCount+1])
    Menu.addButton(animal_models2[Menu.buttonCount+1], "savemodel", animal_models2[Menu.buttonCount+1])
    Menu.addButton(animal_models2[Menu.buttonCount+1], "savemodel", animal_models2[Menu.buttonCount+1])
    Menu.addButton(animal_models2[Menu.buttonCount+1], "savemodel", animal_models2[Menu.buttonCount+1])
    Menu.addButton("Next Page","AnimalMenu",nil)
    Menu.addButton("Previous Page","AnimalMenu",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Models"
    ClearMenu()
    Menu.addButton("Male","OtherMenuMale",nil)
    Menu.addButton("Female","OtherMenuFemale",nil)	
    Menu.addButton("Multiplayer","MPMenu",nil)	
    Menu.addButton("Return","Main",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 1/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 1 of 30"
    ClearMenu()
    Menu.addButton(other_male_models[Menu.buttonCount+1], "savemodel", other_male_models[Menu.buttonCount+1])
    Menu.addButton(other_male_models[Menu.buttonCount+1], "savemodel", other_male_models[Menu.buttonCount+1])
    Menu.addButton(other_male_models[Menu.buttonCount+1], "savemodel", other_male_models[Menu.buttonCount+1])
    Menu.addButton(other_male_models[Menu.buttonCount+1], "savemodel", other_male_models[Menu.buttonCount+1])
    Menu.addButton(other_male_models[Menu.buttonCount+1], "savemodel", other_male_models[Menu.buttonCount+1])
    Menu.addButton(other_male_models[Menu.buttonCount+1], "savemodel", other_male_models[Menu.buttonCount+1])
    Menu.addButton(other_male_models[Menu.buttonCount+1], "savemodel", other_male_models[Menu.buttonCount+1])
    Menu.addButton(other_male_models[Menu.buttonCount+1], "savemodel", other_male_models[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale2",nil)
    Menu.addButton("Previous Page","OtherMenuMale30",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 2/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 2 of 30"
    ClearMenu()
    Menu.addButton(other_male_models2[Menu.buttonCount+1], "savemodel", other_male_models2[Menu.buttonCount+1])
    Menu.addButton(other_male_models2[Menu.buttonCount+1], "savemodel", other_male_models2[Menu.buttonCount+1])
    Menu.addButton(other_male_models2[Menu.buttonCount+1], "savemodel", other_male_models2[Menu.buttonCount+1])
    Menu.addButton(other_male_models2[Menu.buttonCount+1], "savemodel", other_male_models2[Menu.buttonCount+1])
    Menu.addButton(other_male_models2[Menu.buttonCount+1], "savemodel", other_male_models2[Menu.buttonCount+1])
    Menu.addButton(other_male_models2[Menu.buttonCount+1], "savemodel", other_male_models2[Menu.buttonCount+1])
    Menu.addButton(other_male_models2[Menu.buttonCount+1], "savemodel", other_male_models2[Menu.buttonCount+1])
    Menu.addButton(other_male_models2[Menu.buttonCount+1], "savemodel", other_male_models2[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale3",nil)
    Menu.addButton("Previous Page","OtherMenuMale",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 3/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 3 of 30"
    ClearMenu()
    Menu.addButton(other_male_models3[Menu.buttonCount+1], "savemodel", other_male_models3[Menu.buttonCount+1])
    Menu.addButton(other_male_models3[Menu.buttonCount+1], "savemodel", other_male_models3[Menu.buttonCount+1])
    Menu.addButton(other_male_models3[Menu.buttonCount+1], "savemodel", other_male_models3[Menu.buttonCount+1])
    Menu.addButton(other_male_models3[Menu.buttonCount+1], "savemodel", other_male_models3[Menu.buttonCount+1])
    Menu.addButton(other_male_models3[Menu.buttonCount+1], "savemodel", other_male_models3[Menu.buttonCount+1])
    Menu.addButton(other_male_models3[Menu.buttonCount+1], "savemodel", other_male_models3[Menu.buttonCount+1])
    Menu.addButton(other_male_models3[Menu.buttonCount+1], "savemodel", other_male_models3[Menu.buttonCount+1])
    Menu.addButton(other_male_models3[Menu.buttonCount+1], "savemodel", other_male_models3[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale4",nil)
    Menu.addButton("Previous Page","OtherMenuMale2",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 4/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 4 of 30"
    ClearMenu()
    Menu.addButton(other_male_models4[Menu.buttonCount+1], "savemodel", other_male_models4[Menu.buttonCount+1])
    Menu.addButton(other_male_models4[Menu.buttonCount+1], "savemodel", other_male_models4[Menu.buttonCount+1])
    Menu.addButton(other_male_models4[Menu.buttonCount+1], "savemodel", other_male_models4[Menu.buttonCount+1])
    Menu.addButton(other_male_models4[Menu.buttonCount+1], "savemodel", other_male_models4[Menu.buttonCount+1])
    Menu.addButton(other_male_models4[Menu.buttonCount+1], "savemodel", other_male_models4[Menu.buttonCount+1])
    Menu.addButton(other_male_models4[Menu.buttonCount+1], "savemodel", other_male_models4[Menu.buttonCount+1])
    Menu.addButton(other_male_models4[Menu.buttonCount+1], "savemodel", other_male_models4[Menu.buttonCount+1])
    Menu.addButton(other_male_models4[Menu.buttonCount+1], "savemodel", other_male_models4[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale5",nil)
    Menu.addButton("Previous Page","OtherMenuMale3",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 5/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale5()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 5 of 30"
    ClearMenu()
    Menu.addButton(other_male_models5[Menu.buttonCount+1], "savemodel", other_male_models5[Menu.buttonCount+1])
    Menu.addButton(other_male_models5[Menu.buttonCount+1], "savemodel", other_male_models5[Menu.buttonCount+1])
    Menu.addButton(other_male_models5[Menu.buttonCount+1], "savemodel", other_male_models5[Menu.buttonCount+1])
    Menu.addButton(other_male_models5[Menu.buttonCount+1], "savemodel", other_male_models5[Menu.buttonCount+1])
    Menu.addButton(other_male_models5[Menu.buttonCount+1], "savemodel", other_male_models5[Menu.buttonCount+1])
    Menu.addButton(other_male_models5[Menu.buttonCount+1], "savemodel", other_male_models5[Menu.buttonCount+1])
    Menu.addButton(other_male_models5[Menu.buttonCount+1], "savemodel", other_male_models5[Menu.buttonCount+1])
    Menu.addButton(other_male_models5[Menu.buttonCount+1], "savemodel", other_male_models5[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale6",nil)
    Menu.addButton("Previous Page","OtherMenuMale4",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 6/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale6()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 6 of 30"
    ClearMenu()
    Menu.addButton(other_male_models6[Menu.buttonCount+1], "savemodel", other_male_models6[Menu.buttonCount+1])
    Menu.addButton(other_male_models6[Menu.buttonCount+1], "savemodel", other_male_models6[Menu.buttonCount+1])
    Menu.addButton(other_male_models6[Menu.buttonCount+1], "savemodel", other_male_models6[Menu.buttonCount+1])
    Menu.addButton(other_male_models6[Menu.buttonCount+1], "savemodel", other_male_models6[Menu.buttonCount+1])
    Menu.addButton(other_male_models6[Menu.buttonCount+1], "savemodel", other_male_models6[Menu.buttonCount+1])
    Menu.addButton(other_male_models6[Menu.buttonCount+1], "savemodel", other_male_models6[Menu.buttonCount+1])
    Menu.addButton(other_male_models6[Menu.buttonCount+1], "savemodel", other_male_models6[Menu.buttonCount+1])
    Menu.addButton(other_male_models6[Menu.buttonCount+1], "savemodel", other_male_models6[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale7",nil)
    Menu.addButton("Previous Page","OtherMenuMale5",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 7/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale7()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 7 of 30"
    ClearMenu()
    Menu.addButton(other_male_models7[Menu.buttonCount+1], "savemodel", other_male_models7[Menu.buttonCount+1])
    Menu.addButton(other_male_models7[Menu.buttonCount+1], "savemodel", other_male_models7[Menu.buttonCount+1])
    Menu.addButton(other_male_models7[Menu.buttonCount+1], "savemodel", other_male_models7[Menu.buttonCount+1])
    Menu.addButton(other_male_models7[Menu.buttonCount+1], "savemodel", other_male_models7[Menu.buttonCount+1])
    Menu.addButton(other_male_models7[Menu.buttonCount+1], "savemodel", other_male_models7[Menu.buttonCount+1])
    Menu.addButton(other_male_models7[Menu.buttonCount+1], "savemodel", other_male_models7[Menu.buttonCount+1])
    Menu.addButton(other_male_models7[Menu.buttonCount+1], "savemodel", other_male_models7[Menu.buttonCount+1])
    Menu.addButton(other_male_models7[Menu.buttonCount+1], "savemodel", other_male_models7[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale8",nil)
    Menu.addButton("Previous Page","OtherMenuMale6",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 8/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale8()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 8 of 30"
    ClearMenu()
    Menu.addButton(other_male_models8[Menu.buttonCount+1], "savemodel", other_male_models8[Menu.buttonCount+1])
    Menu.addButton(other_male_models8[Menu.buttonCount+1], "savemodel", other_male_models8[Menu.buttonCount+1])
    Menu.addButton(other_male_models8[Menu.buttonCount+1], "savemodel", other_male_models8[Menu.buttonCount+1])
    Menu.addButton(other_male_models8[Menu.buttonCount+1], "savemodel", other_male_models8[Menu.buttonCount+1])
    Menu.addButton(other_male_models8[Menu.buttonCount+1], "savemodel", other_male_models8[Menu.buttonCount+1])
    Menu.addButton(other_male_models8[Menu.buttonCount+1], "savemodel", other_male_models8[Menu.buttonCount+1])
    Menu.addButton(other_male_models8[Menu.buttonCount+1], "savemodel", other_male_models8[Menu.buttonCount+1])
    Menu.addButton(other_male_models8[Menu.buttonCount+1], "savemodel", other_male_models8[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale9",nil)
    Menu.addButton("Previous Page","OtherMenuMale7",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 9/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale9()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 9 of 30"
    ClearMenu()
    Menu.addButton(other_male_models9[Menu.buttonCount+1], "savemodel", other_male_models9[Menu.buttonCount+1])
    Menu.addButton(other_male_models9[Menu.buttonCount+1], "savemodel", other_male_models9[Menu.buttonCount+1])
    Menu.addButton(other_male_models9[Menu.buttonCount+1], "savemodel", other_male_models9[Menu.buttonCount+1])
    Menu.addButton(other_male_models9[Menu.buttonCount+1], "savemodel", other_male_models9[Menu.buttonCount+1])
    Menu.addButton(other_male_models9[Menu.buttonCount+1], "savemodel", other_male_models9[Menu.buttonCount+1])
    Menu.addButton(other_male_models9[Menu.buttonCount+1], "savemodel", other_male_models9[Menu.buttonCount+1])
    Menu.addButton(other_male_models9[Menu.buttonCount+1], "savemodel", other_male_models9[Menu.buttonCount+1])
    Menu.addButton(other_male_models9[Menu.buttonCount+1], "savemodel", other_male_models9[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale10",nil)
    Menu.addButton("Previous Page","OtherMenuMale8",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 10/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale10()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 10 of 30"
    ClearMenu()
    Menu.addButton(other_male_models10[Menu.buttonCount+1], "savemodel", other_male_models10[Menu.buttonCount+1])
    Menu.addButton(other_male_models10[Menu.buttonCount+1], "savemodel", other_male_models10[Menu.buttonCount+1])
    Menu.addButton(other_male_models10[Menu.buttonCount+1], "savemodel", other_male_models10[Menu.buttonCount+1])
    Menu.addButton(other_male_models10[Menu.buttonCount+1], "savemodel", other_male_models10[Menu.buttonCount+1])
    Menu.addButton(other_male_models10[Menu.buttonCount+1], "savemodel", other_male_models10[Menu.buttonCount+1])
    Menu.addButton(other_male_models10[Menu.buttonCount+1], "savemodel", other_male_models10[Menu.buttonCount+1])
    Menu.addButton(other_male_models10[Menu.buttonCount+1], "savemodel", other_male_models10[Menu.buttonCount+1])
    Menu.addButton(other_male_models10[Menu.buttonCount+1], "savemodel", other_male_models10[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale11",nil)
    Menu.addButton("Previous Page","OtherMenuMale9",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 11/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale11()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 11 of 30"
    ClearMenu()
    Menu.addButton(other_male_models11[Menu.buttonCount+1], "savemodel", other_male_models11[Menu.buttonCount+1])
    Menu.addButton(other_male_models11[Menu.buttonCount+1], "savemodel", other_male_models11[Menu.buttonCount+1])
    Menu.addButton(other_male_models11[Menu.buttonCount+1], "savemodel", other_male_models11[Menu.buttonCount+1])
    Menu.addButton(other_male_models11[Menu.buttonCount+1], "savemodel", other_male_models11[Menu.buttonCount+1])
    Menu.addButton(other_male_models11[Menu.buttonCount+1], "savemodel", other_male_models11[Menu.buttonCount+1])
    Menu.addButton(other_male_models11[Menu.buttonCount+1], "savemodel", other_male_models11[Menu.buttonCount+1])
    Menu.addButton(other_male_models11[Menu.buttonCount+1], "savemodel", other_male_models11[Menu.buttonCount+1])
    Menu.addButton(other_male_models11[Menu.buttonCount+1], "savemodel", other_male_models11[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale12",nil)
    Menu.addButton("Previous Page","OtherMenuMale10",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 12/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale12()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 12 of 30"
    ClearMenu()
    Menu.addButton(other_male_models12[Menu.buttonCount+1], "savemodel", other_male_models12[Menu.buttonCount+1])
    Menu.addButton(other_male_models12[Menu.buttonCount+1], "savemodel", other_male_models12[Menu.buttonCount+1])
    Menu.addButton(other_male_models12[Menu.buttonCount+1], "savemodel", other_male_models12[Menu.buttonCount+1])
    Menu.addButton(other_male_models12[Menu.buttonCount+1], "savemodel", other_male_models12[Menu.buttonCount+1])
    Menu.addButton(other_male_models12[Menu.buttonCount+1], "savemodel", other_male_models12[Menu.buttonCount+1])
    Menu.addButton(other_male_models12[Menu.buttonCount+1], "savemodel", other_male_models12[Menu.buttonCount+1])
    Menu.addButton(other_male_models12[Menu.buttonCount+1], "savemodel", other_male_models12[Menu.buttonCount+1])
    Menu.addButton(other_male_models12[Menu.buttonCount+1], "savemodel", other_male_models12[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale13",nil)
    Menu.addButton("Previous Page","OtherMenuMale11",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 13/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale13()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 13 of 30"
    ClearMenu()
    Menu.addButton(other_male_models13[Menu.buttonCount+1], "savemodel", other_male_models13[Menu.buttonCount+1])
    Menu.addButton(other_male_models13[Menu.buttonCount+1], "savemodel", other_male_models13[Menu.buttonCount+1])
    Menu.addButton(other_male_models13[Menu.buttonCount+1], "savemodel", other_male_models13[Menu.buttonCount+1])
    Menu.addButton(other_male_models13[Menu.buttonCount+1], "savemodel", other_male_models13[Menu.buttonCount+1])
    Menu.addButton(other_male_models13[Menu.buttonCount+1], "savemodel", other_male_models13[Menu.buttonCount+1])
    Menu.addButton(other_male_models13[Menu.buttonCount+1], "savemodel", other_male_models13[Menu.buttonCount+1])
    Menu.addButton(other_male_models13[Menu.buttonCount+1], "savemodel", other_male_models13[Menu.buttonCount+1])
    Menu.addButton(other_male_models13[Menu.buttonCount+1], "savemodel", other_male_models13[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale14",nil)
    Menu.addButton("Previous Page","OtherMenuMale12",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 14/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale14()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 14 of 30"
    ClearMenu()
    Menu.addButton(other_male_models14[Menu.buttonCount+1], "savemodel", other_male_models14[Menu.buttonCount+1])
    Menu.addButton(other_male_models14[Menu.buttonCount+1], "savemodel", other_male_models14[Menu.buttonCount+1])
    Menu.addButton(other_male_models14[Menu.buttonCount+1], "savemodel", other_male_models14[Menu.buttonCount+1])
    Menu.addButton(other_male_models14[Menu.buttonCount+1], "savemodel", other_male_models14[Menu.buttonCount+1])
    Menu.addButton(other_male_models14[Menu.buttonCount+1], "savemodel", other_male_models14[Menu.buttonCount+1])
    Menu.addButton(other_male_models14[Menu.buttonCount+1], "savemodel", other_male_models14[Menu.buttonCount+1])
    Menu.addButton(other_male_models14[Menu.buttonCount+1], "savemodel", other_male_models14[Menu.buttonCount+1])
    Menu.addButton(other_male_models14[Menu.buttonCount+1], "savemodel", other_male_models14[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale15",nil)
    Menu.addButton("Previous Page","OtherMenuMale13",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 15/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale15()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 15 of 30"
    ClearMenu()
    Menu.addButton(other_male_models15[Menu.buttonCount+1], "savemodel", other_male_models15[Menu.buttonCount+1])
    Menu.addButton(other_male_models15[Menu.buttonCount+1], "savemodel", other_male_models15[Menu.buttonCount+1])
    Menu.addButton(other_male_models15[Menu.buttonCount+1], "savemodel", other_male_models15[Menu.buttonCount+1])
    Menu.addButton(other_male_models15[Menu.buttonCount+1], "savemodel", other_male_models15[Menu.buttonCount+1])
    Menu.addButton(other_male_models15[Menu.buttonCount+1], "savemodel", other_male_models15[Menu.buttonCount+1])
    Menu.addButton(other_male_models15[Menu.buttonCount+1], "savemodel", other_male_models15[Menu.buttonCount+1])
    Menu.addButton(other_male_models15[Menu.buttonCount+1], "savemodel", other_male_models15[Menu.buttonCount+1])
    Menu.addButton(other_male_models15[Menu.buttonCount+1], "savemodel", other_male_models15[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale16",nil)
    Menu.addButton("Previous Page","OtherMenuMale14",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 16/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale16()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 16 of 30"
    ClearMenu()
    Menu.addButton(other_male_models16[Menu.buttonCount+1], "savemodel", other_male_models16[Menu.buttonCount+1])
    Menu.addButton(other_male_models16[Menu.buttonCount+1], "savemodel", other_male_models16[Menu.buttonCount+1])
    Menu.addButton(other_male_models16[Menu.buttonCount+1], "savemodel", other_male_models16[Menu.buttonCount+1])
    Menu.addButton(other_male_models16[Menu.buttonCount+1], "savemodel", other_male_models16[Menu.buttonCount+1])
    Menu.addButton(other_male_models16[Menu.buttonCount+1], "savemodel", other_male_models16[Menu.buttonCount+1])
    Menu.addButton(other_male_models16[Menu.buttonCount+1], "savemodel", other_male_models16[Menu.buttonCount+1])
    Menu.addButton(other_male_models16[Menu.buttonCount+1], "savemodel", other_male_models16[Menu.buttonCount+1])
    Menu.addButton(other_male_models16[Menu.buttonCount+1], "savemodel", other_male_models16[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale17",nil)
    Menu.addButton("Previous Page","OtherMenuMale15",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 17/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale17()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 17 of 30"
    ClearMenu()
    Menu.addButton(other_male_models17[Menu.buttonCount+1], "savemodel", other_male_models17[Menu.buttonCount+1])
    Menu.addButton(other_male_models17[Menu.buttonCount+1], "savemodel", other_male_models17[Menu.buttonCount+1])
    Menu.addButton(other_male_models17[Menu.buttonCount+1], "savemodel", other_male_models17[Menu.buttonCount+1])
    Menu.addButton(other_male_models17[Menu.buttonCount+1], "savemodel", other_male_models17[Menu.buttonCount+1])
    Menu.addButton(other_male_models17[Menu.buttonCount+1], "savemodel", other_male_models17[Menu.buttonCount+1])
    Menu.addButton(other_male_models17[Menu.buttonCount+1], "savemodel", other_male_models17[Menu.buttonCount+1])
    Menu.addButton(other_male_models17[Menu.buttonCount+1], "savemodel", other_male_models17[Menu.buttonCount+1])
    Menu.addButton(other_male_models17[Menu.buttonCount+1], "savemodel", other_male_models17[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale18",nil)
    Menu.addButton("Previous Page","OtherMenuMale16",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 18/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale18()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 18 of 30"
    ClearMenu()
    Menu.addButton(other_male_models18[Menu.buttonCount+1], "savemodel", other_male_models18[Menu.buttonCount+1])
    Menu.addButton(other_male_models18[Menu.buttonCount+1], "savemodel", other_male_models18[Menu.buttonCount+1])
    Menu.addButton(other_male_models18[Menu.buttonCount+1], "savemodel", other_male_models18[Menu.buttonCount+1])
    Menu.addButton(other_male_models18[Menu.buttonCount+1], "savemodel", other_male_models18[Menu.buttonCount+1])
    Menu.addButton(other_male_models18[Menu.buttonCount+1], "savemodel", other_male_models18[Menu.buttonCount+1])
    Menu.addButton(other_male_models18[Menu.buttonCount+1], "savemodel", other_male_models18[Menu.buttonCount+1])
    Menu.addButton(other_male_models18[Menu.buttonCount+1], "savemodel", other_male_models18[Menu.buttonCount+1])
    Menu.addButton(other_male_models18[Menu.buttonCount+1], "savemodel", other_male_models18[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale19",nil)
    Menu.addButton("Previous Page","OtherMenuMale17",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 19/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale19()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 19 of 30"
    ClearMenu()
    Menu.addButton(other_male_models19[Menu.buttonCount+1], "savemodel", other_male_models19[Menu.buttonCount+1])
    Menu.addButton(other_male_models19[Menu.buttonCount+1], "savemodel", other_male_models19[Menu.buttonCount+1])
    Menu.addButton(other_male_models19[Menu.buttonCount+1], "savemodel", other_male_models19[Menu.buttonCount+1])
    Menu.addButton(other_male_models19[Menu.buttonCount+1], "savemodel", other_male_models19[Menu.buttonCount+1])
    Menu.addButton(other_male_models19[Menu.buttonCount+1], "savemodel", other_male_models19[Menu.buttonCount+1])
    Menu.addButton(other_male_models19[Menu.buttonCount+1], "savemodel", other_male_models19[Menu.buttonCount+1])
    Menu.addButton(other_male_models19[Menu.buttonCount+1], "savemodel", other_male_models19[Menu.buttonCount+1])
    Menu.addButton(other_male_models19[Menu.buttonCount+1], "savemodel", other_male_models19[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale20",nil)
    Menu.addButton("Previous Page","OtherMenuMale18",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 20/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale20()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 20 of 30"
    ClearMenu()
    Menu.addButton(other_male_models20[Menu.buttonCount+1], "savemodel", other_male_models20[Menu.buttonCount+1])
    Menu.addButton(other_male_models20[Menu.buttonCount+1], "savemodel", other_male_models20[Menu.buttonCount+1])
    Menu.addButton(other_male_models20[Menu.buttonCount+1], "savemodel", other_male_models20[Menu.buttonCount+1])
    Menu.addButton(other_male_models20[Menu.buttonCount+1], "savemodel", other_male_models20[Menu.buttonCount+1])
    Menu.addButton(other_male_models20[Menu.buttonCount+1], "savemodel", other_male_models20[Menu.buttonCount+1])
    Menu.addButton(other_male_models20[Menu.buttonCount+1], "savemodel", other_male_models20[Menu.buttonCount+1])
    Menu.addButton(other_male_models20[Menu.buttonCount+1], "savemodel", other_male_models20[Menu.buttonCount+1])
    Menu.addButton(other_male_models20[Menu.buttonCount+1], "savemodel", other_male_models20[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale21",nil)
    Menu.addButton("Previous Page","OtherMenuMale19",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 21/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale21()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 21 of 30"
    ClearMenu()
    Menu.addButton(other_male_models21[Menu.buttonCount+1], "savemodel", other_male_models21[Menu.buttonCount+1])
    Menu.addButton(other_male_models21[Menu.buttonCount+1], "savemodel", other_male_models21[Menu.buttonCount+1])
    Menu.addButton(other_male_models21[Menu.buttonCount+1], "savemodel", other_male_models21[Menu.buttonCount+1])
    Menu.addButton(other_male_models21[Menu.buttonCount+1], "savemodel", other_male_models21[Menu.buttonCount+1])
    Menu.addButton(other_male_models21[Menu.buttonCount+1], "savemodel", other_male_models21[Menu.buttonCount+1])
    Menu.addButton(other_male_models21[Menu.buttonCount+1], "savemodel", other_male_models21[Menu.buttonCount+1])
    Menu.addButton(other_male_models21[Menu.buttonCount+1], "savemodel", other_male_models21[Menu.buttonCount+1])
    Menu.addButton(other_male_models21[Menu.buttonCount+1], "savemodel", other_male_models21[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale22",nil)
    Menu.addButton("Previous Page","OtherMenuMale20",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 22/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale22()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 22 of 30"
    ClearMenu()
    Menu.addButton(other_male_models22[Menu.buttonCount+1], "savemodel", other_male_models22[Menu.buttonCount+1])
    Menu.addButton(other_male_models22[Menu.buttonCount+1], "savemodel", other_male_models22[Menu.buttonCount+1])
    Menu.addButton(other_male_models22[Menu.buttonCount+1], "savemodel", other_male_models22[Menu.buttonCount+1])
    Menu.addButton(other_male_models22[Menu.buttonCount+1], "savemodel", other_male_models22[Menu.buttonCount+1])
    Menu.addButton(other_male_models22[Menu.buttonCount+1], "savemodel", other_male_models22[Menu.buttonCount+1])
    Menu.addButton(other_male_models22[Menu.buttonCount+1], "savemodel", other_male_models22[Menu.buttonCount+1])
    Menu.addButton(other_male_models22[Menu.buttonCount+1], "savemodel", other_male_models22[Menu.buttonCount+1])
    Menu.addButton(other_male_models22[Menu.buttonCount+1], "savemodel", other_male_models22[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale23",nil)
    Menu.addButton("Previous Page","OtherMenuMale21",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 23/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale23()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 23 of 30"
    ClearMenu()
    Menu.addButton(other_male_models23[Menu.buttonCount+1], "savemodel", other_male_models23[Menu.buttonCount+1])
    Menu.addButton(other_male_models23[Menu.buttonCount+1], "savemodel", other_male_models23[Menu.buttonCount+1])
    Menu.addButton(other_male_models23[Menu.buttonCount+1], "savemodel", other_male_models23[Menu.buttonCount+1])
    Menu.addButton(other_male_models23[Menu.buttonCount+1], "savemodel", other_male_models23[Menu.buttonCount+1])
    Menu.addButton(other_male_models23[Menu.buttonCount+1], "savemodel", other_male_models23[Menu.buttonCount+1])
    Menu.addButton(other_male_models23[Menu.buttonCount+1], "savemodel", other_male_models23[Menu.buttonCount+1])
    Menu.addButton(other_male_models23[Menu.buttonCount+1], "savemodel", other_male_models23[Menu.buttonCount+1])
    Menu.addButton(other_male_models23[Menu.buttonCount+1], "savemodel", other_male_models23[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale24",nil)
    Menu.addButton("Previous Page","OtherMenuMale22",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 24/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale24()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 24 of 30"
    ClearMenu()
    Menu.addButton(other_male_models24[Menu.buttonCount+1], "savemodel", other_male_models24[Menu.buttonCount+1])
    Menu.addButton(other_male_models24[Menu.buttonCount+1], "savemodel", other_male_models24[Menu.buttonCount+1])
    Menu.addButton(other_male_models24[Menu.buttonCount+1], "savemodel", other_male_models24[Menu.buttonCount+1])
    Menu.addButton(other_male_models24[Menu.buttonCount+1], "savemodel", other_male_models24[Menu.buttonCount+1])
    Menu.addButton(other_male_models24[Menu.buttonCount+1], "savemodel", other_male_models24[Menu.buttonCount+1])
    Menu.addButton(other_male_models24[Menu.buttonCount+1], "savemodel", other_male_models24[Menu.buttonCount+1])
    Menu.addButton(other_male_models24[Menu.buttonCount+1], "savemodel", other_male_models24[Menu.buttonCount+1])
    Menu.addButton(other_male_models24[Menu.buttonCount+1], "savemodel", other_male_models24[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale25",nil)
    Menu.addButton("Previous Page","OtherMenuMale23",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 25/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale25()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 25 of 30"
    ClearMenu()
    Menu.addButton(other_male_models25[Menu.buttonCount+1], "savemodel", other_male_models25[Menu.buttonCount+1])
    Menu.addButton(other_male_models25[Menu.buttonCount+1], "savemodel", other_male_models25[Menu.buttonCount+1])
    Menu.addButton(other_male_models25[Menu.buttonCount+1], "savemodel", other_male_models25[Menu.buttonCount+1])
    Menu.addButton(other_male_models25[Menu.buttonCount+1], "savemodel", other_male_models25[Menu.buttonCount+1])
    Menu.addButton(other_male_models25[Menu.buttonCount+1], "savemodel", other_male_models25[Menu.buttonCount+1])
    Menu.addButton(other_male_models25[Menu.buttonCount+1], "savemodel", other_male_models25[Menu.buttonCount+1])
    Menu.addButton(other_male_models25[Menu.buttonCount+1], "savemodel", other_male_models25[Menu.buttonCount+1])
    Menu.addButton(other_male_models25[Menu.buttonCount+1], "savemodel", other_male_models25[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale26",nil)
    Menu.addButton("Previous Page","OtherMenuMale24",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 26/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale26()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 26 of 30"
    ClearMenu()
    Menu.addButton(other_male_models26[Menu.buttonCount+1], "savemodel", other_male_models26[Menu.buttonCount+1])
    Menu.addButton(other_male_models26[Menu.buttonCount+1], "savemodel", other_male_models26[Menu.buttonCount+1])
    Menu.addButton(other_male_models26[Menu.buttonCount+1], "savemodel", other_male_models26[Menu.buttonCount+1])
    Menu.addButton(other_male_models26[Menu.buttonCount+1], "savemodel", other_male_models26[Menu.buttonCount+1])
    Menu.addButton(other_male_models26[Menu.buttonCount+1], "savemodel", other_male_models26[Menu.buttonCount+1])
    Menu.addButton(other_male_models26[Menu.buttonCount+1], "savemodel", other_male_models26[Menu.buttonCount+1])
    Menu.addButton(other_male_models26[Menu.buttonCount+1], "savemodel", other_male_models26[Menu.buttonCount+1])
    Menu.addButton(other_male_models26[Menu.buttonCount+1], "savemodel", other_male_models26[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale27",nil)
    Menu.addButton("Previous Page","OtherMenuMale25",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 27/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale27()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 27 of 30"
    ClearMenu()
    Menu.addButton(other_male_models27[Menu.buttonCount+1], "savemodel", other_male_models27[Menu.buttonCount+1])
    Menu.addButton(other_male_models27[Menu.buttonCount+1], "savemodel", other_male_models27[Menu.buttonCount+1])
    Menu.addButton(other_male_models27[Menu.buttonCount+1], "savemodel", other_male_models27[Menu.buttonCount+1])
    Menu.addButton(other_male_models27[Menu.buttonCount+1], "savemodel", other_male_models27[Menu.buttonCount+1])
    Menu.addButton(other_male_models27[Menu.buttonCount+1], "savemodel", other_male_models27[Menu.buttonCount+1])
    Menu.addButton(other_male_models27[Menu.buttonCount+1], "savemodel", other_male_models27[Menu.buttonCount+1])
    Menu.addButton(other_male_models27[Menu.buttonCount+1], "savemodel", other_male_models27[Menu.buttonCount+1])
    Menu.addButton(other_male_models27[Menu.buttonCount+1], "savemodel", other_male_models27[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale28",nil)
    Menu.addButton("Previous Page","OtherMenuMale26",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 28/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale28()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 28 of 30"
    ClearMenu()
    Menu.addButton(other_male_models28[Menu.buttonCount+1], "savemodel", other_male_models28[Menu.buttonCount+1])
    Menu.addButton(other_male_models28[Menu.buttonCount+1], "savemodel", other_male_models28[Menu.buttonCount+1])
    Menu.addButton(other_male_models28[Menu.buttonCount+1], "savemodel", other_male_models28[Menu.buttonCount+1])
    Menu.addButton(other_male_models28[Menu.buttonCount+1], "savemodel", other_male_models28[Menu.buttonCount+1])
    Menu.addButton(other_male_models28[Menu.buttonCount+1], "savemodel", other_male_models28[Menu.buttonCount+1])
    Menu.addButton(other_male_models28[Menu.buttonCount+1], "savemodel", other_male_models28[Menu.buttonCount+1])
    Menu.addButton(other_male_models28[Menu.buttonCount+1], "savemodel", other_male_models28[Menu.buttonCount+1])
    Menu.addButton(other_male_models28[Menu.buttonCount+1], "savemodel", other_male_models28[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale29",nil)
    Menu.addButton("Previous Page","OtherMenuMale27",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 29/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale29()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 29 of 30"
    ClearMenu()
    Menu.addButton(other_male_models29[Menu.buttonCount+1], "savemodel", other_male_models29[Menu.buttonCount+1])
    Menu.addButton(other_male_models29[Menu.buttonCount+1], "savemodel", other_male_models29[Menu.buttonCount+1])
    Menu.addButton(other_male_models29[Menu.buttonCount+1], "savemodel", other_male_models29[Menu.buttonCount+1])
    Menu.addButton(other_male_models29[Menu.buttonCount+1], "savemodel", other_male_models29[Menu.buttonCount+1])
    Menu.addButton(other_male_models29[Menu.buttonCount+1], "savemodel", other_male_models29[Menu.buttonCount+1])
    Menu.addButton(other_male_models29[Menu.buttonCount+1], "savemodel", other_male_models29[Menu.buttonCount+1])
    Menu.addButton(other_male_models29[Menu.buttonCount+1], "savemodel", other_male_models29[Menu.buttonCount+1])
    Menu.addButton(other_male_models29[Menu.buttonCount+1], "savemodel", other_male_models29[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale30",nil)
    Menu.addButton("Previous Page","OtherMenuMale28",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 30/30
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuMale30()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Males            Page 30 of 30"
    ClearMenu()
    Menu.addButton(other_male_models30[Menu.buttonCount+1], "savemodel", other_male_models30[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuMale",nil)
    Menu.addButton("Previous Page","OtherMenuMale29",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 1/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 1 of 9"
    ClearMenu()
    Menu.addButton(other_female_models[Menu.buttonCount+1], "savemodel", other_female_models[Menu.buttonCount+1])
    Menu.addButton(other_female_models[Menu.buttonCount+1], "savemodel", other_female_models[Menu.buttonCount+1])
    Menu.addButton(other_female_models[Menu.buttonCount+1], "savemodel", other_female_models[Menu.buttonCount+1])
    Menu.addButton(other_female_models[Menu.buttonCount+1], "savemodel", other_female_models[Menu.buttonCount+1])
    Menu.addButton(other_female_models[Menu.buttonCount+1], "savemodel", other_female_models[Menu.buttonCount+1])
    Menu.addButton(other_female_models[Menu.buttonCount+1], "savemodel", other_female_models[Menu.buttonCount+1])
    Menu.addButton(other_female_models[Menu.buttonCount+1], "savemodel", other_female_models[Menu.buttonCount+1])
    Menu.addButton(other_female_models[Menu.buttonCount+1], "savemodel", other_female_models[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale2",nil)
    Menu.addButton("Previous Page","OtherMenuFemale9",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 2/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 2 of 9"
    ClearMenu()
    Menu.addButton(other_female_models2[Menu.buttonCount+1], "savemodel", other_female_models2[Menu.buttonCount+1])
    Menu.addButton(other_female_models2[Menu.buttonCount+1], "savemodel", other_female_models2[Menu.buttonCount+1])
    Menu.addButton(other_female_models2[Menu.buttonCount+1], "savemodel", other_female_models2[Menu.buttonCount+1])
    Menu.addButton(other_female_models2[Menu.buttonCount+1], "savemodel", other_female_models2[Menu.buttonCount+1])
    Menu.addButton(other_female_models2[Menu.buttonCount+1], "savemodel", other_female_models2[Menu.buttonCount+1])
    Menu.addButton(other_female_models2[Menu.buttonCount+1], "savemodel", other_female_models2[Menu.buttonCount+1])
    Menu.addButton(other_female_models2[Menu.buttonCount+1], "savemodel", other_female_models2[Menu.buttonCount+1])
    Menu.addButton(other_female_models2[Menu.buttonCount+1], "savemodel", other_female_models2[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale3",nil)
    Menu.addButton("Previous Page","OtherMenuFemale",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 3/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 3 of 9"
    ClearMenu()
    Menu.addButton(other_female_models3[Menu.buttonCount+1], "savemodel", other_female_models3[Menu.buttonCount+1])
    Menu.addButton(other_female_models3[Menu.buttonCount+1], "savemodel", other_female_models3[Menu.buttonCount+1])
    Menu.addButton(other_female_models3[Menu.buttonCount+1], "savemodel", other_female_models3[Menu.buttonCount+1])
    Menu.addButton(other_female_models3[Menu.buttonCount+1], "savemodel", other_female_models3[Menu.buttonCount+1])
    Menu.addButton(other_female_models3[Menu.buttonCount+1], "savemodel", other_female_models3[Menu.buttonCount+1])
    Menu.addButton(other_female_models3[Menu.buttonCount+1], "savemodel", other_female_models3[Menu.buttonCount+1])
    Menu.addButton(other_female_models3[Menu.buttonCount+1], "savemodel", other_female_models3[Menu.buttonCount+1])
    Menu.addButton(other_female_models3[Menu.buttonCount+1], "savemodel", other_female_models3[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale4",nil)
    Menu.addButton("Previous Page","OtherMenuFemale2",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 4/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 4 of 9"
    ClearMenu()
    Menu.addButton(other_female_models4[Menu.buttonCount+1], "savemodel", other_female_models4[Menu.buttonCount+1])
    Menu.addButton(other_female_models4[Menu.buttonCount+1], "savemodel", other_female_models4[Menu.buttonCount+1])
    Menu.addButton(other_female_models4[Menu.buttonCount+1], "savemodel", other_female_models4[Menu.buttonCount+1])
    Menu.addButton(other_female_models4[Menu.buttonCount+1], "savemodel", other_female_models4[Menu.buttonCount+1])
    Menu.addButton(other_female_models4[Menu.buttonCount+1], "savemodel", other_female_models4[Menu.buttonCount+1])
    Menu.addButton(other_female_models4[Menu.buttonCount+1], "savemodel", other_female_models4[Menu.buttonCount+1])
    Menu.addButton(other_female_models4[Menu.buttonCount+1], "savemodel", other_female_models4[Menu.buttonCount+1])
    Menu.addButton(other_female_models4[Menu.buttonCount+1], "savemodel", other_female_models4[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale5",nil)
    Menu.addButton("Previous Page","OtherMenuFemale3",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 5/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale5()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 5 of 9"
    ClearMenu()
    Menu.addButton(other_female_models5[Menu.buttonCount+1], "savemodel", other_female_models5[Menu.buttonCount+1])
    Menu.addButton(other_female_models5[Menu.buttonCount+1], "savemodel", other_female_models5[Menu.buttonCount+1])
    Menu.addButton(other_female_models5[Menu.buttonCount+1], "savemodel", other_female_models5[Menu.buttonCount+1])
    Menu.addButton(other_female_models5[Menu.buttonCount+1], "savemodel", other_female_models5[Menu.buttonCount+1])
    Menu.addButton(other_female_models5[Menu.buttonCount+1], "savemodel", other_female_models5[Menu.buttonCount+1])
    Menu.addButton(other_female_models5[Menu.buttonCount+1], "savemodel", other_female_models5[Menu.buttonCount+1])
    Menu.addButton(other_female_models5[Menu.buttonCount+1], "savemodel", other_female_models5[Menu.buttonCount+1])
    Menu.addButton(other_female_models5[Menu.buttonCount+1], "savemodel", other_female_models5[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale6",nil)
    Menu.addButton("Previous Page","OtherMenuFemale4",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 6/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale6()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 6 of 9"
    ClearMenu()
    Menu.addButton(other_female_models6[Menu.buttonCount+1], "savemodel", other_female_models6[Menu.buttonCount+1])
    Menu.addButton(other_female_models6[Menu.buttonCount+1], "savemodel", other_female_models6[Menu.buttonCount+1])
    Menu.addButton(other_female_models6[Menu.buttonCount+1], "savemodel", other_female_models6[Menu.buttonCount+1])
    Menu.addButton(other_female_models6[Menu.buttonCount+1], "savemodel", other_female_models6[Menu.buttonCount+1])
    Menu.addButton(other_female_models6[Menu.buttonCount+1], "savemodel", other_female_models6[Menu.buttonCount+1])
    Menu.addButton(other_female_models6[Menu.buttonCount+1], "savemodel", other_female_models6[Menu.buttonCount+1])
    Menu.addButton(other_female_models6[Menu.buttonCount+1], "savemodel", other_female_models6[Menu.buttonCount+1])
    Menu.addButton(other_female_models6[Menu.buttonCount+1], "savemodel", other_female_models6[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale7",nil)
    Menu.addButton("Previous Page","OtherMenuFemale5",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 7/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale7()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 7 of 9"
    ClearMenu()
    Menu.addButton(other_female_models7[Menu.buttonCount+1], "savemodel", other_female_models7[Menu.buttonCount+1])
    Menu.addButton(other_female_models7[Menu.buttonCount+1], "savemodel", other_female_models7[Menu.buttonCount+1])
    Menu.addButton(other_female_models7[Menu.buttonCount+1], "savemodel", other_female_models7[Menu.buttonCount+1])
    Menu.addButton(other_female_models7[Menu.buttonCount+1], "savemodel", other_female_models7[Menu.buttonCount+1])
    Menu.addButton(other_female_models7[Menu.buttonCount+1], "savemodel", other_female_models7[Menu.buttonCount+1])
    Menu.addButton(other_female_models7[Menu.buttonCount+1], "savemodel", other_female_models7[Menu.buttonCount+1])
    Menu.addButton(other_female_models7[Menu.buttonCount+1], "savemodel", other_female_models7[Menu.buttonCount+1])
    Menu.addButton(other_female_models7[Menu.buttonCount+1], "savemodel", other_female_models7[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale8",nil)
    Menu.addButton("Previous Page","OtherMenuFemale6",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 8/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale8()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 8 of 9"
    ClearMenu()
    Menu.addButton(other_female_models8[Menu.buttonCount+1], "savemodel", other_female_models8[Menu.buttonCount+1])
    Menu.addButton(other_female_models8[Menu.buttonCount+1], "savemodel", other_female_models8[Menu.buttonCount+1])
    Menu.addButton(other_female_models8[Menu.buttonCount+1], "savemodel", other_female_models8[Menu.buttonCount+1])
    Menu.addButton(other_female_models8[Menu.buttonCount+1], "savemodel", other_female_models8[Menu.buttonCount+1])
    Menu.addButton(other_female_models8[Menu.buttonCount+1], "savemodel", other_female_models8[Menu.buttonCount+1])
    Menu.addButton(other_female_models8[Menu.buttonCount+1], "savemodel", other_female_models8[Menu.buttonCount+1])
    Menu.addButton(other_female_models8[Menu.buttonCount+1], "savemodel", other_female_models8[Menu.buttonCount+1])
    Menu.addButton(other_female_models8[Menu.buttonCount+1], "savemodel", other_female_models8[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale9",nil)
    Menu.addButton("Previous Page","OtherMenuFemale7",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 9/9
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherMenuFemale9()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Other Females           Page 9 of 9"
    ClearMenu()
    Menu.addButton(other_female_models9[Menu.buttonCount+1], "savemodel", other_female_models9[Menu.buttonCount+1])
    Menu.addButton("Next Page","OtherMenuFemale",nil)
    Menu.addButton("Previous Page","OtherMenuFemale8",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 1/2
--Multiplayer Models
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MPMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "MP Models               Page 1 of 2"
    ClearMenu()
    Menu.addButton(mp_models[Menu.buttonCount+1], "savemodel", mp_models[Menu.buttonCount+1])
    Menu.addButton(mp_models[Menu.buttonCount+1], "savempmodel", mp_models[Menu.buttonCount+1])
    Menu.addButton(mp_models[Menu.buttonCount+1], "savemodel", mp_models[Menu.buttonCount+1])
    Menu.addButton(mp_models[Menu.buttonCount+1], "savemodel", mp_models[Menu.buttonCount+1])
    Menu.addButton(mp_models[Menu.buttonCount+1], "savemodel", mp_models[Menu.buttonCount+1])
    Menu.addButton(mp_models[Menu.buttonCount+1], "savemodel", mp_models[Menu.buttonCount+1])
    Menu.addButton(mp_models[Menu.buttonCount+1], "savemodel", mp_models[Menu.buttonCount+1])
    Menu.addButton("Next Page","MPMenu2",nil)
    Menu.addButton("Previous Page","MPMenu2",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others Menu        Page 2/2
--Multiplayer Models
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MPMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "MP Models               Page 2 of 2"
    ClearMenu()
    Menu.addButton(mp_models2[Menu.buttonCount+1], "savemodel", mp_models2[Menu.buttonCount+1])
    Menu.addButton(mp_models2[Menu.buttonCount+1], "savemodel", mp_models2[Menu.buttonCount+1])
    Menu.addButton(mp_models2[Menu.buttonCount+1], "savempmodel", mp_models2[Menu.buttonCount+1])
    Menu.addButton(mp_models2[Menu.buttonCount+1], "savemodel", mp_models2[Menu.buttonCount+1])
    Menu.addButton(mp_models2[Menu.buttonCount+1], "savemodel", mp_models2[Menu.buttonCount+1])
    Menu.addButton(mp_models2[Menu.buttonCount+1], "savemodel", mp_models2[Menu.buttonCount+1])
    Menu.addButton(mp_models2[Menu.buttonCount+1], "savemodel", mp_models2[Menu.buttonCount+1])
    Menu.addButton("Next Page","MPMenu",nil)
    Menu.addButton("Previous Page","MPMenu",nil)	
    Menu.addButton("Return","OtherMenu",nil)
end
--[[
     _                                    _           
    / \   ___ ___ ___  ___ ___  ___  _ __(_) ___  ___ 
   / _ \ / __/ __/ _ \/ __/ __|/ _ \| '__| |/ _ \/ __|
  / ___ \ (_| (_|  __/\__ \__ \ (_) | |  | |  __/\__ \
 /_/   \_\___\___\___||___/___/\___/|_|  |_|\___||___/
                                                      
]]

function Accessories()
    texture_help = false
    options.menu_subtitle = "Accessories"
    ClearMenu()
    Menu.addButton("Hats", "HatChecker")
    Menu.addButton("Glasses", "GlassesChecker")
    Menu.addButton("Earings", "PercingChecker")
    Menu.addButton("Masks", "MaskMenu")
	Menu.addButton("Remove Accessories", "RemoveAccessories")
    Menu.addButton("Return","Customisation",nil)
end

function RemoveAccessories()
    options.menu_subtitle = "Accessories"
    ClearMenu()
    Menu.addButton("Remove hat", "riphat",nil)
    Menu.addButton("Remove glasses", "ripglasses",nil)
    Menu.addButton("Remove earrings", "ripearrings",nil)
    Menu.addButton("Remove mask", "ripmask",nil)
    Menu.addButton("Return","Accessories",nil)
end

function riphat()
	ClearPedProp(GetPlayerPed(-1),0)
end
function ripglasses()
	ClearPedProp(GetPlayerPed(-1),1)
end
function ripearrings()
	ClearPedProp(GetPlayerPed(-1),2)
end
function ripmask()
	c_options.mask = 0
    SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(c_options.mask), 0, 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 1/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function MaskMenu()
    texture_help = true
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 1 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg1[Menu.buttonCount+1], "savemask", ass.masks_pg1[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg1[Menu.buttonCount+1], "savemask", ass.masks_pg1[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg1[Menu.buttonCount+1], "savemask", ass.masks_pg1[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg1[Menu.buttonCount+1], "savemask", ass.masks_pg1[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg1[Menu.buttonCount+1], "savemask", ass.masks_pg1[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg1[Menu.buttonCount+1], "savemask", ass.masks_pg1[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg1[Menu.buttonCount+1], "savemask", ass.masks_pg1[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg1[Menu.buttonCount+1], "savemask", ass.masks_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu2",nil)
    Menu.addButton("Previous Page","MaskMenu9",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 2/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaskMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 2 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg2[Menu.buttonCount+1], "savemask", ass.masks_pg2[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg2[Menu.buttonCount+1], "savemask", ass.masks_pg2[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg2[Menu.buttonCount+1], "savemask", ass.masks_pg2[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg2[Menu.buttonCount+1], "savemask", ass.masks_pg2[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg2[Menu.buttonCount+1], "savemask", ass.masks_pg2[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg2[Menu.buttonCount+1], "savemask", ass.masks_pg2[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg2[Menu.buttonCount+1], "savemask", ass.masks_pg2[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg2[Menu.buttonCount+1], "savemask", ass.masks_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu3",nil)
    Menu.addButton("Previous Page","MaskMenu",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 3/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaskMenu3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 3 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg3[Menu.buttonCount+1], "savemask", ass.masks_pg3[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg3[Menu.buttonCount+1], "savemask", ass.masks_pg3[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg3[Menu.buttonCount+1], "savemask", ass.masks_pg3[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg3[Menu.buttonCount+1], "savemask", ass.masks_pg3[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg3[Menu.buttonCount+1], "savemask", ass.masks_pg3[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg3[Menu.buttonCount+1], "savemask", ass.masks_pg3[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg3[Menu.buttonCount+1], "savemask", ass.masks_pg3[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg3[Menu.buttonCount+1], "savemask", ass.masks_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu4",nil)
    Menu.addButton("Previous Page","MaskMenu2",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 4/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaskMenu4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 4 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg4[Menu.buttonCount+1], "savemask", ass.masks_pg4[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg4[Menu.buttonCount+1], "savemask", ass.masks_pg4[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg4[Menu.buttonCount+1], "savemask", ass.masks_pg4[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg4[Menu.buttonCount+1], "savemask", ass.masks_pg4[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg4[Menu.buttonCount+1], "savemask", ass.masks_pg4[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg4[Menu.buttonCount+1], "savemask", ass.masks_pg4[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg4[Menu.buttonCount+1], "savemask", ass.masks_pg4[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg4[Menu.buttonCount+1], "savemask", ass.masks_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu5",nil)
    Menu.addButton("Previous Page","MaskMenu3",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 5/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaskMenu5()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 5 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg5[Menu.buttonCount+1], "savemask", ass.masks_pg5[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg5[Menu.buttonCount+1], "savemask", ass.masks_pg5[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg5[Menu.buttonCount+1], "savemask", ass.masks_pg5[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg5[Menu.buttonCount+1], "savemask", ass.masks_pg5[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg5[Menu.buttonCount+1], "savemask", ass.masks_pg5[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg5[Menu.buttonCount+1], "savemask", ass.masks_pg5[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg5[Menu.buttonCount+1], "savemask", ass.masks_pg5[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg5[Menu.buttonCount+1], "savemask", ass.masks_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu6",nil)
    Menu.addButton("Previous Page","MaskMenu4",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 6/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaskMenu6()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 6 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg6[Menu.buttonCount+1], "savemask", ass.masks_pg6[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg6[Menu.buttonCount+1], "savemask", ass.masks_pg6[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg6[Menu.buttonCount+1], "savemask", ass.masks_pg6[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg6[Menu.buttonCount+1], "savemask", ass.masks_pg6[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg6[Menu.buttonCount+1], "savemask", ass.masks_pg6[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg6[Menu.buttonCount+1], "savemask", ass.masks_pg6[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg6[Menu.buttonCount+1], "savemask", ass.masks_pg6[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg6[Menu.buttonCount+1], "savemask", ass.masks_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu7",nil)
    Menu.addButton("Previous Page","MaskMenu6",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 7/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaskMenu7()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 7 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg7[Menu.buttonCount+1], "savemask", ass.masks_pg7[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg7[Menu.buttonCount+1], "savemask", ass.masks_pg7[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg7[Menu.buttonCount+1], "savemask", ass.masks_pg7[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg7[Menu.buttonCount+1], "savemask", ass.masks_pg7[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg7[Menu.buttonCount+1], "savemask", ass.masks_pg7[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg7[Menu.buttonCount+1], "savemask", ass.masks_pg7[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg7[Menu.buttonCount+1], "savemask", ass.masks_pg7[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg7[Menu.buttonCount+1], "savemask", ass.masks_pg7[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu8",nil)
    Menu.addButton("Previous Page","MaskMenu6",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 8/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaskMenu8()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 8 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg8[Menu.buttonCount+1], "savemask", ass.masks_pg8[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg8[Menu.buttonCount+1], "savemask", ass.masks_pg8[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg8[Menu.buttonCount+1], "savemask", ass.masks_pg8[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg8[Menu.buttonCount+1], "savemask", ass.masks_pg8[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg8[Menu.buttonCount+1], "savemask", ass.masks_pg8[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg8[Menu.buttonCount+1], "savemask", ass.masks_pg8[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg8[Menu.buttonCount+1], "savemask", ass.masks_pg8[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg8[Menu.buttonCount+1], "savemask", ass.masks_pg8[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu9",nil)
    Menu.addButton("Previous Page","MaskMenu7",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 9/9
--Masks
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaskMenu9()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 9 of 9"
    ClearMenu()
    Menu.addButton(acc.masks_pg9[Menu.buttonCount+1], "savemask", ass.masks_pg9[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg9[Menu.buttonCount+1], "savemask", ass.masks_pg9[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg9[Menu.buttonCount+1], "savemask", ass.masks_pg9[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg9[Menu.buttonCount+1], "savemask", ass.masks_pg9[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg9[Menu.buttonCount+1], "savemask", ass.masks_pg9[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg9[Menu.buttonCount+1], "savemask", ass.masks_pg9[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg9[Menu.buttonCount+1], "savemask", ass.masks_pg9[Menu.buttonCount+1])
    Menu.addButton(acc.masks_pg9[Menu.buttonCount+1], "savemask", ass.masks_pg9[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaskMenu",nil)
    Menu.addButton("Previous Page","MaskMenu8",nil)
    Menu.addButton("Return","Accessories",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 1/4
--Textures
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function maskTextures()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                Page 1 of 4"
    ClearMenu()
    Menu.addButton(ass.txt_pg1[Menu.buttonCount+1], "savetxt", ass.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg1[Menu.buttonCount+1], "savetxt", ass.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg1[Menu.buttonCount+1], "savetxt", ass.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg1[Menu.buttonCount+1], "savetxt", ass.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg1[Menu.buttonCount+1], "savetxt", ass.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg1[Menu.buttonCount+1], "savetxt", ass.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg1[Menu.buttonCount+1], "savetxt", ass.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg1[Menu.buttonCount+1], "savetxt", ass.txt_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","maskTextures2",nil)
    Menu.addButton("Previous Page","maskTextures4",nil)
    Menu.addButton("Return","MaskMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 2/4
--Textures
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function maskTextures2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                Page 2 of 4"
    ClearMenu()
    Menu.addButton(ass.txt_pg2[Menu.buttonCount+1], "savetxt", ass.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg2[Menu.buttonCount+1], "savetxt", ass.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg2[Menu.buttonCount+1], "savetxt", ass.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg2[Menu.buttonCount+1], "savetxt", ass.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg2[Menu.buttonCount+1], "savetxt", ass.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg2[Menu.buttonCount+1], "savetxt", ass.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg2[Menu.buttonCount+1], "savetxt", ass.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg2[Menu.buttonCount+1], "savetxt", ass.txt_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","maskTextures3",nil)
    Menu.addButton("Previous Page","maskTextures",nil)
    Menu.addButton("Return","MaskMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 3/4
--Textures
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function maskTextures3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                Page 3 of 4"
    ClearMenu()
    Menu.addButton(ass.txt_pg3[Menu.buttonCount+1], "savetxt", ass.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg3[Menu.buttonCount+1], "savetxt", ass.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg3[Menu.buttonCount+1], "savetxt", ass.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg3[Menu.buttonCount+1], "savetxt", ass.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg3[Menu.buttonCount+1], "savetxt", ass.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg3[Menu.buttonCount+1], "savetxt", ass.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg3[Menu.buttonCount+1], "savetxt", ass.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg3[Menu.buttonCount+1], "savetxt", ass.txt_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","maskTextures4",nil)
    Menu.addButton("Previous Page","maskTextures2",nil)
    Menu.addButton("Return","MaskMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu                     Page 4/4
--Textures
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function maskTextures4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                Page 4 of 4"
    ClearMenu()
    Menu.addButton(ass.txt_pg4[Menu.buttonCount+1], "savetxt", ass.txt_pg4[Menu.buttonCount+1])
    Menu.addButton(ass.txt_pg4[Menu.buttonCount+1], "savetxt", ass.txt_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","maskTextures",nil)
    Menu.addButton("Previous Page","maskTextures3",nil)
    Menu.addButton("Return","MaskMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mask Menu             --Credit to izio38 for helping me with one of my annoying errors :)
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function savemask(mask) --Sets Players mask in database
    c_options.mask = mask
    SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(c_options.mask), 0, 0)
    maskTextures()
end

function savetxt(mask_txt) --Sets mask texture in database
    c_options.mask_txt = mask_txt
    SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(c_options.mask), tonumber(c_options.mask_txt), 0)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Hat, Earrings and Glasses
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Credits to JcPires for this crap \/\/\/
function HatChecker()
	TriggerServerEvent("mm:wearHat")
end

function PercingChecker()
    TriggerServerEvent("mm:wearPercing")
end

function GlassesChecker()
    TriggerServerEvent("mm:wearGlasses")
end


RegisterNetEvent("mm:Hatwear")
AddEventHandler("mm:Hatwear", function(item)
    SetPedPropIndex(GetPlayerPed(-1), 0, item.helmet,item.helmet_txt, 0)
end)

RegisterNetEvent("mm:Percingwear")
AddEventHandler("mm:Percingwear", function(item)
    SetPedPropIndex(GetPlayerPed(-1), 2, item.percing,item.percing_txt, 0)
end)

RegisterNetEvent("mm:Glasseswear")
AddEventHandler("mm:Glasseswear", function(item)
    SetPedPropIndex(GetPlayerPed(-1), 1, item.glasses,item.glasses_txt, 0)
end)
--[[
  ______                           _                 _               
 / _____)          _              (_)           _   (_)              
| /     _   _  ___| |_  ___  ____  _  ___  ____| |_  _  ___  ____    
| |    | | | |/___)  _)/ _ \|    \| |/___)/ _  |  _)| |/ _ \|  _ \   
| \____| |_| |___ | |_| |_| | | | | |___ ( ( | | |__| | |_| | | | |  
 \______)____(___/ \___)___/|_|_|_|_(___/ \_||_|\___)_|\___/|_| |_|                                                                 
]]
function Customisation()
    shirt_help = false
    texture_help = false
    options.menu_title = "Customisation"
    options.menu_subtitle = "Customise your character"
    ClearMenu()
    Menu.addButton("Accessories", "Accessories")
    --Menu.addButton("Head", "HeadMenu")
    Menu.addButton("Head", "TempHeadMenu")
    Menu.addButton("Hair", "HairMenu")
    Menu.addButton("Shirt", "MainShirtMenu")
    Menu.addButton("Undershirt", "UndershirtMenu")
    Menu.addButton("Armour", "ArmourMenu")
    Menu.addButton("Hands", "HandsMenu")
    Menu.addButton("Pants", "PantsMenu")
    Menu.addButton("Shoes", "ShoeMenu")
    Menu.addButton("Return","Main",nil)
end
--Females 34,45,33,21
--Males 1,12,13,22,42,43,44
function TempHeadMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Gender"
    ClearMenu()
    Menu.addButton("Male","TempMaleHeadMenu",nil)
    Menu.addButton("Female","TempFemaleHeadMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Temp-Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TempMaleHeadMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Heads"
    ClearMenu()
    Menu.addButton(head.mname[Menu.buttonCount+1], "savehead", head.mhead[Menu.buttonCount+1])
    Menu.addButton(head.mname[Menu.buttonCount+1], "savehead", head.mhead[Menu.buttonCount+1])
    Menu.addButton(head.mname[Menu.buttonCount+1], "savehead", head.mhead[Menu.buttonCount+1])
    Menu.addButton(head.mname[Menu.buttonCount+1], "savehead", head.mhead[Menu.buttonCount+1])
    Menu.addButton(head.mname[Menu.buttonCount+1], "savehead", head.mhead[Menu.buttonCount+1])
    Menu.addButton(head.mname[Menu.buttonCount+1], "savehead", head.mhead[Menu.buttonCount+1])
    Menu.addButton(head.mname[Menu.buttonCount+1], "savehead", head.mhead[Menu.buttonCount+1])
    Menu.addButton(head.mname[Menu.buttonCount+1], "savehead", head.mhead[Menu.buttonCount+1])
    Menu.addButton("Return","TempHeadMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Temp-Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TempFemaleHeadMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Heads"
    ClearMenu()
    Menu.addButton(head.fname[Menu.buttonCount+1], "savehead", head.fhead[Menu.buttonCount+1])
    Menu.addButton(head.fname[Menu.buttonCount+1], "savehead", head.fhead[Menu.buttonCount+1])
    Menu.addButton(head.fname[Menu.buttonCount+1], "savehead", head.fhead[Menu.buttonCount+1])
    Menu.addButton(head.fname[Menu.buttonCount+1], "savehead", head.fhead[Menu.buttonCount+1])
    Menu.addButton("Return","TempHeadMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 1 of 6
--Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HeadMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Heads                   Page 1 of 6"
    ClearMenu()
    Menu.addButton(heads.name_pg1[Menu.buttonCount+1], "savehead", heads.drawable_pg1[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg1[Menu.buttonCount+1], "savehead", heads.drawable_pg1[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg1[Menu.buttonCount+1], "savehead", heads.drawable_pg1[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg1[Menu.buttonCount+1], "savehead", heads.drawable_pg1[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg1[Menu.buttonCount+1], "savehead", heads.drawable_pg1[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg1[Menu.buttonCount+1], "savehead", heads.drawable_pg1[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg1[Menu.buttonCount+1], "savehead", heads.drawable_pg1[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg1[Menu.buttonCount+1], "savehead", heads.drawable_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","HeadMenu2",nil)
    Menu.addButton("Previous Page","HeadMenu6",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 2 of 6
--Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HeadMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Heads                   Page 2 of 6"
    ClearMenu()
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","HeadMenu3",nil)
    Menu.addButton("Previous Page","HeadMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 3 of 6
--Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HeadMenu3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Heads                   Page 3 of 6"
    ClearMenu()
    Menu.addButton(heads.name_pg3[Menu.buttonCount+1], "savehead", heads.drawable_pg3[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg3[Menu.buttonCount+1], "savehead", heads.drawable_pg3[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg3[Menu.buttonCount+1], "savehead", heads.drawable_pg3[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg3[Menu.buttonCount+1], "savehead", heads.drawable_pg3[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg3[Menu.buttonCount+1], "savehead", heads.drawable_pg3[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg3[Menu.buttonCount+1], "savehead", heads.drawable_pg3[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg3[Menu.buttonCount+1], "savehead", heads.drawable_pg3[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg3[Menu.buttonCount+1], "savehead", heads.drawable_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","HeadMenu4",nil)
    Menu.addButton("Previous Page","HeadMenu2",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 4 of 6
--Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HeadMenu4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Heads                   Page 4 of 6"
    ClearMenu()
    Menu.addButton(heads.name_pg4[Menu.buttonCount+1], "savehead", heads.drawable_pg4[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg4[Menu.buttonCount+1], "savehead", heads.drawable_pg4[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg4[Menu.buttonCount+1], "savehead", heads.drawable_pg4[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg4[Menu.buttonCount+1], "savehead", heads.drawable_pg4[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg4[Menu.buttonCount+1], "savehead", heads.drawable_pg4[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg4[Menu.buttonCount+1], "savehead", heads.drawable_pg4[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg4[Menu.buttonCount+1], "savehead", heads.drawable_pg4[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg4[Menu.buttonCount+1], "savehead", heads.drawable_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","HeadMenu5",nil)
    Menu.addButton("Previous Page","HeadMenu3",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 5 of 6
--Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HeadMenu5()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Heads                   Page 5 of 6"
    ClearMenu()
    Menu.addButton(heads.name_pg5[Menu.buttonCount+1], "savehead", heads.drawable_pg5[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg5[Menu.buttonCount+1], "savehead", heads.drawable_pg5[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg5[Menu.buttonCount+1], "savehead", heads.drawable_pg5[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg5[Menu.buttonCount+1], "savehead", heads.drawable_pg5[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg5[Menu.buttonCount+1], "savehead", heads.drawable_pg5[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg5[Menu.buttonCount+1], "savehead", heads.drawable_pg5[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg5[Menu.buttonCount+1], "savehead", heads.drawable_pg5[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg5[Menu.buttonCount+1], "savehead", heads.drawable_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","HeadMenu6",nil)
    Menu.addButton("Previous Page","HeadMenu4",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 6 of 6
--Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HeadMenu6()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Heads                   Page 6 of 6"
    ClearMenu()
    Menu.addButton(heads.name_pg6[Menu.buttonCount+1], "savehead", heads.drawable_pg6[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg6[Menu.buttonCount+1], "savehead", heads.drawable_pg6[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg6[Menu.buttonCount+1], "savehead", heads.drawable_pg6[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg6[Menu.buttonCount+1], "savehead", heads.drawable_pg6[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg6[Menu.buttonCount+1], "savehead", heads.drawable_pg6[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg6[Menu.buttonCount+1], "savehead", heads.drawable_pg6[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg6[Menu.buttonCount+1], "savehead", heads.drawable_pg6[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg6[Menu.buttonCount+1], "savehead", heads.drawable_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","HeadMenu",nil)
    Menu.addButton("Previous Page","HeadMenu5",nil)
    Menu.addButton("Return","Customisation",nil)
end
--[[
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 2 of 6
--Head
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HeadMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Masks                   Page 2 of 6"
    ClearMenu()
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton(heads.name_pg2[Menu.buttonCount+1], "savehead", heads.drawable_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","HeadMenu",nil)
    Menu.addButton("Previous Page","HeadMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end
]]
--[[
	Head Functions
--]]
function savehead(head) --Sets Players head in database
    c_options.head = head
    SetPedComponentVariation(GetPlayerPed(-1), 0, tonumber(c_options.head), 0, 2)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Hair
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HairMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Gender"
    ClearMenu()
	Menu.addButton("Male","MaleHairMenu",nil)
    Menu.addButton("Female","FemaleHairMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 1 of 6
--Hair
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleHairMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair                      Page 1 of 4"
    ClearMenu()
    Menu.addButton(hair.m_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleHairMenu2",nil)
    Menu.addButton("Previous Page","MaleHairMenu4",nil)
    Menu.addButton("Return","HairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 2 of 4
--Hair
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleHairMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair                      Page 2 of 4"
    ClearMenu()
    Menu.addButton(hair.m_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleHairMenu3",nil)
    Menu.addButton("Previous Page","MaleHairMenu",nil)
    Menu.addButton("Return","HairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 3 of 4
--Hair
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleHairMenu3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair                      Page 3 of 4"
    ClearMenu()
    Menu.addButton(hair.m_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleHairMenu4",nil)
    Menu.addButton("Previous Page","MaleHairMenu2",nil)
    Menu.addButton("Return","HairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 4 of 4
--Hair
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleHairMenu4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair                      Page 4 of 4"
    ClearMenu()
    Menu.addButton(hair.m_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton(hair.m_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleHairMenu",nil)
    Menu.addButton("Previous Page","MaleHairMenu3",nil)
    Menu.addButton("Return","HairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 1 of 4
--Hair
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleHairMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair                      Page 1 of 4"
    ClearMenu()
    Menu.addButton(hair.f_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg1[Menu.buttonCount+1], "savehair", hair.hair_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleHairMenu2",nil)
    Menu.addButton("Previous Page","FemaleHairMenu4",nil)
    Menu.addButton("Return","HairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 2 of 4
--Hair
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleHairMenu2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair                      Page 2 of 4"
    ClearMenu()
    Menu.addButton(hair.f_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg2[Menu.buttonCount+1], "savehair", hair.hair_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleHairMenu3",nil)
    Menu.addButton("Previous Page","FemaleHairMenu",nil)
    Menu.addButton("Return","HairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 3 of 4
--Hair
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleHairMenu3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair                      Page 3 of 4"
    ClearMenu()
    Menu.addButton(hair.f_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg3[Menu.buttonCount+1], "savehair", hair.hair_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleHairMenu4",nil)
    Menu.addButton("Previous Page","FemaleHairMenu2",nil)
    Menu.addButton("Return","HairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       Page 4 of 4
--Hair
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleHairMenu4()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair                      Page 4 of 4"
    ClearMenu()
    Menu.addButton(hair.f_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton(hair.f_name_pg4[Menu.buttonCount+1], "savehair", hair.hair_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleHairMenu",nil)
    Menu.addButton("Previous Page","FemaleHairMenu3",nil)
    Menu.addButton("Return","HairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Hair
--Colour
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HairColour()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hair Colour    M     F"
    ClearMenu()
    Menu.addButton(hair.hcolour_name[Menu.buttonCount+1], "savecolour", hair.hcolour[Menu.buttonCount+1])
    Menu.addButton(hair.hcolour_name[Menu.buttonCount+1], "savecolour", hair.hcolour[Menu.buttonCount+1])
    Menu.addButton(hair.hcolour_name[Menu.buttonCount+1], "savecolour", hair.hcolour[Menu.buttonCount+1])
    Menu.addButton(hair.hcolour_name[Menu.buttonCount+1], "savecolour", hair.hcolour[Menu.buttonCount+1])
    Menu.addButton(hair.hcolour_name[Menu.buttonCount+1], "savecolour", hair.hcolour[Menu.buttonCount+1])
    Menu.addButton(hair.hcolour_name[Menu.buttonCount+1], "savecolour", hair.hcolour[Menu.buttonCount+1])
    Menu.addButton(hair.hcolour_name[Menu.buttonCount+1], "savecolour", hair.hcolour[Menu.buttonCount+1])
    Menu.addButton("Return to male section","MaleHairMenu",nil)
    Menu.addButton("Return to female section","FemaleHairMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Hair 
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function savehair(hair) --Sets Players head in database
    c_options.hair = hair
    SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(c_options.hair), 0, 0)
    HairColour()
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Hair Textures
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function savecolour(hcolour) --Sets mask texture in database
    c_options.hcolour = hcolour
    SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(c_options.hair), tonumber(c_options.hcolour), 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MainShirtMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Gender"
    ClearMenu()
    Menu.addButton("Male","ShirtMenu",nil)
    Menu.addButton("Female","FemaleShirtMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 1/12
--Male Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 1 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg1[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg1[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg1[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg1[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg1[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg1[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg1[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu2",nil)
    Menu.addButton("Previous Page","ShirtMenu12",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 2/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 2 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg2[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg2[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg2[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg2[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg2[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg2[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu3",nil)
    Menu.addButton("Previous Page","ShirtMenu",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 3/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 3 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg3[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg3[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg3[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg3[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg3[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg3[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu4",nil)
    Menu.addButton("Previous Page","ShirtMenu2",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 4/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu4()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 4 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg4[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg4[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg4[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg4[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg4[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg4[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg4[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu5",nil)
    Menu.addButton("Previous Page","ShirtMenu3",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 5/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu5()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 5 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg5[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg5[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg5[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg5[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg5[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg5[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg5[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu6",nil)
    Menu.addButton("Previous Page","ShirtMenu4",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 6/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu6()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 6 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg6[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg6[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg6[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg6[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg6[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg6[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu7",nil)
    Menu.addButton("Previous Page","ShirtMenu5",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 7/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu7()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 7 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg7[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg7[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg7[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg7[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg7[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg7[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg7[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu8",nil)
    Menu.addButton("Previous Page","ShirtMenu6",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 8/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu8()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 8 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg8[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg8[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg8[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg8[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg8[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg8[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg8[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg8[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu9",nil)
    Menu.addButton("Previous Page","ShirtMenu7",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 9/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu9()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 9 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg9[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg9[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg9[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg9[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg9[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg9[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg9[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg9[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu10",nil)
    Menu.addButton("Previous Page","ShirtMenu8",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 10/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu10()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 10 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg10[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg10[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg10[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg10[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg10[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg10[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg10[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg10[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu11",nil)
    Menu.addButton("Previous Page","ShirtMenu9",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 11/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu11()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 11 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg11[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg11[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg11[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg11[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg11[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg11[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg11[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg11[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu12",nil)
    Menu.addButton("Previous Page","ShirtMenu10",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 12/12
--Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShirtMenu12()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 12 of 12"
    ClearMenu()
    Menu.addButton(shirts.names_pg12[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg12[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg12[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg12[Menu.buttonCount+1])
    Menu.addButton(shirts.names_pg12[Menu.buttonCount+1], "saveshirt", shirts.shirts_pg12[Menu.buttonCount+1])
    Menu.addButton("Next Page","ShirtMenu",nil)
    Menu.addButton("Previous Page","ShirtMenu11",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 1/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 1 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg1[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg1[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg1[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg1[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg1[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg1[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg1[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu2",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu11",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 2/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu2()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 2 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg2[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg2[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg2[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg2[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg2[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg2[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg2[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu3",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 3/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu3()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 3 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg3[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg3[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg3[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg3[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg3[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg3[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg3[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu4",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu2",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 4/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu4()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 4 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg4[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg4[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg4[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg4[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg4[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg4[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg4[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu5",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu3",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 5/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu5()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 5 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg5[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg5[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg5[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg5[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg5[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg5[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg5[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu6",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu4",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 6/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu6()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 6 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg6[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg6[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg6[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg6[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg6[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg6[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg6[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu7",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu5",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 7/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu7()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 7 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg7[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg7[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg7[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg7[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg7[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg7[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg7[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg7[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu8",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu6",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 8/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu8()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 8 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg8[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg8[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg8[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg8[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg8[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg8[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg8[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg8[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu9",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu7",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 9/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu9()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 9 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg9[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg9[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg9[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg9[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg9[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg9[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg9[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg9[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu10",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu8",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 10/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu10()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 10 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg10[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg10[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg10[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg10[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg10[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg10[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg10[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg10[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu11",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu9",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 11/11
--Female Shirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShirtMenu11()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shirts                  Page 11 of 11"
    ClearMenu()
    Menu.addButton(fshirts.name_pg11[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg11[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg11[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg11[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg11[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg11[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton(fshirts.name_pg11[Menu.buttonCount+1], "saveshirt", fshirts.shirts_pg11[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShirtMenu",nil)
    Menu.addButton("Previous Page","FemaleShirtMenu10",nil)
    Menu.addButton("Return","MainShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shirts
--Textures						Page 1/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function shirtTextures()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 1 of 3"
    ClearMenu()
    Menu.addButton(shirts.txt_pg1[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg1[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg1[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg1[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg1[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg1[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg1[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg1[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","shirtTextures2",nil)
    Menu.addButton("Previous Page","shirtTextures",nil)
    Menu.addButton("Return to male section","ShirtMenu",nil)
    Menu.addButton("Return to female section","FemaleShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shirts
--Textures						Page 2/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function shirtTextures2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 2 of 3"
    ClearMenu()
    Menu.addButton(shirts.txt_pg2[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg2[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg2[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg2[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg2[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg2[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg2[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg2[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","shirtTextures3",nil)
    Menu.addButton("Previous Page","shirtTextures",nil)
    Menu.addButton("Return to male section","ShirtMenu",nil)
    Menu.addButton("Return to female section","FemaleShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shirts
--Textures						Page 3/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function shirtTextures3()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 3 of 3"
    ClearMenu()
    Menu.addButton(shirts.txt_pg3[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg3[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg3[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg3[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg3[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg3[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg3[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shirts.txt_pg3[Menu.buttonCount+1], "saveshirt_txt", shirts.txt_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","shirtTextures",nil)
    Menu.addButton("Previous Page","shirtTextures2",nil)
    Menu.addButton("Return to male section","ShirtMenu",nil)
    Menu.addButton("Return to female section","FemaleShirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shirts 
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function saveshirt(shirt) --Sets Players head in database
    c_options.shirt = shirt
    SetPedComponentVariation(GetPlayerPed(-1), 11, 0, 240, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 240, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 11, tonumber(c_options.shirt), 0, 0)
    shirtTextures()
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shirt Textures
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function saveshirt_txt(shirt_txt) --Sets mask texture in database
    c_options.shirt_txt = shirt_txt
    SetPedComponentVariation(GetPlayerPed(-1), 11, tonumber(c_options.shirt), tonumber(c_options.shirt_txt), 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 1/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 1 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg1[Menu.buttonCount+1], "savehand", hands.hands_pg1[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg1[Menu.buttonCount+1], "savehand", hands.hands_pg1[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg1[Menu.buttonCount+1], "savehand", hands.hands_pg1[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg1[Menu.buttonCount+1], "savehand", hands.hands_pg1[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg1[Menu.buttonCount+1], "savehand", hands.hands_pg1[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg1[Menu.buttonCount+1], "savehand", hands.hands_pg1[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg1[Menu.buttonCount+1], "savehand", hands.hands_pg1[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg1[Menu.buttonCount+1], "savehand", hands.hands_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu2",nil)
    Menu.addButton("Previous Page","HandsMenu13",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 2/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 2 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg2[Menu.buttonCount+1], "savehand", hands.hands_pg2[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg2[Menu.buttonCount+1], "savehand", hands.hands_pg2[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg2[Menu.buttonCount+1], "savehand", hands.hands_pg2[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg2[Menu.buttonCount+1], "savehand", hands.hands_pg2[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg2[Menu.buttonCount+1], "savehand", hands.hands_pg2[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg2[Menu.buttonCount+1], "savehand", hands.hands_pg2[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg2[Menu.buttonCount+1], "savehand", hands.hands_pg2[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg2[Menu.buttonCount+1], "savehand", hands.hands_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu3",nil)
    Menu.addButton("Previous Page","HandsMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 3/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 3 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg3[Menu.buttonCount+1], "savehand", hands.hands_pg3[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg3[Menu.buttonCount+1], "savehand", hands.hands_pg3[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg3[Menu.buttonCount+1], "savehand", hands.hands_pg3[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg3[Menu.buttonCount+1], "savehand", hands.hands_pg3[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg3[Menu.buttonCount+1], "savehand", hands.hands_pg3[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg3[Menu.buttonCount+1], "savehand", hands.hands_pg3[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg3[Menu.buttonCount+1], "savehand", hands.hands_pg3[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg3[Menu.buttonCount+1], "savehand", hands.hands_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu4",nil)
    Menu.addButton("Previous Page","HandsMenu2",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 4/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu4()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 4 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg4[Menu.buttonCount+1], "savehand", hands.hands_pg4[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg4[Menu.buttonCount+1], "savehand", hands.hands_pg4[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg4[Menu.buttonCount+1], "savehand", hands.hands_pg4[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg4[Menu.buttonCount+1], "savehand", hands.hands_pg4[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg4[Menu.buttonCount+1], "savehand", hands.hands_pg4[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg4[Menu.buttonCount+1], "savehand", hands.hands_pg4[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg4[Menu.buttonCount+1], "savehand", hands.hands_pg4[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg4[Menu.buttonCount+1], "savehand", hands.hands_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu5",nil)
    Menu.addButton("Previous Page","HandsMenu3",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 5/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu5()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 5 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg5[Menu.buttonCount+1], "savehand", hands.hands_pg5[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg5[Menu.buttonCount+1], "savehand", hands.hands_pg5[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg5[Menu.buttonCount+1], "savehand", hands.hands_pg5[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg5[Menu.buttonCount+1], "savehand", hands.hands_pg5[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg5[Menu.buttonCount+1], "savehand", hands.hands_pg5[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg5[Menu.buttonCount+1], "savehand", hands.hands_pg5[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg5[Menu.buttonCount+1], "savehand", hands.hands_pg5[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg5[Menu.buttonCount+1], "savehand", hands.hands_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu6",nil)
    Menu.addButton("Previous Page","HandsMenu4",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 6/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu6()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 6 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg6[Menu.buttonCount+1], "savehand", hands.hands_pg6[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg6[Menu.buttonCount+1], "savehand", hands.hands_pg6[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg6[Menu.buttonCount+1], "savehand", hands.hands_pg6[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg6[Menu.buttonCount+1], "savehand", hands.hands_pg6[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg6[Menu.buttonCount+1], "savehand", hands.hands_pg6[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg6[Menu.buttonCount+1], "savehand", hands.hands_pg6[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg6[Menu.buttonCount+1], "savehand", hands.hands_pg6[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg6[Menu.buttonCount+1], "savehand", hands.hands_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu7",nil)
    Menu.addButton("Previous Page","HandsMenu5",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 7/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu7()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 7 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg7[Menu.buttonCount+1], "savehand", hands.hands_pg7[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg7[Menu.buttonCount+1], "savehand", hands.hands_pg7[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg7[Menu.buttonCount+1], "savehand", hands.hands_pg7[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg7[Menu.buttonCount+1], "savehand", hands.hands_pg7[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg7[Menu.buttonCount+1], "savehand", hands.hands_pg7[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg7[Menu.buttonCount+1], "savehand", hands.hands_pg7[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg7[Menu.buttonCount+1], "savehand", hands.hands_pg7[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg7[Menu.buttonCount+1], "savehand", hands.hands_pg7[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu9",nil)
    Menu.addButton("Previous Page","HandsMenu6",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 8/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu8()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 8 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg8[Menu.buttonCount+1], "savehand", hands.hands_pg8[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg8[Menu.buttonCount+1], "savehand", hands.hands_pg8[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg8[Menu.buttonCount+1], "savehand", hands.hands_pg8[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg8[Menu.buttonCount+1], "savehand", hands.hands_pg8[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg8[Menu.buttonCount+1], "savehand", hands.hands_pg8[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg8[Menu.buttonCount+1], "savehand", hands.hands_pg8[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg8[Menu.buttonCount+1], "savehand", hands.hands_pg8[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg8[Menu.buttonCount+1], "savehand", hands.hands_pg8[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu9",nil)
    Menu.addButton("Previous Page","HandsMenu7",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 9/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu9()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 9 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg9[Menu.buttonCount+1], "savehand", hands.hands_pg9[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg9[Menu.buttonCount+1], "savehand", hands.hands_pg9[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg9[Menu.buttonCount+1], "savehand", hands.hands_pg9[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg9[Menu.buttonCount+1], "savehand", hands.hands_pg9[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg9[Menu.buttonCount+1], "savehand", hands.hands_pg9[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg9[Menu.buttonCount+1], "savehand", hands.hands_pg9[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg9[Menu.buttonCount+1], "savehand", hands.hands_pg9[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg9[Menu.buttonCount+1], "savehand", hands.hands_pg9[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu10",nil)
    Menu.addButton("Previous Page","HandsMenu8",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 10/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu10()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 10 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg10[Menu.buttonCount+1], "savehand", hands.hands_pg10[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg10[Menu.buttonCount+1], "savehand", hands.hands_pg10[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg10[Menu.buttonCount+1], "savehand", hands.hands_pg10[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg10[Menu.buttonCount+1], "savehand", hands.hands_pg10[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg10[Menu.buttonCount+1], "savehand", hands.hands_pg10[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg10[Menu.buttonCount+1], "savehand", hands.hands_pg10[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg10[Menu.buttonCount+1], "savehand", hands.hands_pg10[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg10[Menu.buttonCount+1], "savehand", hands.hands_pg10[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu11",nil)
    Menu.addButton("Previous Page","HandsMenu9",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 11/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu11()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 11 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg11[Menu.buttonCount+1], "savehand", hands.hands_pg11[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg11[Menu.buttonCount+1], "savehand", hands.hands_pg11[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg11[Menu.buttonCount+1], "savehand", hands.hands_pg11[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg11[Menu.buttonCount+1], "savehand", hands.hands_pg11[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg11[Menu.buttonCount+1], "savehand", hands.hands_pg11[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg11[Menu.buttonCount+1], "savehand", hands.hands_pg11[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg11[Menu.buttonCount+1], "savehand", hands.hands_pg11[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg11[Menu.buttonCount+1], "savehand", hands.hands_pg11[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu12",nil)
    Menu.addButton("Previous Page","HandsMenu10",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 12/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu12()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 12 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg12[Menu.buttonCount+1], "savehand", hands.hands_pg12[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg12[Menu.buttonCount+1], "savehand", hands.hands_pg12[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg12[Menu.buttonCount+1], "savehand", hands.hands_pg12[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg12[Menu.buttonCount+1], "savehand", hands.hands_pg12[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg12[Menu.buttonCount+1], "savehand", hands.hands_pg12[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg12[Menu.buttonCount+1], "savehand", hands.hands_pg12[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg12[Menu.buttonCount+1], "savehand", hands.hands_pg12[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg12[Menu.buttonCount+1], "savehand", hands.hands_pg12[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu13",nil)
    Menu.addButton("Previous Page","HandsMenu11",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 13/13
--Hands
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandsMenu13()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Hands                    Page 13 of 13"
    ClearMenu()
    Menu.addButton(hands.hands_pg13[Menu.buttonCount+1], "savehand", hands.hands_pg13[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg13[Menu.buttonCount+1], "savehand", hands.hands_pg13[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg13[Menu.buttonCount+1], "savehand", hands.hands_pg13[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg13[Menu.buttonCount+1], "savehand", hands.hands_pg13[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg13[Menu.buttonCount+1], "savehand", hands.hands_pg13[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg13[Menu.buttonCount+1], "savehand", hands.hands_pg13[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg13[Menu.buttonCount+1], "savehand", hands.hands_pg13[Menu.buttonCount+1])
    Menu.addButton(hands.hands_pg13[Menu.buttonCount+1], "savehand", hands.hands_pg13[Menu.buttonCount+1])
    Menu.addButton("Next Page","HandsMenu",nil)
    Menu.addButton("Previous Page","HandsMenu12",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Hands
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function savehand(hand) --Sets Players head in database
    c_options.hand = hand
    SetPedComponentVariation(GetPlayerPed(-1), 3, tonumber(c_options.hand), 0, 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShoeMenu()
    texture_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Gender"
    ClearMenu()
    Menu.addButton("Male","MaleShoeMenu",nil)
    Menu.addButton("Female","FemaleShoeMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 1/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleShoeMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 1 of 5"
    ClearMenu()
    Menu.addButton(shoes.m_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleShoeMenu2",nil)
    Menu.addButton("Previous Page","MaleShoeMenu5",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 2/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleShoeMenu2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 2 of 5"
    ClearMenu()
    Menu.addButton(shoes.m_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.fshoes_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleShoeMenu3",nil)
    Menu.addButton("Previous Page","MaleShoeMenu",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 3/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleShoeMenu3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 3 of 5"
    ClearMenu()
    Menu.addButton(shoes.m_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleShoeMenu4",nil)
    Menu.addButton("Previous Page","MaleShoeMenu2",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 4/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleShoeMenu4()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 4 of 5"
    ClearMenu()
    Menu.addButton(shoes.m_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.m_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleShoeMenu5",nil)
    Menu.addButton("Previous Page","MaleShoeMenu3",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 5/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleShoeMenu5()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 5 of 5"
    ClearMenu()
    Menu.addButton(shoes.m_names_pg5[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleShoeMenu",nil)
    Menu.addButton("Previous Page","MaleShoeMenu4",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 1/5
--Female Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShoeMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 1 of 5"
    ClearMenu()
    Menu.addButton(shoes.f_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg1[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShoeMenu2",nil)
    Menu.addButton("Previous Page","FemaleShoeMenu5",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 2/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShoeMenu2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 2 of 5"
    ClearMenu()
    Menu.addButton(shoes.f_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.fshoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.fshoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.fshoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.fshoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.fshoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.fshoes_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg2[Menu.buttonCount+1], "saveshoe", shoes.fshoes_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShoeMenu3",nil)
    Menu.addButton("Previous Page","FemaleShoeMenu",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 3/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShoeMenu3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 3 of 5"
    ClearMenu()
    Menu.addButton(shoes.f_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg3[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShoeMenu4",nil)
    Menu.addButton("Previous Page","FemaleShoeMenu2",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 4/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShoeMenu4()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 4 of 5"
    ClearMenu()
    Menu.addButton(shoes.f_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg4[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShoeMenu5",nil)
    Menu.addButton("Previous Page","FemaleShoeMenu3",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 5/5
--Male Shoes
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleShoeMenu5()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Shoes                    Page 5 of 5"
    ClearMenu()
    Menu.addButton(shoes.f_names_pg5[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg5[Menu.buttonCount+1])
    Menu.addButton(shoes.f_names_pg5[Menu.buttonCount+1], "saveshoe", shoes.shoes_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleShoeMenu",nil)
    Menu.addButton("Previous Page","FemaleShoeMenu4",nil)
    Menu.addButton("Return","ShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shoes
--Textures                      Page 1/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function shoeTextures()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 1 of 3"
    ClearMenu()
    Menu.addButton(shoes.txt_pg1[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg1[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg1[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg1[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg1[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg1[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg1[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg1[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","shoeTextures2",nil)
    Menu.addButton("Previous Page","shoeTextures3",nil)
    Menu.addButton("Return to male section","MaleShoeMenu",nil)
    Menu.addButton("Return to female section","FemaleShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shoes
--Textures                      Page 2/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function shoeTextures2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 2 of 3"
    ClearMenu()
    Menu.addButton(shoes.txt_pg2[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg2[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg2[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg2[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg2[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg2[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg2[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg2[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","shoeTextures3",nil)
    Menu.addButton("Previous Page","shoeTextures",nil)
    Menu.addButton("Return to male section","MaleShoeMenu",nil)
    Menu.addButton("Return to female section","FemaleShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shoes
--Textures                      Page 3/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function shoeTextures3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 3 of 3"
    ClearMenu()
    Menu.addButton(shoes.txt_pg3[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg3[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg3[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg3[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg3[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg3[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg3[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(shoes.txt_pg3[Menu.buttonCount+1], "saveshoe_txt", shoes.txt_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","shoeTextures",nil)
    Menu.addButton("Previous Page","shoeTextures2",nil)
    Menu.addButton("Return to male section","MaleShoeMenu",nil)
    Menu.addButton("Return to female section","FemaleShoeMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shoes 
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function saveshoe(shoe) --Sets Players head in database
    c_options.shoes = shoe
    SetPedComponentVariation(GetPlayerPed(-1), 6, tonumber(c_options.shoes), 0, 0)
    shoeTextures()
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Shoe Textures
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function saveshoe_txt(shoe_txt) --Sets mask texture in database
    c_options.shoes_txt = shoe_txt
    SetPedComponentVariation(GetPlayerPed(-1), 6, tonumber(c_options.shoes), tonumber(c_options.shoes_txt), 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function PantsMenu()
    texture_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Gender"
    ClearMenu()
    Menu.addButton("Male","MalePantsMenu",nil)
    Menu.addButton("Female","FemalePantsMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Male                      Page 1/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MalePantsMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 1 of 6"
    ClearMenu()
    Menu.addButton(pants.m_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","MalePantsMenu2",nil)
    Menu.addButton("Previous Page","MalePantsMenu6",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Male                      Page 2/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MalePantsMenu2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 2 of 6"
    ClearMenu()
    Menu.addButton(pants.m_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","MalePantsMenu3",nil)
    Menu.addButton("Previous Page","MalePantsMenu",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Male                      Page 3/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MalePantsMenu3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 3 of 6"
    ClearMenu()
    Menu.addButton(pants.m_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","MalePantsMenu4",nil)
    Menu.addButton("Previous Page","MalePantsMenu2",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Male                      Page 4/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MalePantsMenu4()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 4 of 6"
    ClearMenu()
    Menu.addButton(pants.m_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","MalePantsMenu5",nil)
    Menu.addButton("Previous Page","MalePantsMenu3",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Male                      Page 5/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MalePantsMenu5()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 5 of 6"
    ClearMenu()
    Menu.addButton(pants.m_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","MalePantsMenu6",nil)
    Menu.addButton("Previous Page","MalePantsMenu4",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Male                      Page 6/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MalePantsMenu6()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 6 of 6"
    ClearMenu()
    Menu.addButton(pants.m_names_pg6[Menu.buttonCount+1], "savepants", pants.pants_pg6[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg6[Menu.buttonCount+1], "savepants", pants.pants_pg6[Menu.buttonCount+1])
    Menu.addButton(pants.m_names_pg6[Menu.buttonCount+1], "savepants", pants.pants_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","MalePantsMenu",nil)
    Menu.addButton("Previous Page","MalePantsMenu5",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Female                      Page 1/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemalePantsMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 1 of 6"
    ClearMenu()
    Menu.addButton(pants.f_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg1[Menu.buttonCount+1], "savepants", pants.pants_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemalePantsMenu2",nil)
    Menu.addButton("Previous Page","FemalePantsMenu6",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Female                      Page 2/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemalePantsMenu2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 2 of 6"
    ClearMenu()
    Menu.addButton(pants.f_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg2[Menu.buttonCount+1], "savepants", pants.pants_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemalePantsMenu3",nil)
    Menu.addButton("Previous Page","FemalePantsMenu",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Female                      Page 3/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemalePantsMenu3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 3 of 6"
    ClearMenu()
    Menu.addButton(pants.f_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg3[Menu.buttonCount+1], "savepants", pants.pants_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemalePantsMenu4",nil)
    Menu.addButton("Previous Page","FemalePantsMenu2",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Female                      Page 4/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemalePantsMenu4()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 4 of 6"
    ClearMenu()
    Menu.addButton(pants.f_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg4[Menu.buttonCount+1], "savepants", pants.pants_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemalePantsMenu5",nil)
    Menu.addButton("Previous Page","FemalePantsMenu3",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Female                      Page 5/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemalePantsMenu5()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 5 of 6"
    ClearMenu()
    Menu.addButton(pants.f_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg5[Menu.buttonCount+1], "savepants", pants.pants_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemalePantsMenu6",nil)
    Menu.addButton("Previous Page","FemalePantsMenu4",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Female                      Page 6/6
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemalePantsMenu6()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Pants                    Page 6 of 6"
    ClearMenu()
    Menu.addButton(pants.f_names_pg6[Menu.buttonCount+1], "savepants", pants.pants_pg6[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg6[Menu.buttonCount+1], "savepants", pants.pants_pg6[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg6[Menu.buttonCount+1], "savepants", pants.pants_pg6[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg6[Menu.buttonCount+1], "savepants", pants.pants_pg6[Menu.buttonCount+1])
    Menu.addButton(pants.f_names_pg6[Menu.buttonCount+1], "savepants", pants.pants_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemalePantsMenu",nil)
    Menu.addButton("Previous Page","FemalePantsMenu5",nil)
    Menu.addButton("Return","PantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Textures                      Page 1/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function pantsTextures()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 1 of 3"
    ClearMenu()
    Menu.addButton(pants.txt_pg1[Menu.buttonCount+1], "savepants_txt", pants.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg1[Menu.buttonCount+1], "savepants_txt", pants.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg1[Menu.buttonCount+1], "savepants_txt", pants.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg1[Menu.buttonCount+1], "savepants_txt", pants.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg1[Menu.buttonCount+1], "savepants_txt", pants.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg1[Menu.buttonCount+1], "savepants_txt", pants.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg1[Menu.buttonCount+1], "savepants_txt", pants.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg1[Menu.buttonCount+1], "savepants_txt", pants.txt_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","pantsTextures2",nil)
    Menu.addButton("Previous Page","pantsTextures",nil)
    Menu.addButton("Return to male section","MalePantsMenu",nil)
    Menu.addButton("Return to female section","FemalePantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Textures                      Page 2/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function pantsTextures2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 2 of 3"
    ClearMenu()
    Menu.addButton(pants.txt_pg2[Menu.buttonCount+1], "savepants_txt", pants.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg2[Menu.buttonCount+1], "savepants_txt", pants.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg2[Menu.buttonCount+1], "savepants_txt", pants.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg2[Menu.buttonCount+1], "savepants_txt", pants.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg2[Menu.buttonCount+1], "savepants_txt", pants.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg2[Menu.buttonCount+1], "savepants_txt", pants.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg2[Menu.buttonCount+1], "savepants_txt", pants.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg2[Menu.buttonCount+1], "savepants_txt", pants.txt_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","pantsTextures3",nil)
    Menu.addButton("Previous Page","pantsTextures",nil)
    Menu.addButton("Return to male section","MalePantsMenu",nil)
    Menu.addButton("Return to female section","FemalePantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants
--Textures                      Page 3/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function pantsTextures3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 3 of 3"
    ClearMenu()
    Menu.addButton(pants.txt_pg3[Menu.buttonCount+1], "savepants_txt", pants.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg3[Menu.buttonCount+1], "savepants_txt", pants.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg3[Menu.buttonCount+1], "savepants_txt", pants.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg3[Menu.buttonCount+1], "savepants_txt", pants.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg3[Menu.buttonCount+1], "savepants_txt", pants.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg3[Menu.buttonCount+1], "savepants_txt", pants.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg3[Menu.buttonCount+1], "savepants_txt", pants.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(pants.txt_pg3[Menu.buttonCount+1], "savepants_txt", pants.txt_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","pantsTextures",nil)
    Menu.addButton("Previous Page","pantsTextures2",nil)
    Menu.addButton("Return to male section","MalePantsMenu",nil)
    Menu.addButton("Return to female section","FemalePantsMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants 
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function savepants(pants) --Sets Players head in database
    c_options.pants = pants
    SetPedComponentVariation(GetPlayerPed(-1), 4, tonumber(c_options.pants), 0, 0)
    pantsTextures()
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Pants Textures
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function savepants_txt(pants_txt) --Sets mask texture in database
    c_options.pants_txt = pants_txt
    SetPedComponentVariation(GetPlayerPed(-1), 4, tonumber(c_options.pants), tonumber(c_options.pants_txt), 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Undershirts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function UndershirtMenu()
    shirt_help = false
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Gender"
    ClearMenu()
    Menu.addButton("Male","MaleUndershirtMenu",nil)
    Menu.addButton("Female","FemaleUndershirtMenu",nil)
    Menu.addButton("Remove undershirt","RemoveUnderShirt")
    Menu.addButton("Return","Customisation",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 1/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 1 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 2/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 2 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 3/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 3 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 4/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu4()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 4 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 5/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu5()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 5 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 6/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu6()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 6 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 7/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu7()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 7 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 8/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu8()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 8 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 9/9
--Undershirt
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleUndershirtMenu9()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 9 of 8"
    ClearMenu()
    Menu.addButton(undershirt.m_names_pg9[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg9[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg9[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg9[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg9[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg9[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg9[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg9[Menu.buttonCount+1])
    Menu.addButton(undershirt.m_names_pg9[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg9[Menu.buttonCount+1])
    Menu.addButton("Next Page","MaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","MaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 1/8
--Undershirt
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleUndershirtMenu()
    shirt_help = true
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 1 of 8"
    ClearMenu()
    Menu.addButton(undershirt.f_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg1[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 2/8
--Undershirt
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleUndershirtMenu2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 2 of 8"
    ClearMenu()
    Menu.addButton(undershirt.f_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg2[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 3/8
--Undershirt
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleUndershirtMenu3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 3 of 8"
    ClearMenu()
    Menu.addButton(undershirt.f_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg3[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 4/8
--Undershirt
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleUndershirtMenu4()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 4 of 8"
    ClearMenu()
    Menu.addButton(undershirt.f_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg4[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg4[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 5/8
--Undershirt
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleUndershirtMenu5()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 5 of 8"
    ClearMenu()
    Menu.addButton(undershirt.f_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg5[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg5[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 6/8
--Undershirt
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleUndershirtMenu6()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 6 of 8"
    ClearMenu()
    Menu.addButton(undershirt.f_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg6[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg6[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 7/8
--Undershirt
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleUndershirtMenu7()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 7 of 8"
    ClearMenu()
    Menu.addButton(undershirt.f_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg7[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg7[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu           Page 8/8
--Undershirt
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleUndershirtMenu8()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Undershirts            Page 8 of 8"
    ClearMenu()
    Menu.addButton(undershirt.f_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton(undershirt.f_names_pg8[Menu.buttonCount+1], "saveundershirt", undershirt.undershirt_pg8[Menu.buttonCount+1])
    Menu.addButton("Next Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Previous Page","FemaleUndershirtMenu",nil)
    Menu.addButton("Return","UndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Undershirt
--Textures                      Page 1/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function undershirtTextures()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 1 of 3"
    ClearMenu()
    Menu.addButton(undershirt.txt_pg1[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg1[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg1[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg1[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg1[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg1[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg1[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg1[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg1[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg1[Menu.buttonCount+1])
    Menu.addButton("Next Page","undershirtTextures2",nil)
    Menu.addButton("Previous Page","undershirtTextures",nil)
    Menu.addButton("Return to male section","MaleUndershirtMenu",nil)
    Menu.addButton("Return to female section","FemaleUndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Undershirt
--Textures                      Page 2/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function undershirtTextures2()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 2 of 3"
    ClearMenu()
    Menu.addButton(undershirt.txt_pg2[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg2[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg2[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg2[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg2[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg2[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg2[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg2[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg2[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg2[Menu.buttonCount+1])
    Menu.addButton("Next Page","undershirtTextures3",nil)
    Menu.addButton("Previous Page","undershirtTextures",nil)
    Menu.addButton("Return to male section","MaleUndershirtMenu",nil)
    Menu.addButton("Return to female section","FemaleUndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Undershirt
--Textures                      Page 3/3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function undershirtTextures3()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Textures                   Page 3 of 3"
    ClearMenu()
    Menu.addButton(undershirt.txt_pg3[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg3[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg3[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg3[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg3[Menu.buttonCount+1])
    Menu.addButton(undershirt.txt_pg3[Menu.buttonCount+1], "saveundershirt_txt", undershirt.txt_pg3[Menu.buttonCount+1])
    Menu.addButton("Next Page","undershirtTextures",nil)
    Menu.addButton("Previous Page","undershirtTextures2",nil)
    Menu.addButton("Return to male section","MaleUndershirtMenu",nil)
    Menu.addButton("Return to female section","FemaleUndershirtMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Undershirt 
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function saveundershirt(undershirt) --Sets Players head in database
    c_options.undershirt = undershirt
    SetPedComponentVariation(GetPlayerPed(-1), 8, undershirt, 0, 0)
    undershirtTextures()
end

function RemoveUnderShirt()
    c_options.undershirt = 0
    c_options.undershirt_txt = 240
    SetPedComponentVariation(GetPlayerPed(-1), 8, tonumber(c_options.undershirt), tonumber(c_options.undershirt_txt), 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Undershirt Textures
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function saveundershirt_txt(undershirt_txt) --Sets mask texture in database
    c_options.undershirt_txt = undershirt_txt
    SetPedComponentVariation(GetPlayerPed(-1), 8, tonumber(c_options.undershirt), tonumber(c_options.undershirt_txt), 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Armour
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ArmourMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Gender"
    ClearMenu()
    Menu.addButton("Male","MaleArmourMenu",nil)
    Menu.addButton("Female","FemaleArmourMenu",nil)
    Menu.addButton("Return","Customisation",nil)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       
--Armour
--Male
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MaleArmourMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Armour"
    ClearMenu()
    Menu.addButton(armour.m_name[Menu.buttonCount+1], "removearmour", armour.m_armour[Menu.buttonCount+1])
    Menu.addButton(armour.m_name[Menu.buttonCount+1], "savearmour", armour.m_armour[Menu.buttonCount+1])
    Menu.addButton("Return","ArmourMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       
--Armour
--Female
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function FemaleArmourMenu()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Armour"
    ClearMenu()
    Menu.addButton(armour.f_name[Menu.buttonCount+1], "removearmour", armour.f_armour[Menu.buttonCount+1])
    Menu.addButton(armour.f_name[Menu.buttonCount+1], "savearmour", armour.f_armour[Menu.buttonCount+1])
    Menu.addButton("Return","ArmourMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu       
--Armour
--Textures
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function armourTextures()
    DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
    options.menu_subtitle = "Armour"
    ClearMenu()
    Menu.addButton(armour.txt_n[Menu.buttonCount+1], "savearmour_txt", armour.txt[Menu.buttonCount+1])
    Menu.addButton(armour.txt_n[Menu.buttonCount+1], "savearmour_txt", armour.txt[Menu.buttonCount+1])
    Menu.addButton(armour.txt_n[Menu.buttonCount+1], "savearmour_txt", armour.txt[Menu.buttonCount+1])
    Menu.addButton(armour.txt_n[Menu.buttonCount+1], "savearmour_txt", armour.txt[Menu.buttonCount+1])
    Menu.addButton(armour.txt_n[Menu.buttonCount+1], "savearmour_txt", armour.txt[Menu.buttonCount+1])
    Menu.addButton("Return to male section","MaleArmourMenu",nil)
    Menu.addButton("Return to female section","FemaleArmourtMenu",nil)
    Menu.addButton("Return","ArmourMenu",nil)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Armour 
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function savearmour(armour) --Sets Players head in database
    c_options.armour = armour
    SetPedComponentVariation(GetPlayerPed(-1), 9, tonumber(c_options.armour), 0, 0)
    armourTextures()
end

function removearmour(armour) --Sets Players head in database
    c_options.armour = armour
    SetPedComponentVariation(GetPlayerPed(-1), 9, tonumber(c_options.armour), 0, 0)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Customisation Menu
--Armour Textures
--Functions
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function savearmour_txt(armour_txt) --Sets mask texture in database
    c_options.armour_txt = armour_txt
    SetPedComponentVariation(GetPlayerPed(-1), 9, tonumber(c_options.armour), tonumber(c_options.armour_txt), 0)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press E to open/close menu in the red marker
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local emplacement = {
    {name="Clothing Store", id=73, x=1932.76989746094, y=3727.73510742188, z=32.8444557189941},
    {name="Clothing Store", id=73, x=1693.26, y=4822.27, z=42.06},
    {name="Clothing Store", id=73, x=125.83, y=-223.16, z=54.55},
    {name="Clothing Store", id=73, x=-710.16, y=-153.26, z=37.41},
    {name="Clothing Store", id=73, x=-821.69, y=-1073.90, z=11.32},
    {name="Clothing Store", id=73, x=-1192.81, y=-768.24, z=17.31},
    {name="Clothing Store", id=73, x=4.25, y=6512.88, z=31.87},
    {name="Clothing Store", id=73, x=425.471, y=-806.164, z=29.4911},
}
incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(emplacement) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.colour)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(emplacement) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to customise your character.")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        Main() -- Menu to draw
                        Menu.hidden = not Menu.hidden -- Hide/Show the menu
                        shirt_help = false
                        model_info = false
                        texture_help = false
                    end
                    if(IsControlJustReleased(1, 23)) then 
                        if mp_check then
                            mp_check_message = false
                            local user = {
                                hair = c_options.hair,
                                hcolour = c_options.hcolour,
                                shirt = c_options.shirt,
                                shirt_txt = c_options.shirt_txt,
                                pants = c_options.pants,
                                pants_txt = c_options.pants_txt,
                                undershirt = c_options.undershirt,
                                undershirt_txt = c_options.undershirt_txt,
                                shoe = c_options.shoes,
                                shoe_txt = c_options.shoes_txt,
                                hand = c_options.hand,
                                mask = c_options.mask,
                                mask_txt = c_options.mask_txt,
                                head = c_options.head,
                                armour = c_options.armour,
                                armour_txt = c_options.armour_txt
                            }
                            Notify("~g~You saved your outfit.") 
                            TriggerServerEvent("mm:saveeverything", user)
                        else
                            secondsRemaining2 = 10
                            mp_check_message = true
                            TriggerServerEvent("mm:timer2")                          
                        end
                    end
                    Menu.renderGUI(options) -- Draw menu on each tick if Menu.hidden = false
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    shirt_help = false
                    model_info = false
                    texture_help = false
                    mp_check_message = false
                end
            end
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Help messages
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if shirt_help then
            drawTxt(0.66, 1.45, 1.0,1.0,0.4, "~r~NOTICE~w~: If your characters hands or arms are invisible then go to the ~r~Hands ~w~menu.", 255, 255, 255, 255)
            drawTxt(0.66, 1.42, 1.0,1.0,0.4, "~r~NOTICE~w~: If your characters chest is invisible then go to the ~r~Under Shirt ~w~menu.", 255, 255, 255, 255)
            drawTxt(0.66, 1.37, 1.0,1.0,0.4, "~r~NOTICE~w~: If your characters body or arms are going through clothing then go to the ~r~Hands", 255, 255, 255, 255)
            drawTxt(0.66, 1.39, 1.0,1.0,0.4, "              ~w~menu.", 255, 255, 255, 255)
            drawTxt(0.66, 1.34, 1.0,1.0,0.4, "~r~NOTICE~w~: (~g~Number~w~) = the number of ~g~Textures ~w~available.", 255, 255, 255, 255)
            drawTxt(0.66, 1.31, 1.0,1.0,0.4, "~r~NOTICE~w~: ~g~T~w~ = ~g~Textures ~w~and the numbers are textures that work with the clothing.", 255, 255, 255, 255)
        end
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        if model_info then
            drawTxt(0.66, 1.41, 1.0,1.0,0.4, "(~g~" .. secondsRemaining .. "~w~) ~r~NOTICE~w~: Your current player model cannot be customised.", 255, 255, 255, 255)
            drawTxt(0.66, 1.44, 1.0,1.0,0.4, "(~g~" .. secondsRemaining .. "~w~) ~r~NOTICE~w~: Your model must be ~r~mp_m_freemode_01 ~w~or ~r~mp_f_freemode_01~w~.", 255, 255, 255, 255)
        end
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        if mp_check_message then
            drawTxt(0.66, 1.38, 1.0,1.0,0.4, "(~g~" .. secondsRemaining2 .. "~w~) ~r~NOTICE~w~: You cannot save your outfit as your model isn't customisable.", 255, 255, 255, 255)
        end
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        if texture_help then
            drawTxt(0.66, 1.45, 1.0,1.0,0.4, "~r~NOTICE~w~: (~g~Number~w~) = the number of ~g~Textures ~w~available.", 255, 255, 255, 255)
            drawTxt(0.66, 1.42, 1.0,1.0,0.4, "~r~NOTICE~w~: ~g~T~w~ = ~g~Textures ~w~and the numbers are textures that work with the clothing.", 255, 255, 255, 255)
        end
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        if model_info then
            Citizen.Wait(1000)
            if(secondsRemaining > 0)then
                secondsRemaining = secondsRemaining - 1
            end
        end

        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        if mp_check_message then
            Citizen.Wait(1000)
            if(secondsRemaining2 > 0)then
                secondsRemaining2 = secondsRemaining2 - 1
            end
        end

        Citizen.Wait(0)
    end
end)