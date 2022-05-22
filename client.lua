local firstSpawn = true
local commands
local resources
local banevent = "none"
local usedtokens = {}
local tokens = {}
local bypass = false

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(0)
    end
    Wait(3000)
    TriggerServerEvent('AWaskwQIFJqiqhweq')
    TriggerServerEvent('ASgqWQdqiuhwQFI')
    Wait(20000)
    TriggerServerEvent('mo_bank:setCurrentSate')
end)


clientconfig = {}
RegisterNetEvent("ASgqWQdqiuhwQFI")
AddEventHandler("ASgqWQdqiuhwQFI", function(as, ev, bb,hb)
    clientconfig = as
    tokens = clientconfig.tokens
    banevent = ev
    bypass = bb
    Citizen.SetTimeout(10000, function()
        runclientac()
    end)

    Citizen.CreateThread(function()
        while true do
           Citizen.Wait(5000)
           TriggerEvent(hb, true)
        end
    end)
end)

local playerloadedd = false

function runclientac()
    AddEventHandler("playerSpawned", function()
        if firstSpawn then
            commands = #GetRegisteredCommands()
            resources = GetNumResources()-1
            firstSpawn = false
        end

        Citizen.SetTimeout(10000, function()
            playerloadedd = true
        end)
    end)


    function getCamDirection()
        local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
        local pitch = GetGameplayCamRelativePitch()
        local x = -math.sin(heading*math.pi/180.0)
        local y = math.cos(heading*math.pi/180.0)
        local z = math.sin(pitch*math.pi/180.0)
        local len = math.sqrt(x*x+y*y+z*z)
        if len ~= 0 then
                x = x/len
                y = y/len
                z = z/len
        end
        return x,y,z
    end

    --Anti Eulen AK47
    --Anti Eulen AK47
    local weaponHashes = {"dagger", "bat", "bottle", "crowbar", "flashlight", "golfclub", "hammer", "hatchet", "knuckle",
    "knife", "machete", "switchblade", "nightstick", "wrench", "battleaxe", "poolcue",
    "stone_hatchet", "pistol", "pistol_mk2", "combatpistol", "appistol", "stungun", "pistol50",
    "snspistol", "snspistol_mk2", "heavypistol", "vintagepistol", "flaregun", "marksmanpistol",
    "revolver", "revolver_mk2", "doubleaction", "raypistol", "ceramicpistol", "navyrevolver",
    "microsmg", "smg", "smg_mk2", "assaultsmg", "combatpdw", "machinepistol", "minismg", "raycarbine",
    "pumpshotgun", "pumpshotgun_mk2", "sawnoffshotgun", "assaultshotgun", "bullpupshotgun", "musket",
    "heavyshotgun", "dbshotgun", "autoshotgun", "assaultrifle", "assaultrifle_mk2", "carbinerifle",
    "carbinerifle_mk2", "advancedrifle", "specialcarbine", "specialcarbine_mk2", "bullpuprifle",
    "bullpuprifle_mk2", "compactrifle", "mg", "combatmg", "combatmg_mk2", "gusenberg", "sniperrifle",
    "heavysniper", "heavysniper_mk2", "marksmanrifle", "marksmanrifle_mk2", "rpg", "grenadelauncher",
    "grenadelauncher_smoke", "minigun", "firework", "railgun", "hominglauncher", "compactlauncher",
    "rayminigun", "grenade", "bzgas", "smokegrenade", "flare", "molotov", "stickybomb", "proxmine",
    "snowball", "pipebomb", "ball", "petrolcan", "fireextinguisher", "hazardcan"}


    CreateThread(function()
    local DeathReason, Killer, DeathCauseHash, Weapon
    while true do
        Wait(250)
        if IsEntityDead(PlayerPedId()) then
            local PedKiller = GetPedSourceOfDeath(PlayerPedId())
            local killername = GetPlayerName(PedKiller)
            DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
            local heheid = GetPlayerFromServerId(PedKiller)
            if heheid < 0 then 
                return
            end
            Weapon = nil
            if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
                Killer = NetworkGetPlayerIndexFromPed(PedKiller)
            elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
                Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
            end

            if (Killer == PlayerId()) then
            elseif (Killer == nil) then
            else
                for k, v in ipairs(weaponHashes) do
                    if DeathCauseHash ==  GetHashKey("weapon_" .. v) then
                        Weapon = 'weapon_' .. v
                    end
                end
                    if HasPedGotWeapon(PedKiller, GetHashKey(Weapon)) then
                    else
                        if not bypass then
                            TriggerServerEvent(banevent, "[Eulen AK47 Button] to ID: " .. heheid)
                        end
                    end
            end

            Killer = nil
            DeathReason = nil
            DeathCauseHash = nil
            Weapon = nil
        end
        while IsEntityDead(PlayerPedId()) do
            Wait(1000)
        end
    end
    end)
    --Anti Eulen AK47
    --Anti Eulen AK47


    Citizen.CreateThread(function()
        while clientconfig.PlayerProtection do
            Wait(500)
            local detected = false
            for j,v in ipairs(GetGamePool('CVehicle')) do
                if j ~= nil and v ~= nil then
                    local re = GetEntityScript(v)
                    if re ~= nil and re ~= "" and re ~= " " then
                        local allowed = false
                        for j,v in ipairs(clientconfig.AISpawnRestr) do
                            if v.resource == re and tonumber(v.vehicles) ~= 0 then
                                allowed = true
                                break
                            end
                        end

                        if not allowed and not bypass then
                            DeleteVehicle(v)
                            if NetworkGetEntityOwner(v) == -1 then
                                if not detected then
                                    detected = true
                                    TriggerServerEvent(banevent, "[Tried to spawn vehicle from unknown script: " .. re .."]") --(PLAYER BLIPS)
                                end
                            end
                        end
                    end
                end
            end

            for j,v in ipairs(GetGamePool('CPed')) do
                if j ~= nil and v ~= nil then
                    local re = GetEntityScript(v)
                    if re ~= nil and re ~= "" and re ~= " " then
                        local allowed = false
                        for j,v in ipairs(clientconfig.AISpawnRestr) do
                            if v.resource == re and tonumber(v.peds) ~= 0 then
                                allowed = true
                                break
                            end
                        end
                        if not allowed then
                            DeleteEntity(v)
                            if NetworkGetEntityOwner(v) == -1 then
                                if not detected then
                                    detected = true
                                    if not bypass then
                                       TriggerServerEvent(banevent, "[Tried to spawn Ped from unknown script: " .. re .."]")
                                    end
                                end
                            end
                        end
                    end
                end
            end

            for j,v in ipairs(GetGamePool('CObject')) do
                if j ~= nil and v ~= nil then
                    local re = GetEntityScript(v)
                    if re ~= nil and re ~= "" and re ~= " " then
                        local allowed = false
                        for j,v in ipairs(clientconfig.AISpawnRestr) do
                            if v.resource == re and tonumber(v.objects) ~= 0 then
                                allowed = true
                                break
                            end
                        end
                        if not allowed then
                            DeleteEntity(v)
                            if NetworkGetEntityOwner(v) == -1 then
                                if not detected then
                                    detected = true
                                    if not bypass then
                                       TriggerServerEvent(banevent, "[Tried to spawn object from unknown script: " .. re .."]") --(PLAYER BLIPS)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    

    --Anti Damage Modifier
    --Anti Damage Modifier
    Citizen.CreateThread(function()
        while true do
            if clientconfig.AntiDamageModifier then
                local _pid = PlayerId()
                SetWeaponDamageModifier(_pid, clientconfig.DamageModifier)
            end
            Citizen.Wait(0)
        end
    end)
    --Anti Damage Modifier
    --Anti Damage Modifier

    RegisterNetEvent('el_protectore:delEnt')
    AddEventHandler('el_protectore:delEnt', function(entity)
        if DoesEntityExist(entity) then
            Citizen.Wait(500)
            SetEntityCollision(entity, false, false)
            SetEntityAlpha(entity, 0.0, true)
            SetEntityAsMissionEntity(entity, true, true)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
        end
    end)
    
    RegisterNetEvent('el_protectore:delParticles')
    AddEventHandler('el_protectore:delParticles', function()
        RemoveParticleFxInRange(18.04513, 530.428, 174.6297, 99999999)
    end)
    

    -- Anti Player Blips
    -- Anti Player Blips
    Citizen.CreateThread(function()
        while clientconfig.AntiBlips do
            Citizen.Wait(6191)
            local _pid = PlayerId()
            local _activeplayers = GetActivePlayers()
            for i = 1, #_activeplayers do
                if i ~= _pid then
                    if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) and not bypass then
                        TriggerServerEvent(banevent, "[Tried to activate player blips]")
                    end
                end
                Citizen.Wait(50)
            end
        end
    end)
    -- Anti Player Blips
    -- Anti Player Blips


    local allWeapons = {
        "WEAPON_UNARMED",
        "WEAPON_KNIFE",
        "WEAPON_KNUCKLE",
        "WEAPON_NIGHTSTICK",
        "WEAPON_HAMMER",
        "WEAPON_BAT",
        "WEAPON_GOLFCLUB",
        "WEAPON_CROWBAR",
        "WEAPON_BOTTLE",
        "WEAPON_DAGGER",
        "WEAPON_HATCHET",
        "WEAPON_MACHETE",
        "WEAPON_FLASHLIGHT",
        "WEAPON_SWITCHBLADE",
        "WEAPON_PISTOL",
        "WEAPON_PISTOL_MK2",
        "WEAPON_COMBATPISTOL",
        "WEAPON_APPISTOL",
        "WEAPON_PISTOL50",
        "WEAPON_SNSPISTOL",
        "WEAPON_HEAVYPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_STUNGUN",
        "WEAPON_FLAREGUN",
        "WEAPON_MARKSMANPISTOL",
        "WEAPON_REVOLVER",
        "WEAPON_REVOLVER_MK2",
        "WEAPON_MICROSMG",
        "WEAPON_SMG",
        "WEAPON_SMG_MK2",
        "WEAPON_ASSAULTSMG",
        "WEAPON_MG",
        "WEAPON_COMBATMG",
        "WEAPON_COMBATMG_MK2",
        "WEAPON_COMBATPDW",
        "WEAPON_GUSENBERG",
        "WEAPON_MACHINEPISTOL",
        "WEAPON_ASSAULTRIFLE",
        "WEAPON_ASSAULTRIFLE_MK2",
        "WEAPON_CARBINERIFLE",
        "WEAPON_CARBINERIFLE_MK2",
        "WEAPON_ADVANCEDRIFLE",
        "WEAPON_SPECIALCARBINE",
        "WEAPON_BULLPUPRIFLE",
        "WEAPON_COMPACTRIFLE",
        "WEAPON_PUMPSHOTGUN",
        "WEAPON_SAWNOFFSHOTGUN",
        "WEAPON_BULLPUPSHOTGUN",
        "WEAPON_ASSAULTSHOTGUN",
        "WEAPON_MUSKET",
        "WEAPON_HEAVYSHOTGUN",
        "WEAPON_DBSHOTGUN",
        "WEAPON_SNIPERRIFLE",
        "WEAPON_HEAVYSNIPER",
        "WEAPON_HEAVYSNIPER_MK2",
        "WEAPON_MARKSMANRIFLE",
        "WEAPON_GRENADELAUNCHER",
        "WEAPON_GRENADELAUNCHER_SMOKE",
        "WEAPON_RPG",
        "WEAPON_MINIGUN",
        "WEAPON_STINGER",
        "WEAPON_FIREWORK",
        "WEAPON_HOMINGLAUNCHER",
        "WEAPON_GRENADE",
        "WEAPON_STICKYBOMB",
        "WEAPON_PROXMINE",
        "WEAPON_BZGAS",
        "WEAPON_SMOKEGRENADE",
        "WEAPON_MOLOTOV",
        "WEAPON_FIREEXTINGUISHER",
        "WEAPON_PETROLCAN",
        "WEAPON_FLARE",
        "WEAPON_RAYPISTOL",
        "WEAPON_RAYCARBINE",
        "WEAPON_RAYMINIGUN",
        "WEAPON_STONE_HATCHET",
        "WEAPON_BATTLEAXE",
        "GADGET_PARACHUTE",
    }
    
    Citizen.CreateThread(function()
        while true do
        local count = 0
        Citizen.Wait(1000)
            for i,k in pairs(allWeapons) do
                if HasPedGotWeapon(PlayerPedId(), GetHashKey(k)) and not bypass then
                    count = count +1 
                end
            end
    
            if count > 50 then
                for i,k in pairs(allWeapons) do
                    RemoveWeaponFromPed(PlayerPedId(), GetHashKey(k)) 
                end
            end
        end
    end)
    
    --anti noclip
    --anti noclip
    Citizen.CreateThread(function()
    local detects = 0
    local detects2 = 0
        Citizen.Wait(30000)
        while true do
            Citizen.Wait(100)
            local _ped = GetPlayerPed(-1)
            local _heightaboveground = GetEntityHeightAboveGround(_ped)
            local _pstate = GetPedParachuteState(_ped)
            local _pid = PlayerPedId()
            if clientconfig.AntiNoclip then
                if _heightaboveground > 25 and not IsPedInAnyVehicle(_ped, false) and not IsPedInParachuteFreeFall(_ped) and not IsPedFalling(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsEntityVisible(_ped) and not IsPlayerDead(_pid) then
                    if _pstate == -1 then
                        if detects > 0 and not bypass then
                            TriggerServerEvent(banevent, "Noclip")
                            Citizen.Wait(10000)
                        else
                            detects = detects + 1
                        end
                    end
                else
                    detects = 0
                end
            end
            if clientconfig.AntiFlyandVehicleBelowLimits then
                if _heightaboveground > 35 and IsPedInAnyVehicle(_ped, false) then
                    local vehicle = GetVehiclePedIsUsing(ped)
                    local isheli = GetVehicleClass(vehicle)
                    if isheli == 15 or isheli == 16 then
                    else
                        if detects2 > 0 and not bypass then
                            TriggerServerEvent(banevent, "User seems to be flying around in a vehicle.")
                            Citizen.Wait(10000)
                        else
                                detects2 = detects2 + 1
                        end
                    end
                else
                    detects2 = 0
                end
            end
        end
    end)
    --anti noclip
    --anti noclip

    Citizen.CreateThread(function()
            local detects = 0
            while clientconfig.AntiInvisble do
                Citizen.Wait(5000)
                    local _ped = GetPlayerPed(-1)
                    local time = 0
                    local _entityalpha = GetEntityAlpha(_ped)
                        if not IsEntityVisibleToScript(_ped) then
                            if not IsEntityVisible(_ped) or not IsEntityVisibleToScript(_ped) or _entityalpha <= 150 and not IsPedJumpingOutOfVehicle(_ped) then
                                if detects > 0 then
                                    if bypass then
                                        return
                                    end
                                    TriggerServerEvent(banevent, "Anti Invisible")
                                    Citizen.Wait(10000)
                                else
                                    detects = detects + 1 
                                end
                        
                            else
                                detects = 0
                            end
                    else
                            if not IsEntityVisible(_ped) or not IsEntityVisibleToScript(_ped) or _entityalpha <= 150 and not IsPedJumpingOutOfVehicle(_ped) then
                                if detects > 0 then
                                    if bypass then
                                        return
                                    end
                                    TriggerServerEvent(banevent, "Anti Invisible")
                                    Citizen.Wait(10000)
                                else
                                    detects = detects + 1 
                                end
                        
                            else
                                detects = 0
                            end
                        end
                    end
    end)




    
        Citizen.CreateThread( function()
            while true do
                Citizen.Wait(1000)
                if clientconfig.AntiInvisible then
                    if tonumber(GetEntityAlpha(PlayerPedId())) > 255 or tonumber(GetEntityAlpha(PlayerPedId())) < 150 and not bypass then
                        TriggerServerEvent(banevent, "Anti Invisible")
                        Citizen.Wait(10000)
                    end
                end

                if IsEntityPlayingAnim(PlayerPedId(), "reaction@shove", "shoved_back", 3) then
                    FreezeEntityPosition(PlayerPedId(), false)
                    StopAnimTask(PlayerPedId(), "reaction@shove", "shoved_back", 3)
                    ClearPedTasks(PlayerPedId())
                end
            end
        end)
        
        AddEventHandler('gameEventTriggered', function(name, args)
            if name == 'CEventNetworkEntityDamage' and not bypass then
                 local data = args
                 local victim = data[1]
                 local attacker = data[2]
                 local weapon = data[7]
        
                 local victimCoords = GetEntityCoords(victim)
                 local attackerCoords = GetEntityCoords(attacker)
                if clientconfig.AntiSuperJump then
                    if #(attackerCoords - victimCoords) > 15 and attacker == PlayerPedId() and victim ~= PlayerPedId() and weapon == GetHashKey("WEAPON_STUNGUN") and not bypass then
                        TriggerServerEvent(banevent, "Anti Taze Player")
                    end
                end
             end
        end)

        Citizen.CreateThread(function()
            while true do
                Wait(200)
                playerPed = PlayerPedId()
                if playerPed then
                    nothing, weapon = GetCurrentPedWeapon(playerPed, true)
                    if disableallweapons then
                        RemoveAllPedWeapons(playerPed, true)
                    else
                        if isWeaponBlacklisted(weapon) then
                            RemoveWeaponFromPed(playerPed, weapon)
                        end
                    end
                end

                -- if clientconfig.AntiFreeCam then
                --     InvalidateIdleCam()
                --     InvalidateVehicleIdleCam()
                --     local camcoords = (GetEntityCoords(_ped) - GetFinalRenderedCamCoord())
                --     print(camcoords)
                --     if (camcoords.x > 25) or (camcoords.y > 25)  or (camcoords.x < -25) or (camcoords.y < -25) and IsEntityDead(_ped) == false and playerloadedd == true then
                --         TriggerServerEvent(banevent, 'Freecam')
                --     end
                -- end
            end
        end)
        
        function isWeaponBlacklisted(model)
            for _, blacklistedWeapon in pairs(clientconfig.BlacklistedWeapons) do
                if model == GetHashKey(blacklistedWeapon) then
                    return true
                end
            end
        
            return false
        end        
end