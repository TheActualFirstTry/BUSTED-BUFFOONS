SMODS.Atlas{
    key = "bb_legendary",
    path = "BBLegendary.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "sonic",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = { extra = { speed_mult = 4 } },
    attributes = { "bustj", "bustb_d", "xchips" },
    loc_vars = function(self, info_queue, card)
        local speedvalue = G.SETTINGS.GAMESPEED * card.ability.extra.speed_mult
        return { vars = { speedvalue, " " } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                xchips = G.SETTINGS.GAMESPEED * card.ability.extra.speed_mult
            }
        end
    end
}

SMODS.Joker {
    key = "tails",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    attributes = { "bustj", "bustb_d", "multiuse", "bootleg", "generation" },
    config = { extra = { multiuse = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.multiuse } }
    end,
    calculate = function(self, card, context)
        if (context.setting_blind and context.main_eval and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)) or context.forcetrigger then
            local c = SMODS.add_card{set="Bootleg"}
            local m = card.ability.extra.multiuse
            c.ability.cry_multiuse = m
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
    demicolon_compat = true,
    pools = { ["Other"] = true, ["bustjokers"] = true },
    rarity = "busterb_Other",
    cost = 20,
    pos = { x = 0, y = 0 },
    config = { extra = { e_mult = 1.25 }, extra_slots_used = -1 },
    attributes = { "emult" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.e_mult ,colours = {SMODS.Gradients["busterb_eemultgradient"]} } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return { emult = card.ability.extra.e_mult }
        end
        if context.end_of_round and context.game_over and context.main_eval then
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
                    message = "Destroyed!",
                    saved = "Saved by Mr. Hilgard",
                    colour = G.C.UI.TEXT_DARK
                }
            end
    end
}
SMODS.Joker {
    key = "marie",
    unlocked = false,
    atlas = "bb_legendary",
    blueprint_compat = false,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    attributes = { "bustj", "bustb_d", "generation", "boss_blind" },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_busterb_hilgard
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            SMODS.add_card({key = 'j_busterb_hilgard'})
        end
        if (context.setting_blind and context.main_eval and G.GAME.blind.boss) then
            if not next(SMODS.find_card("j_busterb_hilgard")) then
                SMODS.add_card({key = 'j_busterb_hilgard'})
            end
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
    "Ah, so you thought!",
    "That blue fellow has some skeletons hidden somewhere..."
}

SMODS.Joker {
    key = "zag",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    attributes = { "bustj", "bustb_d", "prevents_death", "hand_type" },
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
            if (context.before and next(context.poker_hands["Flush"]) and not context.blueprint) or context.forcetrigger then
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
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    rarity = 4,
    cost = 20,
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    config = { extra = { xmult = 1, xmult_mod = 1 } },
    attributes = { "bustj", "bustb_d", "food", "scaling", "xmult" },
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
        if (context.joker_main or context.forcetrigger) and card.ability.extra.xmult > to_big(1) then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

SMODS.Joker {
    key = "pomni",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 2 },
    soul_pos = { x = 0, y = 3 },
    attributes = { "bustj", "bustb_d", "echips", "emult", "suit", "clubs", "hearts" },
    config = { extra = { emult = 1.5, echips = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.echips, card.ability.extra.emult } }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
                        return { echips = card.ability.extra.echips, emult = card.ability.extra.emult }
                    end
        if context.individual and context.cardarea == G.play then
                    if context.other_card:is_suit("Clubs") then
                        return { echips = card.ability.extra.echips }
                    end
                    if context.other_card:is_suit("Hearts") then
                        return { emult = card.ability.extra.emult }
                    end
                end
    end
}

SMODS.Joker {
    key = "steven",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 1, y = 2 },
    soul_pos = { x = 1, y = 3 },
    config = { extra = { } },
    attributes = { "bustj", "bustb_d", "modify_card", "enhancements", "mod_chance" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_busterb_crystallized
        return { vars = { } }
    end,
    calculate = function(self, card, context)
               if context.modify_scoring_hand and not context.blueprint then
                    if SMODS.has_enhancement(context.other_card, 'm_busterb_crystallized') then
                        return {
                            add_to_hand = true,
                        }
                    end
                end

        if context.remove_playing_cards and context.removed then
            for _, v in ipairs(context.removed) do
                G.E_MANAGER:add_event(Event({
                func = function()
                local c = SMODS.copy_card(v, {area = G.hand or G.deck })
                    c:set_ability('m_busterb_crystallized',true)
                    c:add_sticker('eternal',true)
                    c:juice_up(0.3, 0.3)
                    c.ability.busterb_stevencard = true
                    SMODS.calculate_effect({ message = "Crystal!", colour = HEX('f7b4c6'), card = v })
                    play_sound("tarot1")
                    return true
                end
            }))
        end
    end
end
}


