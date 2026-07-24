SMODS.Atlas{
    key = "joker_u",
    path = "Uncommon.png",
    px = 71, py = 95
}
SMODS.Joker {
    key = "pepsiman",
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { odds = 4 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_double', set = 'Tag' }
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and context.main_eval then
                G.E_MANAGER:add_event(Event({
                func = (function()
                    card:juice_up(5,5)
                    SMODS.calculate_effect{card = card, message = "PEPSIMAN!", colour = G.C.CHIPS}
                    add_tag(Tag('tag_double'))
                    play_sound('busterb_pepsiman')
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
        end
end,
}

SMODS.Joker {
    key = "spongebob",
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 1, y = 0 },
    config = { extra = {  }, immutable = { creates = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
                if context.setting_blind and G.GAME.blind.boss and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.immutable.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Food',
                            key_append = 'busterb_bob' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
end,
}

SMODS.Joker {
    key = "soldier",
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 2, y = 0 },
    config = { extra = {  }, immutable = { repetitions = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 14 then
            return {
                repetitions = card.ability.immutable.repetitions
            }
        end
    end
}
SMODS.Joker {
    key = "sanic",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 3, y = 0 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        local speedvalue = G.SETTINGS.GAMESPEED * 16
        return { vars = { speedvalue, " " } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = G.SETTINGS.GAMESPEED * 16
            }
        end
    end
}
SMODS.Joker {
    key = "dandy",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 0, y = 1 },
    config = { extra = {  }, immutable = { select = 0, select_gain = 1, select_limit = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.immutable.select, card.ability.immutable.select_gain, card.ability.immutable.select_limit } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and context.main_eval then
                card.ability.immutable.select = card.ability.immutable.select + card.ability.immutable.select_gain
                SMODS.calculate_effect{card = card, message = "+"..card.ability.immutable.select_gain.." Card Selection", colour = G.C.CHIPS}
                SMODS.change_play_limit(card.ability.immutable.select_gain)
        		SMODS.change_discard_limit(card.ability.immutable.select_gain)
        end
            if context.selling_self and not context.blueprint then
                SMODS.change_play_limit(-card.ability.immutable.select)
        		SMODS.change_discard_limit(-card.ability.immutable.select)                 
                SMODS.calculate_effect{card = card, message = "Reset!", colour = G.C.CHIPS}
        end

    end,
        remove_from_deck = function(self, card, from_debuff)
    end,
}
SMODS.Joker {
    key = "kfm",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 1, y = 1 },
    config = { extra = {  }, immutable = { reduce = 0.80 } },
    loc_vars = function(self, info_queue, card)
        local value = card.ability.immutable.reduce
        local display = string.format("%d%%",(1-value)*100)
        return { vars = { display } }
    end,
    calculate = function(self, card, context)
        local value = card.ability.immutable.reduce
        local display = string.format("%d%%",(1-value)*100)
         if context.setting_blind and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            SMODS.calculate_effect{card = card, message = display.." Transfer!", colour = G.C.BLACK}
            G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind.chips = G.GAME.blind.chips * card.ability.immutable.reduce
                        G.hand_text_area.blind_chips:juice_up()
                        play_sound('tarot1')
                        play_sound('timpani')
                        return true
                    end
                }))
        end
    end,
}

SMODS.Joker {
    key = "glados",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 2, y = 1 },
    config = { extra = {  }, immutable = { reduce = 0.80 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
	end
}

local oldevalcard = eval_card
function eval_card(card, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards or context.joker_type_destroyed) then return oldevalcard(card, context) end
    local oldhandsplayed, oldhandsleft
    if next((SMODS.find_card('j_busterb_glados'))) then
        oldhandsplayed, oldhandsleft = G.GAME.current_round.hands_played, G.GAME.current_round.hands_left
        G.GAME.current_round.hands_played = 0
        G.GAME.current_round.hands_left = 0
    end
    local g, post = oldevalcard(card, context)
    if next((SMODS.find_card('j_busterb_glados'))) then
        G.GAME.current_round.hands_played = oldhandsplayed
        G.GAME.current_round.hands_left = oldhandsleft
    end
    return g, post
end
SMODS.Joker{
    key = "pbj",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 3, y = 1 },
    config = { extra = { mult = 2, odds = 2048 }, immutable = { divider = 2 } },
        loc_vars = function(self, info_queue, card)
        local pbj, pbjodds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_pbj')
        return {
            vars = {
                card.ability.extra.mult,
                pbj,
                pbjodds
            }
        }
    end,
        calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'busterb_pbj', 1, card.ability.extra.odds, 'busterb_pbj') then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_extinct_ex')
                }
            else
                card.ability.extra.odds = card.ability.extra.odds / card.ability.immutable.divider
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        if context.joker_main then
            return {
                emult = card.ability.extra.mult
            }
        end
    end,
}

SMODS.Joker {
    key = "sunky",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 0, y = 2 },
    calculate = function(self, card, context)
        if context.selling_self and not G.GAME.blind.boss then
            SMODS.calculate_effect{message = ":P", colour = G.C.BLACK, card = card}
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.STATE ~= G.STATES.SELECTING_HAND then
                            return
                        end
                        G.GAME.chips = G.GAME.blind.chips
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()                        
                        G.STATE = G.STATES.HAND_PLAYED
                        G.STATE_COMPLETE = true
                        end_round()
                        play_sound('tarot1')
                        return true
                    end
                }))
            end
        end
}
SMODS.Joker {
    key = "twilight",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 1, y = 2 },
    config = { extra = { plus_asc = 0, gain = 0.25 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.plus_asc,
                card.ability.extra.gain
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "plus_asc",
                scalar_value = "gain",
                scaling_message = {
                message = "+" .. (card.ability.extra.plus_asc + card.ability.extra.gain).." Asc Power",
                colour = G.C.GOLD
            }})
        end
        if context.joker_main then
            return { asc = card.ability.extra.plus_asc }
        end
    end
}

