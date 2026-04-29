local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")

-- Tạo GUI
local sg = Instance.new("ScreenGui")
sg.Name = "UltimateSpeed"
sg.ResetOnSpawn = false
-- Thử đưa vào CoreGui để không bị game xóa, nếu không được thì vào PlayerGui
pcall(function() sg.Parent = game:GetService("CoreGui") end)
if not sg.Parent then sg.Parent = player:WaitForChild("PlayerGui") end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 100)
frame.Position = UDim2.new(0.5, -80, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true -- Có thể cầm chuột kéo đi
frame.Parent = sg

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.9, 0, 0, 30)
box.Position = UDim2.new(0.05, 0, 0.1, 0)
box.PlaceholderText = "Tốc độ..."
box.Text = "50"
box.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.9, 0, 0, 40)
btn.Position = UDim2.new(0.05, 0, 0.5, 0)
btn.Text = "KÍCH HOẠT"
btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
btn.Parent = frame

-- Biến lưu trạng thái
local targetSpeed = 16
local toggled = false

btn.MouseButton1Click:Connect(function()
    toggled = not toggled
    if toggled then
        targetSpeed = tonumber(box.Text) or 16
        btn.Text = "ĐANG CHẠY (" .. targetSpeed .. ")"
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    else
        btn.Text = "KÍCH HOẠT"
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        -- Trả về tốc độ mặc định
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Vòng lặp quan trọng nhất: Ép tốc độ liên tục
runService.Heartbeat:Connect(function()
    if toggled then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = targetSpeed
            end
        end
    end
end)
