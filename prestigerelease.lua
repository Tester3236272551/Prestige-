-- Prestige Hub V1 - COMPLETE FINAL VERSION | G36 + Sniper Skins + Improved Aimbot + Crosshair
-- Made by Paul and Basti

local player = game.Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- ====================== DISCORD LOGGER ======================
local WEBHOOK_URL = "https://discord.com/api/webhooks/1489973283431649342/4eW9OrxjLJAtAInC-Dxtkgas_xWmuS_nYgM0iPyhi07cte62mW3M85DZrEBmEvDEHMAD"

local function sendDiscordLog()
    local gameName = "Unbekannt"
    pcall(function()
        local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
        gameName = info.Name or "Unbekannt"
    end)

    local embed = {
        username = "PrestigeHub Logger",
        embeds = {{
            title = "Prestige Hub V1 - Load Log",
            color = 16776960,
            fields = {
                {name = "👤 Player", value = player.Name .. " (" .. (player.DisplayName or "-") .. ")", inline = false},
                {name = "🆔 UserId", value = tostring(player.UserId), inline = true},
                {name = "📅 Account Age", value = math.floor((os.time() - player.AccountAge * 86400) / 86400) .. " days", inline = true},
                {name = "🎮 Game", value = gameName .. "\nPlaceId: " .. game.PlaceId, inline = false}
            },
            footer = { text = "PrestigeHub • " .. os.date("%d.%m.%Y") },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    pcall(function()
        local req = syn and syn.request or http_request or request
        if req then
            req({ Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(embed) })
        end
    end)
end
sendDiscordLog()

-- ====================== GUI SETUP ======================
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false
gui.Name = "PrestigeHubV1"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 680, 0, 500)
main.Position = UDim2.new(0.5, -340, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Thickness = 2.8
mainStroke.Color = Color3.fromRGB(255, 215, 0)

-- Title Bar
local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 52)
titleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 38)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -160, 0.65, 0)
title.Position = UDim2.new(0, 22, 0, 6)
title.BackgroundTransparency = 1
title.Text = "PRESTIGE V1"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.Font = Enum.Font.GothamBlack
title.TextSize = 30
title.TextXAlignment = Enum.TextXAlignment.Left

local madeBy = Instance.new("TextLabel", titleBar)
madeBy.Size = UDim2.new(1, -160, 0.35, 0)
madeBy.Position = UDim2.new(0, 22, 0.65, 0)
madeBy.BackgroundTransparency = 1
madeBy.Text = "made by Paul and Basti"
madeBy.TextColor3 = Color3.new(1, 1, 1)
madeBy.Font = Enum.Font.GothamSemibold
madeBy.TextSize = 15
madeBy.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", titleBar)
minimizeBtn.Size = UDim2.new(0, 38, 0, 38)
minimizeBtn.Position = UDim2.new(1, -88, 0.5, -19)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 30
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 9)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 38, 0, 38)
closeBtn.Position = UDim2.new(1, -44, 0.5, -19)
closeBtn.BackgroundColor3 = Color3.fromRGB(210, 40, 40)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 26
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 9)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, 0, 1, -52)
content.Position = UDim2.new(0, 0, 0, 52)
content.BackgroundTransparency = 1

local sidebar = Instance.new("ScrollingFrame", content)
sidebar.Size = UDim2.new(0, 185, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 38)
sidebar.ScrollBarThickness = 6
sidebar.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", sidebar)

local sidebarLayout = Instance.new("UIListLayout", sidebar)
sidebarLayout.Padding = UDim.new(0, 8)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

local sidebarPadding = Instance.new("UIPadding", sidebar)
sidebarPadding.PaddingTop = UDim.new(0, 10)
sidebarPadding.PaddingBottom = UDim.new(0, 10)

local pages = Instance.new("Frame", content)
pages.Size = UDim2.new(1, -195, 1, 0)
pages.Position = UDim2.new(0, 195, 0, 12)
pages.BackgroundTransparency = 1

local tabs = {}
local tabButtons = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame", pages)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 7
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 14)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 40)
    end)
    tabs[name] = page
    return page
end

local function switchTab(name)
    for n, p in pairs(tabs) do p.Visible = (n == name) end
    for n, b in pairs(tabButtons) do
        TweenService:Create(b, TweenInfo.new(0.25), {
            BackgroundColor3 = (n == name) and Color3.fromRGB(160, 110, 0) or Color3.fromRGB(45, 45, 75)
        }):Play()
    end
end

