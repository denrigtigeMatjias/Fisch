getgenv().auto_shake = function(button)
    if button and button:IsA("ImageButton") and button.Visible then
        task.wait(getgenv().config.auto_shake_delay)
        getgenv().config.GuiService.SelectedObject = button
        if getgenv().config.GuiService.SelectedObject == button then
            getgenv().config.VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            getgenv().config.VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        end
    end
end
