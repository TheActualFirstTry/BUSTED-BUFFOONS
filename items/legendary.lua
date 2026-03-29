SMODS.Atlas{
    key = "bb_legendary",
    path = "BBLegendary.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "sonic",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        local speedvalue = G.SETTINGS.GAMESPEED * 4
        return { vars = { speedvalue, " " } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = G.SETTINGS.GAMESPEED * 4
            }
        end
    end
}

SMODS.Joker {
    key = "tails",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.discard then
            context.other_card:set_ability('m_steel', nil, true)
                elseif context.individual and context.cardarea == 'unscored' then
            context.other_card:set_ability('m_busterb_nanotech', nil, true)
        end
    end
}
SMODS.Atlas{
    key = "hilg",
    path = "Hilgard.png",
    px = 71,
    py = 95
}
SMODS.Joker {
    key = "hilgard",
    unlocked = true,
    no_collection = true,
    atlas = "hilg",
    blueprint_compat = true,
    pools = { ["Other"] = true, ["bustjokers"] = true },
    rarity = "busterb_Other",
    cost = 20,
    pos = { x = 0, y = 0 },
    config = { extra = { e_mult = 1.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.e_mult ,colours = {SMODS.Gradients["busterb_eemultgradient"]} } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { emult = card.ability.extra.e_mult }
        end
    end
}
SMODS.Joker {
    key = "marie",
    unlocked = false,
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.main_eval and not context.blueprint and G.GAME.blind.boss then
        SMODS.add_card({key = 'j_busterb_hilgard', edition = "e_negative"})
        end
    end
}

local ZagreusTalk = {
    'Not a chance.',
    'I would not allow it.',
    "No.",
    "I refuse!",
    "Argh! No!",
    "We're not done yet.",
    "Care for another chance?",
    "Let's not get ahead of ourselves...",
    "Ah, so you thought!"
}

SMODS.Joker {
    key = "zag",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    config = { extra = { deathdefiance = false }, immutable = { counter = 0, goal = 3, addition = 1, adddisplay = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deathdefiance and "Active" or "Inactive", card.ability.immutable.counter, card.ability.immutable.goal } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval and not card.ability.extra.deathdefiance == false then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
                SMODS.calculate_effect ({
                    message = ZagreusTalk[math.random(#ZagreusTalk)],
                    saved = "Death Defied!",
                    colour = G.C.DARK_EDITION,
                    card = card
                })
            card.ability.extra.deathdefiance = false
            card.ability.immutable.counter = 0
            SMODS.calculate_effect({message = "Reset!", colour = G.C.DARK_EDITION}, card)
        end
--        if context.before and next(context.poker_hands["Flush"]) and card.ability.immutable.counter <= 3 and not card.ability.extra.deathdefiance == true and not context.blueprint then
        if not card.ability.extra.deathdefiance == true and card.ability.immutable.counter <= card.ability.immutable.goal then
            if context.before and next(context.poker_hands["Flush"]) and not context.blueprint then
                card.ability.immutable.adddisplay = card.ability.immutable.adddisplay + card.ability.immutable.addition
                SMODS.scale_card(card, {
                ref_table = card.ability.immutable,
                ref_value = "counter",
                scalar_value = "addition",
                scaling_message = {
                message = card.ability.immutable.adddisplay .. "/" .. card.ability.immutable.goal,
                colour = G.C.DARK_EDITION
            }})
                if card.ability.immutable.counter == card.ability.immutable.goal then
                    card.ability.extra.deathdefiance = true
                    SMODS.calculate_effect({message = "!!!", colour = G.C.DARK_EDITION}, card)
                    local eval = function(card) return card.ability.extra.deathdefiance == true end
                juice_card_until(card, eval, false)
                end
            end
        end
        if context.forcetrigger then
            card.ability.extra.deathdefiance = true
            SMODS.calculate_effect({message = "!!!", colour = G.C.DARK_EDITION}, card)
        end
    end
}

SMODS.Joker {
    key = "steve",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    config = { extra = { xmult = 1, xmult_mod = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod } }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card:is_food() then
            local totalmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                scaling_message = {
                message = "X" ..totalmult.. " Mult",
                colour = G.C.MULT
            }})
        end
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

SMODS.Joker {
    key = "pomni",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 2 },
    soul_pos = { x = 0, y = 3 },
    config = { extra = { xmult = 2.5, xchips = 2.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
                    if context.other_card:is_suit("Clubs") or context.other_card:is_suit("Spades") then
                        return { xchips = card.ability.extra.xchips }
                    end
                    if context.other_card:is_suit("Diamonds") or context.other_card:is_suit("Hearts") then
                        return { xmult = card.ability.extra.xmult }
                    end
                end
    end
}

SMODS.Joker {
    key = "steven",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 1, y = 2 },
    soul_pos = { x = 1, y = 3 },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_suit("Diamonds") or context.other_card:is_suit("Hearts") then
                    context.other_card:set_ability('m_busterb_crystallized', nil, true)
                end
            end
    end
}

SMODS.Joker {
    key = "stormbringer",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 2, y = 2 },
    soul_pos = { x = 2, y = 3 },
    config = { extra = { perma_x_mult = 0.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.perma_x_mult } }
    end,
    calculate = function(self, card, context)
    if G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 then
        for i = 1, #G.hand.cards do
                if G.hand.cards[i].config.center.key ~= 'm_busterb_electric' then
                    G.hand.cards[i]:set_ability('m_busterb_electric', nil, true)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    play_sound("tarot1")
            end
        end
    end
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_busterb_electric') then
                context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) +
                card.ability.extra.perma_x_mult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
            end
        end
    end
}

SMODS.Joker {
    key = "rare_akuma",
    unlocked = false,
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 3, y = 2 },
    soul_pos = { x = 3, y = 3 },
    config = { extra = { }, immutable = { characters = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.immutable.characters, colours = {SMODS.Gradients["busterb_grand"]} } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.main_eval and not context.blueprint and G.GAME.blind.boss then 
            for i = 1, card.ability.immutable.characters do
                SMODS.add_card{ set = "bustjokers", area = G.jokers }
            end
        end
    end
}
SMODS.Sound{
    key = "jackpot",
    path = "jackpot.ogg",
}
SMODS.Joker {
    key = "spamton",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 4, y = 2 },
    soul_pos = { x = 4, y = 3 },
    config = { extra = { }, immutable = { spent = 0, reset = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "price_tower", set = "Other"}
        return { vars = { card.ability.immutable.spent } }
    end,
    calculate = function(self, card, context)
        if context.money_altered and context.amount < 0 then
            card.ability.immutable.spent = card.ability.immutable.spent - context.amount
        end
        if context.ending_shop then
            if card.ability.immutable.spent >= 5 then
                SMODS.add_card{ set = "Tarot", edition = "e_negative" }

            end
            if card.ability.immutable.spent >= 8 then
                SMODS.add_card{ set = "Planet", edition = "e_negative" }

            end
            if card.ability.immutable.spent >= 10 then
                SMODS.add_card{ set = "Spectral", edition = "e_negative" }

            end
            if card.ability.immutable.spent >= 12 then
                SMODS.add_card{ set = "Joker", rarity = "Common", edition = "e_negative" }

            end
            if card.ability.immutable.spent >= 15 then
                SMODS.add_card{ set = "Joker", rarity = "Uncommon", edition = "e_negative" }

            end
            if card.ability.immutable.spent >= 20 then
                SMODS.add_card{ set = "Joker", rarity = "Rare", edition = "e_negative" }

            end
            if card.ability.immutable.spent >= 50 then
                SMODS.add_card{ set = "Dreamy", area = G.jokers, edition = "e_negative" }

            end
            if card.ability.immutable.spent >= 100 then
                SMODS.add_card{ set = "Joker", rarity = "Legendary", edition = "e_negative" }

            end
                if card.ability.immutable.spent >= 500 then
                SMODS.add_card{ set = "Fantastic", area = G.jokers, edition = "e_negative" }
                SMODS.calculate_effect{
                    message = "HOCHI MAMA!",
                    sound = "busterb_jackpot",
                    colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                   card = card
                }
            end
            if card.ability.immutable.spent >= 1000 then
                local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if v.hidden  and not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
                local random_key = pseudorandom_element(pool, "random_rare_consumeable")
                    if random_key then SMODS.add_card{key = random_key, edition = "e_negative" } end
                SMODS.calculate_effect{
                    message = "HOCHI MAMA!",
                    sound = "busterb_jackpot",
                    colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                   card = card
                }
                end
            card.ability.immutable.spent = 0
            play_sound('busterb_cashregister')
            SMODS.calculate_effect({message = "Reset!", colour = G.C.DARK_EDITION}, card)
        end
    end
}

SMODS.Joker {
    key = "eggman",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 4 },
    soul_pos = { x = 0, y = 5 },
    config = { extra = { start = 0, gain = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.start, card.ability.extra.gain } }
    end,
    add_to_deck = function(self, card, from_debuff)
    G.jokers:change_size(1)
end,
    calculate = function(self, card, context)
        if context.selling_self then
            SMODS.add_card{key = "j_busterb_eggman" }
        end
        if context.selling_card and context.card.ability.set == "Joker" then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.gain
            card.ability.extra.start = card.ability.extra.start + card.ability.extra.gain
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers:change_size(-1)
    end
}

