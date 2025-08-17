-- DECKS:

-- 1. True Kinda Deck -- Start with Spinel and Garnet Jokers, and a deck of 52 Ace Cards consisting of only the Hearts and Clubs suits.
-- 2. Ultradeck -- Start with Minos Prime and Sisyphus Prime Jokers, 10 Discards and 10 Random Negative Spectral Cards.
-- 3. Deck of Bones -- Start with Sans and Papyrus and a deck of 52 Cards with only the Club suit.
-- 4. Imperial Deck -- Start with Negative Eternal Dark Donald and True Hyper Sonic and a deck of 52 Cards with only Aces, Kings, Queens, Jacks, and 10s.
-- 5. The Deck of Absolute Hate -- Start with a random Busted Buffoons Joker. Selecting a Blind has a 1 in 10 chance to create a random Fantastic Joker, otherwise creates a random Joker that isn't from the Fantastic Pool.


-- Deck #1
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
    loc_txt = {
        name = "The Deck of Absolute Hate",
        text = {"Start with a random {X:spectral,C:gold}Busted_Buffoons{} Joker",
        "{C:green}#1# in #2#{} chance to spawn a {V:1,E:1}Fantastic{} Joker at the end of the round",
        "Otherwise spawns in a random Non-Fantastic Joker."}

    },
        loc_vars = function(self, info_queue, back)
    local fchance, fodds = SMODS.get_probability_vars(self, 1, self.config.fantasticodds, 'busterb_fantasticjokerchance')
    return {vars = {fchance, fodds, 
    colours = {HEX('b00b69')}}}
    end,
    calculate = function (self, back, context)
        if context.end_of_round and context.main_eval then
            if SMODS.pseudorandom_probability(self, 'busterb_fantasticjokerchance', 1, self.config.fantasticodds, 'busterb_fantasticjokerchance') then
                SMODS.add_card({ set = 'Fantastic', area = G.jokers })
            else
            local randjoker = pseudorandom_element(G.P_CENTER_POOLS.Joker, pseudoseed('hatedeck')).key
            SMODS.add_card({ key = randjoker, edition = 'e_negative' })
            end
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