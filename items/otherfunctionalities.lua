BustB = {}
BustB.has_rarity = function(rarity)
    if G.jokers then
        for _, v in ipairs(G.jokers.cards) do
            if v:is_rarity(rarity) then
                return true
            end
        end
    end
end
local add_to_deck = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    add_to_deck(self, from_debuff)
    if self.ability.set == "Joker" then
        G.E_MANAGER:add_event(Event({func = function()
            ease_background_colour_blind(G.STATE)
        return true end }))
    end
end
--BustB.easebg = function()
--    ease_background_colour { new_colour = G.C.WHITE, special_colour = HEX('b00b69'), tertiary_colour = G.C.BLACK, contrast = 2 }
--    return (
--        #Cryptid.advanced_find_joker(nil, "busterb_Grandiose", nil, nil, true) ~= 0
--		) and 100.000
--	end