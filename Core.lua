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
		print("You loaded Sharpness addon "..self.db.sessions.." times")

		self:InitializeOptions()
		self:UnregisterEvent(event)
	end
end

-- InterfaceOptionsFrame_OpenToCategory(Sharpness.panel_main)
SLASH_SHARPNESS1 = "/sharp"
SLASH_SHARPNESS2 = "/son"

SlashCmdList.SHARPNESS = function(msg, editBox)

	SetCVar("ResampleAlwaysSharpen", not GetCVarBool("ResampleAlwaysSharpen"));
	
end