local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local player = game.Players.LocalPlayer
local userRole = "Пользователь"
if player.Name == "LIN_A8826" then
    userRole = "Владелец"
end

local Window = Rayfield:CreateWindow({
   Name = "MM2 Script | Delta",
   LoadingTitle = "Загрузка скрипта...",
   LoadingSubtitle = "by Assistant",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- Вкладка: Главное
local MainTab = Window:CreateTab("Главное", 4483362458)

MainTab:CreateSection("Статистика")
MainTab:CreateLabel("Ник: " .. player.Name)
MainTab:CreateLabel("Роль: " .. userRole)

MainTab:CreateSection("Функции")

-- ESP Toggle
MainTab:CreateToggle({
   Name = "Подсветка игроков (ESP)",
   CurrentValue = false,
   Flag = "ESPToggle",
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
                       if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                           highlight.FillColor = Color3.fromRGB(255, 0, 0)
                       elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                           highlight.FillColor = Color3.fromRGB(0, 0, 255)
                       else
                           highlight.FillColor = Color3.fromRGB(0, 255, 0)
                       end
                   end
               else
                   if highlight then highlight:Destroy() end
               end
           end
       end
   end,
})

-- Авто-убийства
MainTab:CreateButton({
   Name = "Убить Мардера (Авто-ТП)",
   Callback = function()
       for _, p in pairs(game.Players:GetPlayers()) do
           if p ~= player and p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
               player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
               break
           end
       end
   end,
})

MainTab:CreateButton({
   Name = "Убить Шерифа (Авто-ТП)",
   Callback = function()
       for _, p in pairs(game.Players:GetPlayers()) do
           if p ~= player and p.Character and (p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")) then
               player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
               break
           end
       end
   end,
})

-- Вкладка: Игрок
local PlayerTab = Window:CreateTab("Игрок", 4483362458)

PlayerTab:CreateSlider({
   Name = "Скорость бега",
   Range = {16, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
       if player.Character and player.Character:FindFirstChild("Humanoid") then
           player.Character.Humanoid.WalkSpeed = Value
       end
   end,
})
