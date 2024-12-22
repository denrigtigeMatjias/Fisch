spawn(function()
    while wait(0.1) do
        if getgenv().casttoggle then
            local player = game.Players.LocalPlayer
            local rodSearchTerm = "Rod"
            local character = game:GetService("Workspace"):FindFirstChild(player.Name)
            local equippedRod

            if character then
                for _, item in ipairs(character:GetChildren()) do
                    if item.Name == "RodBodyModel" then
                        continue
                    elseif string.find(item.Name:lower(), rodSearchTerm:lower()) then
                        equippedRod = item
                        break
                    end
                end
            end

            if equippedRod and equippedRod:FindFirstChild("events") and equippedRod.events:FindFirstChild("cast") then
                equippedRod.events.cast:FireServer(100, 1) -- Adjust parameters as needed
            else
                warn("No equipped rod or rod events found.")
            end
        end
    end
end)
