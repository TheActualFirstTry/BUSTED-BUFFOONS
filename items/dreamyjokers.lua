SMODS.Atlas {
    key = "opm",
    path = "Saitama.png",
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "saitama",
    atlas = "opm",
    rarity = "busterb_Dreamy",
    cost = 12,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    config = {
        extra = {  
        }
    },
    loc_txt = {
        name = "Saitama",
        text = {
            "Prevents {s:1.5,C:spectral}Fantasy{} from {C:red}destroying jokers{},",
            "Also prevents jokers from being {C:red}debuffed{}."
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.money, card.ability.extra.xchips_mod, card.ability.extra.dollar_mod } }
    end,

    calculate = function(self, card, context)
    if context.card_added then
        for _, joker in ipairs(G.jokers.cards) do
            SMODS.debuff_card(joker, "prevent_debuff", "j_busterb_saitama")
        end
    end
end,
add_to_deck = function(self, card, from_debuff)
    for _, joker in ipairs(G.jokers.cards) do
        SMODS.debuff_card(joker, "prevent_debuff", "j_busterb_saitama")
    end
end,
    remove_from_deck = function(self, card, from_debuff)
        for _, joker in ipairs(G.jokers.cards) do
            SMODS.debuff_card(joker, false, "j_busterb_saitama")
        end
    end,
}
SMODS.Atlas {
    key = "AX",
    path = "AlienX.png",
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "alienx",
    atlas = "AX",
    rarity = "busterb_Dreamy",
    cost = 12,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    config = {
        extra = {  
        }
    },
    loc_txt = {
        name = "Alien X",
        text = {
            "Prevents death, {C:red}self destructs{}",
            "and sets ante to 0."
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.money, card.ability.extra.xchips_mod, card.ability.extra.dollar_mod } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
            ease_ante(-G.GAME.round_resets.ante)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = "Seconded!",
                    saved = 'Death Prevention Motion Carried!',
                    colour = G.C.UI.TEXT_DARK
                }
            end
        end
}

--thank you PinkFocalors.
--local nope = Card.set_debuff
--function Card:set_debuff(should_debuff)
--	if #SMODS.find_card('j_busterb_saitama') > 0 then
--		return false
--	elseif (((self.config or {}).center or {}).debuff_immune or (((self.config or {}).center or {}).rarity or 1) == 6) and should_debuff == true then
--		card_status_text(self, 'Immune', nil, 0.05*self.T.h, G.C.RED, nil, 0.6, nil, nil, 'bm', 'cancel', 1, 0.9)
--		return false
--	else
--		nope(self, should_debuff)
--	end
--end