local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Kid Hub",
    Icon = "door-open", -- lucide icon. optional
    Author = "by roblox:Dec._._._._60", -- optional
})
local Tab = Window:Tab({
    Title = "TP",
    Icon = "bird", -- optional
    Locked = false,
})


-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Path ไปที่ Maps
local MapsFolder = workspace:WaitForChild("Maps")

-- ตัวแปรเก็บเกาะที่เลือก
getgenv().SelectedIsland = nil

-- ดึงรายชื่อเกาะทั้งหมด
local function getIslands()
    local islands = {}
    for _, island in ipairs(MapsFolder:GetChildren()) do
        if island:IsA("Model") or island:IsA("Folder") then
            table.insert(islands, island.Name)
        end
    end
    table.sort(islands)
    return islands
end

-- Dropdown เลือกเกาะ
local IslandDropdown = Tab:Dropdown({
    Title = "Select Island",
    Values = getIslands(),
    Value = nil,
    Callback = function(option)
        getgenv().SelectedIsland = option
        print("Selected Island:", option)
    end
})

-- ฟังก์ชันวาปไปเกาะ
local function teleportToIsland(islandName)
    if not islandName then return end

    local island = MapsFolder:FindFirstChild(islandName)
    if not island then
        warn("ไม่พบเกาะ:", islandName)
        return
    end

    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    local cf
    if island:IsA("Model") then
        cf = island:GetPivot()
    else
        local part = island:FindFirstChildWhichIsA("BasePart", true)
        if part then
            cf = part.CFrame
        end
    end

    if cf then
        hrp.CFrame = cf + Vector3.new(0, 50, 0)
    else
        warn("หา CFrame ของเกาะไม่ได้:", islandName)
    end
end

-- ปุ่มวาป
Tab:Button({
    Title = "Teleport to Island",
    Callback = function()
        teleportToIsland(getgenv().SelectedIsland)
    end
})








local Tab = Window:Tab({
    Title = "Auto attack",
    Icon = "bird", -- optional
    Locked = false,
})
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Serverside")

local AllArgs = {
    {"Server","Combat","M1s","Combat",1},
    {"Server","Combat","M1s","Sukuna",1},
    {"Server","Combat","M1s","Aizen",1},

    {"Server","Sword","M1s","Katana",1},
    {"Server","Sword","M1s","Dual Katana",1},
    {"Server","Sword","M1s","Dark Blade",1},
    {"Server","Sword","M1s","Zangetsu",1},
    {"Server","Sword","M1s","Tanjiro's Nichirin",1},
    {"Server","Sword","M1s","Dual Dagger",1},
    {"Server","Sword","M1s","Yuta's Katana",1},
    {"Server","Sword","M1s","Venuzdonoa",1},
    {"Server","Sword","M1s","Wado",1},
    {"Server","Sword","M1s","Tensa Zangetsu",1},
    {"Server","Sword","M1s","Gryphon",1},
    {"Server","Sword","M1s","Solemn Lament",1},
    {"Server","Sword","M1s","Spiritual Katana",1},
    {"Server","Sword","M1s","Divine Bident",1},


    {"Server","Sword","M1s","Metal Bat",4},
    {"Server","Sword","Swing","Metal Bat"},
}

local running = false

local Toggle = Tab:Toggle({
    Title = "Auto Attack",
    Desc = "รวมทุกอย่างอัตโนมัติในปุ่มเดียว (0.5s)",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        print("Auto All:", state)
        running = state

        if running then
            task.spawn(function()
                while running do
                    for _, args in ipairs(AllArgs) do
                        Remote:FireServer(unpack(args))
                    end
                    task.wait(0.5) -- ยิงทุก 0.5 วินาที
                end
            end)
        end
    end
})

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Serverside")

local args = {
    "Server",
    "Misc",
    "Observation",
    1
}

local running = false
local loopConn

local Toggle = Tab:Toggle({
    Title = "Observation Loop",
    Desc = "เปิด Loop Observation (ยิงค้าง)",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        running = state
        print("Loop:", state)

        if running then
            -- เริ่ม loop ยิงตลอด
            if loopConn then loopConn:Disconnect() end
            loopConn = RunService.Heartbeat:Connect(function()
                Remote:FireServer(unpack(args))
            end)
        else
            -- หยุด loop (แต่ไม่สั่งปิด Observation)
            if loopConn then
                loopConn:Disconnect()
                loopConn = nil
            end
        end
    end
})
