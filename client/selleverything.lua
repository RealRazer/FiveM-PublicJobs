
local PlayerData              = {}


ESX = nil
 Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    done = true
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)
function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
  end
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		Citizen.Wait(1)
		if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.Selltapanta, true) < 15 then
			DrawMarker(1,  Config.Selltapanta, 0, 0, 0, 0, 0, 390.0, 1.5, 1.5, 1.5, 229, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Selltapanta, true) < 2 then
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~  To Sell Items")
				if IsControlJustReleased(1, 51) then
					sell() 
                end
            end
        end
    end
end)


function sell()
    local elements = {}

    table.insert(elements, {label = '<font color = red >Sell <font color = blue > x50<font color = purple > Χυμους πορτακαλι <font color =green > 3250€</font> ', value = 'sell1'})
   
    table.insert(elements, {label = '<font color = red >Sell <font color = blue > x50 <font color =  yellow> Χυμους λεμονι  <font color =green > 2750€</font> ', value = 'sell2'})

    table.insert(elements, {label = '<font color = red >Sell <font color = blue > x50 <font color = orange > Χυμους Μανταρινι  <font color =green > 3625€</font> ', value = 'sell3'})

    table.insert(elements, {label = '<font color = red >Sell <font color = blue > x50<font color = aqua > Wash Stone  <font color =green > 3000€</font> ', value = 'sell4'})


   




    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sellmenu',
    {
        title    = 'Sell Menu',
        align    = 'center',
        elements = elements
    }, function(data, menu)
      local value = data.current.value
      menu.close()


    if value == 'sell1' then
        ESX.TriggerServerCallback('razer_sellmenu:giveitem', "xumos_portokali")
         menu.close()
    elseif value == 'sell2' then
        ESX.TriggerServerCallback('razer_sellmenu:giveitem', "xumos_lemoni")
		menu.close()
      elseif value == 'sell3' then
        ESX.TriggerServerCallback('razer_sellmenu:giveitem', "xumos_mantarini")
		menu.close()
    elseif value == 'sell4' then
        ESX.TriggerServerCallback('razer_sellmenu:giveitem', "washstone")
		menu.close()
    end


    end, function(data, menu)
        menu.close()
    end)
end
  


