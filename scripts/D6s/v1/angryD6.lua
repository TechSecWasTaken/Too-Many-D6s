local mod = TooManyD6s
local itemPool = Game():GetItemPool()
local utils = require("scripts.utils")

function mod:useAngryD6()
    local entities = Isaac.GetRoomEntities()

    for _, entity in ipairs(entities) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
            entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemPool:GetCollectible(ItemPoolType.POOL_BOSS), true)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, entity.Velocity, nil)
            itemPool:RemoveCollectible(entity.SubType)
        end
    end
    SFXManager():Play(Isaac.GetSoundIdByName("fleshreroll"))
    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useAngryD6, utils.ItemID("Angry D6"))