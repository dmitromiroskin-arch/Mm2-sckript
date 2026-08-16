local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local player = game.Players.LocalPlayer
local userRole = "Пользователь"
if player.Name == "LIN_A8826" then
    userRole = "Владелец"
end

local Window = Fluent:CreateWindow({
    Title = "MM2 Script | Delta",
    SubTitle = "by Assistant",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Theme = "Dark"
})

local Tabs = {
    Main = Window:AddTab({ Title = "Главное", Icon = "home" }),
    Player = Window:AddTab({ Title = "Игрок", Icon = "user" })
}

Tabs.Main:AddParagraph({
    Title = "Профиль",
    Content = "Ник: " .. player.Name .. "\nРоль: " .. userRole
})

Tabs.Main:AddToggle("ESPToggle", {
    Title = "Подсветка игроков (ESP)",
    Default = false,
    Callback = function(Value)
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                local highlight = p.Character:FindFirstChild("Highlight")
                if Value then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "Highlight"
                        highlight.Parent = p.Character
                        highlight.FillTransparency = 0.5
                    end
                else
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end
})

Tabs.Main:AddButton({
    Title = "Убить Мардера (Авто-ТП)",
    Callback = function()
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
                player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                break
            end
        end
    end
})

Tabs.Main:AddButton({
    Title = "Убить Шерифа (Авто-ТП)",
    Callback = function()
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and (p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")) then
                player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                break
            end
        end
    end
})

Tabs.Player:AddSlider("SpeedSlider", {
    Title = "Скорость бега",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})
