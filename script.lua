local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Расчет времени использования
local startTime = tick()
local function getUsageTime()
    local seconds = math.floor(tick() - startTime)
    local minutes = math.floor(seconds / 60)
    local hours = math.floor(minutes / 60)
    return string.format("%02d:%02d:%02d", hours, minutes % 60, seconds % 60)
end

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
   KeySystem = true, -- Включаем систему ключей/кодов
   KeySettings = {
      Title = "Проверка кода",
      Subtitle = "Введите код доступа",
      Note = "Подсказка: День рождения создателя",
      FileName = "MM2PinCode",
      SaveKey = true, -- Сохраняет код, чтобы не вводить каждый раз
      GrabKeyFromSite = false,
      Key = {"0811"} -- Твой код доступа
   }
})

-- Вкладка: Главное
local MainTab = Window:CreateTab("Главное", 4483362458)

MainTab:CreateSection("Статистика")
MainTab:CreateLabel("Ник: " .. player.Name)
MainTab:CreateLabel("Роль: " .. userRole)

-- Живой таймер времени
local TimeLabel = MainTab:CreateLabel("Время в скрипте: 00:00:00")
task.spawn(function()
    while task.wait(1) do
        TimeLabel:Set("Время в скрипте: " .. getUsageTime())
    end
end)

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
