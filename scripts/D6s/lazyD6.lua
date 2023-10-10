local mod = TooManyD6s
local utils = require("scripts.utils")
local itemPool = Game():GetItemPool()
local items = utils.GetChaosQuality(3,4)

function mod:useLazyD6()
    local entities = Isaac.GetRoomEntities()
    local itemsExist = false
    
    for _, entity in ipairs(entities) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
            entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, items[math.random(1,#items)], true)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
            itemsExist = true
        end
    end

    if itemsExist then
        Isaac.GetPlayer().ShotSpeed = Isaac.GetPlayer().ShotSpeed - 0.05
    end

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useLazyD6, utils.ItemID("Lazy D6"))