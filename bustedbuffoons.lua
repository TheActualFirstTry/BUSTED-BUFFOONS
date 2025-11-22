assert(SMODS.load_file("items/thanks900n1.lua"))()
assert(SMODS.load_file("items/gradients.lua"))()
assert(SMODS.load_file("items/rarities.lua"))()
assert(SMODS.load_file("items/pools.lua"))()
assert(SMODS.load_file("items/theonlyconsumableinthemod.lua"))()
assert(SMODS.load_file("items/rarejoker.lua"))()
assert(SMODS.load_file("items/hyperjokers.lua"))()
assert(SMODS.load_file("items/deck.lua"))()
assert(SMODS.load_file("items/grandjokers.lua"))()
assert(SMODS.load_file("items/secret_jokers.lua"))()
--assert(SMODS.load_file("items/unused for now/testingjokers.lua"))()
SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true,
    	cardareas = {
        post_trigger = true,
		deck = true,
		discard = true,
	},
}
end
-- 900n1 Gambapack
if next(SMODS.find_mod("900N1GAMBLE")) then assert(SMODS.load_file("items/crossmodshit/silencedenhancement.lua"))() assert(SMODS.load_file("items/crossmodshit/crk.lua"))() end

--Paradox's Stupid Ideas
if next(SMODS.find_mod("paradox_ideas")) then assert(SMODS.load_file("items/crossmodshit/ritualistic.lua"))() assert(SMODS.load_file("items/crossmodshit/thrash.lua"))() end

-- Starspace
if next(SMODS.find_mod("starspace")) then assert(SMODS.load_file("items/crossmodshit/universal.lua"))() assert(SMODS.load_file("items/crossmodshit/ralsei.lua"))() end