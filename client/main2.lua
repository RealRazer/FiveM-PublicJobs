Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}




local PlayerData              = {}
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

local publicBlip              = false
local isInMarker              = false
local isBlip              = false
local display = false

local blip1 = {}
local firstspawn = false
local impacts = 0
local timer = 0
local done = false


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




    --#blips
		local blip = AddBlipForCoord(Config.Blips.Blip.Pos.x, Config.Blips.Blip.Pos.y, Config.Blips.Blip.Pos.z)
		local blipMarker = Config.Blips.Blip

		SetBlipSprite (blip, blipMarker.Sprite)
		SetBlipDisplay(blip, blipMarker.Display)
		SetBlipScale  (blip, blipMarker.Scale)
		SetBlipColour (blip, blipMarker.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Farm')
		EndTextCommandSetBlipName(blip)

    local farmblip = AddBlipForCoord(Config.Blips.farmblip.Pos.x, Config.Blips.farmblip.Pos.y, Config.Blips.farmblip.Pos.z)
		local farmblipMarker = Config.Blips.farmblip

		SetBlipSprite (farmblip, farmblipMarker.Sprite)
		SetBlipDisplay(farmblip, farmblipMarker.Display)
		SetBlipScale  (farmblip, farmblipMarker.Scale)
		SetBlipColour (farmblip, farmblipMarker.Colour)
		SetBlipAsShortRange(farmblip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Farm Frouta')
		EndTextCommandSetBlipName(farmblip)

    local farmprocc = AddBlipForCoord(Config.Blips.farmprocc.Pos.x, Config.Blips.farmprocc.Pos.y, Config.Blips.farmprocc.Pos.z)
		local farmproccMarker = Config.Blips.farmprocc

		SetBlipSprite (farmprocc, farmproccMarker.Sprite)
		SetBlipDisplay(farmprocc, farmproccMarker.Display)
		SetBlipScale  (farmprocc, farmproccMarker.Scale)
		SetBlipColour (farmprocc, farmproccMarker.Colour)
		SetBlipAsShortRange(farmprocc, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Procces Frouta')
		EndTextCommandSetBlipName(farmprocc)
    
    

Citizen.CreateThread(function()
    local sell = AddBlipForCoord(Config.Blips.sell.Pos.x, Config.Blips.sell.Pos.y, Config.Blips.sell.Pos.z)
	local sellMarker = Config.Blips.sell

	SetBlipSprite (sell, sellMarker.Sprite)
	SetBlipDisplay(sell, sellMarker.Display)
	SetBlipScale  (sell, sellMarker.Scale)
	SetBlipColour (sell, sellMarker.Colour)
	SetBlipAsShortRange(sell, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Sell Everything')
	EndTextCommandSetBlipName(sell)
end)

Citizen.CreateThread(function()
    while true do
  local ped = PlayerPedId()
    Citizen.Wait(1)
          if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.portokalia, true) < 15 then
              DrawMarker(1,  Config.portokalia, 0, 0, 0, 0, 0, 390.0, 2.5, 2.5, 2.5, 100, 200, 100, 155, 0, 0, 2, 0, 0, 0, 0)
                  if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.portokalia, true) < 2 then
                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~  To Farm Portokalia")
                    if IsControlJustReleased(1, 51) then
                      farmportokaliampastarde() 
                          end
                      end
                  end
              end
          
      end)
  
      
  Citizen.CreateThread(function()
    while true do
  local ped = PlayerPedId()
  Citizen.Wait(1)
      if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.portokalia2, true) < 15 then
          DrawMarker(1,  Config.portokalia2, 0, 0, 0, 0, 0, 390.0, 2.5, 2.5, 2.5, 100, 200, 100, 155, 0, 0, 2, 0, 0, 0, 0)
              if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.portokalia2, true) < 2 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~  To Farm Portokalia")
                if IsControlJustReleased(1, 51) then
                  farmportokaliampastarde() 
                      end
                  end
              end
          end
      
  end)
  
  Citizen.CreateThread(function()
    while true do
  local ped = PlayerPedId()
  Citizen.Wait(1)
      if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.lemonia, true) < 15 then
          DrawMarker(1,  Config.lemonia, 0, 0, 0, 0, 0, 390.0, 2.5, 2.5, 2.5, 100, 200, 100, 155, 0, 0, 2, 0, 0, 0, 0)
              if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.lemonia, true) < 2 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~  To Farm Lemonia")
                if IsControlJustReleased(1, 51) then
                  farmlemoniampastarde() 
                      end
                  end
              end
          end
      
  end)
  
  Citizen.CreateThread(function()
    while true do
  local ped = PlayerPedId()
  Citizen.Wait(1)
      if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.lemonia2, true) < 15 then
          DrawMarker(1,  Config.lemonia2, 0, 0, 0, 0, 0, 390.0, 2.5, 2.5, 2.5, 100, 200, 100, 155, 0, 0, 2, 0, 0, 0, 0)
              if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.lemonia2, true) < 2 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~  To Farm Lemonia")
                if IsControlJustReleased(1, 51) then
                  farmlemoniampastarde() 
                      end
                  end
              end
          end
      
  end)
  
  Citizen.CreateThread(function()
    while true do
  local ped = PlayerPedId()
  Citizen.Wait(1)
      if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.mantarini, true) < 15 then
          DrawMarker(1,  Config.mantarini, 0, 0, 0, 0, 0, 390.0, 2.5, 2.5, 2.5, 100, 200, 100, 155, 0, 0, 2, 0, 0, 0, 0)
              if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.mantarini, true) < 2 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~  To Farm Mantarinia")
                if IsControlJustReleased(1, 51) then
                  farmmantarini() 
                      end
                  end
              end
          end
      
  end)


  function farmportokaliampastarde()

    ExecuteCommand("e mechanic")
      exports['mythic_progbar']:Progress({
          name = "unique_action_name",
          duration = 4500,
          label = 'Farming',
          useWhileDead = true,
          canCancel = true,
          controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          }
      })
  
      Citizen.Wait(4500)
      ExecuteCommand("e c")
      ESX.TriggerServerCallback("razer_farmjob:additems", "portokali")
  end
  
  function farmmantarini()
    ExecuteCommand("e mechanic")
      exports['mythic_progbar']:Progress({
          name = "unique_action_name",
          duration = 4500,
          label = 'Farming',
          useWhileDead = true,
          canCancel = true,
          controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          }
      })
  
      Citizen.Wait(4500)
      ExecuteCommand("e c")
      ESX.TriggerServerCallback("razer_farmjob:additems", "mantarini")
  end
  
  function kanemantarinia()
  
    ExecuteCommand("e mechanic")
      exports['mythic_progbar']:Progress({
          name = "unique_action_name",
          duration = 4000,
          label = 'Processing Xumo Mantarini',
          useWhileDead = true,
          canCancel = true,
          controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          }
      })
  
      Citizen.Wait(4000)
      ExecuteCommand("e c")
      ESX.TriggerServerCallback("razer_jobs:addproccesitems", "mantarini", "xumos_mantarini")
  end

  function kanelemonada()
  
    ExecuteCommand("e mechanic")
      exports['mythic_progbar']:Progress({
          name = "unique_action_name",
          duration = 4000,
          label = 'Processing Xumo Lemoni',
          useWhileDead = true,
          canCancel = true,
          controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          }
      })
  
      Citizen.Wait(4000)
      ExecuteCommand("e c")
      ESX.TriggerServerCallback("razer_jobs:addlemon", "lemoni", "xumos_lemoni")
  end

  function kanefanta()
  
    ExecuteCommand("e mechanic")
      exports['mythic_progbar']:Progress({
          name = "unique_action_name",
          duration = 4000,
          label = 'Processing Xumo Portokali',
          useWhileDead = true,
          canCancel = true,
          controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          }
      })
  
      Citizen.Wait(4000)
      ExecuteCommand("e c")
      ESX.TriggerServerCallback("razer_jobs:addproccesitems", "portokali", "xumos_portokali")
  end
  
  function farmlemoniampastarde()
  
    ExecuteCommand("e mechanic")
      exports['mythic_progbar']:Progress({
          name = "unique_action_name",
          duration = 4500,
          label = 'Farming',
          useWhileDead = true,
          canCancel = true,
          controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          }
      })
  
      Citizen.Wait(4500)
      ExecuteCommand("e c")
      ESX.TriggerServerCallback("razer_farmjob:additems", "lemoni")
  end
  Citizen.CreateThread(function()
    for _,v in pairs(Config.Npc3) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  
      
    end
  end)

  Citizen.CreateThread(function()
    for _,v in pairs(Config.Npc2) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  
      
    end
  end)
  


