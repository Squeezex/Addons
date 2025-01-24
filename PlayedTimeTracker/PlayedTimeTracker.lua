-- Addon name and namespace
local Overall_Played, addonTable = ...

-- Table to store playtime data
PlayedTimeTrackerDB = PlayedTimeTrackerDB or {}

-- Event frame
local frame = CreateFrame("Frame")

-- Utility function to format time
local function FormatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    return string.format("%dd %dh %dm", days, hours, minutes)
end

-- Function to update and save playtime
local function UpdatePlaytime()
    -- Request playtime information
    RequestTimePlayed()
end

-- Function to calculate total playtime across all characters
local function GetOverallPlaytime()
    local total = 0
    for _, playtime in pairs(PlayedTimeTrackerDB) do
        total = total + playtime
    end
    return total
end

-- Slash command handler
local function HandleSlashCommands(msg)
    if msg == "played" then
        UpdatePlaytime()
    elseif msg == "overallplayed" then
        local overallTime = GetOverallPlaytime()
        print("Total playtime across all characters: " .. FormatTime(overallTime))
    else
        print("Commands:\n/played - Show playtime for this character\n/overallplayed - Show total playtime across all characters")
    end
end

-- Event handler
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "TIME_PLAYED_MSG" then
        local totalTimePlayed = ...

        -- Save playtime for the current character
        local characterKey = UnitName("player") .. " - " .. GetRealmName()
        PlayedTimeTrackerDB[characterKey] = totalTimePlayed

        print("Playtime for " .. characterKey .. ": " .. FormatTime(totalTimePlayed))
    elseif event == "PLAYER_LOGIN" then
        print("PlayedTimeTracker loaded. Use /played to check playtime or /overallplayed for total playtime.")
    end
end)

-- Register events
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("TIME_PLAYED_MSG")

-- Register slash commands
SLASH_PLAYEDTIMETRACKER1 = "/played"
SLASH_PLAYEDTIMETRACKER2 = "/overallplayed"
SlashCmdList["PLAYEDTIMETRACKER"] = HandleSlashCommands