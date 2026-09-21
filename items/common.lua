SMODS.Atlas{
    key = "joker_c",
    path = "Common.png",
    px = 71,
    py = 95
}
SMODS.Joker {
    key = "bf",
    atlas = "joker_c",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 2,
    discovered = true,
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "chips", "two", "four", "six", "eight", "rank" },
    config = { extra = { chips2 = 10, chips4 = 20, chips6 = 30, chips8 = 40  }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips2, card.ability.extra.chips4, card.ability.extra.chips6, card.ability.extra.chips8 } }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return { chips = card.ability.extra.chips8 }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 2 then
                return { chips = card.ability.extra.chips2 } end
                        if context.other_card:get_id() == 4 then
                            return { chips = card.ability.extra.chips4 } end
                                    if context.other_card:get_id() == 6 then
                                        return { chips = card.ability.extra.chips6 } end
                                                if context.other_card:get_id() == 8 then
                                                    return { chips = card.ability.extra.chips8 }
            end
        end
    end
}
SMODS.Joker {
    key = "gf",
    atlas = "joker_c",
    pos = { x = 1, y = 0 },
    rarity = 1,
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 2,
    discovered = true,
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "mult", "two", "four", "six", "eight", "rank" },
    config = { extra = { mult2 = 2, mult4 = 4, mult6 = 6, mult8 = 8 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult2,card.ability.extra.mult4,card.ability.extra.mult6,card.ability.extra.mult8 } }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return { mult = card.ability.extra.mult8 }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 2 then
                return { mult = card.ability.extra.mult2 } end
                        if context.other_card:get_id() == 4 then
                            return { mult = card.ability.extra.mult4 } end
                                    if context.other_card:get_id() == 6 then
                                        return { mult = card.ability.extra.mult6 } end
                                                if context.other_card:get_id() == 8 then
                                                    return { mult = card.ability.extra.mult8 }
            end
        end
    end
}
SMODS.Joker {
    key = "brick",
    atlas = "joker_c",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 2, y = 0 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "joker_slot" },
    config = { extra = { slots = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    add_to_deck = function(self, card, from_debuff)
    G.jokers:change_size(card.ability.extra.slots)
end,
    calculate = function(self, card, context)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers:change_size(-card.ability.extra.slots)
    end
}

SMODS.Joker {
    key = "pelo",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 3, y = 0 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "ace" },
    config = { extra = { chips = 0, gain = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return { chips = card.ability.extra.chips }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "gain",
                scaling_message = {
                message = "+" .. (card.ability.extra.chips + card.ability.extra.gain),
                colour = G.C.CHIPS
            }})
        end
    end
end
}
SMODS.Joker {
    key = "morshu",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 0, y = 1 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "tag", "money" },
    config = { extra = { }, immutable = { spent = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.immutable.spent } }
    end,
    calculate = function(self, card, context)
        if context.money_altered and context.amount < 0 then
            card.ability.immutable.spent = card.ability.immutable.spent - context.amount
        end
        if context.ending_shop or context.forcetrigger then
            if card.ability.immutable.spent >= 10 then
        local tag_pool = get_current_pool('Tag')
        local selected_tag = pseudorandom_element(tag_pool, 'busterb_morshu')
        local it = 1
        while selected_tag == 'UNAVAILABLE' do
            it = it + 1
            selected_tag = pseudorandom_element(tag_pool, 'busterb_morshu_resample'..it)
        end
        add_tag(Tag(selected_tag, false, 'Small'))
            card.ability.immutable.spent = 0
            play_sound('busterb_cashregister')
            SMODS.calculate_effect({message = "Reset!", colour = G.C.DARK_EDITION}, card)
    end
    end
end
}

local PostalDude = {
    "I regret nothing.",
    "Guns don't kill people, i do.",
    "Butt Sauce!",
    "And one for your mother.",
    "The gene pool is stagnant and i am the minister of chlorine",
    "And Joe Bob, son of Billy Joe Bob",
    "I better get out of here",
    "Didn't you just save?",
    "Did I ask for cheese?",
    "Give me some money!",
    "Go long!",
    "Man, i gotta stop smoking this crap",
    "Have a nice day!",
    "This can't be good for me but I feel great",
    "Hey! Now i can't feel my legs!",
    "That weirdo freak guy has got something hiding from us all."
}

