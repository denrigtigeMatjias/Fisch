getgenv().config = {
    -- Services
    Players = game:GetService("Players"),
    VirtualInputManager = game:GetService("VirtualInputManager"),
    GuiService = game:GetService("GuiService"),
    
    -- Variables
    player = getgenv().config.Players.LocalPlayer,
    character = getgenv().config.player:WaitForChild("Character"),
    humanoidRootPart = getgenv().config.charcter:WaitForChild("HumanoidRootPart"),
    auto_shake_delay = 0.1,

    -- Toggles
    cast_toggle = false,
    shake_toggle = false,
    reel_toggle = false,
    freeze_toggle = false,
}
