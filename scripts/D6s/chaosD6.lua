local mod = TooManyD6s
local utils = require("scripts.utils")

function mod:useChaosD6(UsedType, UsedRNG, PlayerUsed, UsedFlags, UsedSlot, UsedCustomData)
	local entities = Isaac:GetRoomEntities()
	
	for i=1, #entities do
		if entities[i].Type == EntityType.ENTITY_PICKUP then
			if entities[i].Variant == PickupVariant.PICKUP_COLLECTIBLE then
				if entities[i].SubType ~= 0 then
					local itemPool = Game():GetItemPool()
					local ranPool = UsedRNG:RandomInt(ItemPoolType.NUM_ITEMPOOLS)
					entities[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemPool:GetCollectible(ranPool), true)
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entities[i].Position, entities[i].Velocity, PlayerUsed)
                    SFXManager():Play(SoundEffect.SOUND_MOM_VOX_EVILLAUGH)
				end
			end
		end
	end
	
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.useChaosD6, utils.ItemID("Chaos D6"))