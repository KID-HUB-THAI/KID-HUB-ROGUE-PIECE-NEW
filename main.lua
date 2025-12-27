local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "My Super Hub",
    Icon = "door-open", -- lucide icon. optional
    Author = "by .ftgs and .ftgs", -- optional
})
local Tab = Window:Tab({
    Title = "Main",
    Icon = "optional", -- optional
    Locked = false,
})
local RunService = game:GetService("RunService")
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
    Desc = "(ต้องมีObservationก่อนถึงจะเปิดได้)() Loop Observation (ยิงค้าง)",
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
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Serverside")

-- รวม args ทั้งหมด (ยกเว้น Observation)
local AllArgs = {
    -- Haki ON


    -- Combat
    {"Server","Combat","M1s","Combat",1},
    {"Server","Combat","M1s","Sukuna",1},
    {"Server","Combat","M1s","Aizen",1},

    -- Sword
    {"Server","Sword","M1s","Katana",1},
    {"Server","Sword","M1s","Dual Katana",1},
    {"Server","Sword","M1s","Dark Blade",1},
    {"Server","Sword","M1s","Zangetsu",1},
    {"Server","Sword","M1s","Tanjiro's Nichirin",1},
    {"Server","Sword","M1s","Dual Dagger",1},
    {"Server","Sword","M1s","Yuta's Katana",1},

    -- Metal Bat (2 คำสั่ง)
    {"Server","Sword","M1s","Metal Bat",4},
    {"Server","Sword","Swing","Metal Bat"},
}

local loopConn

local Toggle = Tab:Toggle({
    Title = "Auto All (No Observation)",
    Desc = "รวมทุกอย่างอัตโนมัติในปุ่มเดียว",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        print("Auto All:", state)

        if state then
            if loopConn then loopConn:Disconnect() end
            loopConn = RunService.Heartbeat:Connect(function()
                for _, args in ipairs(AllArgs) do
                    Remote:FireServer(unpack(args))
                end
            end)
        else
            if loopConn then
                loopConn:Disconnect()
                loopConn = nil
            end
        end
    end
})




local Tab = Window:Tab({
    Title = "Tp",
    Icon = "optional", -- optional
    Locked = false,
})
-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MapsFolder = workspace:WaitForChild("Maps")
local SelectedIsland

local function getIslands()
    local islands = {}
    for _, island in ipairs(MapsFolder:GetChildren()) do
        if island:IsA("Model") then
            table.insert(islands, island.Name)
        end
    end
    return islands
end

local islandList = getIslands()
SelectedIsland = islandList[1]

local Dropdown = Tab:Dropdown({
    Title = "Select Island",
    Desc = "เลือกเกาะ",
    Values = islandList,
    Value = islandList[1],
    Callback = function(option)
        SelectedIsland = option
    end
})

local Button = Tab:Button({
    Title = "Teleport",
    Desc = "วาปไปเหนือเกาะ 50 studs",
    Locked = false,
    Callback = function()
        if not SelectedIsland then return end

        local island = MapsFolder:FindFirstChild(SelectedIsland)
        if not island then return end

        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        local offset = Vector3.new(0, 50, 0) -- สูงกว่าเกาะ 50 studs

        if island.PrimaryPart then
            hrp.CFrame = island.PrimaryPart.CFrame + offset
        else
            local part = island:FindFirstChildWhichIsA("BasePart", true)
            if part then
                hrp.CFrame = part.CFrame + offset
            end
        end
    end
})



local Tab = Window:Tab({
    Title = "fram",
    Icon = "optional", -- optional
    Locked = false,
})





