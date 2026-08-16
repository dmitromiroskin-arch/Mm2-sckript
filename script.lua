-- Загрузка библиотеки WindUI
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

-- Настройка профиля
local player = game.Players.LocalPlayer
local userRole = "Пользователь"
if player.Name == "LIN_A8826" then
    userRole = "Владелец"
end

-- Создание окна
local Window = WindUI:CreateWindow({
    Title = "Murder Mystery 2",
    Subtitle = "space scripts",
    Author = "by Assistant",
    Folder = "MM2Config",
    Size = UDim2.fromOffset(580, 400),
    Transparent = true,
    Theme = "Dark",
})

-- Создание профиля внизу меню (как на скриншоте)
Window:SetUser({
    Username = player.Name,
    Title = userRole,
    Image = game:GetService("Players"):GetUserThumbnailAsync(
        player.UserId, 
        Enum.ThumbnailType.HeadShot, 
        Enum.ThumbnailSize.Size420x420
    )
})

-- Вкладка Main (Главное)
local MainTab = Window:Tab({
    Title = "Main",
    Icon = "box",
})

MainTab:Toggle({
    Title = "Подсветка игроков (ESP)",
    Value = false,
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

-- Вкладка Murder
local MurderTab = Window:Tab({
    Title = "Murder",
    Icon = "sword",
})

MurderTab:Button({
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

-- Вкладка Sheriff
local SheriffTab = Window:Tab({
    Title = "Sheriff",
    Icon = "disc",
})

SheriffTab:Button({
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
