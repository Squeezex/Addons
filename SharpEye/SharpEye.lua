-- Check if LibStub, LibDataBroker and LibDBIcon are available
local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LibStub("LibDBIcon-1.0", true)

if not LDB or not LDBIcon then
    print("|cffff0000[SharpEye]|r LibDataBroker or LibDBIcon not found!")
    return
end

-- Set the icon ID (can be changed)
local ICON_ID = "INV_Misc_Eye_01"

-- Setup saved variables for LibDBIcon
SharpEyeDB = SharpEyeDB or {}

-- Create the LDB object
local dataobj = LDB:NewDataObject("SharpEye", {
    type = "data source",
    icon = "Interface\\Icons\\"..ICON_ID,
    label = "SharpEye",
    OnClick = function(self, button)
        -- Toggle the ResampleAlwaysSharpen CVar
        local state = not GetCVarBool("ResampleAlwaysSharpen")
        SetCVar("ResampleAlwaysSharpen", state)

        if state then
            print("|cff00ff00Sharpen enabled|r")
        else
            print("|cffff0000Sharpen disabled|r")
        end
    end,
    OnTooltipShow = function(tooltip)
        tooltip:AddLine("SharpEye")
        tooltip:AddLine("Click: toggle ResampleAlwaysSharpen")
    end,
})

-- Register the icon with LibDBIcon
LDBIcon:Register("SharpEye", dataobj, SharpEyeDB)
