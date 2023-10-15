-- Created by Chara (@Tuenai1 on Twitch & Twitter - https://www.twitch.tv/tuenai1 & https://twitter.com/Chara_Mads)
-- Inspired by TechSecTV's (@techsecballer on youtube - https://www.youtube.com/channel/UC-UDHiqZp5goqCzylXWq9Rg) Too Many D6s mod, also thanks to them for the occasional help
-- All of the code for rerolling an item is courtesy of the "Too Many D6's" mod, I yoinked it straight from the main.lua file :D (upon further investigation the file i got my hands on was the OLD file so... yk)
-- i dont actually own the binding of isaac so this will not go on steam as a standalone mod
-- this is my SECOND ever fully functional mod so ignore how sloppy and inefficient and overall SHIT it is
-- i like the green color of comments so they're literally fucking everywhere hahaha

local mod = TooManyD6s

local diceSet = Isaac.GetItemIdByName("Dice Set")

-- dice values
local rN1 = 0
local rN2 = 0
local rN3 = 0
local rN4 = 0
local rN5 = 0
local total = 0

local i = 0 -- sum of previous damage increases
local ii = 0 -- sum of previous range increases
local iii = 0 -- sum of previous tears increases

local thirtyy1 = 0 -- used for thirty roll stat buff
local thirtyy2 = 0 -- used for thirty roll stat buff

local twentytotwentyfivee1 = 0 -- used for 2nd stat buff
local twentytotwentyfivee2 = 0 -- used for 2nd stat buff
local totall = 0 -- used for 2nd stat buff

local yhatzee1 = 0 -- used for stopping the other function when it's a yahtzee

local largestraight1 = 0 -- used for checking for large straights and stopping other functions if it's a large straight
local smallstraight1 = 0 -- used for checking ofr short straights and stopping other functions if it's a short straight

local smallstraight2 = 0 -- used for small straight stat buff

local utils = require("scripts.utils")

-- resets the values for the next game
function mod:reset()
    rN1 = 0
    rN2 = 0
    rN3 = 0
    rN4 = 0
    rN5 = 0
    total = 0
    i = 0
    ii = 0
    iii = 0
end

-- sets the dice values, duh
function mod:dices()
    rN1 = math.random(6)
    rN2 = math.random(6)
    rN3 = math.random(6)
    rN4 = math.random(6)
    rN5 = math.random(6)
    total = rN1 + rN2 + rN3 + rN4 + rN5
end

-- checks for a large or short straight
function mod:straightchecks()
    local rolls = {rN1,rN2,rN3,rN4,rN5}
    table.sort(rolls)
    local count = 1
    local m = 1
    while m < #rolls do
        if rolls[m] == rolls[m+1] - 1 then
            count = count + 1
            if count == 4 then
                smallstraight1 = 1
            end
            if count == 5 then
                largestraight1 = 1
            end
        else
            count = 1
        end
        m = m +1
    end
    if largestraight1 == 1 then
        return
    else
        largestraight1 = 0
    end
    if smallstraight1 == 1 then
        return
    else
        smallstraight1 = 0
    end
end

-- if it is a large or small straight
function mod:largestraight()
    if largestraight1 == 1 then
        Game():GetHUD():ShowItemText("Large Straight!","Bountiful items await!")
        local item = utils.ItemOfQuality(1,3)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(-80, 80),Vector(0,0),nil)
        item = utils.ItemOfQuality(1,3)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(-40, 80),Vector(0,0),nil)
        item = utils.ItemOfQuality(1,3)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(-0, 80),Vector(0,0),nil)
        item = utils.ItemOfQuality(1,3)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(40, 80),Vector(0,0),nil)
        item = utils.ItemOfQuality(1,3)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(80, 80),Vector(0,0),nil)
    else
        return
    end
end
function mod:smallstraight()
    if largestraight1 ~= 1 and smallstraight1 == 1 then
        Game():GetHUD():ShowItemText("Small Straight!","Stats and items are in your near future!")
        local item = utils.ItemOfQuality(0,2)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(-80, 80),Vector(0,0),nil)
        item = utils.ItemOfQuality(0,2)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(-40, 80),Vector(0,0),nil)
        item = utils.ItemOfQuality(0,2)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(0, 80),Vector(0,0),nil)
        item = utils.ItemOfQuality(0,2)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(40, 80),Vector(0,0),nil)
        item = utils.ItemOfQuality(0,2)
        Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(80, 80),Vector(0,0),nil)
        smallstraight2 = 1
        Isaac.GetPlayer():AddCacheFlags(CacheFlag.CACHE_DAMAGE)
        Isaac.GetPlayer():EvaluateItems()
    else
        return
    end
