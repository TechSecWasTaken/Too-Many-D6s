local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useGlitchedD6()
    for i=1, Game():GetNumPlayers() do
        if Isaac.GetPlayer(i):HasCollectible(utils.ItemID("Glitched D6")) then
            Isaac.GetPlayer(i):AddCollectible(CollectibleType.COLLECTIBLE_GLITCHED_CROWN)
            Isaac.GetPlayer(i):UseActiveItem(CollectibleType.COLLECTIBLE_D6)
            Isaac.GetPlayer(i):RemoveCollectible(CollectibleType.COLLECTIBLE_GLITCHED_CROWN)
        end
    end

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useGlitchedD6, utils.ItemID("Glitched D6"))