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

SLASH_SHARPNESS1 = "/son"
SLASH_SHARPNESS2 = "/soff"

SlashCmdList.SHARPNESS = function(msg, editBox)
	InterfaceOptionsFrame_OpenToCategory(Sharpness.panel_main)
end