local player = game:GetService("Players").LocalPlayer

-- 1. Tạo ScreenGui chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UniversalSpeedGUI"
screenGui.ResetOnSpawn = false

-- Đưa GUI vào CoreGui (dành cho Executor) để ẩn khỏi game, nếu lỗi thì dùng PlayerGui
local success, err = pcall(function()
    screenGui.Parent = game:GetService("CoreGui")
end)
if not success then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- 2. Tạo Khung (Frame) nền có thể kéo thả
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- Cho phép dùng chuột kéo bảng GUI đi chỗ khác
frame.Parent = screenGui

-- 3. Tạo Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Hack Tốc Độ"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- 4. Tạo Ô nhập số (TextBox)
local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.8, 0, 0, 35)
speedInput.Position = UDim2.new(0.1, 0, 0.35, 0)
speedInput.Text = "50"
speedInput.PlaceholderText = "Nhập tốc độ..."
speedInput.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
speedInput.TextColor3 = Color3.fromRGB(0, 0, 0)
speedInput.Font = Enum.Font.SourceSansBold
speedInput.TextSize = 20
speedInput.Parent = frame

-- 5. Tạo Nút áp dụng (TextButton)
local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0.8, 0, 0, 35)
applyButton.Position = UDim2.new(0.1, 0, 0.65, 0)
applyButton.Text = "Chạy ngay!"
applyButton.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.Font = Enum.Font.SourceSansBold
applyButton.TextSize = 20
applyButton.Parent = frame

-- 6. Chức năng đổi tốc độ
applyButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(speedInput.Text)
    
    if newSpeed then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid.WalkSpeed = newSpeed
        end
    end
end)
