HeadSize = 8

local old;
old = hookfunction(getrawmetatable(game).__namecall,function(...)
    local args = {...}
    if getnamecallmethod() == "FireServer" and typeof(args[3]) == "Vector3" then
        args[3] = Vector3.new(2,1,1)
        args[5] = 16
        return old(unpack(args))
    end
    return old(...)
end)

game:GetService("RunService").Stepped:Connect(function()
    local plrs = game.Players:GetPlayers()
    for i = 2, #plrs do local v = plrs[i]
        if v:FindFirstChild("team") and v.team.Value ~= game.Players.LocalPlayer.team.Value then
            pcall(function()
                v.Character.Head.Size = Vector3.new(HeadSize,HeadSize,HeadSize)
                v.Character.Head.CanCollide = false
                v.Character.Head.Massless = true
                v.Character.Head.Transparency = 0.7
                v.Character.Head.CFrame = v.Character.Torso.CFrame * CFrame.new(0,HeadSize/2,0)
            end)
        end
    end
end)

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/SkiddDev/Scripts/main/woah.lua"))()
ESP.Overrides.GetTeam = function(p)
    return p:FindFirstChild("team") and p.team.Value
end
ESP.Overrides.GetColor = function(char)
    local p = ESP:GetPlrFromChar(char)
    if p then
        local team = ESP:GetTeam(p)
        if team then
            return team == "blue" and Color3.new(0,0,1) or Color3.new(1,0,0)
        end
    end
    return nil
end
ESP:Toggle(true)
ESP.Names = true
ESP.Boxes = true
