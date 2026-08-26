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
            local flipchance = pseudorandom(pseudoseed("busterb_truekinda"), 1, 2)
           if flipchance == 1 then 
                local c = SMODS.create_card({key = "j_busterb_spinel", edition = "e_negative"})
                    c:add_to_deck()
                    G.jokers:emplace(c)
            end
            if flipchance == 2 then 
                local c = SMODS.create_card({key = "j_busterb_garnet", edition = "e_negative"})
                    c:add_to_deck()
                    G.jokers:emplace(c)
            end
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
            odds = 100
    },
        loc_vars = function(self, info_queue, back)
    local fchance, fodds = SMODS.get_probability_vars(self, 1, self.config.odds, 'busterb_hatechance')
    return {vars = {fchance, fodds, " ", 
    colours = {HEX('b00b69'), SMODS.Gradients["busterb_epileptic"]}}}
    end,
    calculate = function (self, back, context)
        local rarity_map = {
  busterb_Grandiose = 'busterb_Dreamy',
  busterb_Secret = 'busterb_Fantastic',
  busterb_technopotent = "busterb_Fantastic",
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
  jen_ritualistic = 'cry_exotic',
  jen_miscellaneous = 'Rare',
  bos_transcendent = 'bos_exotic',
  bos_miscellaneous = 'Rare',
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
        if SMODS.pseudorandom_probability(card, 'busterb_hatechance', 1, self.config.odds, 'busterb_hatechance') then
        local c = SMODS.add_card({ key = 'j_busterb_gaia', area = G.jokers, force_stickers = true, stickers = { "busterb_omega" } })
        c.config.center.gaia = true
        else
            SMODS.add_card({ set = 'all_bb_joker', area = G.jokers })
        end
        return true
    end
}))
end
}
SMODS.Atlas {
    key = "atlas_sttgl",
    path = "STTGL.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "sttgl",
    atlas = "atlas_sttgl",
    pos = { x = 0, y = 0 },
    config = { operator = 1, ante = 2 },
    loc_vars = function(self, info_queue, back)
    return {vars = { self.config.ante, self.config.operator }}
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_operator(self.config.operator)
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1].config.colour = G.C.GRANDIOSE
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1]:juice_up()
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
            G.GAME.win_ante = G.GAME.win_ante * self.config.ante
                play_sound("slib_eblindsize", 1)
					attention_text({
						scale = 2,
						text = "X"..self.config.ante.." Ante",
                        colour = G.C.RED,
						hold = 2,
						align = "cm",
						offset = { x = 0, y = -2.7 },
						major = G.play,
                    })
                return true
            end
        }))
end,
calculate = function(self, card, context)
	end,
}