Citizen.CreateThread(function()
  for _,v in pairs(Config.Npc) do
    RequestModel(GetHashKey(v[7]))
    while not HasModelLoaded(GetHashKey(v[7])) do
      Wait(1)
    end
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
    ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
    SetEntityHeading(ped, v[5])
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

    
  end
end)

Citizen.CreateThread(function()
  while true do
      local pos = GetEntityCoords(GetPlayerPed(-1), true)
      Citizen.Wait(0)
      for _,v in pairs(Config.Npc2) do
          x = v[1]
          y = v[2]
          z = v[3]
          if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 3.0)then
              DrawText3D(x,y,z+2.10, "~h~~y~"..v[4], 1.2, 4)
              DrawText3D(x,y,z+1.95, "[~g~E~w~]~g~ To Process  ~", 1.0, 4)
      if IsControlJustPressed(0, Keys["E"]) then
        if IsEntityDead(PlayerPedId()) then
          ESX.ShowNotification("You are dead!")
          return
        else 
          kanelemonada()
        end

      
     
      end
    
    end
  end
  end
end)


Citizen.CreateThread(function()
  while true do
      local pos = GetEntityCoords(GetPlayerPed(-1), true)
      Citizen.Wait(0)
      for _,v in pairs(Config.Npc) do
          x = v[1]
          y = v[2]
          z = v[3]
          if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 3.0)then
              DrawText3D(x,y,z+2.10, "~h~~o~"..v[4], 1.2, 4)
              DrawText3D(x,y,z+1.95, "[~g~E~w~]~g~ To Process ~", 1.0, 4)
      if IsControlJustPressed(0, Keys["E"]) then
        if IsEntityDead(PlayerPedId()) then
          ESX.ShowNotification("You are dead!")
          return
        else 
          kanefanta()
        end

      
     
      end
    
    end
  end
  end
end)

Citizen.CreateThread(function()
  while true do
      local pos = GetEntityCoords(GetPlayerPed(-1), true)
      Citizen.Wait(0)
      for _,v in pairs(Config.Npc3) do
          x = v[1]
          y = v[2]
          z = v[3]
          if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 3.0)then
              DrawText3D(x,y,z+2.10, "~h~~o~"..v[4], 1.2, 4)
              DrawText3D(x,y,z+1.95, "[~g~E~w~]~g~ To Process ~", 1.0, 4)
      if IsControlJustPressed(0, Keys["E"]) then
        if IsEntityDead(PlayerPedId()) then
          ESX.ShowNotification("You are dead!")
          return
        else 
          kanemantarinia()
        end

      
     
      end
    
    end
  end
  end
end)
