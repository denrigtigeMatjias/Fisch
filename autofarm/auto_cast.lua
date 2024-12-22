getgenv().auto_cast = function()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local rodSearchTerm = "Rod"
    local equippedRod

    if character then
        for _, item in ipairs(character:GetChildren()) do
            if item:IsA("Tool") and (item.Name:find("rod") or item.Name:find("Rod")) then
                equippedRod = item
            end
        end
    end

    if equippedRod and equippedRod:FindFirstChild("events") and equippedRod.events:FindFirstChild("cast") then
        equippedRod.events.cast:FireServer(100, 1)
    else
        local rod = getgenv().findItemInLocalBackpack(rodSearchTerm)

        if rod then
            local equipEvent = getgenv().config.PlayerGui:FindFirstChild("hud") and getgenv().config.PlayerGui.hud.safezone.backpack.events:FindFirstChild("equip")

            if equipEvent then
                equipEvent:FireServer(rod)

                wait(0.5)

                if getgenv().config.character then
                    for _, item in ipairs(getgenv().config.character:GetChildren()) do
                        if item:IsA("Tool") and (item.Name:find("rod") or item.Name:find("Rod")) then
                            equippedRod = item
                        end
                    end
                end
            end
        end
    end
end