SMODS.Joker {
    key = "bill",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 1, y = 4 },
    soul_pos = { x = 1, y = 5 },
    config = { extra = { emult = 1, emult_mod = 0.1} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.emult, card.ability.extra.emult_mod } }
    end,
    calculate = function(self, card, context)
        if context.individual and
        context.cardarea == G.play and 
        context.other_card:get_id() == 14 and 
        context.other_card:is_suit("Diamonds") and
        #context.full_hand == 1
            then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "emult",
                scalar_value = "emult_mod",
                scaling_message = {
                message = "^" .. (card.ability.extra.emult + card.ability.extra.emult_mod) .. " Mult",
                colour = G.C.DARK_EDITION
            }})
            end
            if context.joker_main then
                SMODS.calculate_effect ({
                    emult = card.ability.extra.emult,
                    colour = SMODS.Gradients["busterb_eemultgradient"],
                    card = card
                })
            end
    end
}

SMODS.Joker {
    key = "moony",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 2, y = 4 },
    soul_pos = { x = 2, y = 5 },
    config = { extra = { moony = 1, moonyodds = 4 } },
    loc_vars = function(self, info_queue, card)
    local oddwin, oddnope = SMODS.get_probability_vars(card, 1, card.ability.extra.moonyodds, self.key)
    return {vars = {oddwin, oddnope}}
    end,
    calculate = function(self, card, context)
           local function moony_planet(card, new_card, area)
    if not card then return nil end
    local area = area or (new_card and new_card.area) or card.area or G.consumeables
    local cardwasindeck = new_card and new_card.added_to_deck or nil
    local copy = copy_card(card, new_card)
    if new_card and cardwasindeck then copy:remove_from_deck() end
    if card.playing_card then
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        copy.playing_card = G.playing_card
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, copy)
    end
    if (new_card and cardwasindeck) or not new_card then copy:add_to_deck() end
    if not new_card then area:emplace(copy) end
    return copy
    end
    if context.using_consumeable and not (context.consumeable.edition or {}).negative then
    local copy = moony_planet(context.consumeable)
    if SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.moonyodds) then
        copy:set_edition('e_negative')
    end
    end
    end
}