SMODS.Joker {
    key = "dude",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 1, y = 1 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "clubs","spades","economy","face" },
    config = { extra = { chips = 30 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card:is_face() and (context.other_card:is_suit("Clubs") or context.other_card:is_suit("Spades")) then
            context.other_card:set_ability("m_gold", nil, true)
            return { message = PostalDude[math.random(#PostalDude)], colour = G.C.GOLD }
        end
    end,
}
SMODS.Joker {
    key = "richard",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 2, y = 1 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "economy", "destroy_card" },
    config = { extra = { dollar = 1, dollar_bonus = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollar, card.ability.extra.dollar_bonus } }
    end,
    calculate = function(self, card, context)
        if ( ( context.selling_card and context.card.ability.set == "Joker" ) and not context.blueprint and not context.retrigger_joker ) or context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollar",
                scalar_value = "dollar_bonus",
                scaling_message = {
                message = "$" .. (card.ability.extra.dollar + card.ability.extra.dollar_bonus),
                colour = G.C.GOLD
            }})
        end
    end,
     calc_dollar_bonus = function(self, card)
		return lenient_bignum(card.ability.extra.dollar)
    end
}

SMODS.Joker {
    key = "cancer",
    atlas = "joker_c",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 3, y = 1 },
    config = { extra = { score = 0 }, immutable = { gain = 0.01 } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "xscore","hands" },
    loc_vars = function(self, info_queue, card)
        local display = card.ability.immutable.gain*100
        return { vars = { display, card.ability.extra.score } }
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 then
            local display = card.ability.immutable.gain*G.GAME.chips
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "score",
                scalar_value = "addendum",
                scalar_table = { addendum = G.GAME.chips * card.ability.immutable.gain},
                scaling_message = {
                message = "+" ..(card.ability.extra.score + display).. " Score",
                colour = G.C.PURPLE
            }})
        end
        if context.joker_main and G.GAME.current_round.hands_left == 0 or (context.forcetrigger and G.GAME.blind.in_blind) then
            return {
                score = card.ability.extra.score
            }
        end
    end,
}
SMODS.Joker {
    key = "doom",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 0, y = 2 },
    config = { extra = {  } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "tarot", "ace", "king", "generation" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_death
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card{key= "c_death" }
                    play_sound("tarot1")
                    return true
                end
            }))

        end
            local ace = false
            local king = false
            if context.joker_main then
        for k, v in ipairs(context.scoring_hand) do
            if v:get_id() == 13 then ace = true end 
            if v:get_id() == 14 then king = true end
        end
    end
                if ace and king and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
                G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card{key= "c_death" }
                    play_sound("tarot1")
                    return true
                end
            }))
        end
    end,
}
SMODS.Joker {
    key = "nyancat",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 1, y = 2 },
    config = { extra = {  } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "editions","modify_card" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        local nyan = pseudorandom_element(G.hand.cards, 'busterb_nyancat')
        local card = nyan
        if context.end_of_round and context.main_eval or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, 1 do
            local percent = 1.15 - (i - 0.999) / (1 - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    nyan:flip()
                    play_sound('card1', percent)
                    nyan:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, 1 do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                nyan:set_edition('e_polychrome',true)
                nyan:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        for i = 1, 1 do
            local percent = 0.85 + (i - 0.999) / (1 - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    nyan:flip()
                    play_sound('tarot2', percent, 0.6)
                    nyan:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
        end
    end,
}
SMODS.Joker {
    key = "roz",
    atlas = "joker_c",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 2, y = 2 },
    config = { extra = { chance = 1, odds = 4 } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "enhancements","modify_card" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_busterb_nanotech
        local nanorare, nanoodds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_nanorare')
        return { vars = { nanorare, nanoodds } }
    end,
    calculate = function(self, card, context)
            local nano = false
            if context.joker_main then
        for k, v in ipairs(context.scoring_hand) do
            if SMODS.has_enhancement(v, "m_busterb_nanotech") then nano = true end 
        end
    end
                if nano and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
                    if SMODS.pseudorandom_probability(card, 'busterb_nanorare', 1, card.ability.extra.odds, 'busterb_nanorare', true) then
                G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card{set="Bootleg",soulable=true}
                    play_sound("tarot1")
                    return true
                end
            }))
        end
    end
    end,
}

