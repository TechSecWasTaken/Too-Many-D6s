local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useRockCube()
    local entities = Isaac.GetRoomEntities()

    for _, entity in ipairs(entities) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
            entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_SMALL_ROCK, true)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
        end
    end
    SFXManager():Play(SoundEffect.SOUND_ROCK_CRUMBLE)
    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useRockCube, utils.ItemID("rock cube"))