end

function mod:smallstraightstats()
    local player = Isaac.GetPlayer()
    if smallstraight2 == 1 then
        player.Damage = player.Damage + (total/10) + i
        i = i + (total/10)
    end
    smallstraight2 = 0
end
------------------------------------------------------------------------------------------------------------------------
-- if it is a yahtzee
function mod:yahtzee()
   if rN1 == rN2 and rN1 == rN3 and rN1 == rN4 and rN1 == rN5 then
    Game():GetHUD():ShowItemText("Yahtzee!","Wonderful items await!")
    local item = utils.ItemOfQuality(4,4)
    Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(-40, 80),Vector(0,0),nil)
    item = utils.ItemOfQuality(4,4)
    Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(0, 80),Vector(0,0),nil)
    item = utils.ItemOfQuality(4,4)
    Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,item,utils.FindPlayerPickupPositon(40, 80),Vector(0,0),nil)
    yhatzee1 = 1
   end
end
------------------------------------------------------------------------------------------------------------------------
-- if it's not a yahtzee, large straight, or short straight
function mod:sumofallDice1()
    if yhatzee1 == 0 and largestraight1 == 0 and smallstraight1 == 0 then
        if total <= 10 then
            Game():GetHUD():ShowItemText("Unfortunate "..total,"Enjoy these flies!")
            local n = 0
            while n <= 10 do
                Isaac.Spawn(EntityType.ENTITY_ATTACKFLY,0,0,utils.FindPlayerPickupPositon(0, -60),Vector(0,0),nil)
                n = n + 1
            end
            n = 0
            SFXManager():Play(SoundEffect.SOUND_FART)
        end
    ------------------------------------------------------------------------------------------------------------------------
        if total <= 15 and total > 10 then
            Game():GetHUD():ShowItemText("Not the worst, a "..total,"Enjoy the damage!")
            Isaac.GetPlayer():AddCacheFlags(CacheFlag.CACHE_DAMAGE)
            Isaac.GetPlayer():EvaluateItems()
            SFXManager():Play(SoundEffect.SOUND_1UP)
        end
    ------------------------------------------------------------------------------------------------------------------------
        if total <= 20 and total > 15 then
            Game():GetHUD():ShowItemText("Not bad, a "..total,"RIP any high quality items in the room!")
            for _, entity in ipairs(Isaac.GetRoomEntities()) do -- also ripped from too many d6s lol
                if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
                    local item = utils.ItemOfQuality(0, 2)
                    entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, item, true)
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
                    Game():GetItemPool():RemoveCollectible(entity.SubType)
                end
            end
            SFXManager():Play(SoundEffect.SOUND_1UP)
        end
    ------------------------------------------------------------------------------------------------------------------------
        if total <= 25 and total > 20 then
            Game():GetHUD():ShowItemText("Pretty good, a " .. total,"Enjoy the stats!")
            Isaac.GetPlayer():AddCacheFlags(CacheFlag.CACHE_DAMAGE)
            Isaac.GetPlayer():EvaluateItems()
            SFXManager():Play(SoundEffect.SOUND_CASH_REGISTER)
        end
    ------------------------------------------------------------------------------------------------------------------------
        if total <30 and total > 25 then
            Game():GetHUD():ShowItemText("Wow, a "..total,"I hope there was an item in the room!")
            for _, entity in ipairs(Isaac.GetRoomEntities()) do -- also ripped from too many d6s lol
                if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE and entity.SubType ~= 0 and entity.SubType ~= 668 then
                    local item = utils.ItemOfQuality(4,4)
                    entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, item, true)
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entity.Position, entity.Velocity, nil)
                    Game():GetItemPool():RemoveCollectible(entity.SubType)
                end
            end
            SFXManager():Play(SoundEffect.SOUND_HOLY)
        end
    ------------------------------------------------------------------------------------------------------------------------
        
    ------------------------------------------------------------------------------------------------------------------------   
        return { -- once again ripped from that mod
            Discharge = true,
            Remove = false,
            ShowAnim = true
        }
    end
