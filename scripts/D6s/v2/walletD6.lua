local mod = TooManyD6s
local utils = require("scripts.utils")
local curLevel

function mod:useWalletD6()
    if Isaac.GetPlayer():HasCollectible(CollectibleType.COLLECTIBLE_DEEP_POCKETS) then
        Isaac.GetPlayer():AddCoins(-999)
        Isaac.GetPlayer():AddCoins(math.random(1,999))
    else
        Isaac.GetPlayer():AddCoins(-999)
        Isaac.GetPlayer():AddCoins(math.random(1,99))
    end

    return true
end

function mod:LMAO_YOURE_BROKE_AS_FUCK()
    if Game():GetLevel() ~= curLevel and Isaac.GetPlayer():HasCollectible(utils.ItemID("Wallet D6")) then
        Isaac.GetPlayer():AddCoins(-999)
        Isaac.GetPlayer():QueueExtraAnimation("Sad")

        if Isaac.GetPlayer():IsExtraAnimationFinished() then
            SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
        end
        
        curLevel = Game():GetLevel()
    end
end

function mod:GetStartFloorShit(IsContinued)
    if not IsContinued then
        curLevel = Game():GetLevel()
    end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.GetStartFloorShit)
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.LMAO_YOURE_BROKE_AS_FUCK)
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useWalletD6, utils.ItemID("Wallet D6"))