local player = game.Players.LocalPlayer

-- 1. Tạo ScreenGui chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 2. Tạo Khung (Frame) nền
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75) -- Giữa màn hình
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 2
frame.Parent = screenGui

-- 3. Tạo Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Điều chỉnh tốc độ"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- 4. Tạo Ô nhập số (TextBox)
local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.8, 0, 0, 35)
speedInput.Position = UDim2.new(0.1, 0, 0.35, 0)
speedInput.Text = "16" -- Tốc độ mặc định của Roblox
speedInput.PlaceholderText = "Nhập tốc độ..."
speedInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextColor3 = Color3.fromRGB(0, 0, 0)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 20
speedInput.Parent = frame

-- 5. Tạo Nút áp dụng (TextButton)
local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0.8, 0, 0, 35)
applyButton.Position = UDim2.new(0.1, 0, 0.65, 0)
applyButton.Text = "Áp dụng"
applyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.Font = Enum.Font.SourceSansBold
applyButton.TextSize = 20
applyButton.Parent = frame

-- 6. Viết chức năng thay đổi tốc độ khi bấm nút
applyButton.MouseButton1Click:Connect(function()
    -- Lấy số từ ô nhập
    local newSpeed = tonumber(speedInput.Text)
    
    -- Kiểm tra xem người dùng có nhập đúng số không
    if newSpeed then
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid.WalkSpeed = newSpeed
            applyButton.Text = "Thành công!"
            task.wait(1)
            applyButton.Text = "Áp dụng"
        end
    else
        -- Nếu nhập sai (nhập chữ), báo lỗi
        speedInput.Text = ""
        speedInput.PlaceholderText = "Vui lòng nhập SỐ!"
        task.wait(1.5)
        speedInput.PlaceholderText = "Nhập tốc độ..."
        speedInput.Text = "16"
    end
end)
