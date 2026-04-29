local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")

-- Xóa GUI cũ nếu đã chạy trước đó để không bị đè lên nhau
local coreGui = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or player:WaitForChild("PlayerGui")
if coreGui:FindFirstChild("ProControlHub") then
    coreGui.ProControlHub:Destroy()
end

-- ==========================================
-- 1. TẠO GIAO DIỆN (UI)
-- ==========================================
local sg = Instance.new("ScreenGui")
sg.Name = "ProControlHub"
sg.ResetOnSpawn = false
sg.Parent = coreGui

-- Khung chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 260)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = sg

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 10)
cornerMain.Parent = mainFrame

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "UNIVERSAL SPEED & FLY CONTROL"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Parent = mainFrame

local cornerTitle = Instance.new("UICorner")
cornerTitle.CornerRadius = UDim.new(0, 10)
cornerTitle.Parent = title

-- === PHẦN SPEED ===
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 150, 0, 20)
speedLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
speedLabel.Text = "SPEED CONTROL"
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.BackgroundTransparency = 1
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = mainFrame

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.45, 0, 0, 35)
speedBox.Position = UDim2.new(0.05, 0, 0.3, 0)
speedBox.Text = "50"
speedBox.PlaceholderText = "Nhập tốc độ..."
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 14
speedBox.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 5)
speedBox.Parent = mainFrame

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0.4, 0, 0, 35)
speedBtn.Position = UDim2.new(0.55, 0, 0.3, 0)
speedBtn.Text = "ACTIVATE SPEED"
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 14
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 5)
speedBtn.Parent = mainFrame

-- === PHẦN FLY ===
local flyLabel = Instance.new("TextLabel")
flyLabel.Size = UDim2.new(0, 150, 0, 20)
flyLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
flyLabel.Text = "FLY CONTROL (Phím E)"
flyLabel.Font = Enum.Font.GothamBold
flyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
flyLabel.BackgroundTransparency = 1
flyLabel.TextXAlignment = Enum.TextXAlignment.Left
flyLabel.Parent = mainFrame

local flyBox = Instance.new("TextBox")
flyBox.Size = UDim2.new(0.45, 0, 0, 35)
flyBox.Position = UDim2.new(0.05, 0, 0.6, 0)
flyBox.Text = "75"
flyBox.PlaceholderText = "Tốc độ bay..."
flyBox.Font = Enum.Font.Gotham
flyBox.TextSize = 14
flyBox.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Instance.new("UICorner", flyBox).CornerRadius = UDim.new(0, 5)
flyBox.Parent = mainFrame

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.4, 0, 0, 35)
flyBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
flyBtn.Text = "ACTIVATE FLY"
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 14
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 5)
flyBtn.Parent = mainFrame

-- === NÚT ĐÓNG ===
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.9, 0, 0, 35)
closeBtn.Position = UDim2.new(0.05, 0, 0.82, 0)
closeBtn.Text = "CLOSE GUI"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.Parent = mainFrame


-- ==========================================
-- 2. LOGIC TỐC ĐỘ (SPEED)
-- ==========================================
local speedActive = false
speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        speedBtn.Text = "SPEED: ON"
        speedBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    else
        speedBtn.Text = "ACTIVATE SPEED"
        speedBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
end)

runService.Heartbeat:Connect(function()
    if speedActive then
        local targetSpeed = tonumber(speedBox.Text) or 50
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = targetSpeed
        end
    end
end)


-- ==========================================
-- 3. LOGIC BAY (FLY)
-- ==========================================
local flying = false
local bodyVel, bodyGyro

local function toggleFly()
    flying = not flying
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if flying and root then
        flyBtn.Text = "FLYING: ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        
        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = root.CFrame
        
        bodyVel = Instance.new("BodyVelocity", root)
        bodyVel.Velocity = Vector3.new(0, 0, 0)
        bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flying do
                runService.RenderStepped:Wait()
                local flySpeed = tonumber(flyBox.Text) or 75
                local cam = workspace.CurrentCamera.CFrame
                local dir = Vector3.new(0,0,0)
                
                if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
                
                if bodyVel and bodyGyro then
                    bodyVel.Velocity = dir * flySpeed
                    bodyGyro.CFrame = cam
                end
            end
        end)
    else
        flyBtn.Text = "ACTIVATE FLY"
        flyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVel then bodyVel:Destroy() end
    end
end

flyBtn.MouseButton1Click:Connect(toggleFly)

-- Dùng phím E để bật/tắt Fly nhanh
uis.InputBegan:Connect(function(input, isTyping)
    if not isTyping and input.KeyCode == Enum.KeyCode.E then
        toggleFly()
    end
end)

-- ==========================================
-- 4. NÚT ĐÓNG BẢNG
-- ==========================================
closeBtn.MouseButton1Click:Connect(function()
    speedActive = false
    if flying then toggleFly() end -- Tắt fly nếu đang bay
    sg:Destroy() -- Xóa bảng đi
end)
