

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('razer_mine:addstone', function(src)
  local player = ESX.GetPlayerFromId(src)
  local balempastardp = math.random(Config.Random.arxi,Config.Random.full)

  if player.getInventoryItem('stone').count < 120 and player.getInventoryItem('pickaxe').count > 0 then
  player.addInventoryItem("stone", balempastardp)
  else
      TriggerClientEvent("esx:showNotification", src ,"Full Inventory or you dont have pickaxe")
  end
end)

ESX.RegisterServerCallback('razer_farmjob:additems', function(src, items)
  local player = ESX.GetPlayerFromId(src)
  if player.getInventoryItem('gantia').count > 0 then
  if player.getInventoryItem(items).count < 100 then

   local randomitem = math.random(Config.Random.arxi,Config.Random.full)
   player.addInventoryItem(items, randomitem)
  else
    TriggerClientEvent("esx:showNotification", src ,"Full Inventory")
  end
  else
      TriggerClientEvent("esx:showNotification", src ,"Δεν Εχεις Γαντια")
  end
end)


ESX.RegisterServerCallback('razer_jobs:addbuyitems', function(src, itemyouhavebuy)
  local player = ESX.GetPlayerFromId(src)
  local balance = player.getAccount("bank").money
  if balance > 1000 then
   if player.getInventoryItem(itemyouhavebuy).count < 1 then
    

    player.removeAccountMoney("bank", 1000)
    player.addInventoryItem(itemyouhavebuy, 1)

  else
    TriggerClientEvent("esx:showNotification", src ,"Εχεις ηδη "..itemyouhavebuy.."")
  end
else 
  TriggerClientEvent("esx:showNotification", src ,"You Dont Have Money")
end
end)


ESX.RegisterServerCallback('razer_jobs:addproccesitems', function(src, itemhave, itemgive)
  local player = ESX.GetPlayerFromId(src)
  if player.getInventoryItem(itemhave).count > 3 then
  if player.getInventoryItem(itemgive).count < 100 then

    player.removeInventoryItem(itemhave, 4)
    player.addInventoryItem(itemgive, 2)

  else
    TriggerClientEvent("esx:showNotification", src ,"Full Inventory")
  end
  else
    TriggerClientEvent("esx:showNotification", src ,"You Dont Have "..itemhave.."")
  end
  
end)



ESX.RegisterServerCallback('razer_store:getmoney', function(src, bl)
  local player = ESX.GetPlayerFromId(src)
  local balance = player.getAccount("bank").money
  bl(balance)
end)


ESX.RegisterServerCallback('razer_mine:addwashstone', function(src)
  local player = ESX.GetPlayerFromId(src)
  if player.getInventoryItem('stone').count > 3   then
    if player.getInventoryItem('washstone').count < 100 then 
      if  player.getInventoryItem('washpan').count > 0  then
      player.removeInventoryItem("stone", 4)
      player.addInventoryItem("washstone", 2)

      else
        TriggerClientEvent("esx:showNotification", src ,"You dont have WashPan")
      end
    else 
      TriggerClientEvent("esx:showNotification", src ,"Full Inventory")
    end

  else
      TriggerClientEvent("esx:showNotification", src ,"You dont have Stone")
  end
end)

ESX.RegisterServerCallback('razer_sellmenu:giveitem', function(src, item)
  local player = ESX.GetPlayerFromId(src)
  if player.getInventoryItem(item).count > 49 then

    player.removeInventoryItem(item, 50)
    Wait(500)
    player.addAccountMoney('bank', Config.sellitems[item])
    
  else
      TriggerClientEvent("esx:showNotification", src ,"Δεν Εχεις "..item.."")
  end
end)

 