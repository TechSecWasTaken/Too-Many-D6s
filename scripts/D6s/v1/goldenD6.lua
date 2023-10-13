local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useGoldenD6()
    local entities = Isaac.GetRoomEntities()
    local itemPool = Game():GetItemPool()

    for _, entity in ipairs(entities) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
            local item = utils.GetChaosQuality(3,4)
            entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, item, true)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
            itemPool:RemoveCollectible(entity.SubType)
        end
    end
    SFXManager():Play(Isaac.GetSoundIdByName("goldreroll"))
    Isaac.GetPlayer():AddBrokenHearts(2)
    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useGoldenD6, utils.ItemID("Golden D6"))