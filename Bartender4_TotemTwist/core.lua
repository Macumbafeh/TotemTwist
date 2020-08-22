--------------------------------------------------------------------------------
-- Bartender4 TotemTwist (c) 2020 by Siarkowy
-- Released under the terms of BSD 2.0 license.
--------------------------------------------------------------------------------

assert(Bartender4, "TotemTwist requires Bartender4 to work.")

local Twist = CreateFrame("Frame", "Bar4TotemTwistFrame")
local GetTime = GetTime

local WF_DURATION = 10
local WF_TEXTURE  = [[Interface\Icons\Spell_Nature_Windfury]]

local lastwf = 0

hooksecurefunc(Bartender4.Button.prototype, "UpdateCooldown", function(self)
    if self.iconTex == WF_TEXTURE and GetTime() - lastwf < WF_DURATION then
        CooldownFrame_SetTimer(self.cooldown, lastwf, WF_DURATION, 1)
    end
end)

Twist:SetScript("OnEvent", function(self, event, unit, spell)
    if unit == "player" and spell == "Windfury Totem" then
        lastwf = GetTime()
    end
end)

Twist:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