SMODS.Joker {
    key = "noelle",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 2, y = 2 },
    config = { extra = {  }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_busterb_frost
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
                if G.hand.cards[1].config.center.key ~= 'm_busterb_frost' then
                    G.hand.cards[1]:set_ability('m_busterb_frost', nil, true)
                    G.hand.cards[1]:juice_up(0.3, 0.3)
                    play_sound("tarot1")
        end
    end
            if context.modify_scoring_hand and not context.blueprint then
                if context.other_card.config.center.key == 'm_busterb_frost' then
                    return {
                        add_to_hand = true,
                    }
                end
            end

end
}

SMODS.Joker {
    key = "salty",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 3, y = 2 },
    config = { extra = { chips = 0, gain = 50 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.chips, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.before then
            for k, v in ipairs(G.play.cards) do
                if v.config.center.key == 'm_stone' then
                    SMODS.destroy_cards(v)
                    SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "gain",
                scaling_message = {
                message = "+" .. (card.ability.extra.chips + card.ability.extra.gain).." Chips",
                colour = G.C.CHIPS
            }})
                end
            end            
        end
        if context.joker_main then
            return { chips = card.ability.extra.chips }
        end
    end
}
SMODS.Joker {
    key = "fakepep",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 0, y = 3 },
    config = { extra = { mult = 1, gain = 0.2 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.gain
            }
        }
    end,
    calculate = function(self, card, context)
        local multgain = pseudorandom(pseudoseed("busterb_fakepep"), 0.01, 2.00)
        if context.selling_card and context.card.ability.set == "Pizza" then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "incremental",
                scalar_table = { incremental = multgain },
                scaling_message = {
                message = "tluM " .. (card.ability.extra.mult + multgain).."X",
                colour = G.C.MULT
            }})
        end
        if context.joker_main then
            return { xmult = card.ability.extra.mult, message = "tluM " .. (card.ability.extra.mult).."X", colour = G.C.CHIPS}
        end
    end
}
SMODS.Joker {
    key = "mysteryman",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 1, y = 3 },
    config = { extra = { value = 1 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.value,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
        local funval = pseudorandom(pseudoseed("busterb_funval"), 1, 6)
		local additive = card.ability.extra.value
        if funval == 1 then
		G.hand:change_size(additive)
        SMODS.calculate_effect{card = card, message = "+"..card.ability.extra.value.." Hand Size", colour = G.C.BLACK}
        else
        if funval == 2 then
        G.jokers:change_size(additive)
        SMODS.calculate_effect{card = card, message = "+"..card.ability.extra.value.." Joker Slots", colour = G.C.BLACK}
        else
        if funval == 3 then
        G.consumeables:change_size(additive)
        SMODS.calculate_effect{card = card, message = "+"..card.ability.extra.value.." Consumable Slots", colour = G.C.BLACK}
        else
        if funval == 4 then
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + additive
        ease_hands_played(additive)
        SMODS.calculate_effect{card = card, message = "+"..card.ability.extra.value.." Hands", colour = G.C.BLACK}
        else
        if funval == 5 then
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + additive
        ease_discard(additive)
        SMODS.calculate_effect{card = card, message = "+"..card.ability.extra.value.." Discards", colour = G.C.BLACK}
        else
        if funval == 6 then
        SMODS.change_play_limit(additive)
		SMODS.change_discard_limit(additive)
        SMODS.calculate_effect{card = card, message = "+"..card.ability.extra.value.." Card Selection", colour = G.C.BLACK}
        end
        end
    end
    end
    end
end
end
end
}

SMODS.Joker {
    key = "finn",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 2, y = 3 },
    config = { extra = { mult = 6, chips = 12, asc = 1, score = 25 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips,
                card.ability.extra.asc,
                card.ability.extra.score
            }
        }
    end,
    calculate = function(self, card, context)
        local m = card.ability.extra.mult
        local c = card.ability.extra.chips
        local a = card.ability.extra.asc
        local s = card.ability.extra.score
        if context.individual and context.cardarea == "unscored" then
            return { mult = m, chips = c, asc = a, score = s }
        end
    end
}
SMODS.Joker {
    key = "jake",
    unlocked = true, 
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 3, y = 3 },
    config = { extra = { value = 0, gain = 1, hand = 1 }, immutable = { req = 5, inc = 2, handmax = 0 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.value,
                card.ability.extra.gain,
                card.ability.extra.hand,
                card.ability.immutable.req,
            }
        }
    end,
    calculate = function(self, card, context)
		local additive = card.ability.extra.hand
        if context.individual and context.cardarea == G.play then
        card.ability.extra.value = card.ability.extra.value + card.ability.extra.gain
        if card.ability.extra.value >= card.ability.immutable.req then
        card.ability.extra.value = 0
        card.ability.immutable.req = card.ability.immutable.req * card.ability.immutable.inc 
        card.ability.immutable.handmax = card.ability.immutable.handmax + additive
		G.hand:change_size(additive)
        SMODS.calculate_effect{message = localize("k_upgrade_ex"), colour = G.C.CHIPS, card = card}
        end
    end
