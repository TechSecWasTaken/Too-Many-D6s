local mod = TooManyD6s
local itemPool = Game():GetItemPool()
local utils = require("scripts.utils")

function mod:useAngelicD6()
    local entities = Isaac.GetRoomEntities()
    
    for _, entity in ipairs(entities) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
            entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemPool:GetCollectible(ItemPoolType.POOL_ANGEL), true)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
            itemPool:RemoveCollectible(entity.SubType)
        end
    end

    SFXManager():Play(SoundEffect.SOUND_SUPERHOLY)
    
    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useAngelicD6, utils.ItemID("Angelic D6"))

if not EID then return end

EID:addCollectible(utils.ItemID("Angelic D6"), "{{AngelRoom}} Rerolls any pedestal item in the room into a pedestal item from the Angel Room pool.", "Angelic D6", "en_us")