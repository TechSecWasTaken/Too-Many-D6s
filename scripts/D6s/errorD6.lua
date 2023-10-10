local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useErrorD6(player)
    player = Isaac.GetPlayer()
    local hastrainer = player:HasCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
    if hastrainer then
        player:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_D6)
        player:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
        SFXManager():Play(SoundEffect.SOUND_EDEN_GLITCH)
    else
        player:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_D6)
        player:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
        SFXManager():Play(SoundEffect.SOUND_EDEN_GLITCH)
    end

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useErrorD6, utils.ItemID("Error D6"))