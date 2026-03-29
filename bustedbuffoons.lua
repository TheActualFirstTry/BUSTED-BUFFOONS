

SMODS.Atlas{
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}

SMODS.Atlas {
    key = "placeholder",
    path = "placeholder.png",
    px = 71,
    py = 95,
}
-- Epileptic color for Grandiose
SMODS.Gradient{
    key = "epileptic",
    colours = {
        HEX('FF0000'),
        HEX('FF7F00'),
        HEX('FFFF00'),
        HEX('00FF00'),
        HEX('00FFFF'),
        HEX('0000FF'),
        HEX('8B00FF'),
        HEX('FF00FF')
    },
    cycle = 0.75,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "grand",
    colours = {
        G.C.SECONDARY_SET.Spectral,
        G.C.PURPLE,
        G.C.SECONDARY_SET.Tarot,
        G.C.RED,
        G.C.FILTER,
        G.C.GOLD,
        G.C.GREEN,
        G.C.SECONDARY_SET.Planet,
        G.C.CHIPS
    },
    cycle = 2,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "Secret",
    colours = {
        G.C.SUITS.Spades,
        G.C.PURPLE,
        G.C.RARITY.Legendary,
        G.C.TAROT
    },
    cycle = 1,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "eemultgradient",
    colours = {
        G.C.RED,
        G.C.SUITS.Hearts,
        G.C.FILTER,
        G.C.SUITS.Diamonds,
        G.C.GOLD,
        G.C.RARITY[3]
    },
    cycle = 1,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "eechipsgradient",
    colours = {
        G.C.SECONDARY_SET.Spectral,
        G.C.SECONDARY_SET.Planet,
        G.C.CHIPS,
        G.C.RARITY[1],
        HEX('00FFFF'),
        HEX('0000FF')
    },
    cycle = 1,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "balatro",
    colours = {
        G.C.MULT,
        G.C.GOLD,
        G.C.CHIPS,
        G.C.GREEN
    },
    cycle = 1,
    interpolation = 'linear',
}
SMODS.Gradient{
    key = "Thomasgradient",
    colours = {
        G.C.SUITS.Spades,
        G.C.SECONDARY_SET.Spectral,
        G.C.GOLD,
        G.C.SUITS.Hearts
    },
    cycle = 1,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "GoldenFreddyGradient",
    colours = {
        G.C.SUITS.Diamonds,
        G.C.GOLD,
        G.C.WHITE,
        G.C.MONEY,
        G.C.FILTER,
    },
    cycle = 1,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "hedera",
    colours = {
        HEX('5e7297'),
        HEX('b0a8e0'),
        HEX('c1c8f9'),
        HEX('b0a8e0'),
    },
    cycle = 4,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "bigbang",
    colours = {
        HEX('262626'),
        HEX('BC1006'),
        HEX('DB4026'),
        HEX('FF7031'),
        HEX('FFDE74'),
        HEX('FFFFC2'),
        HEX('FFFFFF'),
        HEX('FFFFC2'),
        HEX('FFDE74'),
        HEX('FF7031'),
        HEX('DB4026'),
        HEX('BC1006'),
    },
    cycle = 1,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "unstable",
    colours = {
        HEX('1b0033'),
        HEX('3d0075'),
        HEX('5e00b8'),
        HEX('7f00ff'),
        HEX('5e00b8'),
        HEX('3d0075'),
        HEX('1b0033'),
        HEX('3d0075'),
        HEX('5e00b8'),
        HEX('7f00ff'),
    },
    cycle = 1,
    interpolation = 'trig',
}
----------------Other Colours------------------
loc_colour("inactive")
G.ARGS.LOC_COLOURS.busterb_epileptic = SMODS.Gradients["busterb_epileptic"]
G.ARGS.LOC_COLOURS.busterb_grand = SMODS.Gradients["busterb_grand"]
G.ARGS.LOC_COLOURS.busterb_secret = SMODS.Gradients["busterb_secret"]
G.ARGS.LOC_COLOURS.busterb_eemult = SMODS.Gradients["busterb_eemultgradient"]
G.ARGS.LOC_COLOURS.busterb_eechips = SMODS.Gradients["busterb_eechipsgradient"]
G.ARGS.LOC_COLOURS.busterb_dreamy = HEX('5e7297')
G.ARGS.LOC_COLOURS.busterb_fantastic = HEX('b00b69')
G.ARGS.LOC_COLOURS.busterb_Thomas = SMODS.Gradients["busterb_Thomasgradient"]
G.ARGS.LOC_COLOURS.busterb_gfreddy = SMODS.Gradients["busterb_GoldenFreddyGradient"]
G.ARGS.LOC_COLOURS.busterb_balatro = SMODS.Gradients["busterb_balatro"]
G.ARGS.LOC_COLOURS.busterb_infinity = HEX('00FFFF')
G.ARGS.LOC_COLOURS.busterb_pizza = HEX('bc1006')
G.ARGS.LOC_COLOURS.busterb_hedra = SMODS.Gradients["busterb_hedera"]
G.ARGS.LOC_COLOURS.busterb_bigbang = SMODS.Gradients["busterb_bigbang"]
G.ARGS.LOC_COLOURS.busterb_unstable = SMODS.Gradients["busterb_unstable"]


