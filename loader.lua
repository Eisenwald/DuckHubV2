-- Tekrarlı yüklemeyi engelle
if getgenv().duckLoaderLoaded then
    return
end
getgenv().duckLoaderLoaded = true

-- Desteklenen oyun yerlerini kontrol eden yardımcı
local function isSupportedPlace()
    local id = game.PlaceId
    return id == 17625359962
        or id == 71874690745115
        or id == 117398147513099
end

-- Yükleyiciyi çağır
if isSupportedPlace() then
    local url = "https://api.luarmor.net/files/v3/loaders/e35dfe3721a4a57029cc101d8ec43cbe.lua"
    local resp = game:HttpGet(url)
    loadstring(resp)()
end
