spawn(function()
    while wait(0.1) do
        if getgenv().reeltoggle then
            game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, false)
        end
    end
end)