--assert(SMODS.load_file("items/otherfunctionalities.lua"))()
assert(SMODS.load_file("items/thanks900n1.lua"))()
assert(SMODS.load_file("items/rarities.lua"))()
assert(SMODS.load_file("items/pools.lua"))()
assert(SMODS.load_file("items/thanksrattlingsnow.lua"))()
assert(SMODS.load_file("items/spectrals.lua"))()
assert(SMODS.load_file("items/infinity.lua"))()
assert(SMODS.load_file("items/enhancement.lua"))()
assert(SMODS.load_file("items/tarots.lua"))()
assert(SMODS.load_file("items/packs.lua"))()
assert(SMODS.load_file("items/rarejoker.lua"))()
assert(SMODS.load_file("items/pizza.lua"))()
assert(SMODS.load_file("items/dreamyjokers.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()
assert(SMODS.load_file("items/evilbuttons.lua"))()
assert(SMODS.load_file("items/hyperjokers.lua"))()
assert(SMODS.load_file("items/deck.lua"))()
assert(SMODS.load_file("items/grandjokers.lua"))()
assert(SMODS.load_file("items/secret_jokers.lua"))()
assert(SMODS.load_file("items/edition.lua"))()
assert(SMODS.load_file("items/voucher.lua"))()
assert(SMODS.load_file("items/uiforace.lua"))()
assert(SMODS.load_file("items/ace.lua"))()
assert(SMODS.load_file("items/summusic.lua"))()
assert(SMODS.load_file("items/tag.lua"))()
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

SMODS.current_mod.spectrallib_features = { "ascension_power" }

SMODS.Sound{
    key = "cashregister",
    path = "cashregister.ogg"
}
SMODS.Sound{
    key = "fahhh",
    path = "fahhh.ogg"
}
SMODS.Sound{
    key = "vineboom",
    path = "vine-boom.ogg"
}
to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end
--thank you sdm
local fahhh = Card.open
function Card:open()
    fahhh(self)
    if self.config and self.config.center and self.config.center.kind and self.config.center.key == "p_busterb_gem" then
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('busterb_fahhh')
                play_sound('busterb_vineboom')
            return true
        end}))
    end
end
--purely for testing tags
function rosespawn()
    local rose = Tag("tag_busterb_rose")
    add_tag(rose)
    rose:apply_to_run({ type = "new_blind_choice" })
end
function rarespawn()
local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if v.hidden  and not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
                local random_key = pseudorandom_element(pool, "random_rare_consumeable")
                    if random_key then SMODS.add_card{key = random_key, edition = "e_negative"} end
            end

-- 900n1 Gambapack
if next(SMODS.find_mod("900N1GAMBLE")) then assert(SMODS.load_file("items/crossmodshit/silencedenhancement.lua"))() assert(SMODS.load_file("items/crossmodshit/crk.lua"))() end

-- Paradox's Stupid Ideas
if next(SMODS.find_mod("paradox_ideas")) then assert(SMODS.load_file("items/crossmodshit/ritualistic.lua"))() assert(SMODS.load_file("items/crossmodshit/thrash.lua"))() end

-- Starspace
if next(SMODS.find_mod("starspace")) then assert(SMODS.load_file("items/crossmodshit/universal.lua"))() assert(SMODS.load_file("items/crossmodshit/ralsei.lua"))() end

-- UNIK's Mod
if next(SMODS.find_mod("unik")) then assert(SMODS.load_file("items/crossmodshit/awakened.lua"))() assert(SMODS.load_file("items/crossmodshit/UNIK.lua"))() end

-- Cryptid
--if next(SMODS.find_mod("Cryptid")) then return nil else assert(SMODS.load_file("items/uiforace.lua"))() end

-- Entropy
-- if next(SMODS.find_mod("entr")) then assert(SMODS.load_file("items/crossmodshit/entropydefinitions.lua"))() assert(SMODS.load_file("items/crossmodshit/invert.lua"))()assert(SMODS.load_file("items/crossmodshit/alternateentropy.lua"))() end