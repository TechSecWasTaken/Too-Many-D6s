local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useGlassD6(type, rng, player)
    rng=math.random(1,5)
    if rng == 5 then
        player:RemoveCollectible(utils.ItemID("Glass D6"))
        player:TakeDamage(1, DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(player), 0)
        SFXManager():Play(SoundEffect.SOUND_GLASS_BREAK)
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 1, player.Position, Vector(0,0), nil)
        player:RemoveCollectible(type)
        player:AnimateSad()
    else
        player:UseActiveItem(CollectibleType.COLLECTIBLE_D6)
        player:AnimateHappy()
    end

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useGlassD6, utils.ItemID("Glass D6"))