local function createTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -14, 0, 50)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 75)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 9)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 1.6
    stroke.Color = Color3.fromRGB(255, 215, 0)
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
    tabButtons[name] = btn
end

local function createButton(parent, text, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -28, 0, 50)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(55, 55, 90)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 17
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", b)
    stroke.Thickness = 1.8
    stroke.Color = Color3.fromRGB(255, 215, 0)
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(110, 80, 20), Size = UDim2.new(1, -20, 0, 52)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 90), Size = UDim2.new(1, -28, 0, 50)}):Play()
    end)
    b.MouseButton1Click:Connect(callback)
end

local function createToggleSwitch(parent, text, onToggle)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -28, 0, 62)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left

    local switchBg = Instance.new("Frame", frame)
    switchBg.Size = UDim2.new(0, 56, 0, 30)
    switchBg.Position = UDim2.new(1, -64, 0.5, -15)
    switchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", switchBg)
    knob.Size = UDim2.new(0, 26, 0, 26)
    knob.Position = UDim2.new(0, 2, 0.5, -13)
    knob.BackgroundColor3 = Color3.fromRGB(220, 220, 230)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local enabled = false
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            enabled = not enabled
            if enabled then
                TweenService:Create(switchBg, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}):Play()
                TweenService:Create(knob, TweenInfo.new(0.25), {Position = UDim2.new(1, -28, 0.5, -13)}):Play()
                onToggle(true)
            else
                TweenService:Create(switchBg, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
                TweenService:Create(knob, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0.5, -13)}):Play()
                onToggle(false)
            end
        end
    end)
end

-- ====================== PAGES ======================
local infoPage      = createPage("Info")
local ogSniperPage  = createPage("OG Sniper")
local skyPage       = createPage("Skybox")
local underglowPage = createPage("Underglow")
local fpsPage       = createPage("FPS")
local visualsPage   = createPage("Visuals")
local espPage       = createPage("ESP")
local aimbotPage    = createPage("Auto Aim")
local skinsPage     = createPage("Skins")
local crosshairPage = createPage("Crosshair")

createTab("Info")
createTab("OG Sniper")
createTab("Skybox")
createTab("Underglow")
createTab("FPS")
createTab("Visuals")
createTab("ESP")
createTab("Auto Aim")
createTab("Skins")
createTab("Crosshair")

switchTab("Info")