end
------------------------------------------------------------------------------------------------------------------------   
function mod:thirty()
    if total == 30 then
        Game():GetHUD():ShowItemText("Well I'll be, a 6 full Yahtzee.","Massive stats and beautiful items await!")
        Isaac.GetPlayer():AddCacheFlags(CacheFlag.CACHE_DAMAGE)
        Isaac.GetPlayer():EvaluateItems()
        SFXManager():Play(SoundEffect.SOUND_HOLY)
    end
end
------------------------------------------------------------------------------------------------------------------------   
function mod:tentofifteen()
    local player = Isaac.GetPlayer()
    if total <= 15 and total > 10 then
        player.Damage = player.Damage + (total / 50) + i
        i = i + total/50
        total = 0
    end
end
------------------------------------------------------------------------------------------------------------------------   
function mod:twentytotwentyfive1()
    local player = Isaac.GetPlayer()
    if total <= 25 and total > 20 then
        totall = total
        player.Damage = player.Damage + (total/50) + i
        i = i + totall/50
        total = 0
        twentytotwentyfivee1 = 1
    end
end
function mod:twentytotwentyfive2()
    local player = Isaac.GetPlayer()
    if twentytotwentyfivee1 == 1 then
        total = totall
        player.TearRange = player.TearRange + (total*3) + ii
        ii = ii + total*3
        total = 0
        twentytotwentyfivee1 = 0
        twentytotwentyfivee2 = 1
    end
end
function mod:twentytotwentyfive3()
    local player = Isaac.GetPlayer()
    if twentytotwentyfivee2 == 1 then
        total = totall
        player.MaxFireDelay = player.MaxFireDelay - (total/100) - iii
        iii = iii + total/100
        total = 0
        twentytotwentyfivee2 = 0
        totall = 0
    end
end
------------------------------------------------------------------------------------------------------------------------   
function mod:thirty1()
    local player = Isaac.GetPlayer()
    if total == 30 then
        player.Damage = player.Damage + (total / 2) + i
        i = i + total/2
        total = 0
        thirtyy1 = 1
    end
end
function mod:thirty2()
    local player = Isaac.GetPlayer()
    if thirtyy1 == 1 then
        total = 30
        player.TearRange = player.TearRange + (total * 10) + ii
        ii = ii + total*5
        thirtyy1 = 0
        thirtyy2 = 1
        total = 0
    end
end
function mod:thirty3()
    local player = Isaac.GetPlayer()
    if thirtyy2 == 1 then
        total = 30
        player.MaxFireDelay = player.MaxFireDelay - (total / 10) - iii
        iii = iii + total/50
        thirtyy2 = 0
        total = 0
    end
end
------------------------------------------------------------------------------------------------------------------------

function mod:reset2()
    yhatzee1 = 0
    smallstraight1 = 0
    largestraight1 = 0
end

-- callbacks

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED,mod.reset) -- resets values on game start
mod:AddCallback(ModCallbacks.MC_USE_ITEM,mod.dices,diceSet) -- sets values for the rolls
mod:AddCallback(ModCallbacks.MC_USE_ITEM,mod.straightchecks,diceSet) -- checks for large and/or small straight
mod:AddCallback(ModCallbacks.MC_USE_ITEM,mod.largestraight,diceSet) -- does large straight things
mod:AddCallback(ModCallbacks.MC_USE_ITEM,mod.smallstraight,diceSet) -- does small straight things
mod:AddCallback(ModCallbacks.MC_USE_ITEM,mod.yahtzee,diceSet) -- checks for yahtzee
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.smallstraightstats) -- small straight stat buff
mod:AddCallback(ModCallbacks.MC_USE_ITEM,mod.sumofallDice1,diceSet) -- does things/checks for non-specials
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.tentofifteen) -- stat increases for total number being between 10 and 15
------------------------------------------------------------------------------------------------------------------------
-- stat increases for total number being between 20 and 25
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.twentytotwentyfive1)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.twentytotwentyfive2)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.twentytotwentyfive3)
------------------------------------------------------------------------------------------------------------------------
-- stat increases for total number being between 30 and 35
mod:AddCallback(ModCallbacks.MC_USE_ITEM,mod.thirty,diceSet) -- checks for thirty, needs to be separate cause yahtzee
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.thirty1)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.thirty2)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE,mod.thirty3)
------------------------------------------------------------------------------------------------------------------------
mod:AddCallback(ModCallbacks.MC_USE_ITEM,mod.reset2,diceSet) -- resets values for special checks

-- finishing notes: i know it's sloppy, i know it's inefficient, leave me alone about it i literally learned lua like 3 days ago
-- i don't give a fuck lmao - TechSec