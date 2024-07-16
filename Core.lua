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

		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		hooksecurefunc("JumpOrAscendStart", self.JumpOrAscendStart)

		self:InitializeOptions()
		self:UnregisterEvent(event)
	end
end

function Sharpness:PLAYER_ENTERING_WORLD(event, isLogin, isReload)
	if isLogin and self.db.hello then
		DoEmote("HELLO")
	end
end

SLASH_SHARPNESS1 = "/son"
SLASH_SHARPNESS2 = "/soff"

SlashCmdList.SHARPNESS = function(msg, editBox)
	InterfaceOptionsFrame_OpenToCategory(Sharpness.panel_main)
end