local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:EvaluateCache()
    if Isaac:GetPlayer():HasCollectible(utils.ItemID("Mr.Beast Burger")) then
        Isaac:GetPlayer():AddCoins(-999)
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)