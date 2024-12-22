-- https://denrigtigematjias.github.io/
if game.PlaceId = 16732694052 then
      return
else
      while true do end
end

local url = "https://render-mzyi.onrender.com/increment/Fisch"

local response = request({
    Url = url,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json",
    },
    Body = game:GetService("HttpService"):JSONEncode({
        game = "Fisch"
    })
})

if response.Success then
    print("Increment successful! Response:", response.Body)
else
    print("Failed to increment count. Error:", response.StatusCode)
end

-- Script
local workspace = game:GetService("Workspace")
local lp = game:GetService("Players").LocalPlayer
local character = lp.Character

local versionCheck = true

local version = "1.09.1"
local gameVersion = game:GetService("ReplicatedStorage").world.version.Value
print(gameVersion)

getgenv().startScript = true;

-- Generate walk on water part
if not workspace:FindFirstChild("matjias Fisch Folder") then
      local folder = Instance.new("Folder", game:GetService("Workspace"))
      folder.Name = "matjias Fisch Folder"

      local part = Instance.new("Part", folder)
      part.Name = "Jesus"
      part.Size = Vector3.new(500, 0.5, 500)
      part.Anchored = true
      part.Transparency = 1
      part.Position = Vector3.new(character.HumanoidRootPart.CFrame.X, 126.5, character.HumanoidRootPart.CFrame.Z)
end

function noclip()
      getgenv().Clip = false
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
  
      local function Nocl()
          if not getgenv().Clip and character then
              for _, v in pairs(character:GetDescendants()) do
                  if v:IsA("BasePart") and v.CanCollide and v.Name ~= "HumanoidRootPart" then
                      v.CanCollide = false
                  end
              end
          end
      end
  
      -- Connect the Nocl function to RunService
      if not getgenv().Noclip then
          getgenv().Noclip = game:GetService("RunService").Stepped:Connect(Nocl)
      end
end

function clip()
      if getgenv().Noclip then
            getgenv().Noclip:Disconnect() -- Disconnect the event
            getgenv().Noclip = nil       -- Clear the connection
      end
      getgenv().Clip = true
end

function VersionCheck()
      if version == gameVersion then
            return true;
      end

      return false;
end

