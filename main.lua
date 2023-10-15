TooManyD6s = RegisterMod("Too Many D6s", 1)

local v1Scripts = { -- Put D6 scripts here!!!!!!!
    "angelicD6",
    "angryD6",
    "babyD6",
    "blueD6",
    "chaosD6",
    "craneD6",
    "crookedD6",
    "deviousD6",
    "dollarcube",
    "errorD6",
    "glassD6",
    "goldenD6",
    "keepersD6",
    "rockcube",
    "secretD6"
}

local v2Scripts = {
    "deathD6",
    "diceSet",
    "glitchedD6",
    "lazyD6",
    "revolverD6",
    "shittyD6",
    "walletD6"
}

local EIDScripts = {
    "Chinese",
    "English",
    "German",
    "Polish"
}

for i=1, #v1Scripts do
    require("scripts.D6s.v1."..v1Scripts[i])
end

for i=1, #v2Scripts do
    require("scripts.D6s.v2."..v2Scripts[i])
end

if EID then
    for i=1, #EIDScripts do
        require("scripts.languages."..EIDScripts[i])
    end
end