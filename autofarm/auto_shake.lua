getgenv().autoShake = function(button)
    if button and button:IsA("ImageButton") and button.Visible then
        task.wait(getgenv().config.autoShakeDelay)
        getgenv().config.GuiService.SelectedObject = button
        if getgenv().config.GuiService.SelectedObject == button then
            getgenv().config.VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            getgenv().config.VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        end
    end
end

spawn(function()
    while wait(0.1) do
        if getgenv().shaketoggle then
            local exampleButton = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
                :FindFirstChild("shakeui")
                :FindFirstChild("safezone")
                :FindFirstChild("button")
            
            if exampleButton then
                getgenv().autoShake(exampleButton)
            end
        end
    end
end)
