local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MM2 Script | Delta",
   LoadingTitle = "Загрузка скрипта...",
   LoadingSubtitle = "by Assistant",
   ConfigurationSaving = {
      Enabled = false
   },
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

local MainTab = Window:CreateTab("Главное", 4483362458)

local ESP_Enabled = false

local function ToggleESP(state)
    ESP_Enabled = state
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("Highlight")
            if state then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "Highlight"
                    highlight.Parent = player.Character
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    
                    if player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun") then
                        highlight.FillColor = Color3.fromRGB(0, 0, 255)
                    elseif player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife") then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    end
                end
            else
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

MainTab:CreateToggle({
   Name = "Подсветка игроков (ESP)",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
       ToggleESP(Value)
   end,
})

MainTab:CreateSlider({
   Name = "Скорость игрока",
   Range = {16, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
       end
   end,
})
