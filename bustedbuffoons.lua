SMODS.Atlas{
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}
assert(SMODS.load_file("items/thanks900n1.lua"))()
assert(SMODS.load_file("items/gradients.lua"))()
assert(SMODS.load_file("items/rarities.lua"))()
assert(SMODS.load_file("items/pools.lua"))()
assert(SMODS.load_file("items/thanksrattlingsnow.lua"))()
assert(SMODS.load_file("items/consumables.lua"))()
assert(SMODS.load_file("items/packs.lua"))()
assert(SMODS.load_file("items/rarejoker.lua"))()
assert(SMODS.load_file("items/dreamyjokers.lua"))()
assert(SMODS.load_file("items/hyperjokers.lua"))()
assert(SMODS.load_file("items/deck.lua"))()
assert(SMODS.load_file("items/grandjokers.lua"))()
assert(SMODS.load_file("items/secret_jokers.lua"))()
assert(SMODS.load_file("items/edition.lua"))()
assert(SMODS.load_file("items/voucher.lua"))()
--assert(SMODS.load_file("unused for now/testingjokers.lua"))() -- for future jokers
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

-- Starspace
if next(SMODS.find_mod("starspace")) then assert(SMODS.load_file("items/crossmodshit/universal.lua"))() assert(SMODS.load_file("items/crossmodshit/ralsei.lua"))() end

-- UNIK's Mod
if next(SMODS.find_mod("unik")) then assert(SMODS.load_file("items/crossmodshit/awakened.lua"))() assert(SMODS.load_file("items/crossmodshit/UNIK.lua"))() end

-- Cryptid
if next(SMODS.find_mod("Cryptid")) then assert(SMODS.load_file("items/crossmodshit/ace.lua"))() end

-- Entropy

-- if next(SMODS.find_mod("entr")) then assert(SMODS.load_file("items/crossmodshit/entropydefinitions.lua"))() assert(SMODS.load_file("items/crossmodshit/invert.lua"))()assert(SMODS.load_file("items/crossmodshit/alternateentropy.lua"))() end
