local mod = TooManyD6s
local utils = require("scripts.utils")
local itemCap = 20
local items = {}
local pedestalAmt = 0

function mod:useGlitchedD6()
    local entities = Isaac.GetRoomEntities()
    local curRoom = Game():GetRoom()
    local itemPool = Game():GetItemPool()

    if items[curRoom] == nil then
        items[curRoom] = {}
    end

    for i=1, #entities do
        if entities[i].Type == EntityType.ENTITY_PICKUP and entities[i].Variant == PickupVariant.PICKUP_COLLECTIBLE and entities[i].SubType ~= 0 and entities[i].SubType ~= 668 then
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entities[i].Position, entities[i].Velocity, nil)
            pedestalAmt = pedestalAmt + 1
        end
    end

    for i=1, pedestalAmt do
        local newVar = "pedestal"..i
        items[curRoom][newVar] = {}
        for i=1, itemCap do
            table.insert(items[curRoom][newVar], itemPool:GetPoolForRoom(Game():GetRoom():GetType(), Game():GetSeeds():GetStartSeed()))
        end
    end

    return true
end

function mod:switchItemShit()
    local entities = Isaac.GetRoomEntities()
    local curRoom = Game():GetRoom()
    local timer = 0
    local switchSpeed = 1

    if items[curRoom] == nil then return end

    for i=1, pedestalAmt do
        if entities[i].Type == EntityType.ENTITY_PICKUP and entities[i].Variant == PickupVariant.PICKUP_COLLECTIBLE and entities[i].SubType ~= 0 and entities[i].SubType ~= 668 then
            entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, items[curRoom]["pedestal"..i][i], true)
            while not timer > switchSpeed do
                timer = timer + 1
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useGlitchedD6, utils.ItemID("Glitched D6"))
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.switchItemShit)