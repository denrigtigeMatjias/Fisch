-- Check if Fisch
if not game.PlaceId == 16732694052 then
    while wait(10000) do end
end

local script_details = {
    debug = false,
    version = "1.0.0",
}

local url = script_details.debug and "http://localhost:6845" or "https://raw.githubusercontent.com/P-DennyGamingYT/ALCATRAZ-PF/main"

local out = script_details.debug and function(T, ...)
    return warn("[FISCH - DEBUG]: "..T:format(...))
end or function() end

local function import(file)
    out("Importing File \"%s\"", file)
    local x, a = pcall(function()
        return loadstring(game:HttpGet(url .. file))()
    end)
    if not x then
        return warn('failed to import', file)
    end
end

getgenv().import = import
getgenv().details = scriptdetails

import('/main_loader.lua')