SMODS.Joker {
    key = "jax",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 3, y = 2 },
    config = { extra = { select = 1 }, immutable = { max = 10 } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "modify_card","boss_blind", "ccd" },
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.immutable.max, card.ability.extra.select) } }
    end,
    calculate = function(self, card, context)
        local jax = card.children.center
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
            jax:set_sprite_pos({ x = 3, y = 5 })
            card:juice_up(10, 10)
            play_sound('busterb_vineboom')
                return true
            end
            }))
            G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
            for i = 1, math.min(card.ability.immutable.max, card.ability.extra.select) do
            local c = SMODS.add_card{set = "Playing Card", area=G.hand}
            SMODS.calculate_effect{ message = "Added!", colour = SMODS.Gradients["busterb_grand"], card = c}
            local enhancement_type = pseudorandom_element({"Enhanced","Enhanced","Enhanced","Joker","Consumeables","Voucher","Booster"}, pseudoseed("package"))
            local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] or (enhancement_type == "Joker" and SMODS.Rarities[G.P_CENTERS[enhancement].rarity]
                and (
                    SMODS.Rarities[G.P_CENTERS[enhancement].rarity].get_weight
                    or (SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight and SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight > 0)
                )) do
                enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            end
            c:set_ability(G.P_CENTERS[enhancement])
        end
                return true
            end
            }))
            G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
            jax:set_sprite_pos({ x = 3, y = 2 })
            card:juice_up(0.3, 0.3)
            play_sound('tarot1')
                return true
            end
            }))
        end
 
        if context.main_eval then
        if context.setting_blind and G.GAME.blind.boss then
            G.E_MANAGER:add_event(Event({
            func = function()
            jax:set_sprite_pos({ x = 3, y = 5 })
            card:juice_up(10, 10)
            play_sound('busterb_vineboom')
                return true
            end
            }))
            for i = 1, math.min(card.ability.immutable.max, card.ability.extra.select) do
            local c = SMODS.add_card{set = "Playing Card", area=G.hand}
            SMODS.calculate_effect{ message = "Added!", colour = SMODS.Gradients["busterb_grand"], card = c}
            local enhancement_type = pseudorandom_element({"Enhanced","Enhanced","Enhanced","Joker","Consumeables","Voucher","Booster"}, pseudoseed("package"))
            local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] or (enhancement_type == "Joker" and SMODS.Rarities[G.P_CENTERS[enhancement].rarity]
                and (
                    SMODS.Rarities[G.P_CENTERS[enhancement].rarity].get_weight
                    or (SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight and SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight > 0)
                )) do
                enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            end
            c:set_ability(G.P_CENTERS[enhancement])

        end
    end
                if context.beat_boss then
                G.E_MANAGER:add_event(Event({
            func = function()
            jax:set_sprite_pos({ x = 3, y = 2 })
            card:juice_up(0.3, 0.3)
            play_sound('tarot1')
                return true
            end
            }))
            end
end
end
}
SMODS.Joker {
    key = "kid",
    atlas = "joker_c",
    pos = { x = 0, y = 3 },
    rarity = 1,
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 2,
    discovered = true,
    config = { extra = { mult = 0, gain = 0.2 }, },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "mult", "two", "scaling", "rank" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 2 then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "gain",
                scaling_message = {
                message = "+" .. (card.ability.extra.mult + card.ability.extra.gain.. " Mult"),
                colour = G.C.MULT
            }})
        end
    end
    if context.joker_main then
        return { mult = card.ability.extra.mult }
    end
end
}
SMODS.Joker {
    key = "hfg",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 1, y = 3 },
    config = { extra = { chance = 1, odds = 4 } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "spectral", "five", "generation" },
    loc_vars = function(self, info_queue, card)
        local ghostrare, ghostodds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_ghostrare')
        return { vars = { ghostrare, ghostodds } }
    end,
    calculate = function(self, card, context)
            local five = false
            if context.joker_main then
        for k, v in ipairs(context.scoring_hand) do
            if v:get_id() == 5 then five = true end 
        end
    end
                if five and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
                    if SMODS.pseudorandom_probability(card, 'busterb_ghostrare', 1, card.ability.extra.odds, 'busterb_ghostrare', true) then
                G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card{set="Spectral",soulable=true}
                    play_sound("tarot1")
                    return true
                end
            }))
        end
    end