SMODS.Joker {
    key = "ultra_greed",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    evilbutton = true,
    rarity = 4,
    cost = 20,
    pos = { x = 3, y = 4 },
    soul_pos = { x = 3, y = 5 },
    config = { extra = { xmult = 1, xmult_mod = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod } }
    end,
    calculate = function(self, card, context)
        if context.greedbutton and G.GAME.dollars >= 10 then
            ease_dollars(-10)
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                scaling_message = {
                message = "X" .. (card.ability.extra.xmult + card.ability.extra.xmult_mod) .. " Mult",
                colour = G.C.MULT
            }})
        end
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

SMODS.Joker {
    key = "hastur",
    unlocked = false, 
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 4, y = 4 },
    soul_pos = { x = 4, y = 5 },
    config = { extra = { emult = 1.15, suit = 'Diamonds', destroyodds = 4 } },
    loc_vars = function(self, info_queue, card)
    local oddwin, oddnope = SMODS.get_probability_vars(card, 1, card.ability.extra.destroyodds, self.key)
    return {vars = {card.ability.extra.emult, card.ability.extra.suit, oddwin, oddnope}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit(card.ability.extra.suit) then
            return {
                emult = card.ability.extra.emult,
                colour = SMODS.Gradients["busterb_eemultgradient"],
                card = card
            }
        elseif context.destroy_card and context.cardarea == G.play and
            context.destroy_card:is_suit(card.ability.extra.suit) and 
            SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.destroyodds) then
            return {remove = true}
        end
    end
}