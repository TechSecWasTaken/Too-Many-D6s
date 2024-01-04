local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useDeathD6()
    local entities = Isaac:GetRoomEntities()

    for _, entity in ipairs(entities) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and (entity.SubType ~= 0 and entity.SubType ~= 668) then
            local random = math.random(1,100)
            
            if random > 0 and random < 6 + (1 * Isaac.GetPlayer().Luck) then
                entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 628, true)
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
            elseif random > 5 + (1*Isaac.GetPlayer().Luck) and random < 101 + (1 * Isaac.GetPlayer().Luck) then
                entity:Remove()
            end
        end
    end
    
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useDeathD6, utils.ItemID("Death D6"))