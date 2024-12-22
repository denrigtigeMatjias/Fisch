spawn(function()
    while wait(0.1) do
        local LocalPlayer = game:GetService("Players").LocalPlayer

        if getgenv().freezetoggle then
            LocalPlayer.Character.HumanoidRootPart.Anchored = true
        else
            LocalPlayer.Character.HumanoidRootPart.Anchored = false
        end
    end
end)