function loadScript()
      local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/denrigtigeMatjias/FluentBackup/refs/heads/main/main.lua"))()
      local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/denrigtigeMatjias/FluentBackup/refs/heads/main/SaveManager.lua"))()
      local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/denrigtigeMatjias/FluentBackup/refs/heads/main/InterfaceManager.lua"))()

      local Window = Fluent:CreateWindow({
      Title = "Fisch v" .. version,
      SubTitle = "by .matjias",
      TabWidth = 160,
      Size = UDim2.fromOffset(620, 480),
      Acrylic = false,
      Theme = "Darker",
      MinimizeKey = Enum.KeyCode.LeftControl
      })
      
      --Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
      local Tabs = {
            Main = Window:AddTab({ Title = "Main", Icon = "align-justify" }),
            Auto = Window:AddTab({ Title = "Auto", Icon = "refresh-ccw" }),
            Teleport = Window:AddTab({ Title = "Teleport", Icon = "plane" }),
            Misc = Window:AddTab({ Title = "Misc", Icon = "folder-open" }),
            Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
      }

      local Options = Fluent.Options

      do
      
      -- MAIN TAB
      Tabs.Main:AddParagraph({
            Title = "Localplayer",
      })

      local WalkspeedInput = Tabs.Main:AddInput("Input", {
            Title = "Walkspeed",
            Default = "",
            Placeholder = "Walkspeed",
            Numeric = false, -- Only allows numbers
            Finished = false, -- Only calls callback when you press enter
            Callback = function(Value)
                character:WaitForChild("Humanoid").WalkSpeed = Value
            end
      })
    
      WalkspeedInput:OnChanged(function()
            print("Input updated:", WalkspeedInput.Value)
      end)

      -- Noclip Toggle
      local NoclipToggle = Tabs.Main:AddToggle("Noclip", {Title = "Noclip", Default = false })

      NoclipToggle:OnChanged(function(state)
            if state then
                noclip() -- Enable noclip
                print("Noclip enabled.")
            else
                clip() -- Disable noclip
                print("Noclip disabled.")
            end
      end)
        
      Options.Noclip:SetValue(false)
      
      -- Jesus Toggle
      local JesusToggle = Tabs.Main:AddToggle("Jesus", {Title = "Walk on water", Default = false })

      JesusToggle:OnChanged(function()
            getgenv().walkonwatertoggle = Options.Jesus.Value
      end)

      Options.Jesus:SetValue(false)

      spawn(function()
            while wait(0.01) do
                  if getgenv().walkonwatertoggle then
                        local player = game.Players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()
                        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                        local folder = game:GetService("Workspace"):FindFirstChild("matjias Fisch Folder")
                        
                        if folder then
                              folder:FindFirstChild("Jesus").Position = Vector3.new(humanoidRootPart.Position.X, 126.5, humanoidRootPart.Position.Z)
                        end
                  end

                  game:GetService("Workspace"):FindFirstChild("matjias Fisch Folder"):FindFirstChild("Jesus").CanCollide = getgenv().walkonwatertoggle
            end
      end)

      -- AUTO TAB
      Tabs.Auto:AddParagraph({
            Title = "Autofarm",
            Content = "Auto detects rod and equips it"
      })

      local CastToggle = Tabs.Auto:AddToggle("Cast", {Title = "Auto Cast", Default = false })

      CastToggle:OnChanged(function()
            getgenv().casttoggle = Options.Cast.Value
      end)

      Options.Cast:SetValue(false)
        
      local function findItemInLocalBackpack(searchTerm)
            local player = game.Players.LocalPlayer
            local backpack = player:FindFirstChild("Backpack")
            if not backpack then
                warn("Backpack not found for LocalPlayer!")
                return nil
            end
        
            for _, item in ipairs(backpack:GetChildren()) do
                if string.find(item.Name:lower(), searchTerm:lower()) then
                    return item -- Return the first matching item
                end
            end
        
            return nil -- No matching item found
      end
        
      spawn(function()
            while wait(0.1) do
                  if getgenv().casttoggle then
                        local player = game.Players.LocalPlayer
                        local rodSearchTerm = "Rod"
                        
                        -- Check character for equipped rod
                        local character = game:GetService("Workspace"):FindFirstChild(player.Name)
                        local equippedRod
                        if character then
                              print("Checking equipped items in character...")
                              for _, item in ipairs(character:GetChildren()) do
                                    if item.Name == "RodBodyModel" then
                                          print("Skipping RodBodyModel")
                                    elseif string.find(item.Name:lower(), rodSearchTerm:lower()) then
                                          equippedRod = item
                                          break
                                    end
                              end
                        end
                        
                        if equippedRod then
                              print("Rod already equipped:", equippedRod.Name)
            
                              -- Use the equipped rod
                              if equippedRod:FindFirstChild("events") and equippedRod.events:FindFirstChild("cast") then
                              equippedRod.events.cast:FireServer(100, 1) -- Adjust parameters as needed
                              print("Casted equipped rod.")
                              else
                              warn("Equipped rod does not have the required events.")
                              end
                        else
                              print("No equipped rod found, checking backpack...")
                              -- No rod equipped, search in Backpack
                              local backpackRod = findItemInLocalBackpack(rodSearchTerm)
                              if backpackRod then
                              print("Found rod in Backpack:", backpackRod.Name)
            
                                    -- Equip the rod from Backpack
                                    local equipEvent = player.PlayerGui:FindFirstChild("hud")
                                    and player.PlayerGui.hud.safezone.backpack.events:FindFirstChild("equip")
                                    if equipEvent then
                                          equipEvent:FireServer(backpackRod)
            
                                          -- Wait for the rod to equip
                                          task.wait(0.5)
                  
                                          -- Recheck for the equipped rod
                                          character = game:GetService("Workspace"):FindFirstChild(player.Name)
                                          if character then
                                                for _, item in ipairs(character:GetChildren()) do
                                                if item.Name == "RodBodyModel" then
                                                      print("Skipping RodBodyModel")
                                                elseif string.find(item.Name:lower(), rodSearchTerm:lower()) then
                                                      equippedRod = item
                                                      break
                                                end
                                                end
                                          end
                                          
                                          if equippedRod and equippedRod:FindFirstChild("events") and equippedRod.events:FindFirstChild("cast") then
                                                equippedRod.events.cast:FireServer(100, 1) -- Adjust parameters as needed
                                                print("Casted newly equipped rod.")
                                          else
                                                warn("Failed to equip or use the rod.")
                                          end
                                    else
                                          warn("Equip event not found in PlayerGui.")
                                    end
                              else
                              warn("No rod found in Backpack or equipped.")
                              end
                        end
                  else
                        task.wait(0.1) -- Avoid unnecessary CPU usage when toggle is off
                  end
            end
      end)

      -- Reel Toggle
      local ReelToggle = Tabs.Auto:AddToggle("Reel", {Title = "Auto Reel", Default = false })

      ReelToggle:OnChanged(function()
            getgenv().reeltoggle = Options.Reel.Value
      end)

      Options.Reel:SetValue(false)

      spawn(function()
            while wait(0.1) do
                  if getgenv().reeltoggle then
                        game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, false)
                  end
            end
      end)

      -- Freeze Toggle
      -- Find alternative method to freeze player state
      local FreezeToggle = Tabs.Auto:AddToggle("Freeze", {Title = "Freeze", Default = false })

      FreezeToggle:OnChanged(function()
            getgenv().freezetoggle = Options.Freeze.Value
      end)

      Options.Freeze:SetValue(false)

      spawn(function()
            while wait(0.1) do
                  if getgenv().freezetoggle then
                        local LocalPlayer = game:GetService("Players").LocalPlayer

                        LocalPlayer.Character.HumanoidRootPart.Anchored = true
                  else
                        local LocalPlayer = game:GetService("Players").LocalPlayer

                        LocalPlayer.Character.HumanoidRootPart.Anchored = false
                  end
            end
      end)

      --[[
      Tabs.Auto:AddParagraph({
            Title = "Modifiers",
            Content = "Modify certain things"
      })

      local ShakeSlider = Tabs.Main:AddSlider("ShakeSlider", {
            Title = "Shake Scale",
            Description = "Modifies the scale of the shake button",
            Default = 1,
            Min = 0,
            Max = 5,
            Rounding = 1,
            Callback = function(Value)
                print("Slider was changed:", Value)
            end
      })
    
      ShakeSlider:OnChanged(function(Value)
            print("Slider changed:", Value)
      end)
    
      ShakeSlider:SetValue(1)]]

      -- Teleport TAB
      Tabs.Teleport:AddParagraph({
            Title = "Teleports",
      })

      local teleportAreaLocations = {
            ["Moosewood"] = Vector3.new(380, 136, 240),
            ["Mushgrove Swamp"] = Vector3.new(2410, 141, -750),
            ["Sunstone Island"] = Vector3.new(-959, 223, -987),
            ["Roslit Bay"] = Vector3.new(-1490, 137, 700),
            ["Roslit Volcano"] = Vector3.new(-1968, 163, 250),
            ["Forsaken Shores"] = Vector3.new(-2822, 213, 1526),
            ["Terrapin Island"] = Vector3.new(-160, 146, 1942),
            ["Snowcap Island"] = Vector3.new(2685, 153, 2393),
            ["Vertigo"] = Vector3.new(-140, -516, 1145),
            ["The Depths"] = Vector3.new(940, -739, 1450),
            ["Desolate Deep"] = Vector3.new(-1650, -214, -2857),
            ["Brine Pool"] = Vector3.new(-1797, -143, -3405),
            ["Statue Of Sovereignty"] = Vector3.new(25, 161, -1036),
            ["Dr. Finneus"] = Vector3.new(1175, 133, 2456),
            ["Keepers Altar"] = Vector3.new(1305, -806, -102),
            ["Archeological Site"] = Vector3.new(4034, 132, 77),
      }
      
      
      local Dropdown = Tabs.Teleport:AddDropdown("Area Teleport", {
            Title = "Teleport to Area",
            Values = {"Moosewood", "Mushgrove Swamp", "Sunstone Island", "Roslit Bay", "Roslit Volcano","Forsaken Shores", "Terrapin Island", "Snowcap Island", "Vertigo", "Desolate Deep", "Brine Pool", "The Depths", "Statue Of Sovereignty", "Dr. Finneus", "Keepers Altar"},
            Multi = false,
            Default = 1,
      })
      
      Dropdown:OnChanged(function(Value)
            print("Dropdown changed to:", Value)
            if not getgenv().startScript then
                  local targetPosition = teleportAreaLocations[Value]
                  if targetPosition then
                        local player = game.Players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()
                        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                  
                        -- Teleport the player to the target position
                        humanoidRootPart.CFrame = CFrame.new(targetPosition)
                        print("Teleported to:", targetPosition)
                  else
                        warn("No teleport location found for:", Value)
                  end
            end
      end)

      -- MISC TAB
      Tabs.Misc:AddParagraph({
            Title = "QOL",
            Content = "Miscellaneous QOL features"
      })

      local AfkToggle = Tabs.Misc:AddToggle("AntiAfk", {Title = "No [AFK]", Default = false })

      AfkToggle:OnChanged(function()
            getgenv().afktoggle = Options.AntiAfk.Value
      end)

      Options.AntiAfk:SetValue(false)

      spawn(function()
            while wait(0.01) do
                  if getgenv().afktoggle then
                        game:GetService("ReplicatedStorage").events.afk:FireServer(false)
                  end
            end
      end)

      Tabs.Misc:AddParagraph({
            Title = "Various stat spoofing options (Client-sided)",
      })

      local StreakSlider = Tabs.Misc:AddSlider("StreakSlider", {
            Title = "Streak Spoofer",
            Description = "Client-side",
            Default = tonumber(game:GetService("Workspace").hejakjkaj.HumanoidRootPart.user.streak.Text),
            Min = 1,
            Max = 10000,
            Rounding = 0,
      })
    
      StreakSlider:OnChanged(function(Value)
            game:GetService("Workspace").hejakjkaj.HumanoidRootPart.user.streak.Text = Value
      end)
    
      StreakSlider:SetValue(game.Players.LocalPlayer.leaderstats:FindFirstChild("Level").Value)

      local LevelSlider = Tabs.Misc:AddSlider("LevelSlider", {
            Title = "Level Spoofer",
            Description = "Client-side",
            Default = game.Players.LocalPlayer.leaderstats:FindFirstChild("Level").Value,
            Min = 1,
            Max = 10000,
            Rounding = 0,
      })
    
      LevelSlider:OnChanged(function(Value)
            game:GetService("Workspace").hejakjkaj.HumanoidRootPart.user.level.Text = "Level: " .. Value
      end)
    
      LevelSlider:SetValue(game.Players.LocalPlayer.leaderstats:FindFirstChild("Level").Value)

      local UserInput = Tabs.Misc:AddInput("UserInput", {
            Title = "Change username (Client-side)",
            Default = game:GetService("Players").LocalPlayer.DisplayName,
            Placeholder = "Username",
            Numeric = false,
            Finished = false,
      })
    
      UserInput:OnChanged(function()
            game:GetService("Workspace").hejakjkaj.HumanoidRootPart.user.user.Text = UserInput.Value
      end)

      local TitleInput = Tabs.Misc:AddInput("UserInput", {
            Title = "Change title (Client-side)",
            Default = game:GetService("Workspace").hejakjkaj.HumanoidRootPart.user:FindFirstChild("title").Text,
            Placeholder = "Title",
            Numeric = false,
            Finished = false,
      })
    
      TitleInput:OnChanged(function()
            game:GetService("Workspace").hejakjkaj.HumanoidRootPart.user.title.Text = TitleInput.Value
      end)

      getgenv().startScript = false;
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
      InterfaceManager:SetFolder("FluentScriptHub")
      SaveManager:SetFolder("FluentScriptHub/specific-game")

      InterfaceManager:BuildInterfaceSection(Tabs.Settings)
      SaveManager:BuildConfigSection(Tabs.Settings)


      Window:SelectTab(1)

      Fluent:Notify({
      Title = "Fisch",
      Content = "The script has been loaded.",
      Duration = 8
      })

      -- You can use the SaveManager:LoadAutoloadConfig() to load a config
      -- which has been marked to be one that auto loads!
      SaveManager:LoadAutoloadConfig()
end

-- Script execution logic
if versionCheck and VersionCheck() then
      loadScript()
elseif versionCheck and not VersionCheck() then
      local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/denrigtigeMatjias/FluentBackup/refs/heads/main/main.lua"))()

      Fluent:Notify({
            Title = "Fisch",
            Content = "Server and script version mismatch. Please update or change versionCheck to false. Note this might lead to problems or ban",
            Duration = 10
      })
else
      loadScript()
      local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/denrigtigeMatjias/FluentBackup/refs/heads/main/main.lua"))()
      Fluent:Notify({
            Title = "Fisch",
            Content = "Having versionCheck off might lead to problems or ban",
            Duration = 8
      })
end
