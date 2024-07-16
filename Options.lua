Sharpness.defaults = {
	sessions = 0,
	hello = false,
	mushroom = false,
}

local function CreateIcon(icon, width, height, parent)
	local f = CreateFrame("Frame", nil, parent)
	f:SetSize(width, height)
	f.tex = f:CreateTexture()
	f.tex:SetAllPoints(f)
	f.tex:SetTexture(icon)
	return f
end

function Sharpness:CreateCheckbox(option, label, parent, updateFunc)
	local cb = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
	cb.Text:SetText(label)
	local function UpdateOption(value)
		self.db[option] = value
		cb:SetChecked(value)
		if updateFunc then
			updateFunc(value)
		end
	end
	UpdateOption(self.db[option])
	-- there already is an existing OnClick script that plays a sound, hook it
	cb:HookScript("OnClick", function(_, btn, down)
		UpdateOption(cb:GetChecked())
	end)
	EventRegistry:RegisterCallback("Sharpness.OnReset", function()
		UpdateOption(self.defaults[option])
	end, cb)
	return cb
end

function Sharpness:InitializeOptions()
	-- main panel
	self.panel_main = CreateFrame("Frame")
	self.panel_main.name = "Sharpness"

	local cb_mushroom = self:CreateCheckbox("mushroom", "Show a mushroom on your screen", self.panel_main, self.UpdateIcon)
	cb_mushroom:SetPoint("TOPLEFT", cb_hello, 0, -30)

	InterfaceOptions_AddCategory(Sharpness.panel_main)

	-- sub panel
	local panel_shroom = CreateFrame("Frame")
	panel_shroom.name = "Shrooms"
	panel_shroom.parent = self.panel_main.name

	for i = 1, 10 do
		local icon = CreateIcon("interface/icons/inv_mushroom_11", 32, 32, panel_shroom)
		icon:SetPoint("TOPLEFT", 20, -32*i)
	end

	InterfaceOptions_AddCategory(panel_shroom)
end

function Sharpness.UpdateIcon(value)
	if not Sharpness.mushroom then
		Sharpness.mushroom = CreateIcon("interface/icons/inv_mushroom_11", 64, 64, UIParent)
		Sharpness.mushroom:SetPoint("CENTER")
	end
	Sharpness.mushroom:SetShown(value)
end

-- a bit more efficient to register/unregister the event when it fires a lot
function Sharpness:UpdateEvent(value, event)
	if value then
		self:RegisterEvent(event)
	else
		self:UnregisterEvent(event)
	end
end
