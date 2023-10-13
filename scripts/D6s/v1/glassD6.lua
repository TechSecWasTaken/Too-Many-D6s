local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useGlassD6(player, rng)
    rng = math.random(1, 5)
    if rng == 5 then
        player:TakeDamage(2, DamageFlag.DAMAGE_RED_HEARTS, EntityRef(player), 0)
        SFXManager():Play(SoundEffect.SOUND_GLASS_BREAK)
        player:AnimateSad()
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 1, player.Position, Vector(0,0), nil)
        player:RemoveCollectible(utils.ItemID("Glass D6"))
    else
        player:UseActiveItem(CollectibleType.COLLECTIBLE_D6)
        SFXManager():Play(SoundEffect.SOUND_THUMBSUP)
    end

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useGlassD6, utils.ItemID("Glass D6"))