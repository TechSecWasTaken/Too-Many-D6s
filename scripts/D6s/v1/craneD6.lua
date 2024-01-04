local mod = TooManyD6s
local utils = require("scripts.utils")
local itemPool = Game():GetItemPool()

function mod:useCraneD6()
    local entities = Isaac.GetRoomEntities()
    local itemsExist = false

    for _, entity in ipairs(entities) do
        if Isaac.GetPlayer():GetNumCoins() >= 5 then
            if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
                entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemPool:GetCollectible(ItemPoolType.POOL_CRANE_GAME), true)
                itemPool:RemoveCollectible(entity.SubType)
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
                itemsExist = true
            end
        end
    end

    if itemsExist then Isaac.GetPlayer():AddCoins(-5) end
    
    SFXManager():Play(SoundEffect.SOUND_COIN_SLOT)
    
    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useCraneD6, utils.ItemID("Crane D6"))
