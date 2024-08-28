-- Function to open Engineering profession
local function OpenEngineering()
    CastSpellByName("Engineering")
end

-- Registering the slash command for Nitro Boost prompt
SLASH_NITROBOOST1 = "/nitroboost"
SlashCmdList["NITROBOOST"] = function()
    OpenEngineering()
    print("Use your Nitro Boost with your macro or manual activation!")
end

-- Registering the slash command for Glider prompt
SLASH_GLIDER1 = "/glider"
SlashCmdList["GLIDER"] = function()
    OpenEngineering()
    print("Use your Goblin Glider with your macro or manual activation!")
end
