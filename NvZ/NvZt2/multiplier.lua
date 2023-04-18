
local multi=mu
local settings = {repeatamount = multi, exceptions = {"SayMessageRequest","MeleeUpdateEvent","NinjaBombEvent","BulletUpdateEvent", 'UpdatePingEvent', 'HandleUpdatePingEvent', 'CharacterUpdateEvent', 'ShopEvent', 'ModuleObtainEvent', 'VisualEvent', 'PlantEvent', 'WeaponInteractEvent', 'MatchRoundEvent', 'UnitCameraEvent', 'CommandEvent', 'LobbyEvent', 'UpdateFeedEvent',  'FinishedLoadEvent', 'HitMarkerEvent', 'EchoEvent', 'SummonEvent', 'MovementEvent', 'BulletPartEvent', 'BulletRicochetEvent', 'WeaponHoldEvent', 'LocalEnviromentEvent', 'BasePlanFunction', 'ListEvent'}}

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = function(uh, ...)
  local args = {...}
  local method = getnamecallmethod()
  for i,o in next, settings.exceptions do
      if uh.Name == o then
          return old(uh, ...)
      end
  end
  if method == "FireServer" or method == "InvokeServer" then
      for i = 1,settings.repeatamount do
          old(uh, ...)
      end
  end
  return old(uh, ...)
end

setreadonly(mt, true)
