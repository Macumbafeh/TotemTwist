--------------------------------------------------------------------------------
-- Blizz TotemTwist (c) 2013 by Siarkowy
-- Released under the terms of BSD 2.0 license.
--------------------------------------------------------------------------------

local Twist = CreateFrame("Frame", "BlizzTotemTwistFrame")
local GetTime = GetTime

local WF_DURATION = 10
local WF_TEXTURE  = [[Interface\Icons\Spell_Nature_Windfury]]

local lastwf = 0

hooksecurefunc("ActionButton_UpdateCooldown", function()
    local name = this:GetName()
    local icon = _G[name .. "Icon"]
    local cooldown = _G[name .. "Cooldown"]

    if icon and cooldown and icon:GetTexture() == WF_TEXTURE
        and GetTime() - lastwf < WF_DURATION then

        CooldownFrame_SetTimer(cooldown, lastwf, WF_DURATION, 1)
    end
end)

-- A dirty hack for cast sequence macros.
hooksecurefunc("ActionButton_Update", ActionButton_UpdateCooldown)

Twist:SetScript("OnEvent", function(self, event, unit, spell)
    if unit == "player" and spell == "Windfury Totem" then
        lastwf = GetTime()
    end
end)

Twist:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
