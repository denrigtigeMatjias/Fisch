local scriptSupportedVersion = "1.11"
local gameVersion = game:GetService("ReplicatedStorage").world.version.Value

if scriptSupportedVersion ~= gameVersion then
    print("Script is outdated! Your current script supports game version ".. scriptSupportedVersion.. ", but the latest game version is ".. gameVersion.. ".")
    while wait(10000) do end
end

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/denrigtigeMatjias/FluentBackup/refs/heads/main/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/denrigtigeMatjias/FluentBackup/refs/heads/main/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/denrigtigeMatjias/FluentBackup/refs/heads/main/InterfaceManager.lua"))()

-- Initialize the Window
local scriptVersion = "v1.0"

local Window = Fluent:CreateWindow({
    Title = "Fisch " .. scriptVersion,
    SubTitle = "by .matjias",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
})

-- Define Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "align-justify" }),
    LocalPlayer = Window:AddTab({ Title = "LocalPlayer", Icon = "user" }),
    Autofarm = Window:AddTab({ Title = "Autofarm", Icon = "refresh-cw" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "folder-open" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local Options = Fluent.Options

do
    --[[Fluent:Notify({
        Title = "Notification",
        Content = "This is a notification",
        SubContent = "SubContent", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })]]


    --[[
          ___  _   _ _____ ___________ ___  _________  ___
         / _ \| | | |_   _|  _  |  ___/ _ \ | ___ \  \/  |
        / /_\ \ | | | | | | | | | |_ / /_\ \| |_/ / .  . |
        |  _  | | | | | | | | | |  _||  _  ||    /| |\/| |
        | | | | |_| | | | \ \_/ / |  | | | || |\ \| |  | |
        \_| |_/\___/  \_/  \___/\_|  \_| |_/\_| \_\_|  |_/
    ]]
    
    local AutofarmSettingsSection = Tabs.Autofarm:AddSection("Autofarm Settings")

    local CastToggle = AutofarmSettingsSection:AddToggle("Cast", {Title = "Auto Cast", Default = false })
    CastToggle:OnChanged(function()
        getgenv().config.cast_toggle = Options.Cast.Value
    end)

    spawn(function()
        while wait(0.1) do
            if getgenv().config.cast_toggle then
                getgenv().auto_cast()
            end
        end
    end)

    local ShakeToggle = AutofarmSettingsSection:AddToggle("Shake", {Title = "Auto Shake", Default = false })
    ShakeToggle:OnChanged(function()
        getgenv().config.shake_toggle = Options.Shake.Value
    end)

    spawn(function()
        while wait(0.1) do
            if getgenv().config.shake_toggle then
                local shakeButton = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
                    :FindFirstChild("shakeui")
                    :FindFirstChild("safezone")
                    :FindFirstChild("button")
                
                if shakeButton then
                    getgenv().auto_shake(shakeButton)
                end
            end
        end
    end)

    local ReelToggle = AutofarmSettingsSection:AddToggle("Reel", {Title = "Auto Reel", Default = false })
    ReelToggle:OnChanged(function()
        getgenv().config.reel_toggle = Options.Reel.Value
    end)

    spawn(function()
        while wait(0.1) do
            if getgenv().config.reel_toggle then
                getgenv().auto_reel()
            end
        end
    end)

    local FreezeToggle = AutofarmSettingsSection:AddToggle("Freeze", {Title = "Freeze", Default = false })
    FreezeToggle:OnChanged(function()
        if getgenv().config.freeze_toggle then
            getgenv().config.humanoidRootPart.Anchored = true
        else
            getgenv().config.humanoidRootPart.Anchored = false
        end
    end)
end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("matjiasScripts")
SaveManager:SetFolder("matjiasScripts/Fisch")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
