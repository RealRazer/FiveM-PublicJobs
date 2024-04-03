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



local IsJobTrue2              = false
local PlayerData              = {}
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

local isInMarker              = false
local display = false

local blip1 = {}
local blips = false
local mineActive = false
local firstspawn = false
local impacts = 0
local timer = 0


local locations = {
    { ['x'] = 1376.86,  ['y'] = -2082.11,  ['z'] = 52.0},
}



local washzone = {
  vector3(1932.2,421.89,160.85)
}


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


function cleanPlayer(playerPed)
  ClearPedBloodDamage(playerPed)
  ResetPedVisibleDamage(playerPed)
  ClearPedLastWeaponDamage(playerPed)
  ResetPedMovementClipset(playerPed, 0)
end


AddEventHandler('razer_jobs:hasEnteredMarker', function(zone)
 
    if zone == 'BossActions' and IsGradeBoss() then
      CurrentAction     = 'menu_boss_actions'
      CurrentActionMsg  = _U('open_bossmenu')
      CurrentActionData = {}
    end

    if zone == 'Fridge' then
      CurrentAction     = 'menu_fridge'
      CurrentActionMsg  = _U('open_fridge')
      CurrentActionData = {}
    end      

end)

AddEventHandler('razer_jobs:hasExitedMarker', function(zone)

    CurrentAction = nil
    ESX.UI.Menu.CloseAll()

end)





		local blip = AddBlipForCoord(Config.Blips.Blip.Pos.x, Config.Blips.Blip.Pos.y, Config.Blips.Blip.Pos.z)
		local blipMarker = Config.Blips.Blip

		SetBlipSprite (blip, blipMarker.Sprite)
		SetBlipDisplay(blip, blipMarker.Display)
		SetBlipScale  (blip, blipMarker.Scale)
		SetBlipColour (blip, blipMarker.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Miner')
		EndTextCommandSetBlipName(blip)

    local blip2 = AddBlipForCoord(Config.Blips.Blip2.Pos.x, Config.Blips.Blip2.Pos.y, Config.Blips.Blip2.Pos.z)
		local blip2Marker = Config.Blips.Blip2

		SetBlipSprite (blip2, blip2Marker.Sprite)
		SetBlipDisplay(blip2, blip2Marker.Display)
		SetBlipScale  (blip2, blip2Marker.Scale)
		SetBlipColour (blip2, blip2Marker.Colour)
		SetBlipAsShortRange(blip2, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('WashStone')
		EndTextCommandSetBlipName(blip2)
	



    
    --#Zones
    for i=1, #washzone do
      local radiusblip = AddBlipForRadius(washzone[i], 100.0)
      SetBlipHighDetail(radiusblip, true)
      SetBlipAsShortRange(radiusblip, true)
      SetBlipDisplay(radiusblip, 3)
      SetBlipColour(radiusblip, 60)
      SetBlipAlpha (radiusblip, 150)
    end


	
	
    

Citizen.CreateThread(function()
  local blip3 = AddBlipForCoord(Config.Blips.Blip3.Pos.x, Config.Blips.Blip3.Pos.y, Config.Blips.Blip3.Pos.z)
  local blip3Marker = Config.Blips.Blip3

  SetBlipSprite (blip3, blip3Marker.Sprite)
  SetBlipDisplay(blip3, blip3Marker.Display)
  SetBlipScale  (blip3, blip3Marker.Scale)
  SetBlipColour (blip3, blip3Marker.Colour)
  SetBlipAsShortRange(blip3, true)

  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString('MarketStore')
  EndTextCommandSetBlipName(blip3)
end)




RegisterNetEvent('esx_razerminer:createblips')
AddEventHandler('esx_razerminer:createblips', function()
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1)
                if blips == true and blipActive == false then
                    blip1 = AddBlipForCoord(1933.45,422.41,160.62)    
                    SetBlipSprite(blip1, 354)
                    SetBlipColour(blip1, 49)
                    SetBlipAsShortRange(blip1, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Mine")
                    EndTextCommandSetBlipName(blip1)                      
                    blipActive = true
                elseif blips == false and blipActive == false then
                    RemoveBlip(blip1)                 
                end
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
    Citizen.Wait(1)
      if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.LocationX, Config.LocationY, Config.LocationZ, true) < 25 then

          DrawMarker(20, Config.LocationX, Config.LocationY, Config.LocationZ, 0, 0, 0, 0, 0, 180.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
              if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.LocationX, Config.LocationY, Config.LocationZ, true) < 1 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ To Miner")
                if IsControlJustReleased(1, 51) then
                  mine() 
                      end
                  end
              end
          end
      
end)

Citizen.CreateThread(function()
  while true do
local ped = PlayerPedId()
  Citizen.Wait(1)
    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Location2X, Config.Location2Y, Config.Location2Z, true) < 25 then
        DrawMarker(20, Config.Location2X, Config.Location2Y, Config.Location2Z, 0, 0, 0, 0, 0, 180.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Location2X, Config.Location2Y, Config.Location2Z, true) < 1 then
              ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ To Miner")
              if IsControlJustReleased(1, 51) then
                mine() 
                    end
                end
            end
        end
    
        
end)


