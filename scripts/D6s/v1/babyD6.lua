local mod = TooManyD6s
local utils = require("scripts.utils")
local items = utils.FindTaggedItems(ItemConfig.TAG_BABY)

function mod:useBabyD6()
    local entites = Isaac.GetRoomEntities()

    for _, entity in ipairs(entites) do
        local babyRng = math.random(#items)
        local item = babyRng or CollectibleType.COLLECTIBLE_BREAKFAST

        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
            entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, items[item], true)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, entity.Velocity, nil)
            table.remove(items, babyRng)
        end
    end

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useBabyD6, utils.ItemID("Baby D6"))