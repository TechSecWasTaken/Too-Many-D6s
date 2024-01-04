local mod = TooManyD6s
local utils = require("scripts.utils")

local pow = Isaac.GetSoundIdByName("pow pow")
local click = Isaac.GetSoundIdByName("click")

local items = utils.GetChaosQuality(4,4)

function mod:useGun()
    local rng = math.random(1,6)

    if rng == 1 then
        SFXManager():Play(pow)
        Isaac.GetPlayer():Die()
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 1, Isaac.GetPlayer().Position, Vector(0,0), nil)
        Game():ShakeScreen(20)
    else
        local item = math.random(1,#items)
        
        SFXManager():Play(click)
        
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, items[item], Game():GetRoom():FindFreePickupSpawnPosition(Isaac.GetPlayer().Position + Vector(0,-40)), Vector(0,0), nil)
        
        for i=1, #items do
            if item == items[i] then
                table.remove(items, items[i])
                return true
            end
        end
    end

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useGun, utils.ItemID("Russian Roulette"))