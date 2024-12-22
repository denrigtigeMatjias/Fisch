getgenv().auto_reel = function()
    local reel_ui = playergui:FindFirstChild("reel")
    if not reel_ui then
        return
    end

    local reel_bar = reel_ui:FindFirstChild("bar")
    if not reel_bar then
        return
    end
    
    local reel_client = reel_bar:FindFirstChild("reel")
    if not reel_client then
        return
    end

    game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, false)
end
