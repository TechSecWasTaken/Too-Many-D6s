local mod = TooManyD6s
local utils = require("scripts.utils")
local itemPool = Game():GetItemPool()

function mod:useKeepersD6()
    local entities = Isaac.GetRoomEntities()

    for _, entity in ipairs(entities) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
            entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemPool:GetCollectible(ItemPoolType.POOL_SHOP), true)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
            itemPool:RemoveCollectible(entity.SubType)
        end
    end
    SFXManager():Play(SoundEffect.SOUND_LUCKYPICKUP)
    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useKeepersD6, utils.ItemID("Keeper's D6"))