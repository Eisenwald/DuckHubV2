-- Eğer zaten yüklenmişse çık
if getgenv().duckLoaderLoaded then return end
getgenv().duckLoaderLoaded = true

-- Kısayol referanslar
local TweenService       = cloneRef(game:GetService("TweenService"))
local UserInputService   = cloneRef(game:GetService("UserInputService"))
local CoreGui            = cloneRef(game:GetService("CoreGui"))

-- Ekran öğeleri
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local titleBar  = Instance.new("Frame")
local titleLbl  = Instance.new("TextLabel")
local content   = Instance.new("Frame")

screenGui.Parent   = CoreGui
mainFrame.Parent   = screenGui
mainFrame.Active   = true
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0.5, 0.5, 0)
mainFrame.Size     = UDim2.new(0, 300, 0, 153)
mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
makeDraggable(mainFrame)

-- Başlık çubuğu
titleBar.Parent    = mainFrame
titleBar.Size      = UDim2.new(1, 0, 0, 20)
titleBar.BackgroundColor3 = Color3.fromRGB(15,15,15)
titleBar.BorderSizePixel   = 0

titleLbl.Parent    = titleBar
titleLbl.Size      = UDim2.new(1,0,0,20)
titleLbl.BackgroundTransparency = 1
titleLbl.Font      = Enum.Font.Gotham
titleLbl.Text      = "Duck Hub"
titleLbl.TextColor3= Color3.fromRGB(240,240,240)
titleLbl.TextSize  = 13

-- İçerik alanı
content.Parent     = mainFrame
content.Position   = UDim2.new(0,5,0,25)
content.Size       = UDim2.new(0.965,0,0.793,0)
content.BackgroundTransparency = 1

-- Köşe yuvarlama ekleyen yardımcı fonksiyon
function addCorner(instance, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 4)
    c.Parent       = instance
end

-- Tween animasyonu fonksiyonu
function tween(obj, props, onComplete)
    local info = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local t    = TweenService:Create(obj, info, props)
    t.Completed:Connect(onComplete or function() end)
    t:Play()
end

-- Sürükleme desteği
function makeDraggable(frame)
    local dragging, dragInput, dragStart, frameStart
    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1) then
            dragging = true
            dragStart = input.Position
            frameStart = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                frameStart.X.Scale, frameStart.X.Offset + delta.X,
                frameStart.Y.Scale, frameStart.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                frameStart.X.Scale, frameStart.X.Offset + delta.X,
                frameStart.Y.Scale, frameStart.Y.Offset + delta.Y
            )
        end
    end)
end

-- Oyun yerinde çalıştırılacak URL kontrolü
local function isSupportedPlace()
    local id = game.PlaceId
    return (id == 17625359962 or id == 71874690745115 or id == 117398147513099)
end

-- Yükleyiciyi çağıran fonksiyon
local function loadDuckHub()
    if not isSupportedPlace() then return end
    -- Burada doğrudan loader URL’sini çağırıyoruz; eskiden key kontrolü vardı, kaldırıldı.
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e35dfe3721a4a57029cc101d8ec43cbe.lua"))()
end

-- Ana yükleme
loadDuckHub()