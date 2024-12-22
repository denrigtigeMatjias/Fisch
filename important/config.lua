getgenv().config = {
    -- Services
    Players = game:GetService("Players"),
    VirtualInputManager = game:GetService("VirtualInputManager"),
    GuiService = game:GetService("GuiService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),

    -- Variables
    player = game:GetService("Players").LocalPlayer,
    character = game:GetService("Workspace"):FindFirstChild(player.Name),
    humanoidRootPart = game:GetService("Workspace"):FindFirstChild(player.Name):WaitForChild("HumanoidRootPart"),
    auto_shake_delay = 0.1,

    -- Toggles
    cast_toggle = false,
    shake_toggle = false,
    reel_toggle = false,
    freeze_toggle = false,
}