Citizen.CreateThread(function()
  while true do
local ped = PlayerPedId()
  Citizen.Wait(1)
    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Location3X, Config.Location3Y, Config.Location3Z, true) < 30 then
        DrawMarker(20, Config.Location3X, Config.Location3Y, Config.Location2Z, 0, 0, 0, 0, 0, 180.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Location3X, Config.Location3Y, Config.Location3Z, true) < 1 then
              ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ To Miner")
              if IsControlJustReleased(1, 51) then
                mine() 
                    end
                end
            end
        end
    
end)

RegisterNUICallback("buy3", function(data)
  ESX.TriggerServerCallback('razer_job:addbuyitems', "gantia")
  
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("buypickaxe", function(data)
  ESX.TriggerServerCallback('razer_job:addbuyitems', "washpan")
 
end)

RegisterNUICallback("buywashpan", function(data)
  ESX.TriggerServerCallback('razer_job:addbuyitems', "pickaxe")
  
end)




Citizen.CreateThread(function()
  while true do
local ped = PlayerPedId()
  Citizen.Wait(1)
      if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.marketstoreX, Config.marketstoreY, Config.marketstoreZ, true) < 15 then
          DrawMarker(20, Config.marketstoreX, Config.marketstoreY, Config.marketstoreZ, 0, 0, 0, 0, 0, 390.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
              if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.marketstoreX, Config.marketstoreY, Config.marketstoreZ, true) < 2 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ To Open The Market")
                if IsControlJustReleased(1, 51) then
                  openmarkerstore() 
                      end
                  end
              end
          end
        
    end)


Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.washLocationX, Config.washLocationY, Config.washLocationZ, true) < 15 then
            DrawMarker(1, Config.washLocationX, Config.washLocationY, Config.washLocationZ, 0, 0, 0, 0, 0, 390.0, 2.0, 2.0, 2.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.washLocationX, Config.washLocationY, Config.washLocationZ, true) < 2 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ To Wash ")
                if IsControlJustReleased(1, 51) then
                    washmine() 
                end
            end
        end
    end
end)




    
Citizen.CreateThread(function()
  while true do
local ped = PlayerPedId()
  Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.washLocation2X, Config.washLocation2Y, Config.washLocation2Z, true) < 15 then
            DrawMarker(1, Config.washLocation2X, Config.washLocation2Y, Config.washLocation2Z, 0, 0, 0, 0, 0, 390.0, 2.0, 2.0, 2.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.washLocation2X, Config.washLocation2Y, Config.washLocation2Z, true) < 2 then
                  ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ To Wash ")
                  if IsControlJustReleased(1, 51) then
                    washmine() 
                        end
                    end
                end
            end
        
    end)

function washmine()
Citizen.CreateThread(function()
    ExecuteCommand("e mechanic")
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 6000,
        label = 'Washing',
        useWhileDead = true,
        canCancel = true,
    })

    Citizen.Wait(6000)
    ExecuteCommand("e c")
    ESX.TriggerServerCallback("razer_mine:addwashstone")
end)
end

function mine()

  isMining = true
  Citizen.CreateThread(function()
      Citizen.Wait(1)
    
    local ped = PlayerPedId()	
          RequestAnimDict("amb@world_human_hammering@male@base")

          Citizen.Wait(200)
          TaskPlayAnim((ped), 'amb@world_human_hammering@male@base', 'base', 12.0, 12.0, -1, 80, 0, 0, 0, 0)
          SetEntityHeading(ped, 106.86006164551)
              pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
              AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
      exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 2500,
        label = 'Mining',
        useWhileDead = true,
        canCancel = true,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        }
      }, function(cancelled)
        if not cancelled then
          DetachEntity(pickaxe, 1, true)
          DeleteEntity(pickaxe)
          DeleteObject(pickaxe)
          ESX.TriggerServerCallback("razer_mine:addstone")
          isMining = false
          cleanPlayer()
        else
          --cancell
        end
      end)

      end)
end



function SetDisplay(bool)
	ESX.TriggerServerCallback('razer_store:getmoney', function(bl)
		display = bool
		SetNuiFocus(bool, bool)
		SendNUIMessage({
			type = "ui",
			status = bool,
			balance = bl,
		
		})
	end)
end



function openmarkerstore()
	SetDisplay(not display) 
end
