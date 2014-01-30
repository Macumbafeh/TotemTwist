--------------------------------------------------------------------------------
-- Bongos2 TotemTwist (c) 2013 by Siarkowy
-- Released under the terms of BSD 2.0 license.
--------------------------------------------------------------------------------

assert(Bongos, "TotemTwist requires Bongos to work.")

local Twist = CreateFrame("Frame", "BongosTotemTwistFrame")
local GetTime = GetTime

local WF_DURATION = 10
local WF_TEXTURE  = [[Interface\Icons\Spell_Nature_Windfury]]

local lastwf = 0

hooksecurefunc(BongosActionButton, "UpdateCooldown", function(self)
    if self.icon:GetTexture() == WF_TEXTURE and GetTime() - lastwf < WF_DURATION then
        CooldownFrame_SetTimer(self.cooldown, lastwf, WF_DURATION, 1)
    end
end)

Twist:SetScript("OnEvent", function(self, event, unit, spell)
    if unit == "player" and spell == "Windfury Totem" then
        lastwf = GetTime()
    end
end)

Twist:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
