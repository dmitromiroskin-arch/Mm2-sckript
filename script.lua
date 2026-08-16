local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Расчет времени использования
local startTime = tick()
local function getUsageTime()
    local seconds = math.floor(tick() - startTime)
    local minutes = math.floor(seconds / 60)
    local hours = math.floor(minutes / 60)
    return string.format("%02d:%02d:%02d", hours, minutes % 60, seconds % 60)
end

-- Определение роли (Владелец для вашего ника)
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
   KeySystem = true,
   KeySettings = {
      Title = "Проверка ключа",
      Subtitle = "Введите ключ доступа",
      Note = "Ключ доступа: MYKEY123",
      FileName = "MM2Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"MYKEY123"}
   }
})

-- Вкладка 1: Главное
local MainTab = Window:CreateTab("Главное", 4483362458)

-- Секция статистики
MainTab:CreateSection("Статистика")

MainTab:CreateLabel("Ник: " .. player.Name)
MainTab:CreateLabel("Роль: " .. userRole)

local TimeLabel = MainTab:CreateLabel("Время в скрипте: 00:00:00")
task.spawn(function()
    while task.wait(1) do
        TimeLabel:Set("Время в скрипте: " .. getUsageTime())
    end
end)

-- Секция функций
MainTab:CreateSection("Функции")

-- Функция ESP
local function ToggleESP(state)
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local highlight = p.Character:FindFirstChild("Highlight")
            if state then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "Highlight"
                    highlight.Parent = p.Character
                    highlight.FillTransparency = 0.5
                    
                    if p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                        highlight.FillColor = Color3.fromRGB(0, 0, 255)
                    elseif p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    end
                end
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end

MainTab:CreateToggle({
   Name = "Подсветка игроков (ESP)",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value) ToggleESP(Value) end,
})

-- Функция авто-убийства через телепортацию к цели
local function KillTarget(targetRole)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hasTool = p.Backpack:FindFirstChild(targetRole) or p.Character:FindFirstChild(targetRole)
            if hasTool then
                player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                break
            end
        end
    end
end

MainTab:CreateButton({
   Name = "Убить Мардера (Авто-ТП)",
   Callback = function()
       KillTarget("Knife")
   end,
})

MainTab:CreateButton({
   Name = "Убить Шерифа (Авто-ТП)",
   Callback = function()
       KillTarget("Gun")
   end,
})

-- Вкладка 2: Персонаж
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

PlayerTab:CreateSlider({
   Name = "Сила прыжка",
   Range = {50, 200},
   Increment = 5,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
       if player.Character and player.Character:FindFirstChild("Humanoid") then
           player.Character.Humanoid.JumpPower = Value
       end
   end,
})
