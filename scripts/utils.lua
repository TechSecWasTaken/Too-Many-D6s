local utils = {}

local MAX_ROLL_COUNT = 5000
local itemPool = Game():GetItemPool()
    local itemConfig = Isaac.GetItemConfig()

-- Get items of certain quality. (I DON'T USE THIS ANYMORE, IT TYPICALLY CRASHES MY GAME FOR WHATEVER REASON.)
function utils.ItemOfQuality(minQuality, maxQuality, pool, fallback, removeItems)
    minQuality = minQuality or 0
    maxQuality = maxQuality or 4
    pool = pool or ItemPoolType.POOL_TREASURE
    fallback = fallback or CollectibleType.COLLECTIBLE_BREAKFAST
    removeItems = removeItems or false

    local failCounter = 0
    while failCounter < MAX_ROLL_COUNT do
        local item = itemPool:GetCollectible(pool, removeItems)
        local config = itemConfig:GetCollectible(item)
        if config and config.Quality >= minQuality and config.Quality <= maxQuality then
            return item
        end
        failCounter = failCounter + 1
    end
    return fallback
end

-- I'm using this function cause I really don't want to keep typing "GetItemIdByName", this function is optional.
-- This function is really just a me thing.
function utils.ItemID(name)
    return Isaac.GetItemIdByName(name)
end

-- What this function does is get every item in the game, and store every item of a certain quality in a table.
-- This is used for dices that have the idea of a chaosed pool in mind. Typically cause the ItemOfQuality() function crashes a ton when trying to get from a chaosed pool.
-- DOES NOT GET STORY ITEMS!!!!!!!!
utils.GetChaosQuality = function (minQ, maxQ)
    local items = {}

    for i=1, CollectibleType.NUM_COLLECTIBLES do
        local item = itemConfig:GetCollectible(i)

        if item and item.Quality >= minQ and item.Quality <= maxQ and not item:HasTags(ItemConfig.TAG_QUEST) then
            table.insert(items, i)
        end
    end

    return items
end

-- This grabs all the items that are in a certain tag (i.e. Seraphim, Leviathan, Conjoined, etc...) and puts them in a table.
utils.FindTaggedItems = function (tag)
    local items = {}

    for i=1, CollectibleType.NUM_COLLECTIBLES do
        local item = itemConfig:GetCollectible(i)

        if item and item:HasTags(tag) then
            table.insert(items, i)
        end
    end

    return items
end

-- Finds closest safe pickup position
utils.FindPlayerPickupPositon = function (x,y)
    local pos = Game():GetRoom():FindFreePickupSpawnPosition(Isaac.GetPlayer().Position + Vector(x,y))
    return pos
end

return utils