-- ====================== INFO PAGE ======================
local infoLabel = Instance.new("TextLabel", infoPage)
infoLabel.Size = UDim2.new(1, -40, 0, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Prestige Hub V1\n\nMade by Paul and Basti\n\nAlle Tabs komplett:\n• OG Sniper + No Cooldown\n• Skybox\n• Underglow + Farben\n• FPS Boost\n• Visuals\n• Enhanced ESP\n• Auto Aim mit Hit Prediction + Whitelist\n• Weapon Skins (G36 + Sniper)\n• Custom Crosshair (ersetzt normales)\n\nDiscord: https://discord.gg/UNCdDbSd"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.Font = Enum.Font.GothamSemibold
infoLabel.TextSize = 17
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextWrapped = true
infoLabel.AutomaticSize = Enum.AutomaticSize.Y

-- ====================== OG SNIPER ======================
local scopeConnection = nil
local cooldownConnection = nil

local function isSniper(tool)
    if not tool or not tool:IsA("Tool") then return false end
    local nameLower = tool.Name:lower()
    return nameLower:find("sniper") or nameLower:find("scharf") or tool:GetAttribute("Scope") ~= nil or tool:FindFirstChild("Scope") ~= nil
end

local function removeAimCooldown()
    local character = player.Character
    if not character then return end
    for _, tool in pairs(character:GetChildren()) do
        if isSniper(tool) then tool:SetAttribute("AimDelay", 0) end
    end
end

local function enableNoCooldown()
    if cooldownConnection then return end
    cooldownConnection = RunService.Heartbeat:Connect(removeAimCooldown)
end

local function disableNoCooldown()
    if cooldownConnection then cooldownConnection:Disconnect() cooldownConnection = nil end
end

createToggleSwitch(ogSniperPage, "OG Sniper (Scope Remover)", function(state)
    if state then
        if not scopeConnection then
            scopeConnection = RunService.Heartbeat:Connect(function()
                local character = player.Character
                if not character then return end
                for _, tool in pairs(character:GetChildren()) do
                    if tool:IsA("Tool") and (tool:GetAttribute("Scope") ~= nil or tool:FindFirstChild("Scope")) then
                        tool:SetAttribute("Scope", false)
                    end
                end
            end)
        end
    else
        if scopeConnection then scopeConnection:Disconnect() scopeConnection = nil end
    end
end)

createToggleSwitch(ogSniperPage, "No Sniper Cooldown", function(state)
    if state then enableNoCooldown() else disableNoCooldown() end
end)

-- ====================== SKYBOX ======================
local skies = {
    ["Universe"] = {SkyboxBk = "rbxassetid://159454299", SkyboxDn = "rbxassetid://159454296", SkyboxFt = "rbxassetid://159454293", SkyboxLf = "rbxassetid://159454286", SkyboxRt = "rbxassetid://159454300", SkyboxUp = "rbxassetid://159454288"},
    ["Purple"] = {SkyboxBk = "rbxassetid://16553658937", SkyboxDn = "rbxassetid://16553660713", SkyboxFt = "rbxassetid://16553662144", SkyboxLf = "rbxassetid://16553664042", SkyboxRt = "rbxassetid://16553665766", SkyboxUp = "rbxassetid://16553667750"},
    ["Aurora"] = {SkyboxBk = "rbxassetid://128600713462148", SkyboxDn = "rbxassetid://129205524771926", SkyboxFt = "rbxassetid://91295549823939", SkyboxLf = "rbxassetid://78049621027692", SkyboxRt = "rbxassetid://97339481871314", SkyboxUp = "rbxassetid://85412515491070"},
    ["Orange"] = {SkyboxBk = "rbxassetid://75806894209584", SkyboxDn = "rbxassetid://88955070832523", SkyboxFt = "rbxassetid://137588397191887", SkyboxLf = "rbxassetid://124955584991258", SkyboxRt = "rbxassetid://140343245463200", SkyboxUp = "rbxassetid://134383800716949"},
    ["Moonlight"] = {SkyboxBk = "rbxassetid://116261899350523", SkyboxDn = "rbxassetid://92257816837512", SkyboxFt = "rbxassetid://108326981730305", SkyboxLf = "rbxassetid://131834280163741", SkyboxRt = "rbxassetid://99525277797873", SkyboxUp = "rbxassetid://125425274451894"},
    ["Red Nebula"] = {SkyboxBk = "rbxassetid://401664839", SkyboxDn = "rbxassetid://401664862", SkyboxFt = "rbxassetid://401664960", SkyboxLf = "rbxassetid://401664881", SkyboxRt = "rbxassetid://401664901", SkyboxUp = "rbxassetid://401664936"},
    ["Pink Dream"] = {SkyboxBk = "rbxassetid://271042516", SkyboxDn = "rbxassetid://271077243", SkyboxFt = "rbxassetid://271042556", SkyboxLf = "rbxassetid://271042310", SkyboxRt = "rbxassetid://271042467", SkyboxUp = "rbxassetid://271077958"}
}

local function applySky(data)
    if Lighting:FindFirstChild("Sky") then Lighting.Sky:Destroy() end
    local s = Instance.new("Sky", Lighting)
    s.SkyboxBk = data.SkyboxBk
    s.SkyboxDn = data.SkyboxDn
    s.SkyboxFt = data.SkyboxFt
    s.SkyboxLf = data.SkyboxLf
    s.SkyboxRt = data.SkyboxRt
    s.SkyboxUp = data.SkyboxUp
end

for name, data in pairs(skies) do
    createButton(skyPage, name, function() applySky(data) end)
end

createButton(skyPage, "Remove Sky", function()
    if Lighting:FindFirstChild("Sky") then Lighting.Sky:Destroy() end
end)

-- ====================== UNDERGLOW ======================
local underglowEnabled = false
local rainbowEnabled = false
local onlyMyCar = true
local currentColor = Color3.fromRGB(0, 255, 255)
local underglowLights = {}
local rainbowConnection = nil

local function getPlayerVehicle()
    local character = player.Character
    if not character then return nil end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.SeatPart == nil then return nil end
    return humanoid.SeatPart.Parent
end

local function applyUnderglow(car)
    if not car then return end
    for _, obj in pairs(car:GetDescendants()) do
        if obj:IsA("PointLight") or (obj:IsA("Attachment") and obj:FindFirstChild("PointLight")) then obj:Destroy() end
    end
    local body = car:FindFirstChild("Body") or car.PrimaryPart
    if not body then return end
    local positions = {Vector3.new(0,-1.5,2), Vector3.new(0,-1.5,-2), Vector3.new(1.8,-1.5,0), Vector3.new(-1.8,-1.5,0)}
    for _, offset in ipairs(positions) do
        local att = Instance.new("Attachment", body)
        att.Position = offset
        local light = Instance.new("PointLight", att)
        light.Color = currentColor
        light.Brightness = 2.8
        light.Range = 9
        light.Shadows = false
        table.insert(underglowLights, {light, att})
    end
end

local function updateAllUnderglow()
    for _, lightData in pairs(underglowLights) do
        if lightData[1] and lightData[1].Parent then lightData[1].Color = currentColor end
    end
end

local function enableUnderglow()
    underglowEnabled = true
    underglowLights = {}
    if onlyMyCar then
        local car = getPlayerVehicle()
        if car then applyUnderglow(car) end
    else
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and (v:FindFirstChild("Body") or v.PrimaryPart) then applyUnderglow(v) end
        end
    end
end

local function disableUnderglow()
    underglowEnabled = false
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    rainbowEnabled = false
    for _, data in pairs(underglowLights) do
        for _, obj in pairs(data) do if obj then obj:Destroy() end end
    end
    underglowLights = {}
end

local function startRainbow()
    if rainbowConnection then return end
    rainbowEnabled = true
    local hue = 0
    rainbowConnection = RunService.Heartbeat:Connect(function(dt)
        hue = (hue + dt * 0.8) % 1
        currentColor = Color3.fromHSV(hue, 1, 1)
        updateAllUnderglow()
    end)
end

createToggleSwitch(underglowPage, "Enable Underglow", function(state)
    if state then enableUnderglow() else disableUnderglow() end
end)

createToggleSwitch(underglowPage, "Rainbow Underglow", function(state)
    if state then startRainbow()
    else
        if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
        rainbowEnabled = false
        currentColor = Color3.fromRGB(0, 255, 255)
        updateAllUnderglow()
    end
end)

createToggleSwitch(underglowPage, "Only My Car", function(state)
    onlyMyCar = state
    if underglowEnabled then
        disableUnderglow()
        task.wait(0.1)
        enableUnderglow()
    end
end)

local colorPresets = {
    {name = "Cyan", color = Color3.fromRGB(0, 255, 255)},
    {name = "Red", color = Color3.fromRGB(255, 0, 0)},
    {name = "Green", color = Color3.fromRGB(0, 255, 0)},
    {name = "Purple", color = Color3.fromRGB(128, 0, 255)},
    {name = "Yellow", color = Color3.fromRGB(255, 215, 0)},
    {name = "Blue", color = Color3.fromRGB(0, 100, 255)}
}

for _, preset in ipairs(colorPresets) do
    createButton(underglowPage, "Farbe: " .. preset.name, function()
        currentColor = preset.color
        if underglowEnabled then updateAllUnderglow() end
    end)
end

-- ====================== FPS ======================
createButton(fpsPage, "BOOST FPS (alles schlechter machen)", function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    Lighting.Brightness = 0.5
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.EffectsQuality = 0
    settings().Rendering.TextureQuality = 0
    print("🚀 FPS BOOST AKTIVIERT")
end)

-- ====================== VISUALS ======================
local timeFrozen = false
local targetTime = 12
local timeConnection = nil

local function updateTime()
    if timeFrozen then Lighting.ClockTime = targetTime end
end

local function toggleTimeFreeze(state)
    timeFrozen = state
    if state then
        if not timeConnection then timeConnection = RunService.Heartbeat:Connect(updateTime) end
    else
        if timeConnection then timeConnection:Disconnect() timeConnection = nil end
    end
end

createToggleSwitch(visualsPage, "Freeze Time", toggleTimeFreeze)
createToggleSwitch(visualsPage, "Fullbright", function(state) Lighting.Brightness = state and 6 or 1 end)
createToggleSwitch(visualsPage, "No Fog", function(state) Lighting.FogEnd = state and 999999 or 500 end)

createButton(visualsPage, "Clear Weather / Remove Clouds", function()
    Lighting.ClockTime = targetTime
    Lighting.FogEnd = 999999
    Lighting.Brightness = 3
    if Lighting:FindFirstChild("Atmosphere") then Lighting.Atmosphere:Destroy() end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("cloud") or obj.Name:lower():find("fog") then pcall(function() obj:Destroy() end) end
    end
end)

-- ====================== ESP ======================
local espEnabled = false
local boxEnabled = false
local tracerEnabled = false
local espObjects = {}

local function removeESP(char)
    if espObjects[char] then
        local data = espObjects[char]
        if data.billboard then data.billboard:Destroy() end
        if data.box then data.box:Remove() end
        if data.tracer then data.tracer:Remove() end
        for _, conn in pairs(data.connections or {}) do conn:Disconnect() end
        espObjects[char] = nil
    end
end

local function createFullESP(char)
    if not char or espObjects[char] then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end

    local data = {connections = {}}

    local billboard = Instance.new("BillboardGui", root)
    billboard.Adornee = root
    billboard.Size = UDim2.new(0, 240, 0, 100)
    billboard.StudsOffset = Vector3.new(0, 5, 0)
    billboard.AlwaysOnTop = true
    local text = Instance.new("TextLabel", billboard)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextStrokeTransparency = 0.3
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.TextYAlignment = Enum.TextYAlignment.Top

    local nameConn = RunService.RenderStepped:Connect(function()
        if not char.Parent then return end
        local dist = (root.Position - (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or Vector3.new())).Magnitude
        local wanted = (char:FindFirstChild("Wanted") or char:FindFirstChild("WantedLevel")) and (char:FindFirstChild("Wanted") or char:FindFirstChild("WantedLevel")).Value or 0
        local col = Color3.fromRGB(255,255,255)
        if char:FindFirstChild("Police") or char.Name:lower():find("police") then col = Color3.fromRGB(0,170,255)
        elseif wanted > 0 then col = Color3.fromRGB(255,60,60) end
        text.TextColor3 = col
        text.Text = string.format("%s%s\n%.0f m\nHP: %d", char.Name, wanted > 0 and (" ★"..wanted) or "", dist, math.floor(hum.Health))
    end)

    data.billboard = billboard
    data.connections.name = nameConn

    local box = Drawing.new("Square")
    box.Thickness = 2.5 box.Filled = false box.Transparency = 1
    local boxConn = RunService.RenderStepped:Connect(function()
        if not (boxEnabled and espEnabled and char.Parent) then box.Visible = false return end
        local rootPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
        if not onScreen then box.Visible = false return end
        local top = workspace.CurrentCamera:WorldToViewportPoint(root.Position + Vector3.new(0, 3, 0))
        local bottom = workspace.CurrentCamera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
        local size = Vector2.new((top.Y - bottom.Y) * 1.6, top.Y - bottom.Y)
        box.Size = size
        box.Position = Vector2.new(rootPos.X - size.X/2, rootPos.Y - size.Y/2 + 10)
        local col = Color3.fromRGB(255,255,255)
        if char:FindFirstChild("Police") or char.Name:lower():find("police") then col = Color3.fromRGB(0,170,255)
        elseif (char:FindFirstChild("Wanted") or char:FindFirstChild("WantedLevel")) and (char:FindFirstChild("Wanted") or char:FindFirstChild("WantedLevel")).Value > 0 then col = Color3.fromRGB(255,60,60) end
        box.Color = col
        box.Visible = true
    end)
    data.box = box data.connections.box = boxConn

    local tracer = Drawing.new("Line")
    tracer.Thickness = 2 tracer.Transparency = 1
    local tracerConn = RunService.RenderStepped:Connect(function()
        if not (tracerEnabled and espEnabled and char.Parent) then tracer.Visible = false return end
        local rootPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
        if not onScreen then tracer.Visible = false return end
        local screenBottom = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
        tracer.From = screenBottom
        tracer.To = Vector2.new(rootPos.X, rootPos.Y)
        local col = Color3.fromRGB(255,255,255)
        if char:FindFirstChild("Police") or char.Name:lower():find("police") then col = Color3.fromRGB(0,170,255)
        elseif (char:FindFirstChild("Wanted") or char:FindFirstChild("WantedLevel")) and (char:FindFirstChild("Wanted") or char:FindFirstChild("WantedLevel")).Value > 0 then col = Color3.fromRGB(255,60,60) end
        tracer.Color = col
        tracer.Visible = true
    end)
    data.tracer = tracer data.connections.tracer = tracerConn

    espObjects[char] = data
end

createToggleSwitch(espPage, "Enable Player ESP (Nametags)", function(state)
    espEnabled = state
    if not state then
        for char in pairs(espObjects) do removeESP(char) end
    else
        for _, plr in game.Players:GetPlayers() do
            if plr ~= player and plr.Character then createFullESP(plr.Character) end
        end
    end
end)

createToggleSwitch(espPage, "Box ESP", function(state) boxEnabled = state end)
createToggleSwitch(espPage, "Tracer ESP", function(state) tracerEnabled = state end)

createButton(espPage, "Remove All ESP", function()
    for char in pairs(espObjects) do removeESP(char) end
end)

game.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        if espEnabled then task.wait(0.6) createFullESP(char) end
    end)
