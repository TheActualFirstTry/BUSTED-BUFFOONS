-- DECKS:

-- 1. True Kinda Deck -- Start with Spinel and Garnet Jokers, and a deck of 52 Ace Cards consisting of only the Hearts and Clubs suits.
-- 2. Ultradeck -- Start with Minos Prime and Sisyphus Prime Jokers, 10 Discards and 10 Random Negative Spectral Cards.
-- 3. Deck of Bones -- Start with Sans and Papyrus and a deck of 52 Cards with only the Club suit.
-- 4. Imperial Deck -- Start with Negative Eternal Dark Donald and True Hyper Sonic and a deck of 52 Cards with only Aces, Kings, Queens, Jacks, and 10s.
-- 5. The Deck of Absolute Hate -- Start with a random Busted Buffoons Joker. Selecting a Blind has a 1 in 10 chance to create a random Fantastic Joker, otherwise creates a random Joker that isn't from the Fantastic Pool.


-- Deck #1 -- True Kinda Deck
SMODS.Atlas {
    key = "atlas_truekinda",
    path = "truekinda.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "truekinda",
    atlas = "atlas_truekinda",
    pos = { x = 0, y = 0 },
    config =  {},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
        func = function()
            local card = SMODS.create_card({
					set = 'Joker',
					area = G.jokers,
					key = 'j_busterb_spinel',
					edition = e_negative,
					stickers = {"eternal"}
				})
                card:add_to_deck()
                G.jokers:emplace(card)
				card:set_edition({ negative = true })
				local card2 = SMODS.create_card({
					set = 'Joker',
					area = G.jokers,
					key = 'j_busterb_garnet',
					edition = e_negative,
					stickers = {"eternal"}
				})
                card2:add_to_deck()
                G.jokers:emplace(card2)
				card2:set_edition({ negative = true })
            if not G.playing_cards then return false end
            for k, v in pairs(G.playing_cards) do
                if v.base.suit == 'Spades' then
                    v:change_suit('Clubs')
                end
                if v.base.suit == 'Diamonds' then
                    v:change_suit('Hearts')
                end
            end
            
            return true
        end
    }))
end
-- I feel like there should be a loc_vars here somewhere.
}

-- Deck #2 -- Ultradeck
-- SMODS.Back {
--}

--Deck #5 - The Deck of Absolute Hate

SMODS.Atlas {
    key = "atlas_hate",
    path = "hate.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "hate",
    atlas = "atlas_hate",
    pos = { x = 0, y = 0 },
    config =  {
            fantasticodds = 10
    },
        loc_vars = function(self, info_queue, back)
    local fchance, fodds = SMODS.get_probability_vars(self, 1, self.config.fantasticodds, 'busterb_fantasticjokerchance')
    return {vars = {fchance, fodds, " ", 
    colours = {HEX('b00b69'), SMODS.Gradients["busterb_epileptic"]}}}
    end,
    calculate = function (self, back, context)
        local rarity_map = {
  busterb_Grandiose = 'busterb_Dreamy',
  busterb_Secret = 'busterb_Fantastic',
  Common = 'Rare',
  Uncommon = 'Rare',
  cry_cursed = 'cry_exotic',
  crp_abysmal = 'crp_mythic',
  unik_detrimental = 'unik_ancient',
  valk_supercursed = 'valk_exquisite',
  jen_junk = 'Rare',
  jen_omegatranscendent = 'cry_exotic',
  jen_omnipotent = 'cry_exotic',
  jen_transcendent = 'cry_exotic',
  jen_wondrous = 'cry_exotic',
  jen_ritualistic = 'cry_exotic',
  jen_miscellaneous = 'Rare',
  gj_detri = "gj_uniq",
  ocstobal_challengeexclusive = "ocstobal_omega",
  ocstobal_absolute_curse = "ocstobal_beyondexotic",
  ocstobal_cursed = "ocstobal_unique"
}
        if context.end_of_round and context.main_eval then
                local _, key = pseudorandom_element(SMODS.Rarities, "cogito")
           key = rarity_map[key] or key
        SMODS.add_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.jokers }
    end
    end,

    apply = function(self, back)
            		G.E_MANAGER:add_event(Event({
    func = function()
        if not G.jokers then return false end
        SMODS.add_card({ set = 'bustjokers', area = G.jokers })
        return true
    end
}))
end
}