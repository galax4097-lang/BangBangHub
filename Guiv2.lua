local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")

-- Xóa GUI cũ để tránh trùng lặp
local coreGui = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or player:WaitForChild("PlayerGui")
if coreGui:FindFirstChild("VisualControlHub") then
    coreGui.VisualControlHub:Destroy()
end

-- ==========================================
-- 1. TẠO GIAO DIỆN (UI) VỚI HÌNH ẢNH
-- ==========================================
local sg = Instance.new("ScreenGui")
sg.Name = "VisualControlHub"
sg.ResetOnSpawn = false
sg.Parent = coreGui

-- Khung chính (Main Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 300)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = sg

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 15)
cornerMain.Parent = mainFrame

-- Hiệu ứng bóng đổ / Viền sáng
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = mainFrame

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "🚀 PRO GADGET CONTROL"
title.Font = Enum.Font.GothamBlack
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Parent = mainFrame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 15)

-- --- PHẦN SPEED (Tốc độ) ---
-- Icon Tốc độ
local speedIcon = Instance.new("ImageLabel")
speedIcon.Size = UDim2.new(0, 30, 0, 30)
speedIcon.Position = UDim2.new(0.05, 0, 0.22, 0)
speedIcon.Image = "rbxassetid://6031265917" -- Icon tia sét/tốc độ
speedIcon.BackgroundTransparency = 1
speedIcon.ImageColor3 = Color3.fromRGB(255, 255, 0)
speedIcon.Parent = mainFrame

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.4, 0, 0, 35)
speedBox.Position = UDim2.new(0.15, 0, 0.32, 0)
speedBox.Text = "50"
speedBox.Font = Enum.Font.GothamBold
speedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 8)
speedBox.Parent = mainFrame

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0.35, 0, 0, 35)
speedBtn.Position = UDim2.new(0.6, 0, 0.32, 0)
speedBtn.Text = "RUN FAST"
speedBtn.Font = Enum.Font.GothamBlack
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 8)
speedBtn.Parent = mainFrame

-- --- PHẦN FLY (Bay) ---
-- Icon Bay
local flyIcon = Instance.new("ImageLabel")
flyIcon.Size = UDim2.new(0, 30, 0, 30)
flyIcon.Position = UDim2.new(0.05, 0, 0.52, 0)
flyIcon.Image = "rbxassetid://6034287525" -- Icon đôi cánh
flyIcon.BackgroundTransparency = 1
flyIcon.ImageColor3 = Color3.fromRGB(0, 255, 255)
flyIcon.Parent = mainFrame

local flyBox = Instance.new("TextBox")
flyBox.Size = UDim2.new(0.4, 0, 0, 35)
flyBox.Position = UDim2.new(0.15, 0, 0.62, 0)
flyBox.Text = "75"
flyBox.Font = Enum.Font.GothamBold
flyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
flyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", flyBox).CornerRadius = UDim.new(0, 8)
flyBox.Parent = mainFrame

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.35, 0, 0, 35)
flyBtn.Position = UDim2.new(0.6, 0, 0.62, 0)
flyBtn.Text = "FLY (E)"
flyBtn.Font = Enum.Font.GothamBlack
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 180)
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 8)
flyBtn.Parent = mainFrame

-- Nút Đóng
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.9, 0, 0, 40)
closeBtn.Position = UDim2.new(0.05, 0, 0.82, 0)
closeBtn.Text = "❌ CLOSE & STOP ALL"
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)
closeBtn.Parent = mainFrame

-- ==========================================
-- 2. LOGIC HOẠT ĐỘNG (GIỮ NGUYÊN SỨC MẠNH)
-- ==========================================
local speedActive = false
speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    speedBtn.Text = speedActive and "STOP RUN" or "RUN FAST"
    speedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(255, 80, 0) or Color3.fromRGB(0, 120, 215)
end)

runService.Heartbeat:Connect(function()
    if speedActive then
        local target = tonumber(speedBox.Text) or 16
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = target
        end
    end
end)

local flying = false
local bodyVel, bodyGyro

local function toggleFly()
    flying = not flying
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if flying and root then
        flyBtn.Text = "LANDING"
        flyBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 0)
        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyVel = Instance.new("BodyVelocity", root)
        bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flying do
                runService.RenderStepped:Wait()
                local fSpeed = tonumber(flyBox.Text) or 75
                local cam = workspace.CurrentCamera.CFrame
                local dir = Vector3.new(0,0,0)
                if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
                if bodyVel then bodyVel.Velocity = dir * fSpeed end
                if bodyGyro then bodyGyro.CFrame = cam end
            end
        end)
    else
        flyBtn.Text = "FLY (E)"
        flyBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 180)
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVel then bodyVel:Destroy() end
    end
end

flyBtn.MouseButton1Click:Connect(toggleFly)
uis.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.E then toggleFly() end end)
closeBtn.MouseButton1Click:Connect(function() 
    speedActive = false
    if flying then toggleFly() end
    sg:Destroy() 
end)
