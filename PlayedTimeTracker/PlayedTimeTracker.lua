-- Addon namespace
local frame = CreateFrame("Frame")

-- Format time into hours, minutes, seconds
local function FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%dh %dm %ds", hours, minutes, secs)
end

-- Get total playtime across all characters
local function GetOverallPlaytime()
    local total = 0
    for character, time in pairs(PlayedTimeTrackerDB) do
        print("DEBUG: Adding playtime for " .. character .. ": " .. time .. " seconds.")
        total = total + time
    end
    return total
end

-- Slash command handler
local function HandleSlashCommands(msg)
    msg = string.lower(msg or "") -- Normalize input to lowercase and handle nil cases

    if msg == "played" or msg == "" then
        -- Handle /played command for this character
        print("Checking playtime for this character...")
        RequestTimePlayed() -- Requests playtime (triggers TIME_PLAYED_MSG)
    elseif msg == "overallplayed" then
        -- Handle /overallplayed command for all characters
        if next(PlayedTimeTrackerDB) == nil then
            print("No playtime data available. Log in with your characters to record their playtime.")
        else
            local overallTime = GetOverallPlaytime()
            print("Total playtime across all characters: " .. FormatTime(overallTime))
        end
    else
        -- Show help text for invalid commands
        print("Commands:\n/played - Show playtime for this character\n/overallplayed - Show total playtime across all characters")
    end
end

-- Event handler for playtime updates
local function OnEvent(self, event, ...)
    if event == "TIME_PLAYED_MSG" then
        -- Get total playtime for this character
        local totalTimePlayed = ...
        local characterKey = UnitName("player") .. " - " .. GetRealmName()

        -- Save to database
        if not PlayedTimeTrackerDB then
            PlayedTimeTrackerDB = {}
        end

        PlayedTimeTrackerDB[characterKey] = totalTimePlayed
        print("Playtime for " .. characterKey .. ": " .. FormatTime(totalTimePlayed))
    elseif event == "PLAYER_LOGIN" then
        -- Initialize database if it doesn't exist
        PlayedTimeTrackerDB = PlayedTimeTrackerDB or {}
        print("PlayedTimeTracker loaded. Commands registered: /played, /overallplayed.")
    end
end

-- Register events and commands
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("TIME_PLAYED_MSG")
frame:SetScript("OnEvent", OnEvent)

-- Register slash commands
SLASH_PLAYEDTIMETRACKER1 = "/played"
SLASH_PLAYEDTIMETRACKER2 = "/overallplayed"
SlashCmdList["PLAYEDTIMETRACKER"] = HandleSlashCommands