end,
}
SMODS.Joker {
    key = "starwalker",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 2, y = 3 },
    config = { extra = { asc = 1 }, immutable = { rounds = 0, round_add = 1, total_rounds = 3} },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "asc_power", "hand_type" },
    loc_vars = function(self, info_queue, card)
        local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            local most_played = _handname
        return { vars = { card.ability.extra.asc, most_played, card.ability.immutable.rounds, card.ability.immutable.total_rounds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            local most_played = _handname
            SMODS.scale_card(card, {
                ref_table = card.ability.immutable,
                ref_value = "rounds",
                scalar_value = "round_add",
            })
        if ((card.ability.immutable.rounds) >= (card.ability.immutable.total_rounds)) then
                    SMODS.upgrade_poker_hands{
                        from = card,
                        ascension_power = card.ability.extra.asc,
                        hands = most_played,
                    }
                card.ability.immutable.rounds = 0
            SMODS.calculate_effect({ message = "Reset!", colour = G.C.FILTER}, card)
        end
    end
end,
yyy}
SMODS.Joker {
    key = "uknux",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 3, y = 3 },
    config = { extra = { xchips = 1, gain = 0.1 } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "tarot", "xchips", "scaling" },
    loc_vars = function(self, info_queue, card)
         info_queue[#info_queue + 1] = G.P_CENTERS.c_devil
        return { vars = { card.ability.extra.xchips, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if ( ( context.using_consumeable and context.consumeable.config.center_key == "c_devil" ) and not context.blueprint and not context.retrigger_joker ) or context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xchips",
                scalar_value = "gain",
                scaling_message = {
                message = "X" .. (card.ability.extra.xchips + card.ability.extra.gain).. " Chips",
                colour = G.C.CHIPS
            }})
        end
        if context.joker_main or context.forcetrigger then
            if card.ability.extra.xchips > to_big(1) then
            return { xchips = card.ability.extra.xchips }
        end
    end
end,
}

SMODS.Joker {
    key = "frylock",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true, ["Food"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 0, y = 4 },
    config = { extra = { bal = 0.25 }, immutable = { bal_loss = 0.05 } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "scaling", "food", "balance" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.bal*100, card.ability.immutable.bal_loss*100 } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not context.repetition then
            if card.ability.extra.bal < card.ability.immutable.bal_loss  then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = "Dead!",
                    colour = G.C.RED
                }
            else
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.bal = card.ability.extra.bal - card.ability.immutable.bal_loss
                return {
                    message = card.ability.extra.bal.."%",
                    colour = G.C.PURPLE
                }
            end
        end
        if context.final_scoring_step or context.forcetrigger then
            if (card.ability.extra.bal > to_big(0)) then
            return {
                cry_broken_swap = card.ability.extra.bal
            }
        end
    end
end,
}
SMODS.Joker {
    key = "lancer",
    atlas = "joker_c",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 1, y = 4 },
    config = { extra = {  }, immutable = {  } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "suit", "clubs", "spades", "passive" },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
    end,
}
--eternalnacho
local is_suit_ref = Card.is_suit
Card.is_suit = function(self, suit, bypass_debuff, flush_calc, ...)
  local ret = is_suit_ref(self, suit, bypass_debuff, flush_calc, ...)
  if ret
      or (suit ~= 'Clubs' and suit ~= 'Spades')
      or not (flush_calc or not self.debuff or bypass_debuff) then
    return ret
  end
  return next(SMODS.find_card("j_busterb_lancer"))
      and SMODS.has_enhancement(self, 'm_stone')
      or ret
end

SMODS.Joker {
    key = "susapphire",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 2, y = 4 },
    config = { extra = { scoring = 3 }, immutable = {  } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "xchips", "hands" },
    loc_vars = function(self, info_queue, card)
        local s = card.ability.extra.scoring
        return { vars = { s } }
    end,
    calculate = function(self, card, context)
        local s = card.ability.extra.scoring
        if (context.joker_main and (G.GAME.round % 2 == 1 and G.GAME.round >= 0)) or context.forcetrigger then
            return{ xchips = s }
            end
        end,
}
SMODS.Joker {
    key = "suruby",
    atlas = "joker_c",
    blueprint_compat = true,
demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 1,
    cost = 2,
    pos = { x = 3, y = 4 },
    config = { extra = { scoring = 2 }, immutable = {  } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "hands", "xmult" },
    loc_vars = function(self, info_queue, card)
        local s = card.ability.extra.scoring
        return { vars = { s } }
    end,
    calculate = function(self, card, context)
        local s = card.ability.extra.scoring
        if (context.joker_main and (G.GAME.round % 2 == 0 and G.GAME.round >= 0)) or context.forcetrigger then
            return{ xmult = s }
            end
        end,
}
