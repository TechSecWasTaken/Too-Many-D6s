TooManyD6s = RegisterMod("Too Many D6s", 1)

local scripts = { -- Put D6 scripts here!!!!!!!
    "angelicD6",
    "blueD6",
    "chaosD6",
    "craneD6",
    "crookedD6",
    "deviousD6",
    "dollarcube",
    "errorD6",
    "glassD6",
    "glitchedD6",
    "goldenD6",
    "keepersD6",
    "lazyD6",
    "revolverD6",
    "rockcube",
    "secretD6"
}

local EIDScripts = {
    "en-us",
    "pl",
    "zh-cn"
}

for i=1, #scripts do
    require("scripts.D6s."..scripts[i])
end

if EID then
    for i=1, #EIDScripts do
        require("scripts.languages."..EIDScripts[i])
    end
end