SMODS.Joker {
    key = "stormbringer",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 2, y = 2 },
    soul_pos = { x = 2, y = 3 },
    config = { extra = { perma_x_mult = 0.5 } },
    attributes = { "bustj", "bustb_d", "modify_card", "retrigger", "perma_bonus", "xmult", "enhancements" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_busterb_electric
        info_queue[#info_queue + 1] = G.P_CENTERS.c_busterb_conductor
        return { vars = { card.ability.extra.perma_x_mult } }
    end,
    calculate = function(self, card, context)
    if (context.setting_blind and not context.blueprint) or context.forcetrigger then
        local c = SMODS.add_card{key="c_busterb_conductor"}
        return { card = c, message = "Added!", colour = G.C.GOLD }
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
    attributes = { "bustj", "bustb_d", "generation", "boss_blind" },
    config = { extra = { }, immutable = { characters = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.immutable.characters, colours = {SMODS.Gradients["busterb_grand"]} } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.main_eval and not context.blueprint and G.GAME.blind.boss then 
            for i = 1, card.ability.immutable.characters do
                SMODS.add_card{ attributes = {"bustb_d"}, area = G.jokers }
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
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 4, y = 2 },
    soul_pos = { x = 4, y = 3 },
    attributes = { "bustj", "bustb_d", "tarot", "planet", "spectral", "generation", "passive", "consumeables", "economy" },
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
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 4 },
    soul_pos = { x = 0, y = 5 },
    config = { extra = { x = 1, gain = 0.1 } },
    attributes = { "bustj", "bustb_d", "bootleg", "emult", "scaling" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x, card.ability.extra.gain } }
    end,
    add_to_deck = function(self, card, from_debuff)
end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Bootleg' then
        local copy = moony_planet(context.consumeable,nil,G.conusmeables)
        if Incantation and context.consumeable.bulkuse then
        copy:setQty(context.consumeable:getQty())
        end
    end
end
}

--thank u ruby


SMODS.Joker {
    key = "bill",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 1, y = 4 },
    soul_pos = { x = 1, y = 5 },
    config = { extra = { level = 0 } },
    attributes = { "bustj", "bustb_d", "asc_power", "ace", "diamonds", "suit", "rank" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.level+1 } }
    end,
    calculate = function(self, card, context)
        if (context.individual and
        context.cardarea == G.play and 
        context.other_card:get_id() == 14 and 
        context.other_card:is_suit("Diamonds") and
        #context.full_hand == 1) or context.forcetrigger
            then
        local amt = amt or 1
        local used_consumable = copier or card
        delay(0.4)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
        )
        for i, v in pairs(G.GAME.hands) do
            G.GAME.hands[i].AscensionPower = to_big(G.GAME.hands[i].AscensionPower or 0) + to_big(G.GAME.hands[i].level) * to_big(amt) + to_big(card.ability.extra.level)
        end
        delay(1.0)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.2,
          func = function()
            play_sound("tarot1")
            ease_colour(G.C.UI_CHIPS, copy_table(Spectrallib.get_asc_colour(to_big(1) * to_big(amt) + to_big(card.ability.extra.level))), 0.1)
            ease_colour(G.C.UI_MULT, copy_table(Spectrallib.get_asc_colour(to_big(1) * to_big(amt) + to_big(card.ability.extra.level))), 0.1)
            Spectrallib.pulse_flame(0.01, sunlevel)
            used_consumable:juice_up(0.8, 0.5)
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              blockable = false,
              blocking = false,
              delay = 1.2,
              func = function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                ease_colour(G.C.UI_MULT, G.C.RED, 1)
                return true
              end,
            }))
            return true
          end,
        }))
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+ ..." })
        delay(1.0)
        delay(2.6)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
            end
    end
}