end,
        remove_from_deck = function(self, card, from_debuff)
                G.hand:change_size(-card.ability.immutable.handmax)
                SMODS.calculate_effect{card = card, message = "Reset!", colour = G.C.CHIPS}
    end,

}
SMODS.Joker {
    key = "power",
    atlas = "joker_u",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 0, y = 4 },
    config = { extra = { asc = 3 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.asc } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 8 then
            return {
                asc = card.ability.extra.asc
            }
        end
    end
}

SMODS.Joker {
    key = "batman",
    atlas = "joker_u",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 1, y = 4 },
    config = { extra = {  }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 1 and G.GAME.blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            play_sound('timpani')
                            delay(0.4)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                    return true
                end
            }))

        end
    end
}
SMODS.Joker {
    key = "tenna",
    atlas = "joker_u",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 2, y = 4 },
    config = { extra = { booster_mod = 1}, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.booster_mod } }
    end,
    calculate = function(self, card, context)
    end,
        add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + card.ability.extra.booster_mod
    end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) - card.ability.extra.booster_mod
            end

}

SMODS.Joker {
    key = "skeletron",
    atlas = "joker_u",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 2,
    cost = 4,
    pos = { x = 3, y = 4 },
    config = { extra = { }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.joker_type_destroyed then
            local other_card = context.card
            if other_card.ability.set == "Joker" then
                return { no_destroy = true }
            end
        end
    end
}