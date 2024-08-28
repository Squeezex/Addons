-- Function to open Engineering profession
local function OpenEngineering()
    CastSpellByName("Engineering")
end

-- Function to activate Nitro Boost from waist (slot 6)
local function ApplyNitroBoost()
    -- Use the item in the waist slot (slot 6)
    UseInventoryItem(6)
end

-- Function to activate Goblin Glider from cloak (slot 15)
local function ApplyGlider()
    -- Use the item in the back slot (slot 15)
    UseInventoryItem(15)
end

-- Registering the slash command for Nitro Boost
SLASH_NITROBOOST1 = "/boost"
SlashCmdList["BOOST"] = function()
    -- Open Engineering and apply Nitro Boost
    OpenEngineering()
    ApplyNitroBoost()
end

-- Registering the slash command for Glider
SLASH_GLIDER1 = "/glider"
SlashCmdList["GLIDER"] = function()
    -- Open Engineering and apply Glider
    OpenEngineering()
    ApplyGlider()
end
