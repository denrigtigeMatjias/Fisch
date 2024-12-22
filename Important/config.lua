getgenv().config = {
    -- Services
    player = game:GetService("Players").LocalPlayer
    VirtualInputManager = game:GetService("VirtualInputManager")
    GuiService = game:GetService("GuiService")
    
    -- Variables
    autoShakeDelay = 0.1

    -- Toggles
    getgenv().shaketoggle = false
}
