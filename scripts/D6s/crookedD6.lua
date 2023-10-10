local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useCrookedD6()
    local entities = Isaac:GetRoomEntities()
    local rng = math.random(0, 1)
    local playerPos = Isaac.GetPlayer().Position
    local collectiblesExist = false

    local PickupVariantShit = {PickupVariant.PICKUP_BOMB, PickupVariant.PICKUP_BOMBCHEST, PickupVariant.PICKUP_CHEST, PickupVariant.PICKUP_COIN, PickupVariant.PICKUP_ETERNALCHEST, PickupVariant.PICKUP_COLLECTIBLE, PickupVariant.PICKUP_GRAB_BAG, PickupVariant.PICKUP_KEY, PickupVariant.PICKUP_TAROTCARD, PickupVariant.PICKUP_TAROTCARD, PickupVariant.PICKUP_HEART, PickupVariant.PICKUP_MIMICCHEST, PickupVariant.PICKUP_MEGACHEST}

    if rng == 0 then -- Delete all items and spawn Dice Shard
        for _, entity in ipairs(entities) do
            if entity.Type == EntityType.ENTITY_PICKUP and entity.SubType ~= 0 then
                for _, itemVariant in ipairs(PickupVariantShit) do
                    if entity.Variant == itemVariant then
                        entity:Remove()
                        collectiblesExist = true
                        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
                    end
                end
            end
        end

        if collectiblesExist then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_DICE_SHARD, Game():GetRoom():FindFreePickupSpawnPosition(playerPos + Vector(0,40)), Vector(0,0), nil)
        end
    else -- Duplicate and Reroll
        for _, entity in ipairs(entities) do
            if entity.Type == EntityType.ENTITY_PICKUP and entity.SubType ~= 0 and entity.SubType ~= 668 then
                for _, itemVariant in ipairs(PickupVariantShit) do
                    if entity.Variant == itemVariant then
                        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, entity.SubType, Game():GetRoom():FindFreePickupSpawnPosition(playerPos + Vector(0,40)), Vector(0,0), nil)
                        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
                    end
                end
            end
        end
        Isaac.GetPlayer():UseActiveItem(CollectibleType.COLLECTIBLE_D6)
    end

    if rng == 0 then
        SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
    else
        SFXManager():Play(SoundEffect.SOUND_THUMBSUP)
    end
    
    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useCrookedD6, utils.ItemID("Crooked D6"))