--[[

SMODS.Joker {
    key = "bill",
    unlocked = true,
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

]]
SMODS.Joker {
    key = "moony",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 2, y = 4 },
    soul_pos = { x = 2, y = 5 },
    attributes = { "bustj", "bustb_d", "generation", "consumeables", "editions" },
    config = { extra = { moony = 1, moonyodds = 4 } },
    loc_vars = function(self, info_queue, card)
    local oddwin, oddnope = SMODS.get_probability_vars(card, 1, card.ability.extra.moonyodds, self.key)
    info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
    return {vars = {oddwin, oddnope}}
    end,
    calculate = function(self, card, context)
    if context.using_consumeable and not (context.consumeable.edition or {}).negative then
    local copy = moony_planet(context.consumeable,nil,G.conusmeables)
    if SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.moonyodds) then
        copy:set_edition('e_negative')
    if Incantation and context.consumeable.bulkuse then
    copy:setQty(context.consumeable:getQty())
    end
    end
    end
    end
}

SMODS.Joker {
    key = "ultra_greed",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
 --   evilbutton = true,
    rarity = 4,
    cost = 20,
    pos = { x = 3, y = 4 },
    soul_pos = { x = 3, y = 5 },
    attributes = { "bustj", "bustb_d", "xmult", "scaling", "economy" },
    config = { extra = { xmult = 1, xmult_mod = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod } }
    end,
        use = function(self, card, area, copier)
            ease_dollars(-10)
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                scaling_message = {
                message = "X" .. (card.ability.extra.xmult + card.ability.extra.xmult_mod) .. " Mult",
                colour = G.C.MULT
            }})
    end,
        can_use = function(self, card)
        return ((G.GAME.dollars - G.GAME.bankrupt_at) >= 10)
        end,
        calculate = function(self, card, context)
        if (context.joker_main or context.forcetrigger) and card.ability.extra.xmult > to_big(1) then
            return { xmult = card.ability.extra.xmult }
        end
    end
}

SMODS.Joker {
    key = "hastur",
    unlocked = true,
    atlas = "bb_legendary",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 4,
    cost = 20,
    pos = { x = 4, y = 4 },
    soul_pos = { x = 4, y = 5 },
    attributes = { "bustj", "bustb_d", "asc", "suit", "diamonds" },
    config = { extra = { emult = 10, suit = 'Diamonds', destroyodds = 4 } },
    loc_vars = function(self, info_queue, card)
    local oddwin, oddnope = SMODS.get_probability_vars(card, 1, card.ability.extra.destroyodds, self.key)
    return {vars = {card.ability.extra.emult, card.ability.extra.suit, oddwin, oddnope}}
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return { asc = card.ability.extra.emult }
        end
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit(card.ability.extra.suit) then
            return {
                asc = card.ability.extra.emult,
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

--[[

        local amt = amt or 1
        local used_consumable = copier or card
        delay(0.4)
        local max=0
        local ind="High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > max then
                max = v.played
                ind = i
            end
        end
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize(ind,'poker_hands'), chips = "...", mult = "...", level = "" }
        )
        G.GAME.hands[ind].AscensionPower = to_big(G.GAME.hands[ind].AscensionPower or 0) + to_big(G.GAME.hands[ind].level) * to_big(amt) * to_big(card.ability.level)
        delay(1.0)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.2,
          func = function()
            play_sound("tarot1")
            ease_colour(G.C.UI_CHIPS, copy_table(Spectrallib.get_asc_colour(to_big(G.GAME.hands[ind].level) * to_big(amt) * to_big(card.ability.level))), 0.1)
            ease_colour(G.C.UI_MULT, copy_table(Spectrallib.get_asc_colour(to_big(G.GAME.hands[ind].level) * to_big(amt) * to_big(card.ability.level))), 0.1)
            Spectrallib.pulse_flame(0.01, sunlevel)
            used_consumable:juice_up(0.8, 0.5)
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              blockable = false,
              blocking = false,
              delay = 1.2,
              func = function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                ease_colour(G.C.UI_MULT, G.C.RED, 1)
                return true
              end,
            }))
            return true
          end,
        }))
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+"..(to_big(G.GAME.hands[ind].level) * to_big(amt) * to_big(card.ability.level)) })
        delay(1.0)
        delay(2.6)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
    end,

]]