end)

for _, plr in game.Players:GetPlayers() do
    if plr ~= player and plr.Character then
        plr.CharacterAdded:Connect(function(char)
            if espEnabled then task.wait(0.6) createFullESP(char) end
        end)
    end
end

-- ====================== AUTO AIM mit Hit Prediction ======================
local aimbotEnabled = false
local aimbotConnection = nil
local aimPart = "HumanoidRootPart"
local whitelist = {}
local useHitPrediction = true
local useVisibleCheck = true
local useTeamCheck = true

local function isWhitelisted(plr)
    return whitelist[plr.UserId] == true
end

local function isVisible(target)
    if not useVisibleCheck then return true end
    local origin = workspace.CurrentCamera.CFrame.Position
    local direction = (target.Position - origin).Unit * 500
    local ray = Ray.new(origin, direction)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character})
    return hit == nil or hit:IsDescendantOf(target.Parent)
end

local function getPredictedPosition(targetPart)
    if not useHitPrediction or not targetPart.Velocity then return targetPart.Position end
    local distance = (targetPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
    local travelTime = distance / 1500
    return targetPart.Position + targetPart.Velocity * travelTime
end

local function enableAimbot()
    aimbotEnabled = true
    aimbotConnection = RunService.RenderStepped:Connect(function()
        if not aimbotEnabled then return end
        local closest = nil
        local minDist = math.huge
        local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then return end

        for _, plr in game.Players:GetPlayers() do
            if plr ~= player and plr.Character and not isWhitelisted(plr) then
                local targetPart = plr.Character:FindFirstChild(aimPart)
                if targetPart then
                    if useTeamCheck and plr.Team == player.Team then continue end
                    if not isVisible(targetPart) then continue end

                    local predictedPos = getPredictedPosition(targetPart)
                    local dist = (predictedPos - myRoot.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = predictedPos
                    end
                end
            end
        end

        if closest then
            workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, closest)
        end
    end)
end

local function disableAimbot()
    aimbotEnabled = false
    if aimbotConnection then aimbotConnection:Disconnect() aimbotConnection = nil end
end

createToggleSwitch(aimbotPage, "Aimbot", function(s)
    if s then enableAimbot() else disableAimbot() end
end)

createToggleSwitch(aimbotPage, "Hit Prediction", function(state) useHitPrediction = state end)
createToggleSwitch(aimbotPage, "Visible Check", function(state) useVisibleCheck = state end)
createToggleSwitch(aimbotPage, "Team Check", function(state) useTeamCheck = state end)

-- Whitelist
local whitelistLabel = Instance.new("TextLabel", aimbotPage)
whitelistLabel.Size = UDim2.new(1, -28, 0, 30)
whitelistLabel.BackgroundTransparency = 1
whitelistLabel.Text = "Whitelist (Ignorierte Spieler)"
whitelistLabel.TextColor3 = Color3.new(1, 1, 1)
whitelistLabel.Font = Enum.Font.GothamBold
whitelistLabel.TextSize = 18
whitelistLabel.TextXAlignment = Enum.TextXAlignment.Left

local whitelistFrame = Instance.new("ScrollingFrame", aimbotPage)
whitelistFrame.Size = UDim2.new(1, -28, 0, 140)
whitelistFrame.Position = UDim2.new(0, 14, 0, 40)
whitelistFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
whitelistFrame.ScrollBarThickness = 6
Instance.new("UICorner", whitelistFrame).CornerRadius = UDim.new(0, 8)

local function refreshWhitelistUI()
    for _, child in pairs(whitelistFrame:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for _, plr in game.Players:GetPlayers() do
        if plr ~= player then
            local btn = Instance.new("TextButton", whitelistFrame)
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.BackgroundColor3 = whitelist[plr.UserId] and Color3.fromRGB(200, 60, 60) or Color3.fromRGB(55, 55, 90)
            btn.Text = plr.Name .. (whitelist[plr.UserId] and " [WHITELISTED]" or "")
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.GothamSemibold
            btn.TextSize = 16
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.MouseButton1Click:Connect(function()
                whitelist[plr.UserId] = not whitelist[plr.UserId]
                refreshWhitelistUI()
            end)
        end
    end
end

refreshWhitelistUI()
createButton(aimbotPage, "Refresh Whitelist (aktuelle Lobby)", refreshWhitelistUI)

local hotkeyLabel = Instance.new("TextLabel", aimbotPage)
hotkeyLabel.Size = UDim2.new(1, -28, 0, 40)
hotkeyLabel.BackgroundTransparency = 1
hotkeyLabel.Text = "K = Toggle Auto Aim"
hotkeyLabel.TextColor3 = Color3.new(1, 1, 1)
hotkeyLabel.Font = Enum.Font.GothamBold
hotkeyLabel.TextSize = 20
hotkeyLabel.TextXAlignment = Enum.TextXAlignment.Center

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.K then
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then enableAimbot() else disableAimbot() end
        print("Aimbot: " .. (aimbotEnabled and "ON" or "OFF"))
    end
end)

-- ====================== SKINS TAB (nur G36 + Sniper) ======================
local weaponSkins = {
    ["Default"] = nil,
    ["Blood"]   = {primary = "rbxassetid://122271132142798", secondary = "rbxassetid://87911546375139"},
    ["Gold"]    = {primary = "rbxassetid://102006781490148", secondary = "rbxassetid://102006781490148"},
    ["Galaxy"]  = {primary = "rbxassetid://122271132142798", secondary = "rbxassetid://83994660888462"},
    ["Black"]   = {primary = "rbxassetid://122271132142798", secondary = "rbxassetid://122271132142798"},
    ["Devil"]   = {primary = "rbxassetid://81551553428680", secondary = "rbxassetid://81551553428680"},
    ["Ozean"]   = {primary = "rbxassetid://138912737283012", secondary = "rbxassetid://138912737283012"}
}

local currentG36Skin = "Default"
local currentSniperSkin = "Blood"

local function applySkinToTool(tool)
    if not tool or not tool:IsA("Tool") then return end
    local skinData = nil
    local nameLower = tool.Name:lower()

    if nameLower:find("g36") then 
        skinData = weaponSkins[currentG36Skin]
    elseif isSniper(tool) then 
        skinData = weaponSkins[currentSniperSkin]
    end

    if not skinData then return end

    for _, desc in ipairs(tool:GetDescendants()) do
        if desc:IsA("Texture") or desc:IsA("Decal") then
            desc.Texture = skinData.primary
        elseif desc:IsA("MeshPart") then
            desc.TextureID = skinData.primary
        elseif desc:IsA("SpecialMesh") then
            desc.TextureId = skinData.primary
        elseif desc:IsA("SurfaceAppearance") then
            desc.ColorMap = skinData.primary
        end
    end
    print("Skin applied to " .. tool.Name)
end

-- Sofort-Anwendung beim Equip (kein Delay)
local function setupSkinApplier()
    if player.Character then
        for _, child in pairs(player.Character:GetChildren()) do
            if child:IsA("Tool") then
                applySkinToTool(child)
            end
        end
    end

    player.Character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            applySkinToTool(child)
        end
    end)
