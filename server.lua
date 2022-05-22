local configloaded = false
local esxsrv = false
local loadedplayers = {}
local clienttokens = {}
local banEventClients 
local HBEVENT

do
    local wewew = 7186422254865010
    local qweqweqeq = 1325
  
    local inv256

    function decode(str)
		local K, F = wewew, 16384 + qweqweqeq
		return (str:gsub('%x%x',
			function(c)
				local L = K % 274877906944  -- 2^38
				local H = (K - L) / 274877906944
				local M = H % 128
				c = tonumber(c, 16)
				local m = (c + (H - M) / 128) * (2*M + 1) % 256
				K = L * F + H + c + m
				return string.char(m)
			end
		))
    end
end



iskkkkk = true
PerformHttpRequest('https://license.dnz.wtf/auth/ac', function(a, config, d)
    -- if dnz_system.extraScript == 'el_protectore' then
    --     maprint("[^1PRO^0TECTOR] >   ^1[MODULE] Please rename el_protectore to something else. In Config.extraScript and also rename the script itself we delivered.^0")
    --     maprint("[^1PRO^0TECTOR] >   ^1[MODULE] Please rename el_protectore to something else. In Config.extraScript and also rename the script itself we delivered.^0")
    --     return
    -- end
    -- if GetResourceState(dnz_system.extraScript) ~= 'started' then
    --     iskkkkk = false
    --     StartResource(dnz_system.extraScript)
    --     if GetResourceState(dnz_system.extraScript) ~= 'started' then
    --         maprint("[^1PRO^0TECTOR] >   ^1[MODULE] dnz_system.extraScript was not able to load. Please ensure you are using the script that was in the download included or you will run into problems.^0")
    --         maprint("[^1PRO^0TECTOR] >   ^1[MODULE] dnz_system.extraScript was not able to load. Please ensure you are using the script that was in the download included or you will run into problems.^0")
    --         return
    --     end
    -- end

  loadconfig = json.decode(config)
  if loadconfig ~= nil then
      configloaded = true
      serverconfig = loadconfig.server
      ts = loadconfig.ts
      clientconfig = loadconfig.client
      blacklistconfig = loadconfig.blacklist
      clientconfig.BlacklistedWeapons = blacklistconfig.blacklistedweaponslist
      clientconfig.BlackListedCMDEnabled = blacklistconfig.BlackListedCMDEnabled
      clientconfig.BlacklistedWordsEnabled = blacklistconfig.BlacklistedWordsEnabled
      clientconfig.AntiBlacklistedWeaponsEnabled = blacklistconfig.AntiBlacklistedWeaponsEnabled
      generalconfig = loadconfig.general
      webhookconfig = loadconfig.webhook
      exploitconfig = loadconfig.exploits
      userinfo = loadconfig.user
      explosionslist = loadconfig.explosions
      clientconfig.AISpawnRestr = {}
        for i,k in pairs(explosionslist) do 
            table.insert(clientconfig.AISpawnRestr, {resource = k.name, vehicles = k.log, objects = k.kick, peds = k.block})
        end



        if generalconfig.esx_server and generalconfig.esx_shared_object then
            esxsrv = true
            Citizen.CreateThread(function()
                while ESX == nil do
                    TriggerEvent('' .. generalconfig.esx_shared_object ..'', function(obj) ESX = obj end)
                    Citizen.Wait(0)
                end
                maprint("[^1PRO^0TECTOR] >   ^0[ESX] ^2Object has been loaded.^0")
            end)
        end
        if blacklistconfig.BlacklistedWords then
            str = blacklistconfig.BlacklistedWords
            clientconfig.BlacklistedWords = {}
            for s in str:gmatch("[^\r\n]+") do
                table.insert(clientconfig.BlacklistedWords, s) 
            end
        end

        if ts.SecuringTriggers then
            str = ts.SecuringTriggers
            ts.SecuringTriggers = {}
            for s in str:gmatch("[^\r\n]+") do
                table.insert(ts.SecuringTriggers, s) 
            end
        end

        if blacklistconfig.blacklistedweaponslist then
            str = blacklistconfig.blacklistedweaponslist
            clientconfig.BlacklistedWeapons = {}
            for s in str:gmatch("[^\r\n]+") do
                table.insert(clientconfig.BlacklistedWeapons, s) 
            end
        end
        if blacklistconfig.BlackListedCMD then
            str = blacklistconfig.BlackListedCMD
            clientconfig.BlackListedCMD = {}
            for s in str:gmatch("[^\r\n]+") do
                table.insert(clientconfig.BlackListedCMD, s) 
            end
        end
        
        if blacklistconfig.blacklistedweaponslist then
            str = blacklistconfig.blacklistedweaponslist
            blacklistconfig.blacklistedweaponslistnew = {}
                for s in str:gmatch("[^\r\n]+") do
                    table.insert(blacklistconfig.blacklistedweaponslistnew, s) 
                end
        end
        if blacklistconfig.BlacklistedModels then
            str = blacklistconfig.BlacklistedModels
            blacklistconfig.BlacklistedModelsnew = {}
                for s in str:gmatch("[^\r\n]+") do
                    table.insert(blacklistconfig.BlacklistedModelsnew, s) 
                end
                clientconfig.blacklistmodels = blacklistconfig.BlacklistedModelsnew
        end
        if blacklistconfig.BlackListedCMD then
            str = blacklistconfig.BlackListedCMD
            blacklistconfig.BlackListedCMDnew = {}
                for s in str:gmatch("[^\r\n]+") do
                    table.insert(blacklistconfig.BlackListedCMDnew, s) 
                end
        end
        if blacklistconfig.WhitelistedProps then
            str = blacklistconfig.WhitelistedProps
            blacklistconfig.WhitelistedPropsnew = {}
            for s in str:gmatch("[^\r\n]+") do
                table.insert(blacklistconfig.WhitelistedPropsnew, s) 
            end
        end

        if blacklistconfig.BlacklistedTriggers then
            str = blacklistconfig.BlacklistedTriggers
            blacklistconfig.BlacklistedTriggersnew = {}
                for s in str:gmatch("[^\r\n]+") do
                    table.insert(blacklistconfig.BlacklistedTriggersnew, s) 
                end
        end

        if blacklistconfig.BlacklistedWords then
            str = blacklistconfig.BlacklistedWords
            blacklistconfig.BlacklistedWordsnew = {}
                for s in str:gmatch("[^\r\n]+") do
                    table.insert(blacklistconfig.BlacklistedWordsnew, s) 
                end
        end

        expiry = "none"
        if userinfo.expiry ~= nil then
            expiry = userinfo.expiry
        end

        maprint("")
        maprint("[^1PRO^0TECTOR] >   ^2Logged in as: ^0" .. userinfo.username)
        maprint("[^1PRO^0TECTOR] >   ^2Expiration: ^0" .. expiry)
        maprint("")
        maprint("                        ^0_            _             ")
        maprint("       ^1 _ __  _ __ ___ ^0| |_ ___  ___| |_ ___  _ __ ")
        maprint("       ^1| '_ \\| '__/ _ \\^0| __/ _ \\/ __| __/ _ \\| '__|")
        maprint("       ^1| |_) | | | (_) ^0| ||  __/ (__| || (_) | |   ")
        maprint("       ^1| .__/|_|  \\___/ ^0\\__\\___|\\___|\\__\\___/|_|   ")
        maprint("       ^1|_|             ^0                                      ")
        maprint("")
        maprint("")
        maprint("[^1PRO^0TECTOR] >   ^0We have loaded your panel config ^2successfully^0")
        maprint("[^1PRO^0TECTOR] >   ^1PRO^0TECTOR is now active and operating.^0")
        local charset = {}    
        for i = 48,  57 do table.insert(charset, string.char(i)) end
        for i = 65,  90 do table.insert(charset, string.char(i)) end
        for i = 97, 122 do table.insert(charset, string.char(i)) end

        local config = LoadResourceFile(GetCurrentResourceName(), "bans.json")
        if config == nil then
            banlistregenerator()
            Citizen.Wait(100)
        end

        function string.random(length)
            math.randomseed(os.time())
            if length >  0 then
            return string.random(length - 1) .. charset[math.random(1, #charset)]
            else
            return ""
            end
        end
        
         banEventClients = string.random(45)
         HBEVENT = string.random(25)
         local beingbanned = {}
        --Banevent
        RegisterServerEvent(banEventClients)
        AddEventHandler(banEventClients, function(reason)
            if not beingbanned[source] then
                beingbanned[source] = true
                if reason == "DrawText3D2" then
                elseif reason == 'RequestControlOnce' then
                else
                    sendDiscordLog(reason, "none", webhookconfig.webhook1, source)
                    cya(reason, source)
                end
            end
        end)
        loadac()


        file = LoadResourceFile(GetCurrentResourceName(), "secure.protector", "r")
        local connectedclients = {}
        if file then
            if string.find(file, '27cabf8559b15d8d65a6dc0a8d7e904244bbe') and #file == 1025950 then
                local xy = decode(file)
                clienttokens = json.decode(xy)
                RegisterServerEvent('AWaskwQIFJqiqhweq')
                AddEventHandler('AWaskwQIFJqiqhweq',function()
                    if not connectedclients[source] then
                        connectedclients[source] = true
                        TriggerClientEvent('protector:recieveTokens', source, clienttokens, banEventClients,HBEVENT)
                    end
                end)
                maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2secure.protector has been loaded.^0")
            else
                maprint("[^1PRO^0TECTOR] >   ^1[MODULE] secure.protector is corrupted. Please redownload.^0")
            end
        else
            maprint("[^1PRO^0TECTOR] >   ^1[MODULE] secure.protector is corrupted. Please redownload.^0")
        end
        if exploitconfig.AntiCipher then
            maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2Anti Backdoor has been initiated.^0")
            runcipher(0)
        end

        if exploitconfig.AntiDphone then
            AddEventHandler('d-phone:server:twitter:writetweet', function(clientsource, message, twitteraccount, image)
                if string.find(twitteraccount.username,'<') then
                    cya("Hell no.", source)
                end
            end)
        end

        if exploitconfig.AntiMoneyDupe then
            if not esxsrv then
                maprint("[^1PRO^0TECTOR] >   ^1[MODULE] Anti Money Dupe was not able to load because there is no ESX Object..^0")
            else
                maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2Anti Money Dupe has been loaded.^0")
                AddEventHandler('esx:playerLoaded', function(source)
                    local xPlayers = ESX.GetPlayers()
                    local myplayer = ESX.GetPlayerFromId(source)
                    local myid = myplayer.identifier
                    local myname = myplayer.getName()
                    for i=1, #xPlayers, 1 do
                        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                        if myplayer.source == xPlayer.source then
                        else
                            if xPlayer.identifier == myid then
                                kickuser("Hell no.", source) --edit for release
                            end
                        end
                    end
                end)
            end
        end

        if exploitconfig.layer7protector then
            maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2L7 Blocker has been loaded.^0")
            ExecuteCommand("set sv_requestParanoia 3")
        end

        RegisterServerEvent('sGasHHerR')
        AddEventHandler('sGasHHerR', function()
            local xyc = source
            TriggerClientEvent('JQWODJQIHG', xyc, true)
        end)

        if exploitconfig.AntiWeaponHack then

        end

        --antiservercrasher
        if exploitconfig.AntiServerCrasher then
            if not esxsrv then
                maprint("[^1PRO^0TECTOR] >   ^1[MODULE] Anti Server Crasher was not able to load because there is no ESX Object..^0")
            else
                maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2Anti Server Crasher has been loaded.^0")
                sentrequest = {}
                RegisterNetEvent('esx_license:getLicenses')
                AddEventHandler('esx_license:getLicenses', function()
                    local _src = source
                    if sentrequest[_src] == nil or sentrequest[_src] == "no" then 
                        sentrequest[_src] = "trigger"
                        Citizen.Wait(500)
                        sentrequest[_src] = "no"
                    elseif sentrequest[_src] == "trigger" then
                        kickuser("Hell no.", source)--edit for release
                    end
                end)
            end
        end

        -- anti namechanger
        if exploitconfig.AntiNameChanger then
            if not esxsrv then
                maprint("[^1PRO^0TECTOR] >   ^1[MODULE] Anti Name Changer was not able to load because there is no ESX Object..^0")
            else
                maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2Anti Name Changer has been loaded.^0")
                RegisterServerEvent('esx_identity:setIdentity')
                AddEventHandler('esx_identity:setIdentity', function(data, myIdentifiers)
                        local xPlayer = ESX.GetPlayerFromId(source)
                        local identifier = json.encode(GetPlayerIdentifiers(source))
                        if string.find(json.encode(myIdentifiers), xPlayer.identifier) then
                            kickuser("Hell no.", source)--edit for release
                        end
                end)
            end
        end

        local AntiLuaExecutorAITrigger = {}
        local regexpatterns = {'RegisterNetEvent%((.-)%)', 'RegisterServerEvent%((.-)%)'}
        local regexpatternsAILuaExecutorSearch = {'TriggerServerEvent%((.-)%)'}
        function teee123(source)
            count = 0
            skip = 0
            if source == 0 then
                for resources = 0, GetNumResources() - 1 do
                    local _resname = GetResourceByFindIndex(resources)
                    local num = GetNumResourceMetadata(_resname, 'client_script')
                    if num >  0 then
                        for i = 0, num-1 do
                            local file = GetResourceMetadata(_resname, 'client_script', i)
                            checkresource = LoadResourceFile(_resname, file)
                            if string.find(file, "@") or string.find(file, "locale") or _resname == GetCurrentResourceName() or string.find(_resname, 'webadmin') or string.find(_resname, 'monitor')  or  string.find(_resname, 'oxmysql') or file == 'mysql-async.js' then
                                skip = skip + 1
                               
                            else
                                if string.find(file, "*") then
                                    skip = skip + 1
                                else
                                    if checkresource ~= nil and checkresource ~= GetCurrentResourceName() then
                                            s = checkresource
                                            local found = string.match(s, "TriggerServerEvent%((.-)%)")
                                            for i,k in ipairs(regexpatternsAILuaExecutorSearch) do
                                            for word in checkresource:gmatch(k) do
                                                count = count +1
                                                local fo = false
                                                if string.find(word, "'") or string.find(word, '"') then
                                                    local foundtriggi = ""
                                                    
                                                    if string.find(word, ",") then
                                                        local cabin_text = word:match('^(.-),')
                                                        cabin_text = cabin_text:gsub(" ", '')
                                                      foundtriggi = cabin_text:gsub("'", '')
                                                      foundtriggi = foundtriggi:gsub('"', '')
                                                      foundtriggi = foundtriggi:gsub(" ", '')
                                                      if string.find(foundtriggi, "..") then
                                                         foundtriggi:gsub("..", "") 
                                                      end    
                                                    for i,k in ipairs(AntiLuaExecutorAITrigger) do
                                                            if k == foundtriggi then
                                                                fo = true
                                                                break
                                                            end
                                                        end
                                                        if not fo then
                                                            if foundtriggi ~= "" then
                                                                if foundtriggi ~= " " then
                                                                    if foundtriggi ~= nil then
                                                                        if string.find(foundtriggi, 'dnz') or string.find(foundtriggi, 'es:') or string.find(foundtriggi, 'AWaskwQIFJqiqhweq') or string.find(foundtriggi, 'playerSpawn') then
                                                                        else
                                                                            table.insert(AntiLuaExecutorAITrigger, foundtriggi)
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    else
                                                        foundtriggi = word:gsub("'", '')
                                                        foundtriggi = foundtriggi:gsub('"', '')
                                                        foundtriggi = foundtriggi:gsub(" ", '')
                                                        if string.find(foundtriggi, "..") then
                                                           foundtriggi:gsub("..", "") 
                                                        end    
                                                        for i,k in ipairs(AntiLuaExecutorAITrigger) do
                                                            if k == foundtriggi then
                                                                fo = true
                                                                break
                                                            end
                                                        end
                                                        if not fo then
                                                            if foundtriggi ~= "" then
                                                            if foundtriggi ~= " " then
                                                                if foundtriggi ~= nil then
                                                                    if string.find(foundtriggi, 'dnz') or string.find(foundtriggi, 'es:') or string.find(foundtriggi, 'AWaskwQIFJqiqhweq') or string.find(foundtriggi, 'playerSpawn') then
                                                                    else
                                                                        table.insert(AntiLuaExecutorAITrigger, foundtriggi)
                                                                    end
                                                                end
                                                            end
                                                        end
                                                        end
                                                    end
                                            end
                                        end
                                            
                                        end
        
                                    end
                                end
                            end
                        end
                    else
                        local file = GetResourceMetadata(_resname, 'client_script', 0)
                    end
                end
                
                string = ""
                local tlist = ""
                for i,k in pairs(AntiLuaExecutorAITrigger) do
                    tlist = tlist .. '\n' .. k
                end
            end
        end
        -- Anti Trigger
        local reggedevents = {}
        if ts.EnableSecuringTriggers then
            tokens = {}
            local blacklistedtriggers = {'baseevents','baseevents'}
            --teee123(0)
            --Wait(5000)
            local mytriggers = 0
            local foundtriggers = 0
            local waitingexecution = {}
            ts.SecuringTriggers1 = AntiLuaExecutorAITrigger
            clientconfig.enableSecuring = true
            if ts.SecuringTriggers then
                for i, k in pairs(ts.SecuringTriggers) do
                    found = false
                    checkevent = k
                    for i,k in pairs(reggedevents) do 
                        if k == checkevent then
                            found = true
                        end
                    end
                    for i,k in pairs(blacklistedtriggers) do 
                        if string.find(checkevent, k) then
                            found = true
                        end
                    end
                    if not found then
                        RegisterNetEvent("DmOGhVyyAUFaSIbybagXUkRwYKbHMIQzLDNhuhGvDVHdIxBpHadwIwxgXkbwfKkGbOpmkPOtjgPgyTyVoRedssudQREuctjtZRnUpGgpGoPZoxSMmXvrilslmjnXyNhAEVPddjSbeGqNCqvcpYXirsqmNqpHYUxWDeuUbNxJbgyFpVQnCzvrvHWblXRkKhiLbwWOGNpCDmOGhVyyAUFaSIbybagXUkRwYKbHMIQzLDNhuhGvDVHdIxBpHadwIwxgXkbwfKkGbOpmkPOtjgPgyTyVoRedssudQREuctjtZRnUpGgpGoPZoxSMmXvrilslmjnXyNhAEVPddjSbeGqNCqvcpYXirsqmNqpHYUxWDeuUbNxJbgyFpVQnCzvrvHWblXRkKhiLbwWOGNpC" .. k)
                        AddEventHandler("DmOGhVyyAUFaSIbybagXUkRwYKbHMIQzLDNhuhGvDVHdIxBpHadwIwxgXkbwfKkGbOpmkPOtjgPgyTyVoRedssudQREuctjtZRnUpGgpGoPZoxSMmXvrilslmjnXyNhAEVPddjSbeGqNCqvcpYXirsqmNqpHYUxWDeuUbNxJbgyFpVQnCzvrvHWblXRkKhiLbwWOGNpCDmOGhVyyAUFaSIbybagXUkRwYKbHMIQzLDNhuhGvDVHdIxBpHadwIwxgXkbwfKkGbOpmkPOtjgPgyTyVoRedssudQREuctjtZRnUpGgpGoPZoxSMmXvrilslmjnXyNhAEVPddjSbeGqNCqvcpYXirsqmNqpHYUxWDeuUbNxJbgyFpVQnCzvrvHWblXRkKhiLbwWOGNpC" .. k, function(token)
                            local _src = source

                            if token == nil then
                                sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 8", webhookconfig.webhook1, _src)
                                cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 8", _src)
                                return
                            end
                            token = tostring(token)
                            if loadedplayers[_src] == nil then
                                return
                            end

                            found = false
                            if not waitingexecution[_src] then
                                waitingexecution[_src] = true
                            else
                                sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 1", webhookconfig.webhook1, _src)
                                cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 1", _src)
                                return
                            end


                            if token ~= nil then
                                for i,d in pairs(tokens) do
                                    if d.serverid == _src then
                                        if d.event == k then
                                            if d.token == token then
                                                found = true
                                            end   
                                        end
                                    end
                                end

                                if found then
                                    sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 3", webhookconfig.webhook1, _src)
                                    cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 3", _src)
                                    return
                                else
                                    if string.find(json.encode(clienttokens), token) then
                                        table.insert(tokens,{token = token, event = k, serverid = _src})
                                    else
                                        sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 4", webhookconfig.webhook1, _src)
                                        cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 4", _src)
                                        return
                                    end
                                end
                            else
                                sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 5", webhookconfig.webhook1, _src)
                                cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 5", _src)
                                return
                            end
                        end)
                        RegisterNetEvent(k)
                        AddEventHandler(k, function()
                            local _src = source
                            if loadedplayers[_src] == nil then
                                return
                            end

                            if waitingexecution[_src] then
                                waitingexecution[_src] = false
                            elseif not waitingexecution[_src] then
                                sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 6", webhookconfig.webhook1, _src)
                                cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 6", _src)
                                return
                            end
                        end)

                        mytriggers = mytriggers + 1
                        table.insert(reggedevents, {event = k})
                    end
                end
            end
            
            -- if ts.SecuringTriggers1 then 
            --     for i, k in pairs(ts.SecuringTriggers1) do
            --         checkevent = k
            --         found = false

            --         for i,k in pairs(reggedevents) do 
            --             if k.event == checkevent then
            --                 found = true
            --             end
            --         end

            --         for i,k in pairs(blacklistedtriggers) do 
            --             if string.find(checkevent, k) then
            --                 found = true
            --             end
            --         end
            --         if not found then
            --             RegisterNetEvent("DmOGhVyyAUFaSIbybagXUkRwYKbHMIQzLDNhuhGvDVHdIxBpHadwIwxgXkbwfKkGbOpmkPOtjgPgyTyVoRedssudQREuctjtZRnUpGgpGoPZoxSMmXvrilslmjnXyNhAEVPddjSbeGqNCqvcpYXirsqmNqpHYUxWDeuUbNxJbgyFpVQnCzvrvHWblXRkKhiLbwWOGNpCDmOGhVyyAUFaSIbybagXUkRwYKbHMIQzLDNhuhGvDVHdIxBpHadwIwxgXkbwfKkGbOpmkPOtjgPgyTyVoRedssudQREuctjtZRnUpGgpGoPZoxSMmXvrilslmjnXyNhAEVPddjSbeGqNCqvcpYXirsqmNqpHYUxWDeuUbNxJbgyFpVQnCzvrvHWblXRkKhiLbwWOGNpC" .. k)
            --             AddEventHandler("DmOGhVyyAUFaSIbybagXUkRwYKbHMIQzLDNhuhGvDVHdIxBpHadwIwxgXkbwfKkGbOpmkPOtjgPgyTyVoRedssudQREuctjtZRnUpGgpGoPZoxSMmXvrilslmjnXyNhAEVPddjSbeGqNCqvcpYXirsqmNqpHYUxWDeuUbNxJbgyFpVQnCzvrvHWblXRkKhiLbwWOGNpCDmOGhVyyAUFaSIbybagXUkRwYKbHMIQzLDNhuhGvDVHdIxBpHadwIwxgXkbwfKkGbOpmkPOtjgPgyTyVoRedssudQREuctjtZRnUpGgpGoPZoxSMmXvrilslmjnXyNhAEVPddjSbeGqNCqvcpYXirsqmNqpHYUxWDeuUbNxJbgyFpVQnCzvrvHWblXRkKhiLbwWOGNpC" .. k, function(token)
            --                 local _src = source

            --                 if token == nil then
            --                     sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 8", webhookconfig.webhook1, _src)
            --                     cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 8", _src)
            --                     return
            --                 end
            --                 token = tostring(token)
            --                 if loadedplayers[_src] == nil then
            --                     return
            --                 end
            --                 found = false
            --                 if not waitingexecution[_src] then
            --                     waitingexecution[_src] = true
            --                 else
            --                     sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 1", webhookconfig.webhook1, _src)
            --                     cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 1", _src)
            --                     return
            --                 end

            --                 if token ~= nil then
            --                     for i,d in pairs(tokens) do
            --                         if d.serverid == _src then
            --                             if d.event == k then
            --                                 if d.token == token then
            --                                     found = true
            --                                 end   
            --                             end
            --                         end
            --                     end

            --                     if found then
            --                         sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 3", webhookconfig.webhook1, _src)
            --                         cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 3", _src)
            --                         return
            --                     else
            --                         if string.find(json.encode(clienttokens), token) then
            --                             table.insert(tokens,{token = token, event = k, serverid = _src})
            --                         else
            --                             sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 4", webhookconfig.webhook1, _src)
            --                             cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 4", _src)
            --                             return
            --                         end
            --                     end
            --                 else
            --                     sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 5", webhookconfig.webhook1, _src)
            --                     cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 5", _src)
            --                     return
            --                 end
            --             end)
            --             RegisterNetEvent(k)
            --             AddEventHandler(k, function()
            --                 local _src = source
            --                 if loadedplayers[_src] == nil then
            --                     return
            --                 end
            --                 if waitingexecution[_src] then
            --                     waitingexecution[_src] = false
            --                 elseif not waitingexecution[_src] then
            --                     sendDiscordLog("Anti Trigger Server Event", "[Anti Executor] Player [".. _src .. "] tried to execute the trigger [" .. k .."] - Code 6", webhookconfig.webhook1, _src)
            --                     cya("[Anti Executor] Player [".. source .. "] [" .. k .."] - Code 6", _src)
            --                     return
            --                 end
            --             end)

            --             table.insert(reggedevents, {event = k})
            --             foundtriggers = foundtriggers + 1

            --         end
            --     end
            -- end

            maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2We have secured " .. mytriggers .. " Server Events from the Config.^0")
            -- maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2We have secured an additional " .. foundtriggers .. " Server Events that we found via scan^0")
            maprint("[^1PRO^0TECTOR] >   ^0[MODULE] ^2Anti Trigger has been loaded.^0")
        else
            clientconfig.enableSecuring = false
            clientconfig.SecuringTriggers = {}
        end

  else
    serverconfig = {}
    clientconfig = {}
    blacklistconfig = {}
    generalconfig = {}
    webhookconfig = {}
    exploitconfig = {}
      maprint("")
      maprint("                        ^0_            _             ")
      maprint("       ^1 _ __  _ __ ___ ^0| |_ ___  ___| |_ ___  _ __ ")
      maprint("       ^1| '_ \\| '__/ _ \\^0| __/ _ \\/ __| __/ _ \\| '__|")
      maprint("       ^1| |_) | | | (_) ^0| ||  __/ (__| || (_) | |   ")
      maprint("       ^1| .__/|_|  \\___/ ^0\\__\\___|\\___|\\__\\___/|_|   ")
      maprint("       ^1|_|             ^0                                      ")
      maprint("[^1PRO^0TECTOR]: ^1 PRO^0TECTOR was not able to load your config.")
      maprint("[^1PRO^0TECTOR]: ^0 Please retry or contact the support team.")
    return
  end
end, 'GET', json.encode({token = "", mytoken = dnz_system.Token}), {['Content-Type'] = 'application/json'})


function doesPlayerHavePerms(srrc, k)
    if k == nil or srrc == nil then
        return
    end
    ping = GetPlayerPing(srrc)
    if ping ~= nil then
        if tonumber(ping) > 0 then
            if IsPlayerAceAllowed(srrc, tostring(k)) then
                return true
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

function loadac()
    --Client Config Transfer
    RegisterServerEvent('ASgqWQdqiuhwQFI')
    AddEventHandler("ASgqWQdqiuhwQFI", function()
        TriggerClientEvent('ASgqWQdqiuhwQFI', source, clientconfig, banEventClients, doesPlayerHavePerms(source, generalconfig.protectorBypassGroups), HBEVENT)
    end)

    Text               = {}
    local BanList = {}
    local BlacklistedPropList = {}
    local WhitelistedPropList = {}
    local BlacklistedExplosionsList = {}
    local canbanforentityspawn = false
    srvloaded = false
    
    Citizen.CreateThread(function()
        Wait(10000)
        srvloaded = true
        maprint("[^1PRO^0TECTOR] >   ^0^2Server has been started up. Players can connect now.^0")
    end)




    function round(num, dec)
    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
    end
    

    Citizen.CreateThread(function()
        Citizen.Wait(3000)
        while true do
            loadBanList()
            if generalconfig.reloadbantime then
                Citizen.Wait(tonumber(generalconfig.reloadbantime*60000))
            end
        end
    end)

    function tabcontains(list, x)
        for _, v in pairs(list) do
            if v == x then return true end
        end
        return false
    end

    function uninstaller(source, args)
        if source == 0 then
            count = 0
            skip = 0
            
            local filetodelete = args .. ".lua"
            randomtextfile = "\n\nclient_script '" .. filetodelete .. "'"
            for resources = 0, GetNumResources() - 1 do
                local _resname = GetResourceByFindIndex(resources)
                resourcefile = LoadResourceFile(_resname, "__resource.lua")
                resourcefile2 = LoadResourceFile(_resname, "fxmanifest.lua")
                if resourcefile then
                    if string.find(resourcefile, randomtextfile) then
                        _toadd = resourcefile:gsub(randomtextfile, '')
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        SaveResourceFile(_resname, "__resource.lua", _toadd, -1)
                        Wait(100)
                        os.remove(_toremove)
                        maprint("[^1PRO^0TECTOR]: ^1Removed >>  ".._resname.."^7")
                        count = count + 1
                    else
                        skip = skip + 1
                    end
                elseif resourcefile2 then
                    if string.find(resourcefile2, randomtextfile) then
                        _toadd = resourcefile2:gsub(randomtextfile, '')
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        SaveResourceFile(_resname, "fxmanifest.lua", _toadd, -1)
                        Wait(100)
                        os.remove(_toremove)
                        maprint("[^1PRO^0TECTOR]: ^1Removed >>  ".._resname.."^7")
                        count = count + 1
                    end
                else
                    skip = skip + 1
                end
            end
            maprint("[^1PRO^0TECTOR]: ^2We have uninstalled the main module from your resources.^7")
        end
    end

    

    AddEventHandler('entityCreating', function(entity)
            local src = NetworkGetEntityOwner(entity)
            local model = GetEntityModel(entity)
            local _model = GetEntityModel(entity)
            local _type = GetEntityType(entity)
            if model == 1430544400 then
                TriggerClientEvent('el_protectore:delEnt', entity)
                sendDiscordLog("Anti Entity Spawn", "[Anti Entity] Player [".. src .. "] tried to rape another player.", webhookconfig.webhook1, src)
                if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                    cya("Anti Rape Ped",src)
                end
                DeleteEntity(entity)
                return
            end

        
            if model ~= 0 then
                    if model == 0 then return end
                    if model == '0' then return end
                    if model == nil then return end
                    if model == "null" then return end
                    if model == "0" then return end

                    if _type == 3 then 
                        if blacklistconfig.WhitelistedPropsnew then
                            local whitelistedprop = false
                            for _,whitelisted in ipairs(blacklistconfig.WhitelistedPropsnew) do
                                if _model == GetHashKey(whitelisted) or _model == whitelisted or tonumber(_model) == tonumber(whitelisted) then
                                    whitelistedprop = true
                                end
                            end

                            if not whitelistedprop then
                                --CancelEvent()
                                --TriggerClientEvent('el_protectore:delEnt', entity)
                                maprint("Anti Entity Spawn", "[Anti Entity] Player [".. src .. "] tried to spawn not whitelisted Object: [" .. model .."]", webhookconfig.webhook1, src) 
                                if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                                    --cya("[Anti Entity] Player [".. src .. "] tried to spawn not whitelisted Object: [" .. _model .."]",src)
                                end
                            end
                        else
                            --CancelEvent()
                            --TriggerClientEvent('el_protectore:delEnt', entity)
                            maprint("Anti Entity Spawn", "1 [Anti Entity] Player [".. src .. "] tried to spawn not whitelisted Object: [" .. model .."]", webhookconfig.webhook1, src) 
                            if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                                --cya("[Anti Entity] Player [".. src .. "] tried to spawn not whitelisted Object: [" .. _model .."]",src)
                            end
                        end
                    end
            end
    end)



    AddEventHandler('entityCreating', function(car)
                local src = NetworkGetEntityOwner(car)
                local type = GetEntityType(car)
                local model = GetEntityModel(car)
                if type == 2 then 
                    local ped = GetPlayerPed(src)
                    local playerPos = GetEntityCoords(ped)
                    local targetPos = GetEntityCoords(car) 
                    local distance = #(playerPos - targetPos)
                    local _source = src

                    local ignore = false
                    if blacklistconfig.WhitelistedPropsnew then
                        if serverconfig.MaxPedsPerUser then
                            for _,whitelistedcar in ipairs(blacklistconfig.WhitelistedPropsnew) do
                                if model == whitelistedcar then
                                    ignore = true
                                end
                            end

                            if not ignore then
                                if math.floor(distance) < 1 then 
                                    return
                                end
                                if math.floor(distance) > tonumber(serverconfig.MaxPedsPerUser) then
                                    TriggerClientEvent('el_protectore:delEnt', car)
                                    sendDiscordLog("Anti Entity Spawn", "[Anti Entity] Player [".. src .. "] tried to spawn car above car spawn distance. Spawned [" .. math.floor(distance) .."] Meters from the client away.", webhookconfig.webhook1, src) 
                                    if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                                        cya("[Anti Entity] Player [".. src .. "] tried to spawn car above car spawn distance. Spawned [" .. math.floor(distance) .."] Meters from the client away.",src)
                                    end
                                    CancelEvent()
                                end
                            end
                        end
                    end

                    if blacklistconfig.BlacklistedModelsnew then
                        for _,blacklistedentity in ipairs(blacklistconfig.BlacklistedModelsnew) do
                            if model == GetHashKey(blacklistedentity) or model == blacklistedentity then
                                CancelEvent()
                                TriggerClientEvent('el_protectore:delEnt', car)
                                sendDiscordLog("Anti Entity Spawn", "[Anti Entity] Player [".. src .. "] tried to spawn blacklisted car [" .. blacklistedentity .."]", webhookconfig.webhook1, src) 
                                if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                                    cya("[Anti Entity] Player [".. src .. "] tried to spawn car above car spawn distance. Spawned [" .. math.floor(distance) .."] Meters from the client away.",src)
                                end
                                break
                            end
                        end
                    end
                end
    end)


    
    AddEventHandler('explosionEvent', function(sender, ev)
        local sender = tonumber(sender)
        if (sender ~= nil and sender > 0) and serverconfig.AntiExplosion then 
            CancelEvent()
        end
    end)
    


    -- Anti Vehicle Spam
    local vehicle = {}
    AddEventHandler('entityCreating', function(entity)
            local entity = entity
            if not DoesEntityExist(entity) then
                return
            end
            local entID = NetworkGetNetworkIdFromEntity(entity)
            local src = NetworkGetEntityOwner(entity)
            local type = GetEntityType(entity)
            local hex = GetPlayerIdentifiers(src,1)[1]
            if blacklistconfig.MaxVehiclesPerUser then
            else
                return
            end
            if type ~= 0 then
                if GetEntityPopulationType(entity) ~= 7 then
                    return
                end
                local model = GetEntityModel(entity)
                if type == 2 then -- vehicle
                    if vehicle[hex] == nil then
                            vehicle[hex] = {
                            count = 1,
                            timestamp = os.time()
                            }
                    else
                            vehicle[hex].count = vehicle[hex].count + 1
                            if vehicle[hex].count > tonumber(serverconfig.MaxVehiclesPerUser) then
                                local fs = os.time() - vehicle[hex].timestamp
                                if fs < 10 then
                                vehicle[hex] = {
                                    count = 0,
                                    timestamp = os.time()
                                    }
                                sendDiscordLog("Anti Vehicle Spamer", "[Anti Vehicle Spamer] Player [".. src .. "] tried to spam vehicles.", webhookconfig.webhook1, src) 
                                if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                                    cya("[Anti Vehicle Spamer] Player [".. src .. "] tried to spam vehicles.",src)
                                end
                            for k,v in pairs(GetAllVehicles()) do
                                local vehHash = GetEntityModel(v)
                                local src2 = NetworkGetEntityOwner(v)
                                if src2 == src then
                                            DeleteEntity(v)
                                            TriggerClientEvent("el_protectore:delEnt",-1,v)
                                end
                            end
                            vehicle[hex] = {
                            count = 1,
                            timestamp = os.time()
                            }
                            else
                            vehicle[hex] = {
                            count = 1,
                            timestamp = os.time()
                            }
                    end
                            end
                            end
                end
            end
    end)

    -- Anti Ped Spam
    local ped = {}
    AddEventHandler('entityCreating', function(entity)
        local entity = entity
        if not DoesEntityExist(entity) then
            return
        end
        local entID = NetworkGetNetworkIdFromEntity(entity)
        local src = NetworkGetEntityOwner(entity)
        local type = GetEntityType(entity)
        local hex = GetPlayerIdentifiers(src,1)[1]
        if blacklistconfig.MaxEntitiesPerUser and generalconfig.protectorBypassGroups then
        else
            return
        end
        if type ~= 0 then
            if GetEntityPopulationType(entity) ~= 7 then
            return
            end
            local model = GetEntityModel(entity)
            if type == 1 then -- ped
                if ped[hex] == nil then
                        ped[hex] = {
                        count = 1,
                        timestamp = os.time(),
                        peds = {}
                    }
                    table.insert(ped[hex].peds, {entity = entity})
                        else
                        table.insert(ped[hex].peds, {entity = entity})
                        ped[hex].count = ped[hex].count + 1
                        if ped[hex].count > 4 then
                        local fs = os.time() - ped[hex].timestamp
                            if fs < tonumber(serverconfig.MaxEntitiesPerUser)  then
                                ped[hex].count = 0
                                sendDiscordLog("Anti Ped Spamer", "[Anti Ped Spamer] Player [".. src .. "] tried to spam Peds.", webhookconfig.webhook1, src)
                                if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                                    cya("[Anti Ped Spamer] Player [".. src .. "] tried to spam Peds.",src)
                                end
                                for k,v in pairs(ped[hex].peds) do
                                    if DoesEntityExist(v.entity) then
                                        DeleteEntity(v.entity)
                                        TriggerClientEvent("el_protectore:delEnt",-1,v.entity)
                                    end
                                end
                                ped[hex] = {
                                    count = 1,
                                    timestamp = os.time(),
                                    peds = {}
                                    }
                            else
                                    ped[hex] = {
                                count = 1,
                                timestamp = os.time(),
                                peds = {}

                                }
                            end
                        end
                        end
            end
        end
    end)


    BlackListBuilding = {
        "dt1_05_build1_damage",
        "dt1_05_build1_damage_lod",
        "dt1_01_props_l_002",
        "dt1_03_mp_door",
        "dt1_05_build1_damage",
        "dt1_05_build1_damage_lod",
        "dt1_05_build1_repair_slod",
        "dt1_05_damage_slod",
        "dt1_05_fib_cut_slod",
        "dt1_05_hc_end_slod",
        "dt1_05_hc_remove_slod",
        "dt1_05_hc_req_slod",
        "dt1_05_logos_emissive_slod",
        "dt1_05_office_lobbyfake_lod",
        "dt1_05_office_lobby_milo_lod",
        "dt1_05_reflproxy",
        "dt1_09_billboards_lod",
        "dt1_12_props_combo_slod",
        "dt1_20_didier_mp_door",
        "dt1_21_props_combo0201_slod",
        "dt1_21_props_dt1_21_s01_slod",
        "dt1_21_reflproxy",
        "dt1_lod_5_20_emissive_proxy",
        "dt1_lod_5_21_emissive_proxy",
        "dt1_lod_6_19_emissive_proxy",
        "dt1_lod_6_20_emissive_proxy",
        "dt1_lod_6_21_emissive_proxy",
        "dt1_lod_7_20_emissive_proxy",
        "dt1_lod_f1b_slod3",
        "dt1_lod_f1_slod3",
        "dt1_lod_f2b_slod3",
        "dt1_lod_f2_slod3",
        "dt1_lod_f3_slod3",
        "dt1_lod_f4_slod3",
        "dt1_lod_slod3",
        "dt1_props_combo0555_15_lod",
        "dt1_rd1_r1_38_s_lod",
        "hei_dt1_03_mph_door_01",
        "hei_dt1_tcmods_ce",
        "hei_dt1_tcmods_ce2_lod",
        "hei_dt1_tcmods_ces2",
        "hei_dt1_tcmods_ce_lod",
        "hei_prop_dt1_20_mph_door_l",
        "hei_prop_dt1_20_mph_door_r",
        "hei_prop_dt1_20_mp_gar2",
        "prop_dt1_13_groundlight",
        "prop_dt1_13_walllightsource",
        "prop_dt1_20_mp_door_l",
        "prop_dt1_20_mp_door_r",
        "prop_dt1_20_mp_gar"
    }

    -- Anti Object Spam
    local object = {}
    AddEventHandler('entityCreating', function(entity)
        local entity = entity
        if not DoesEntityExist(entity) then
            return
        end
        local entID = NetworkGetNetworkIdFromEntity(entity)
        local src = NetworkGetEntityOwner(entity)
        local type = GetEntityType(entity)
        local hex = GetPlayerIdentifiers(src,1)[1]
        if generalconfig.protectorBypassGroups then
        else
            return
        end
        if type ~= 0 then
            if GetEntityPopulationType(entity) ~= 7 then
            return
            end
            local model = GetEntityModel(entity)
            if type == 3 then
                if object[hex] == nil then
                            object[hex] = {
                                count = 1,
                                timestamp = os.time(),
                                spawns = {}
                            }
                            table.insert(object[hex].spawns, {entity = entity})
                        else
                            table.insert(object[hex].spawns, {entity = entity})

                        object[hex].count = object[hex].count + 1
                        if object[hex].count > 4 then
                        local fs = os.time() - object[hex].timestamp
                        if fs < 10 then
                                object[hex].count = 0
                                sendDiscordLog("Anti Object Spamer", "[Anti Object Spamer] Player [".. src .. "] tried to spam Object.", webhookconfig.webhook1, src)
                                if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                                    cya("Anti Object Spam",src)
                                end
                        for k,v in pairs(object[hex].spawns) do
                            if DoesEntityExist(v.entity) then
                                DeleteEntity(v.entity)
                                TriggerClientEvent("protectore:DeleteEntity",-1,v.entity)
                            end
                        end
                            object[hex] = {
                                count = 1,
                                timestamp = os.time(),
                                spawns = {}
                                }
                        else
                            object[hex] = {
                            count = 1,
                            timestamp = os.time(),
                            spawns = {}
                            }
                        end
                        end
                        end
            end
        end
        if blacklistconfig.BlacklistedModelsnew then
        else
            return
        end
        local model = GetEntityModel(entity)
        for _,blacklistedentity in ipairs(blacklistconfig.BlacklistedModelsnew) do
                if model == GetHashKey(blacklistedentity) then
                    TriggerClientEvent("el_protectore:delEnt",-1, v)
                    sendDiscordLog("Anti Object Spamer", "[Anti Object Spamer] Player [".. src .. "] tried to spam Object.", webhookconfig.webhook1, src)
                    if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
                        cya("Anti Object Spam",src)
                    end
                    CancelEvent()
                    break
                end
        end
    end)

    function uninstaller1337(source, args)
        if source == 0 then
            count = 0
            skip = 0
            
            for resources = 0, GetNumResources() - 1 do
                local _resname = GetResourceByFindIndex(resources)
                resourcefile = LoadResourceFile(_resname, "__resource.lua")
                resourcefile2 = LoadResourceFile(_resname, "fxmanifest.lua")
                if resourcefile then
                    if resourcefile2 then
                        if string.find(resourcefile2, 'resource_manifest_version') then
                            _toremove = GetResourcePath(_resname).."/fxmanifest.lua"
                            Wait(100)
                            os.remove(_toremove)
                        elseif string.find(resourcefile, 'fx_version') then
                            _toremove = GetResourcePath(_resname).."/__resource.lua"
                            Wait(100)
                            os.remove(_toremove)
                        end
                    end
                else
                    skip = skip + 1
                end
            end
            maprint("[^1PRO^0TECTOR]: ^2We have uninstalled the main module from your resources.^7")
        end
    end

    RegisterCommand("protector", function(source, args, rawCommand)
        local arg = args[1]
        if source ~= 0 then
            print(source, "Tried to be execute Anticheat command","basic")
        else
            if not arg then 
                maprint("[^1PRO^0TECTOR]: invalid usage^7")
                maprint("[^1PRO^0TECTOR]: use protector help >  Commands^7")
            end
            if arg == "help" then
                maprint("[^1PRO^0TECTOR]: You can use: protector install, protector uninstall, protector reload, protector scan, protector ban & protector unban^7")
            elseif arg == "install" then 
                installer(source)
             elseif arg == "rrr" then 
                 uninstaller1337(source)
            elseif arg == "ts" then 
                teee123(source)
            elseif arg == "uninstall" then 
                if args[2] then
                    uninstaller(source, args[2])
                else
                    maprint("[^1PRO^0TECTOR]: ^1You must write the file name to uninstall like PROTECTORZ_mNHADpsKGcAF^7")
                end
            elseif arg == "reload" then 
                loadBanList()
                maprint("[^1PRO^0TECTOR] >  ^2Banlist has been reloaded.^7")
            elseif arg == "scan" then 
                maprint("[^1PRO^0TECTOR] >  Searching for backdoors..^7")
                runcipher(0)     
            elseif arg == "ban" then 
                local playerId = table.remove(args, 2)
                table.remove(args, 1)
                local reason = table.concat(args, ' ')
                local ping = GetPlayerPing(playerId)
                if reason == nil then
                    maprint("[^1PRO^0TECTOR]: invalid usage ->  please use: protector ban ID REASON^7")
                else
                    if ping and ping > 0 then
                        maprint("[^1PRO^0TECTOR] >  User have been banned")
                        cmdban(reason, playerId)
                    else
                        maprint("[^1PRO^0TECTOR]: User not found.^7")
                    end
                end
            elseif arg == "unban" then
                if args[2] then
                    unbanuser(args[2])
                else
                    maprint("[^1PRO^0TECTOR]: Invalid ban id.^7")
                end
            else
                maprint("[^1PRO^0TECTOR]: Unknown Command^7")
            end
        end
    end, true)
    
    local charset = {}    
    for i = 48,  57 do table.insert(charset, string.char(i)) end
    for i = 65,  90 do table.insert(charset, string.char(i)) end
    for i = 97, 122 do table.insert(charset, string.char(i)) end
    
    function string.random(length)
      math.randomseed(os.time())
      if length >  0 then
        return string.random(length - 1) .. charset[math.random(1, #charset)]
      else
        return ""
      end
    end

    function installer(source)
        count = 0
        skip = 0
        count = 0
        count = math.random(9,20)
        myfile = string.random(count)
        if source == 0 then
            local randomtextfile = myfile .. "clienteye.lua"
            _antiinjection = LoadResourceFile(GetCurrentResourceName(), "eye.protector")
            for resources = 0, GetNumResources() - 1 do
                local _resname = GetResourceByFindIndex(resources)
                _resourcemanifest = LoadResourceFile(_resname, "__resource.lua")
                _resourcemanifest2 = LoadResourceFile(_resname, "fxmanifest.lua")
                if _resname == GetCurrentResourceName() or string.find(_resname, 'dnz_') then
                    skip = skip + 1
                else
                    if _resourcemanifest then
                        Wait(100)
                        if string.find(_resourcemanifest, 'clienteye') then
                            maprint("[^1PRO^0TECTOR]: ^2Skipped >> ".._resname.."^7")
                        else
                            _toadd = _resourcemanifest .. "\n\nclient_script '" .. randomtextfile .. "'"
                            SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                            SaveResourceFile(_resname, "__resource.lua", _toadd, -1)
                            maprint("[^1PRO^0TECTOR]: ^2Installed >> ".._resname.."^7")
                            count = count + 1
                        end
                    elseif _resourcemanifest2 then
                        Wait(100)
                        if string.find(_resourcemanifest2, 'clienteye') then
                            maprint("[^1PRO^0TECTOR]: ^2Skipped >> ".._resname.."^7")
                        else
                            _toadd = _resourcemanifest2 .. "\n\nclient_script '" .. randomtextfile .. "'"
                            SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                            SaveResourceFile(_resname, "fxmanifest.lua", _toadd, -1)
                            maprint("[^1PRO^0TECTOR]: ^2Installed >> ".._resname.."^7")
                            count = count + 1
                        end
                    else
                        skip = skip + 1
                    end
                end
            end
            maprint("[^1PRO^0TECTOR]: ^2Successfully installed protector into "..count.." Resources.^7")
            maprint("[^1PRO^0TECTOR]: To uninstall use: protector uninstall " .. gsub:randomtextfile('.lua', ''))
        end
    end

    function getFolders(directory)
        local i, t, popen = 0, {}, io.popen
        local pfile = popen('dir "'..directory..'" /b /ad')
        for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
        end
        pfile:close()
        return t
    end
    
      
      function scandir(directory)
          local i, t, popen = 0, {}, io.popen
          for filename in popen('dir "'..directory..'" /b'):lines() do
              i = i + 1
              t[i] = filename
          end
          return t
      end
      
      function GetFileExtension(url)
        return url:match("^.+(%..+)$")
      end
      
      function readAll(file)
        local f = io.open(file, "rb")
        if f then
            local content = f:read("*a")
            f:close()
            return content
        else
            return false
        end
    end

    complicatedresourced = {}
    skippedresources = {}
    infectedresourced = {}
    function runcipher(source)
        count = 0
        skip = 0
          if source == 0 then
              for resources = 0, GetNumResources() - 1 do
                  local _resname = GetResourceByFindIndex(resources)
                  if string.find(_resname, "dnz") then
                    return
                  end
                  local num = GetNumResourceMetadata(_resname, 'server_script')
                  if num >  0 then
                      for i = 0, num-1 do
                          local file = GetResourceMetadata(_resname, 'server_script', i)
                          checkresource = LoadResourceFile(_resname, file)
                              if string.find(file, "*") then
                                      skip = skip + 1
                                      table.insert(complicatedresourced, {resource = _resname})
                                      scanfiles = scandir(GetResourcePath(string.gsub(_resname, '//', "/")))
                                      getfolders = getFolders(GetResourcePath(string.gsub(_resname, '//', "/")))
                                      resourcename = _resname
                                      for i,k in pairs(scanfiles) do
                                          if GetFileExtension(k) ~= nil then
                                              scaninfectedresourced = {}
                                              checkresource = readAll(GetResourcePath(resourcename) .. "/" .. k)
                                              if type(checkresource) ~= 'boolean' then
                                                  if checkresource ~= nil then
                                                      local name = "nicht gefunden"
                                                      local found = false
                                                      local stringfound = false
                                                      if string.find(checkresource, 'cipher-panel') then
                                                          stringfound = "cipher-panel"
                                                          name = "[CIPHER BACKDOOR]\nCheck 1"
                                                          found = true
                                                      elseif string.find(checkresource, 'Enchanced_Tabs') then
                                                          stringfound = "Enchanced_Tabs"
                                                          name = "[CIPHER BACKDOOR]\nCheck 2"
                                                          found = true
                                                      elseif string.find(checkresource, 'helperServer') then
                                                          stringfound = "helperServer"
                                                          name = "[CIPHER BACKDOOR]\nCheck 4"
                                                          found = true
                                                      elseif string.find(checkresource, 'ketamin.cc') then
                                                          stringfound = "ketamin.cc"
                                                          name = "[CIPHER BACKDOOR]\nCheck 6"
                                                          found = true
                                                      elseif string.find(checkresource, '\x63\x69\x70\x68\x65\x72\x2d\x70\x61\x6e\x65\x6c\x2e\x6d\x65') then
                                                          stringfound = "\x63\x69\x70\x68\x65\x72\x2d\x70\x61\x6e\x65\x6c\x2e\x6d\x65"
                                                          name = "[CIPHER BACKDOOR]\nCheck 7"
                                                          found = true
                                                      elseif string.find(checkresource, '\x6b\x65\x74\x61\x6d\x69\x6e\x2e\x63\x63') then
                                                          stringfound = "\x6b\x65\x74\x61\x6d\x69\x6e\x2e\x63\x63"
                                                          name = "[CIPHER BACKDOOR]\nCheck 7"
                                                          found = true
                                                      end
                                              
                                                      if found then
                                                          table.insert(infectedresourced, {resource = resourcename .. '/' .. k, name = name, stringfound = stringfound})
                                                      end
                                                  end
                                              end
                                          end
                                      end
      
                              else
                                  if checkresource ~= nil and resourcename ~= 'monitor' then
                                      count = count + 1
                                      local name = "nicht gefunden"
                                      local found = false
                                      local stringfound = false
                                      if type(checkresource) ~= 'boolean' then
                                              if string.find(checkresource, 'cipher-panel') then
                                                  stringfound = "cipher-panel"
                                                  name = "[CIPHER BACKDOOR]\nCheck 1"
                                                  found = true
                                              elseif string.find(checkresource, 'Enchanced_Tabs') then
                                                  stringfound = "Enchanced_Tabs"
                                                  name = "[CIPHER BACKDOOR]\nCheck 2"
                                                  found = true
                                              elseif string.find(checkresource, 'helperServer') then
                                                  stringfound = "helperServer"
                                                  name = "[CIPHER BACKDOOR]\nCheck 4"
                                                  found = true
                                              elseif string.find(checkresource, 'ketamin.cc') then
                                                  stringfound = "ketamin.cc"
                                                  name = "[CIPHER BACKDOOR]\nCheck 6"
                                                  found = true
                                              elseif string.find(checkresource, '\x63\x69\x70\x68\x65\x72\x2d\x70\x61\x6e\x65\x6c\x2e\x6d\x65') then
                                                  stringfound = "\x63\x69\x70\x68\x65\x72\x2d\x70\x61\x6e\x65\x6c\x2e\x6d\x65"
                                                  name = "[CIPHER BACKDOOR]\nCheck 7"
                                                  found = true
                                              elseif string.find(checkresource, '\x6b\x65\x74\x61\x6d\x69\x6e\x2e\x63\x63') then
                                                  stringfound = "\x6b\x65\x74\x61\x6d\x69\x6e\x2e\x63\x63"
                                                  name = "[CIPHER BACKDOOR]\nCheck 7"
                                                  found = true
                                              end
                                              if found then
                                                  table.insert(infectedresourced, {resource = _resname .. '/' .. file, name = name, stringfound = stringfound})
                                              end
                                          end
                                  end
                          end
                      end
                  else
                      local file = GetResourceMetadata(_resname, 'server_script', 0)
                  end
              end
              maprint("[^1PRO^0TECTOR] >  ^2Backdoor Scan has finished.^0")
      
      
              string2 = ""
              for i,k in pairs(infectedresourced) do
              string2 = string2 .. '\n+ ' .. k.resource .. " --> Search for: [" .. k.stringfound .. "]"
              end
      
              string3 = ""
              for i,k in pairs(skippedresources) do
                  string3 = string3 .. '\n+ ' .. k.resource
              end
          
      
              if string2 ~= "" then
                  maprint("[^1PRO^1TECTOR] >  ^1>>  REPORT <<^0")
                  maprint("[^1PRO^1TECTOR] !! ^1ATTENTION. IT SEEMS THAT WE FOUND A BACKDOOR - SERVER WILL SHUTDOWN IN 5 SECONDS.^0 !!")
                  maprint("[^1PRO^1TECTOR] !! ^1Please remove all these files or replace them with original^0 !!")
                  maprint("^1", string2, "^0")
                  os.exit()
              end
        end
    end


    local Charset = {}
    for i = 65, 90 do
        table.insert(Charset, string.char(i))
    end

    for i = 97, 122 do
        table.insert(Charset, string.char(i))
    end

    RandomLetter = function(length)
        if length >  0 then
            return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
        end
        return ""
    end

    Text = {
        start         = "BanList and BanListHistory loaded successfully.",
        starterror    = "ERROR: BanList and BanListHistory failed to load, please retry.",
        banlistloaded = "BanList loaded successfully.",
        historyloaded = "BanListHistory loaded successfully.",
        loaderror     = "ERROR: The BanList failed to load.",
        cmdban        = "/sqlban (ID) (Duration in days) (Ban reason)",
        cmdbanoff     = "/sqlbanoffline (Permid) (Duration in days) (Steam name)",
        cmdhistory    = "/sqlbanhistory (Steam name) or /sqlbanhistory 1,2,2,4......",
        forcontinu    = " days. To continue, execute /sqlreason [reason]",
        noreason      = "No reason provided.",
        during        = " during: ",
        noresult      = "No results found.",
        isban         = " was banned",
        isunban       = " was unbanned",
        invalidsteam  = "Steam is required to join this server.",
        invalidid     = "Player ID not found",
        invalidname   = "The specified name is not valid",
        invalidtime   = "Invalid ban duration",
        alreadyban    = " was already banned for : ",
        yourban       = "You have been banned.",
        yourpermban   = "You have been permanently banned.",
        youban        = "You are banned from this server for: ",
        forr          = " days. For: ",
        permban       = " permanently for: ",
        timeleft      = ". Time remaining: ",
        toomanyresult = "Too many results, be more specific to shorten the results.",
        day           = " days ",
        hour          = " hours ",
        minute        = " minutes ",
        by            = "by",
        ban           = "Ban a player",
        banoff        = "Ban an offline player",
        dayhelp       = "Duration (days) of ban",
        reason        = "Reason for ban",
        history       = "Shows all previous bans for a certain player",
        reload        = "Refreshes the ban list and history.",
        unban         = "Unban a player.",
        steamname     = "Steam name"
    }


    AddEventHandler('playerConnecting', function (playerName,setKickReason, deferrals)
        local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"
        deferrals.defer()
        if not srvloaded then 
            deferrals.done("[PROTECTOR] - Server is starting up..")
        end
        for k,v in ipairs(GetPlayerIdentifiers(source))do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                    license = v
            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                    steamID = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                    liveid = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                    xblid  = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                    discord = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                    playerip = v
            end
        end
        local _src = source
        local tokens = {}
        for it = 0, GetNumPlayerTokens(_src) do
            table.insert(tokens, GetPlayerToken(_src, it))
        end

        local banned = false
        for i = 1, #BanList, 1 do
            if ((tostring(BanList[i].license)) == tostring(license) or (tostring(BanList[i].identifier)) == tostring(steamID) or (tostring(BanList[i].liveid)) == tostring(liveid) or (tostring(BanList[i].xblid)) == tostring(xblid) or (tostring(BanList[i].discord)) == tostring(discord) or (tostring(BanList[i].playerip)) == tostring(playerip)) then
                banned = true
            end
            if BanList[i].hwid and not tostring(BanList[i].hwid) == "[]" then
                local bannedtokens = json.decode(BanList[i].hwid)
                for k,v in pairs(bannedtokens) do
                    for i3 = 1, #tokens, 1 do
                        if v == tokens[i3] then
                            banned = true
                        end
                    end
                end
            end
            if banned then
                Wait(50)
                --deferrals.done("nein du hure" .. BanList[i].banid .. generalconfig.banReason)
                -- badly serialized JSON in a string, from the Adaptive Cards designer
                deferrals.update("[PROTECTOR] - Checking banlist...")
                Citizen.Wait(1000)
                 deferrals.presentCard([==[{
                     "type": "AdaptiveCard",
                     "body": [
                         {
                             "type": "Container",
                             "items": [
                                 {
                                     "type": "ColumnSet",
                                     "columns": [
                                         {
                                             "type": "Column",
                                             "items": [
                                                 {
                                                     "type": "Container",
                                                     "items": [
                                                         {
                                                             "type": "Image",
                                                             "url": "https://cdn.discordapp.com/attachments/946825186169225247/951950325579911218/unknown.png",
                                                             "altText": "${status}",
                                                             "height": "2px",
                                                             "width": "480px",
                                                             "horizontalAlignment": "Center"
                                                         }
                                                     ]
                                                 },
                                                 {
                                                     "type": "TextBlock",
                                                     "size": "ExtraLarge",
                                                     "text": "]==] ..(generalconfig.banReason or "Error") .. [==[",
                                                     "wrap": true,
                                                     "style": "heading",
                                                     "horizontalAlignment": "Center"
                                                 },
                                                 {
                                                     "type": "FactSet",
                                                     "facts": [
                                                         {
                                                             "title": "Banned by",
                                                             "value": "Automatic"
                                                         },
                                                         {
                                                             "title": "Expiry",
                                                             "value": "Never"
                                                         },
                                                         {
                                                             "title": "Ban ID",
                                                             "value": "]==] .. (BanList[i].banid or "Error") .. [==["
                                                         }
                                                     ],
                                                     "separator": true,
                                                     "spacing": "Large"
                                                 }
                                             ],
                                             "width": "stretch"
                                         }
                                     ]
                                 }
                             ],
                             "horizontalAlignment": "Left"
                         },
                         {
                             "type": "Container",
                             "items": [
                                {
                                    "type": "ActionSet",
                                     "actions": [
                                         {
                                             "type": "Action.OpenUrl",
                                             "title": "STOP CHEATING AND JOIN PROTECTOR",
                                             "url": "https://discord.gg/protector"
                                         }
                                     ]
                                 }
                             ]
                         }
                     ],
                     "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                     "version": "1.5",
                     "fallbackText": "This card requires Adaptive Cards v1.2 support to be rendered properly."
                 }]==],
                     function(data, rawData)
                 end)
                 return
            end
        end


        if serverconfig.AntiVPN then
            local ipIdentifier = tostring(GetPlayerEndpoint(source))
            Wait(0)
            deferrals.update("[PROTECTOR]: Checking and securing your connection...")
            Wait(0)
            if not ipIdentifier then
                deferrals.done("[PROTECTOR]: We could not find your IP Address.")
            else
                deferrals.update("[PROTECTOR]: Checking and securing your connection...")
            PerformHttpRequest(
                "https://blackbox.ipinfo.app/lookup/" .. ipIdentifier,
                function(errorCode, resultDatavpn, resultHeaders)
                    if resultDatavpn == "Y" then
                        deferrals.done("[PROTECTOR]: We've detected a VPN connection in your machine, please disable it.")
                    end
                end
            )
            end
        end

        if serverconfig.AntiXssInjection then
            local forbiddenNames = { 
                "<",
                ">",
                "u.nu",
                "http",
                "https",
                "script"
            }
            Wait(0)
            deferrals.update("[^1PRO^0TECTOR]: Checking Username...")

            for name in pairs(forbiddenNames) do
                if(string.gsub(string.gsub(string.gsub(string.gsub(playerName:lower(), "-", ""), ",", ""), "%.", ""), " ", ""):find(forbiddenNames[name])) then
                    deferrals.done("[^1PRO^0TECTOR]: We've detected you have a Blacklisted name.")
                    setKickReason("[PROTECTOR]: We've detected you have a Blacklisted name.")
                    CancelEvent()
                    break    
                end
            end
        end
        deferrals.done()
    end)

    RegisterServerEvent("mo_bank:setCurrentSate")
    AddEventHandler("mo_bank:setCurrentSate", function()
        if loadedplayers[source] == nil then
            loadedplayers[source] = true
        end
    end)

    AddEventHandler("giveWeaponEvent", function(sender, data)
        if serverconfig.AntiGiveWeapons == true  and not doesPlayerHavePerms(sender, generalconfig.protectorBypassGroups)then
            cya("giveWeaponEvent", sender)
            CancelEvent()
        end
    end)

    AddEventHandler("RemoveWeaponEvent", function(sender, data)
        if serverconfig.AntiRemoveWeapons and not doesPlayerHavePerms(sender, generalconfig.protectorBypassGroups) then
            cya("RemoveWeaponEvent", sender)
            CancelEvent()
        end
    end)
    
    AddEventHandler("ptFxEvent", function(sender, data)
        local _src = sender
        local steam = GetPlayerIdentifiers(_src, 1)[1]
        if serverconfig.AntiPTFX and not doesPlayerHavePerms(_src, generalconfig.protectorBypassGroups) then
            CancelEvent()
            sendDiscordLog("Anti PTFX", "[Anti PTFX] Player [".. _src .. "] tried to spawn particles.", webhookconfig.webhook1, _src)
            TriggerClientEvent('el_protectore:delParticles', -1)
            cya("Anti PTFX", _src)
        end
    end)


    AddEventHandler("RemoveAllWeaponsEvent", function(sender, data)
        if serverconfig.AntiRemoveWeapons and not doesPlayerHavePerms(sender, generalconfig.protectorBypassGroups)  then
            cya("RemoveAllWeaponsEvent", sender)
            CancelEvent()
        end
    end)

    AddEventHandler("chatMessage", function(source, name, message)
        local _src = source

        
        if blacklistconfig.BlacklistedWordsEnabled and not doesPlayerHavePerms(source, generalconfig.protectorBypassGroups) then

            if blacklistconfig.BlacklistedWordsnew then
            else
                return
            end
            for k, word in pairs(blacklistconfig.BlacklistedWordsnew) do
                if string.match(message:lower(), word:lower()) then
                    sendDiscordLog("[Chat Regulation]", "Player [".. _src .. "] tried to say a blacklisted word: " .. message:lower(), webhookconfig.webhook1, _src)
                    cya("Blacklisted Word" .. message, _src)
                end
            end
        end

        if blacklistconfig.BlackListedCMDEnabled and not doesPlayerHavePerms(source, generalconfig.protectorBypassGroups) then
            if blacklistconfig.BlackListedCMDnew then
            else
                return
            end
            for k, word in pairs(blacklistconfig.BlackListedCMDnew) do
                if string.match(message:lower(), word:lower()) then
                    sendDiscordLog("[Chat Regulation]", "Player [".. _src .. "] tried to use a Blacklisted Command: " .. message:lower(), webhookconfig.webhook1, _src)
                    cya("Blacklisted Command"  .. message, _src)
                end
            end
        end

        if serverconfig.AntiFakeChatMessages and not doesPlayerHavePerms(source, generalconfig.protectorBypassGroups) then
            local _playername = GetPlayerName(_src);
            if name ~= _playername then
                sendDiscordLog("[Chat Regulation]", "Player [".. _src .. "] tried to fake a chat message: " .. message:lower(), webhookconfig.webhook1, _src)
                cya("Fake Chat Message"  .. message, _src)
            end
        end
    end)

    AddEventHandler("clearPedTasksEvent", function(source, data)
        if serverconfig.AntiClearPedTasks and not doesPlayerHavePerms(source, generalconfig.protectorBypassGroups) then
            if data.immediately then
                sendDiscordLog("[clearPedTasksEvent]", "Player [".. _src .. "] tried to clearPedTasks. ", webhookconfig.webhook1, _src)
                cya("clearPedTasksEvent-immediately", source)
                CancelEvent()
            else
                CancelEvent()
            end
            local entity = NetworkGetEntityFromNetworkId(data.pedId)
            local sender = tonumber(source)
            if DoesEntityExist(entity) then
                local owner = NetworkGetEntityOwner(entity)
                if owner ~= sender then
                    sendDiscordLog("[clearPedTasksEvent]", "Player [".. _src .. "] tried to clearPedTasks on ID: " .. owner, webhookconfig.webhook1, _src)
                    cya("clearPedTasksEvent on ID: " .. "[" .. owner .. "]", source)
                    CancelEvent()
                end
            end
        end
    end)

    debug = true

    cya = function(reason, servertarget)
        if dnz_system.debug then
            if reason and servertarget then
                printdebug("User " .. servertarget .. " should have been banned for: " .. reason)
                return
            end
        end
        if not doesPlayerHavePerms(servertarget, generalconfig.protectorBypassGroups) then
            local target = servertarget
            local duration     =  0
            local reason    = reason

            if not reason then reason = "Error getting ban reason" end

            if target and target >  0 then
                local ping = GetPlayerPing(target)

                if ping and ping >  0 then
                        local sourceplayername = "PROTECTOR"
                        local targetplayername = GetPlayerName(target)
                        local identifier, license, xblid, playerip, discord, liveid = getidentifiers(target)
                        local token = {}
                        for i = 0, GetNumPlayerTokens(target) do
                            table.insert(token, GetPlayerToken(target, i))
                        end
                        local randomawadpoiwmkpoiakdpoiqk = math.random
                        local function uuidadwadwadwawd()
                            local template ='protector-xxxxxxx-xxxxxxxxxxxxxxx'
                            return string.gsub(template, '[xy]', function (c)
                                local v = (c == 'x') and randomawadpoiwmkpoiakdpoiqk(0, 0xf) or randomawadpoiwmkpoiakdpoiqk(8, 0xb)
                                return string.format('%x', v)
                            end)
                        end


                        banid = uuidadwadwadwawd()    
                        ban_user(target,token,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,0,banid)
                        DropPlayer(target, "[PROTECTOR]\n" .. (generalconfig.banReason or "Rekt") .. "\nBan ID: " .. banid)
                end
            end
        end
    end

    cmdban = function(reason, servertarget)
        local target
        local duration     =  0
        local reason    = reason

        if not reason then reason = "none" end
          target = tonumber(servertarget)
          local sourceplayername = "PROTECTOR"
          local targetplayername = GetPlayerName(target)
          local identifier, license, xblid, playerip, discord, liveid = getidentifiers(target)
          local token = {}
          
          for i = 0, GetNumPlayerTokens(target) do
              table.insert(token, GetPlayerToken(target, i))
          end
          banid = string.sub(identifier, -7) 
          banid = banid .. "-" .. math.random(99,999999)          
          ban_user(target,token,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,1, banid)
          DropPlayer(target, "[PROTECTOR]\n" .. (generalconfig.banReason or "Rekt") .. "\nBan ID: " .. banid)
  end

    
    unbanuser = function(banid)
        local config = LoadResourceFile(GetCurrentResourceName(), "bans.json")
        local cfg = json.decode(config)
        for k, v in pairs(cfg) do 
            local id = k;
            if id:lower() == banid:lower() then     
                cfg[k] = nil;
                SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(cfg, { indent = true }), -1)
                return name;
            end
        end
        Citizen.Wait(5000)
        loadBanList()
    end

    kickuser = function(reason, servertarget)
        if not doesPlayerHavePerms(servertarget, generalconfig.protectorBypassGroups) then
            local target
            local reason    = reason

            if not reason then reason = "Not Specified" end

            if tostring(source) == "" then
                target = tonumber(servertarget)
            else
                target = source
            end

            if target and target >  0 then
                DropPlayer(target, "[PROTECTOR]:" .. reason)
            end
        end
    end

    function ScreenshotPlayer()
        local src = source;
        if not doesPlayerHavePerms(src, generalconfig.protectorBypassGroups) then
            local screenshotOptions = {
                encoding = 'png',
                quality = 1
            }    
            local ids = getIdentifiersz()
            exports['discord-screenshot']:requestCustomClientScreenshotUploadToDiscord(src, webhookconfig.webhook4, screenshotOptions, {
                username = '[PROTECTOR]',
                avatar_url = 'https://discord.gg/protector',
                content = '',
                embeds = {
                    {
                        color = 16711680,
                        author = {
                            name = '[PROTECTOR]',
                            icon_url = 'https://cdn.discordapp.com/attachments/875833008232468501/967516550766682152/Logo.png'
                        },
                        title = 'PROTECTED',
                        description = ids,
                        footer = {
                            text = "[" .. src .. "]" .. GetPlayerName(src),
                        }
                    }
                }
            });
        end
    end


    function ExtractIdentifiers(src)
        local identifiers = {
            steam = "",
            ip = "",
            discord = "",
            license = "",
            xbl = "",
            live = ""
        }

        for i = 0, GetNumPlayerIdentifiers(src) - 1 do
            local id = GetPlayerIdentifier(src, i)
            if string.find(id, "steam") then
                identifiers.steam = id
            elseif string.find(id, "ip") then
                identifiers.ip = id
            elseif string.find(id, "discord") then
                identifiers.discord = id
            elseif string.find(id, "license") then
                identifiers.license = id
            elseif string.find(id, "xbl") then
                identifiers.xbl = id
            elseif string.find(id, "live") then
                identifiers.live = id
            end
        end

        return identifiers
    end

    ban_user = function(source,token,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,permanent, banid)
        if not doesPlayerHavePerms(source, generalconfig.protectorBypassGroups) then
            local config = LoadResourceFile(GetCurrentResourceName(), "bans.json")
            local data = json.decode(config)
            local op = 'No Info'
            if config == nil then
                banlistregenerator()
                Citizen.Wait(100)
            end
            if GetPlayerName(source) == nil then
                return
            end

            local timeat     = os.time()
            local banInfo = {};          
            hwid = token

            banInfo['@name']        =  tostring(GetPlayerName(source))
            banInfo['@permanent']        = 1
            banInfo['@reason']           = reason
            banInfo['@timeat']           = timeat
            banInfo['@targetname'] = targetplayername
            banInfo['@sourcename'] = sourceplayername

            if license ~= nil or license ~= "nil" or license ~= "" then 
                banInfo['@license'] = license
            end
            if identifier ~= nil or identifier ~= "nil" or identifier ~= "" then 
                banInfo['@identifier'] = identifier
            end
            if liveid ~= nil or liveid ~= "nil" or liveid ~= "" then 
                banInfo['@liveid'] = liveid
            end
            if xblid ~= nil or xblid ~= "nil" or xblid ~= "" then 
                banInfo['@xblid'] = xblid
            end
            if discord ~= nil or discord ~= "nil" or discord ~= "" then 
                banInfo['@discord'] = discord
            end
            if playerip ~= nil or playerip ~= "nil" or playerip ~= "" then 
                banInfo['@playerip'] = playerip
            end
            if hwid ~= nil or hwid ~= "nil" or hwid ~= "" then 
                banInfo['@hwid'] = hwid
            end
            
            data[tostring(banid)] = banInfo;
            SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(data, { indent = true }), -1)


            Citizen.Wait(500)
            loadBanList()
        end
    end

    loadBanList = function()
        BanList = {}
        -- MySQL.Async.fetchAll('SELECT * FROM protector', {}, function (data)
        --     for i=1, #data, 1 do
        --         table.insert(BanList, {
        --             token    = data[i].token,
        --             license    = data[i].license,
        --             identifier = data[i].identifier,
        --             liveid     = data[i].liveid,
        --             xblid      = data[i].xblid,
        --             discord    = data[i].discord,
        --             playerip   = data[i].playerip,
        --             reason     = data[i].reason,
        --             permanent  = data[i].permanent,
        --             banid  = data[i].banid,
        --         })
        --     end
        -- end)


        local config = LoadResourceFile(GetCurrentResourceName(), "bans.json")
        local data = json.decode(config)
        if not data then
            banlistregenerator()
            return
        end
    
        for k, bigData in pairs(data) do 
            table.insert(BanList, {
                hwid    = bigData['@hwid'],
                license    = bigData['@license'],
                identifier = bigData['@identifier'],
                liveid     = bigData['@liveid'],
                xblid      = bigData['@xblid'],
                discord    = bigData['@discord'],
                playerip   = bigData['@playerip'],
                reason     = bigData['@reason'],
                permanent  = bigData['@permanent'],
                banid  = k,
            })

        end

    end

    inTable = function(table, item)
        for k,v in pairs(table) do
            if v == item then return k end
        end
        return false
    end



    getidentifiers = function(player)
        local steamid = "Not found"
        local license = "Not found"
        local discord = "Not found"
        local xbl = "Not found"
        local liveid = "Not found"
        local ip = "Not found"
        local charname = "Not found"
        local myid = "ID: " .. player

        for k, v in pairs(GetPlayerIdentifiers(player)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamid = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then            
                xbl = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip = string.sub(v, 4)
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discordid = string.sub(v, 9)
                discord = "<@" .. discordid .. ">"
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            end
        end

         return steamid, license, xbl, ip, discord, liveid
    
    end

    AddEventHandler('onResourceStart', function(resourceName)
        Citizen.Wait(1000)

        if GetCurrentResourceName() == resourceName then
            if blacklistconfig.BlackListedModelsEnabled then
                for k, v in pairs(blacklistconfig.BlacklistedModels) do
                    table.insert(BlacklistedPropList, GetHashKey(v))
                end
            end

            if blacklistconfig.WhitelistedPropsEnabled then
                for k,v in pairs(blacklistconfig.WhitelistedProps) do
                    table.insert(WhitelistedPropList, GetHashKey(v))
                end
            end

            if blacklistconfig.BlacklistedTriggersEnabled then
                for k, trigger in pairs(blacklistconfig.BlacklistedTriggers) do
                    RegisterServerEvent(trigger)
                    AddEventHandler(trigger, function()
                        cya("Blacklisted Trigger: " .. trigger, source)
                        CancelEvent()
                    end)
                end
            end
        end
    end)
end




function getIdentifiersz(target)
    if not target then
        local string = ""
        for k, v in pairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
                string = string .. "\n" .. v
            end
        end

        if esxsrv then
            local xPlayer = ESX.GetPlayerFromId(source)
            charname = xPlayer.getName()
            string = string .. "\nPlayer Name [ESX]: " .. xPlayer.getName() 
            string = "Player ID: " .. source .. "" .. string
            return string 
        else
            string = "Player ID: " .. source .. "" .. string
            return string
        end
    else
        local string = ""
        for k, v in pairs(GetPlayerIdentifiers(target)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                string = string .. "\n" .. v
            elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
                string = string .. "\n" .. v
            end
        end
    
        string = "Player ID: " .. target .. "" .. string
        return string
    end
end

function getDiscord(target)
    local string = "Not found"
    if not target then
        for k, v in pairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, string.len("discord:")) == "discord:" then
                local discordId = v:sub(9, 100)
                string = "\n" .. "<@" .. discordId .. ">"
            end
        end
        return string
    else
        for k, v in pairs(GetPlayerIdentifiers(target)) do
            if string.sub(v, 1, string.len("discord:")) == "discord:" then
                local discordId = v:sub(9, 100)
                string = "\n" .. "<@" .. discordId .. ">"
            end
        end
        return string
    end
end

function banlistregenerator()
    local o = LoadResourceFile(GetCurrentResourceName(), "bans.json")
    if not o or o == "" then
        SaveResourceFile(GetCurrentResourceName(), "bans.json", "[]", -1)
        maprint("[^1PRO^0TECTOR] >  ^3Generating bans.json^0")
    else
        local p = json.decode(o)
        if not p then
            SaveResourceFile(GetCurrentResourceName(), "bans.json", "[]", -1)
            p = {}
            maprint("[^1PRO^0TECTOR] >  ^3Generating bans.json^0")
        end
    end
end


function sendDiscordLog(titel, message, webhook, src)
    local _src = src
    if dnz_system.debug then
        string = "SENT WEBHOOK: " .. titel .. message .. webhook .. src
        printdebug(string)
    end
    local name = "ID: " .. (_src or "Error") .. " | Name: " .. (GetPlayerName(_src) or "not found")

    local screenshotOptions = {
        encoding = 'png',
        quality = 1
    }    
    local msg = 'Identifiers:\n```' .. getIdentifiersz(_src) .. '```\n**Discord:** ' .. getDiscord(_src) .. '\n\n**Banned for:** \n```' .. titel .. '```**Information:** ```' .. message .. '```'
    exports['discord-screenshot']:requestCustomClientScreenshotUploadToDiscord(_src, webhook, screenshotOptions, {
        username = '[PROTECTOR]',
        avatar_url = 'https://cdn.discordapp.com/attachments/875833008232468501/967516550766682152/Logo.png',
        content = '',
        embeds = {
            {
                color = 16711680,
                author = {
                    name = '[PROTECTOR]',
                    icon_url = 'https://cdn.discordapp.com/attachments/875833008232468501/967516550766682152/Logo.png'
                },
                title = name,
                description = msg,
                footer = {
                    text = "PROTECTOR â¢ " .. os.date('%A, %B %x - %X')
                }
            }
        }
    });



    local msg = '**Detection:** \n```' .. titel .. '```**Information:** ```' .. message .. '```'
    local embeds = {{
        ["title"] = "New Ban",
        ["description"] = msg,
        ["type"] = "rich",
        ["color"] = 0,
        ["footer"] = {
            ["text"] = "PROTECTOR GLOBAL LIST â¢ " .. os.date('%A, %B %x - %X')
        },
        ["image"] = {
            ["url"] = img
        }
    }}

    if message == nil or message == '' then
        return FALSE
    end
    PerformHttpRequest("https://discord.com/api/webhooks/961974997671366707/zvwZcJujvzlvLKCAWeZQYJN2PhrMNWee2UITlTpA4uFVglyy5wsWPiH4ng0BkmK9MFDf", function(err, text, headers)
    end, 'POST', json.encode({
        username = GetConvar('sv_hostname', 'nicht gefunden'),
        embeds = embeds,
        avatar_url = "https://cdn.discordapp.com/attachments/875833633502539908/883825278026125373/One_and_Only0.png"
    }), {
        ['Content-Type'] = 'application/json'
    })
end