--------------------------------------------------------------------------------
-- Bartender3 TotemTwist (c) 2013 by Siarkowy
-- Released under the terms of BSD 2.0 license.
--------------------------------------------------------------------------------

assert(Bartender3, "TotemTwist requires Bartender3 to work.")

local Twist = CreateFrame("Frame", "Bar3TotemTwistFrame")
local GetTime = GetTime

local WF_DURATION = 10
local WF_TEXTURE  = [[Interface\Icons\Spell_Nature_Windfury]]

local lastwf = 0

hooksecurefunc(Bartender3.Class.Button.prototype, "UpdateCooldown", function(self)
    if self.frame.tex == WF_TEXTURE and GetTime() - lastwf < WF_DURATION then
        CooldownFrame_SetTimer(self.frame.cooldown, lastwf, WF_DURATION, 1)
    end
end)

Twist:SetScript("OnEvent", function(self, event, unit, spell)
    if unit == "player" and spell == "Windfury Totem" then
        lastwf = GetTime()
    end
end)

Twist:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