end

player.CharacterAdded:Connect(function() task.wait(0.3) setupSkinApplier() end)
if player.Character then task.wait(0.3) setupSkinApplier() end

-- G36 Button
local g36Btn = Instance.new("TextButton", skinsPage)
g36Btn.Size = UDim2.new(1, -28, 0, 55)
g36Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 75)
g36Btn.Text = "G36 Skin: Default ▼"
g36Btn.TextColor3 = Color3.new(1, 1, 1)
g36Btn.Font = Enum.Font.GothamSemibold
g36Btn.TextSize = 18
Instance.new("UICorner", g36Btn).CornerRadius = UDim.new(0, 10)
g36Btn.MouseButton1Click:Connect(function()
    local options = {"Default","Blood","Gold","Galaxy","Black","Devil","Ozean"}
    local idx = table.find(options, currentG36Skin) or 1
    idx = (idx % #options) + 1
    currentG36Skin = options[idx]
    g36Btn.Text = "G36 Skin: " .. currentG36Skin .. " ▼"
    if player.Character then 
        for _, t in pairs(player.Character:GetChildren()) do 
            if t:IsA("Tool") and t.Name:lower():find("g36") then applySkinToTool(t) end 
        end 
    end
end)

-- Sniper Button
local sniperBtn = Instance.new("TextButton", skinsPage)
sniperBtn.Size = UDim2.new(1, -28, 0, 55)
sniperBtn.Position = UDim2.new(0, 0, 0, 70)
sniperBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 75)
sniperBtn.Text = "Sniper Skin: Blood ▼"
sniperBtn.TextColor3 = Color3.new(1, 1, 1)
sniperBtn.Font = Enum.Font.GothamSemibold
sniperBtn.TextSize = 18
Instance.new("UICorner", sniperBtn).CornerRadius = UDim.new(0, 10)
sniperBtn.MouseButton1Click:Connect(function()
    local options = {"Default","Blood","Gold","Galaxy","Black","Devil","Ozean"}
    local idx = table.find(options, currentSniperSkin) or 1
    idx = (idx % #options) + 1
    currentSniperSkin = options[idx]
    sniperBtn.Text = "Sniper Skin: " .. currentSniperSkin .. " ▼"
    if player.Character then 
        for _, t in pairs(player.Character:GetChildren()) do 
            if t:IsA("Tool") and isSniper(t) then applySkinToTool(t) end 
        end 
    end
end)

createButton(skinsPage, "Apply Skins Now (aktuelle Waffen)", function()
    if player.Character then
        for _, tool in pairs(player.Character:GetChildren()) do
            if tool:IsA("Tool") then applySkinToTool(tool) end
        end
    end
end)

-- ====================== CROSSHAIR TAB (ersetzt normales Crosshair) ======================
local crosshair = Drawing.new("Circle")
crosshair.Radius = 5
crosshair.Thickness = 2
crosshair.Color = Color3.fromRGB(255, 255, 255)
crosshair.Transparency = 1
crosshair.Filled = false
crosshair.NumSides = 4

local crosshairEnabled = true

-- Normales Roblox Crosshair deaktivieren
game:GetService("UserInputService").MouseIconEnabled = false

local function updateCrosshair()
    if not crosshairEnabled then 
        crosshair.Visible = false 
        return 
    end
    local mousePos = UserInputService:GetMouseLocation()
    crosshair.Position = Vector2.new(mousePos.X, mousePos.Y)
    crosshair.Visible = true
end

RunService.RenderStepped:Connect(updateCrosshair)

createToggleSwitch(crosshairPage, "Enable Custom Crosshair (ersetzt normales)", function(state)
    crosshairEnabled = state
    crosshair.Visible = state
    game:GetService("UserInputService").MouseIconEnabled = not state
end)

local crossColors = {
    {name="White", color=Color3.fromRGB(255,255,255)},
    {name="Red", color=Color3.fromRGB(255,0,0)},
    {name="Green", color=Color3.fromRGB(0,255,0)},
    {name="Cyan", color=Color3.fromRGB(0,255,255)},
    {name="Purple", color=Color3.fromRGB(180,0,255)},
}

for _, preset in ipairs(crossColors) do
    createButton(crosshairPage, "Farbe: " .. preset.name, function() crosshair.Color = preset.color end)
end

createButton(crosshairPage, "Rainbow Crosshair", function()
    spawn(function()
        local hue = 0
        while crosshairEnabled do
            hue = (hue + 0.02) % 1
            crosshair.Color = Color3.fromHSV(hue, 1, 1)
            task.wait(0.05)
        end
    end)
end)

createButton(crosshairPage, "Crosshair + (größer)", function() crosshair.Radius = crosshair.Radius + 2 end)
createButton(crosshairPage, "Crosshair - (kleiner)", function() crosshair.Radius = math.max(2, crosshair.Radius - 2) end)
createButton(crosshairPage, "Thickness +", function() crosshair.Thickness = crosshair.Thickness + 1 end)
createButton(crosshairPage, "Thickness -", function() crosshair.Thickness = math.max(1, crosshair.Thickness - 1) end)

createButton(crosshairPage, "Dot Crosshair", function() crosshair.NumSides = 999 crosshair.Radius = 3 end)
createButton(crosshairPage, "Plus Crosshair", function() crosshair.NumSides = 4 crosshair.Radius = 8 end)

-- ====================== MINIMIZE / CLOSE / HOTKEY ======================
local minimized = false
local originalSize = main.Size

local function toggleMinimize()
    minimized = not minimized
    if minimized then
        TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 340, 0, 52)}):Play()
        content.Visible = false
        minimizeBtn.Text = "+"
    else
        TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {Size = originalSize}):Play()
        task.wait(0.25)
        content.Visible = true
        minimizeBtn.Text = "–"
    end
end

minimizeBtn.MouseButton1Click:Connect(toggleMinimize)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        gui.Enabled = not gui.Enabled
        if gui.Enabled and minimized then toggleMinimize() end
    end
end)

print("✅ Prestige Hub V1 - FINAL VERSION (ohne Crime Gear) geladen!")