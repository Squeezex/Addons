Sharpness = CreateFrame("Frame")

function Sharpness:OnEvent(event, ...)
	self[event](self, event, ...)
end

function Sharpness:ADDON_LOADED(event, Sharpness)
	print(event, Sharpness)
end

function Sharpness:PLAYER_ENTERING_WORLD(event, isLogin, isReload)
	print(event, isLogin, isReload)
end

Sharpness:RegisterEvent("ADDON_LOADED")
Sharpness:RegisterEvent("PLAYER_ENTERING_WORLD")
Sharpness:SetScript("OnEvent", Sharpness.OnEvent)

SLASH_SHARPNESS1 = "/son"
SLASH_SHARPNESS2 = "/soff"

SlashCmdList.SHARPNESS = function(msg, editBox)
	InterfaceOptionsFrame_OpenToCategory(Sharpness.panel_main)
end







-- local f = CreateFrame("Frame", nil, UIParent)
f:SetPoint("CENTER")
f:SetSize(64, 64)

f.tex = f:CreateTexture()
f.tex:SetAllPoints(f)
f.tex:SetTexture("interface/icons/inv_mushroom_11")

Sharpness = CreateFrame("Frame")

function Sharpness:OnEvent(event, ...)
	self[event](self, event, ...)
end
Sharpness:SetScript("OnEvent", Sharpness.OnEvent)
Sharpness:RegisterEvent("ADDON_LOADED")

function Sharpness:ADDON_LOADED(event, addOnName)
	if addOnName == "Sharpness" then
		SharpnessDB = SharpnessDB or {}
		self.db = SharpnessDB
		for k, v in pairs(self.defaults) do
			if self.db[k] == nil then
				self.db[k] = v
			end
		end
		self.db.sessions = self.db.sessions + 1
		print("You loaded this addon "..self.db.sessions.." times")

		local version, build, _, tocversion = GetBuildInfo()
		print(format("The current WoW build is %s (%d) and TOC is %d", version, build, tocversion))

		self:InitializeOptions()
		self:UnregisterEvent(event)
	end
end
function SomeObject:SlashHandler(msg, editBox)
    SetCVar("ResampleAlwaysSharpen", not GetCVarBool("ResampleAlwaysSharpen"));
end
SLASH_SHARP1 = "/son"
SlashCmdList["SHARP"] = function(msg, editBox)
    SomeObject:SlashHandler(msg, editBox)
end