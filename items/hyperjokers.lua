 -- Spinel

SMODS.Atlas {
    key = "j_spinel",
    path = "Spinel.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "spinel",
    atlas = "j_spinel",
    rarity = "busterb_Fantastic",
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    cost = 100,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = {
        extra = {
            xmult = 6,           
            xmult_mod = 6,       
            stockpile = 1,         
            stockpile_return = 1,
            stockpile_add = 1,
            high_card = 6
        }
    },
    loc_txt = {
        name = "{C:hearts,E:1,s:2}Your New Best Friend, Spinel{}",
        text = {
            "This Joker gains {X:mult,C:white}X#2#{} Mult every 4 Aces or 4 Face cards scored.",
            "Stockpiles {X:mult,C:white}XMult{} per card played,",
            "applies on the last card and resets after.",
            "Levels up High Card by +#6# levels if played.",
            "Gains {X:dark_edition,C:white}+#5#{} Extra Stockpiling Power at the start of a boss blind.",
            "{C:inactive}(Current Mult from 4 Aces/Face: {}{X:mult,C:white}X#1#{}{C:inactive}){}",
            "{C:inactive}(Stockpiling Power: {}{X:dark_edition,C:white}X#4#{}{C:inactive}){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { card.ability.extra.xmult, 
            card.ability.extra.xmult_mod, 
            card.ability.extra.stockpile, 
            card.ability.extra.stockpile_return, 
            card.ability.extra.stockpile_add,
            card.ability.extra.high_card },
        }
    end,
    calculate = function(self, card, context)

        -- Apply base xmult during main scoring
        if context.joker_main then
            return {
                Xmult = card.ability.extra.xmult
            }
        end

        -- Stockpile xmult for each played card
        if context.individual and context.cardarea == G.play then
            card.ability.extra.stockpile = card.ability.extra.stockpile * 2
            local total_xmult = (card.ability.extra.stockpile * card.ability.extra.xmult)
            if context.other_card == context.scoring_hand[#context.scoring_hand] then
                card:juice_up(0.5, 0.5)
                play_sound('holo1', 1, 0.5)
                return {
                    Xmult = total_xmult
                }
            end
            return {
                message = "Stockpiling X" .. total_xmult .. "!",
                colour = G.C.RED,
                card = card
            }
    end
        -- Check for 4 Aces or 4 Face cards
        if context.before then
            local ace_count = 0
            local face_count = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                local card_id = playing_card:get_id()
                if card_id == 14 then
                    ace_count = ace_count + 1
                elseif playing_card:is_face() then
                    face_count = face_count + 1
                end
            end
            if ace_count >= 4 or face_count >= 4 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = "Boost!",
                    colour = G.C.MULT,
                    card = card
                }
            end
        end

        -- Reset stockpile and cards_played after hand
        if context.after then
            card.ability.extra.stockpile = card.ability.extra.stockpile_return
            return {
                message = "Reset",
                colour = G.C.RED,
                card = card
            }
        end

        -- Adds stockpile power at the start of the round
        if context.setting_blind and context.main_eval and not context.blueprint and G.GAME.blind.boss then
            card.ability.extra.stockpile_return = card.ability.extra.stockpile_return + card.ability.extra.stockpile_add
            card.ability.extra.stockpile = card.ability.extra.stockpile_return
            return {
                message = "+" .. card.ability.extra.stockpile_return .. " Power!",
                colour = G.C.DARK_EDITION,
                card = card
            }
        end
        -- if played hand is a high card, level up hand to 6 levels.
        if context.before and context.scoring_name == "High Card" and not context.blueprint then
            return {
                level_up = card.ability.extra.high_card,
                message = localize('k_level_up_ex'),
                color = G.C.HEARTS,
                card = card
            }
        end
    end
}
 -- Minos Prime

 to_big = to_big or function(x) return x end

-- Register sounds for Minos Prime
SMODS.Sound{
    key = "judgement",
    path = "judgement.ogg",
}
SMODS.Sound{
    key = "die",
    path = "die.ogg",
}

SMODS.Atlas {
    key = "minos",
    path = "Minos.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "minosprime",
    atlas = "minos",
    rarity = "busterb_Fantastic",
    cost = 100,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    blueprint_compat = true,
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = {
        extra = {
            xmult = 1,
            xmult_mod = 2,
            cards_per_discard = 2
        },
    },
    loc_txt = {
        name = "{C:dark_edition}MINOS PRIME // ULTRAKILL{}",
        text = {
            "This Joker creates {C:attention}#3#{} Random {C:dark_edition}Negative{} {C:spectral}Spectral{} cards",
            "per {C:attention}discard{}, gaining {X:mult,C:white}X#2#{} Mult",
            "for each {C:spectral}Spectral{} card created",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { to_big(card.ability.extra.xmult), card.ability.extra.xmult_mod, card.ability.extra.cards_per_discard }
        }
    end,
calculate = function(self, card, context)
    if context.pre_discard and not context.blueprint then
        local total_created = 0
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + card.ability.extra.cards_per_discard
        for _ = 1, math.min(card.ability.extra.cards_per_discard, 10) do
            local g = pseudorandom_element(G.P_CENTER_POOLS.Spectral, pseudoseed('minos')).key
            local spectral_card = SMODS.add_card({key = g, area = G.consumeables, edition = "e_negative", key_append = "minos"})
            if spectral_card then
                total_created = total_created + 1
            end
        end
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - total_created
        if total_created > 0 then
            card.ability.extra.xmult = card.ability.extra.xmult + total_created * card.ability.extra.xmult_mod
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                sound = "busterb_die",
                card = card
            }
        end
    end
    if context.joker_main then
        if to_big(card.ability.extra.xmult) > to_big(1) then
            return {
                message = localize({
                    type = "variable",
                    key = "a_xmult",
                    vars = { number_format(card.ability.extra.xmult) }
                }),
                Xmult_mod = to_big(card.ability.extra.xmult),
                sound = "busterb_judgement",
                colour = G.C.MULT,
                card = card
            }
        end
    end
end
}

-- Papyrus

SMODS.Atlas {
  key = "great_papyrus",
  path = "Papyrus.png",
  px = 71,
  py = 95,
}

SMODS.Joker {
  key = "papyrus",
  atlas = "great_papyrus",
  rarity = "busterb_Fantastic",
  cost = 100,
  discovered = true,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  pools = { ["Fantastic"] = true, ["bustjokers"] = true },
  pos = { x = 0, y = 0 },
  soul_pos = { x = 0, y = 1 },
  loc_txt = {
    name = "{C:clubs}The Great Papyrus{}",
    text = {
      "This Joker adds a {C:tarot}free Mega Arcana Pack{} to the {C:attention}shop{}",
      "{X:dark_edition,C:edition}Doubles{} {X:mult,C:white}XMult{} each time you skip a {C:attention}Booster Pack{}",
      "{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult){}"
    }
  },
  config = {
    extra = {
      triggered = false,
      xmult = 1
    }
  },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult or 1 } }
  end,
  calculate = function(self, card, context)
    if context.starting_shop and not card.ability.extra.triggered then
     local booster = SMODS.add_booster_to_shop("p_arcana_mega_1")
	 booster.cost = 0
      card.ability.extra.triggered = true
    end
    if context.open_booster then
      card.ability.extra.triggered = false
    end
    if context.skipping_booster and not context.blueprint then
      card.ability.extra.xmult = (card.ability.extra.xmult or 1) * 2
      card_eval_status_text(card, 'extra', nil, nil, nil, {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
        colour = G.C.RED
      })
      return {
        card = card
      }
    end
    if context.joker_main then
      return {
        x_mult = card.ability.extra.xmult,
        message = "X" .. card.ability.extra.xmult .. "!",
        colour = G.C.MULT
      }
    end
  end
}
-- Rainbow Dash
SMODS.Atlas {
  key = "r_dash",
  path = "RainbowDash.png",
  px = 71,
  py = 95,
}
SMODS.Joker {
    key = "rainbow",
	atlas = "r_dash",
    loc_txt = {
        name = "{C:edition}Rainbow Dash, The Element of Loyalty{}",
        text = {
            "This Joker applies {C:edition}Polychrome{} to all cards",
            "in the {C:attention}first played hand{} of each round,",
            "retriggers all played {C:edition}Polychrome{} cards."
        }
    },
    unlocked = true,
	discovered = true,
    blueprint_compat = true,
    rarity = "busterb_Fantastic",
    cost = 100,
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
    config = { extra = { edition = 'e_polychrome'} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_polychrome', set = 'Edition', config = { extra = 1.5 } }
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 then
            local polychrome_cards = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if not playing_card.edition or not playing_card.edition.polychrome then
                    playing_card:set_edition('e_polychrome', true)
                    polychrome_cards = polychrome_cards + 1
                end
            end
            if polychrome_cards > 0 then
                return {
                    message = "Applied!",
                    colour = G.C.EDITION
                }
            end
        end

        if context.repetition and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
            if context.other_card.edition and context.other_card.edition.polychrome then
                return {
                    repetitions = 1
                }
            end
        end
        end
}

-- Noisette

SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true }
end

SMODS.Atlas {
    key = "noisette",
    path = "Noisette.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "ptnoisette",
    atlas = "noisette",
    discovered = true,
    blueprint_compat = true,
    rarity = "busterb_Fantastic",
    cost = 100,
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    loc_txt = {
        name = "{C:diamonds}Ooh la belle Noisette{}",
        text = {
            "This Joker gains {C:attention}#1# Retrigger{} each time a",
            "{C:attention}Boss Blind{} is defeated,",
            "re-triggers the {C:attention}rightmost Joker{}",
            "{C:inactive}(Currently:{} {C:attention} #2# {}{C:inactive} Retriggers){}"
        }
    },
    config = {
        extra = { repetitions = 1 },
        immutable = { max_retriggers = 25 }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { 1, card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and G.GAME.blind.boss then
            card.ability.extra.repetitions = card.ability.extra.repetitions + 1
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card == G.jokers.cards[#G.jokers.cards] then
                return {
                    message = localize("k_again_ex"),
                    repetitions = to_number(math.min(card.ability.immutable.max_retriggers, card.ability.extra.repetitions)),
                    card = card
                }
            else
                return nil, true
            end
        end
    end,
}

--Sans

SMODS.Atlas {
    key = "sans",
    path = "sans.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "sans",
    atlas = "sans",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    rarity = "busterb_Fantastic",
    cost = 100,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
        extra = {
            xchips_mod = 2,
            xmult_mod = 2,
            prestige = 1,
            prestige_add = 1,
            xchips = 1,
            xmult = 1,
            dolar = 5
        },
        immutable = {
            max_prestige = 1000
        }
    },
    loc_txt = {
        name = "sans.",
        text = {
            "* human, i remember i gain {X:chips,C:white}X#3#{} chips and {X:mult,C:white}X#4#{} mult per scored {C:clubs}club{} card.",
			"{C:inactive,s:0.75}(jk, here lemme explain:{}",
            "{C:inactive,s:0.75}if you score a {}{C:clubs,s:0.75}club{} {C:inactive,s:0.75}card,{}",
            "{C:inactive,s:0.75}i gain {}{X:chips,C:white,s:0.75}X#3#{} {C:inactive,s:0.75}chips and {}{X:mult,C:white,s:0.75}X#4#{}{C:inactive,s:0.75} mult.{}",
            "{C:inactive,s:0.75}if you defeat a {}{C:attention,s:0.75}Boss Blind{}{C:inactive,s:0.75},{}",
            "{C:inactive,s:0.75}i gain {}{X:dark_edition,C:white,s:0.75}+#6#{} {C:dark_edition,s:0.75}prestige{}{C:inactive,s:0.75},{}",
            "{C:inactive,s:0.75}and {C:dark_edition,s:0.75}prestige{}{C:inactive,s:0.75} is permanent {}{}{X:chips,C:white,s:0.75}xchips{}{C:inactive} and {}{X:mult,C:white,s:0.75}xmult{}{C:inactive,s:0.75}.{}",
            "{C:inactive,s:0.75}and the ceiling only goes as far as {}{X:dark_edition,C:white,s:0.75}#7#{}{C:inactive,s:0.75}.{}",
            "{C:inactive,s:0.75}so that's how the prestige system works, capisce?){}",
            "{C:gold}you also get flat $#8# for each club too btw{}",
            "{C:inactive}(currently {}{X:chips,C:white}X#1#{} {C:inactive}and{} {X:mult,C:white}X#2#{}{C:inactive}){}",
            "{C:inactive}(current {C:dark_edition}prestige{}{C:inactive}: {}{X:dark_edition,C:white}#5#{}{C:inactive}){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { 
                card.ability.extra.xchips, 
                card.ability.extra.xmult, 
                card.ability.extra.xchips_mod, 
                card.ability.extra.xmult_mod, 
                card.ability.extra.prestige, 
                card.ability.extra.prestige_add, 
                card.ability.immutable.max_prestige,
                card.ability.extra.dolar
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Clubs") then
                card.ability.extra.xchips = math.min(1e300 , card.ability.extra.xchips * card.ability.extra.xchips_mod)
                card.ability.extra.xmult = math.min(1e300, card.ability.extra.xmult * card.ability.extra.xmult_mod)
                G.GAME.dollars = G.GAME.dollars + card.ability.extra.dolar
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.CHIPS
                })
            end
        end
        if context.joker_main then
            return {
                x_chips = card.ability.extra.xchips,
                x_mult = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
        -- prestige system, boss blind defeated = resets xchips and xmult, then prestige = prestige + prestige_add, prestige = permanent xchips and xmult, does not increase beyond max_prestige, use math.min
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and G.GAME.blind.boss then
            card.ability.extra.prestige = math.min(card.ability.extra.prestige + card.ability.extra.prestige_add, card.ability.immutable.max_prestige)
            card.ability.extra.xchips = card.ability.extra.prestige
            card.ability.extra.xmult = card.ability.extra.prestige
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.DARK_EDITION,
                card = card
            }
        end
    end
}

-- Sisyphus Prime

SMODS.Sound {
    key = "destroy",
    path = "destroy.ogg",
}
SMODS.Sound {
    key = "keepemcoming",
    path = "keepemcoming.ogg",
}
SMODS.Sound {
    key = "yesthatsit",
    path = "yesthatsit.ogg",
}
SMODS.Atlas {
    key = "j_sisyphus_prime",
    path = "Sisyphus.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "sisyphus",
    atlas = "j_sisyphus_prime",
    rarity = "busterb_Fantastic",
    cost = 100,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    config = {
        extra = {
            xchips = 6,         
            money = 6,       
            xchips_mod = 6,    
            dollar_mod = 6     
        }
    },
    loc_txt = {
        name = "{C:gold,E:1,s:2}SISYPHUS PRIME // ULTRAKILL{}",
        text = {
            "After selecting a {C:attention}Boss Blind{},",
            "This Joker gains {X:attention,C:white}X#3#{} {X:chips,C:white}XChips{} and {C:gold}+#4#${}{}.",
            "{C:inactive}(Current: {}{X:chips,C:white}X#1#{}{C:inactive}, {}{C:money}$#2#{C:inactive} per blind)"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.money, card.ability.extra.xchips_mod, card.ability.extra.dollar_mod } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_chips = card.ability.extra.xchips,
                message = "Destroy!",
                sound = "busterb_destroy",
                colour = G.C.CHIPS
            }
        end

        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            G.GAME.dollars = G.GAME.dollars + card.ability.extra.money
            return {
                dollars = card.ability.extra.money,
                message = "Keep em' coming!",
                sound = "busterb_keepemcoming",
                colour = G.C.MONEY
            }
        end

        if context.setting_blind and context.main_eval and not context.blueprint and G.GAME.blind.boss then
            card.ability.extra.xchips = card.ability.extra.xchips * card.ability.extra.xchips_mod
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.dollar_mod
            return {
                message = "Yes, that's it!",
                sound = "busterb_yesthatsit",
                colour = G.C.GOLD
            }
        end
        remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
        return nil
        else
        G.GAME.chips = G.GAME.blind.chips
        G.STATE = G.STATES.HAND_PLAYED
        G.STATE_COMPLETE = true
        end_round()
    end
end
end
}

-- Dark Donald

to_big = to_big or function(x) return x end

SMODS.Sound{
    key = "laugh",
    path = "laugh.ogg",
}

SMODS.Sound{
    key = "makudonarudo",
    path = "makudonarudo.ogg",
}

SMODS.Sound{
    key = "lovin",
    path = "lovin.ogg",
}

SMODS.Sound{
    key = "intro",
    path = "intro.ogg",
}

SMODS.Atlas {
    key = "dark_donald",
    path = "DD1.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "dd1",
    atlas = "dark_donald",
    rarity = "busterb_Fantastic",
    cost = 100,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    blueprint_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    config = {
        extra = {
            multiplier = 2
        }
    },
    loc_txt = {
        name = "{C:tarot,E:1,s:2}DARK DONALD{}",
        text = {
            "If played hand contains a {C:attention}Flush{},",
            "all {C:attention}poker hands{} have their",
            "levels {C:attention}multiplied by #1#{},",
            "Disables {C:attention}Boss Blinds{}."
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { to_big(card.ability.extra.multiplier) }
        }
    end,
	 add_to_deck = function(self, card, from_debuff)
        play_sound("busterb_intro")
        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
            G.GAME.blind:disable()
            play_sound('timpani')
            SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
        end
    end,
    calculate = function(self, card, context)
        if context.before and next(context.poker_hands["Flush"]) and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('busterb_makudonarudo')
                    card:juice_up(0.3, 0.5)
                    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 },
                        { level = 'x' .. to_big(card.ability.extra.multiplier) })
                    for poker_hand_key, hand in pairs(G.GAME.hands) do
                        local current_level = hand.level or 1
                        local levels_to_add = math.max(0, math.floor(current_level * (to_big(card.ability.extra.multiplier) - 1)))
                        if levels_to_add > to_big(0) then
                            level_up_hand(card, poker_hand_key, true, levels_to_add)
                        end
                    end
                    update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                        { mult = 0, chips = 0, handname = '', level = '' })
                    return true
                end
            }))
            return {
                message = localize('k_level_up_ex'),
                colour = G.C.MULT,
                card = card
            }
        end
        if context.setting_blind and not context.blueprint and G.GAME.blind.boss then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.GAME.blind:disable()
                    play_sound('busterb_laugh')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            return {
                message = localize('k_disabled_ex'),
                colour = G.C.RED,
                sound = "busterb_laugh",
                card = card
            }
        end
    end,
    can_use = function(self, card)
        return true
    end
}

-- Garnet

SMODS.Atlas {
    key = "garnet",
    path = "Garnet.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    name = "Garnet",
    key = "garnet",
    atlas = "garnet",
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    config = {
        extra = {
            Sapphire = 1.5,
            Ruby = 1.5,
            Garnet = 2,
            BaseSapphire = 1.5,
            BaseRuby = 1.5
        }
    },
    loc_txt = {
        name = "{X:clubs,C:hearts}GAR{}{X:hearts,C:clubs}NET{}",
        text = {
            "Gives {X:chips,C:white}X#4#{} Chips and {X:mult,C:white}X#5#{} Mult each hand.",
            "Played {C:clubs}Clubs{} cards increase {X:chips,C:white}XChips{} by {C:attention}#1#{}.",
            "Played {C:hearts}Hearts{} cards increase {X:mult,C:white}XMult{} by {C:attention}#2#{}.",
            "If a hand contains both {C:clubs}Clubs{} and {C:hearts}Hearts{},",
            "{X:chips,C:white}XChips{} and {X:mult,C:white}XMult{} are multiplied by {C:attention}#3#{}."
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 0,
        y = 1
    },
    cost = 100,
    rarity = "busterb_Fantastic",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Sapphire, card.ability.extra.Ruby, card.ability.extra.Garnet, card.ability.extra.BaseSapphire, card.ability.extra.BaseRuby } }
    end,


    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
        if context.other_card:is_suit("Clubs") and not context.other_card.debuff then
            card.ability.extra.BaseSapphire = card.ability.extra.Sapphire + card.ability.extra.BaseSapphire
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex"), colour = G.C.CHIPS })
            return { card = card }
        end
        if context.other_card:is_suit("Hearts") and not context.other_card.debuff then
            card.ability.extra.BaseRuby = card.ability.extra.Ruby + card.ability.extra.BaseRuby
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex"), colour = G.C.MULT })
            return { card = card }
        end
    end
    if context.joker_main and context.cardarea == G.jokers then
        local has_clubs = false
        local has_hearts = false
        for _, c in ipairs(context.full_hand) do
            if c:is_suit("Clubs") then has_clubs = true end
            if c:is_suit("Hearts") then has_hearts = true end
        end
        if has_clubs and has_hearts then
            card.ability.extra.Sapphire = card.ability.extra.Sapphire * card.ability.extra.Garnet
            card.ability.extra.Ruby = card.ability.extra.Ruby * card.ability.extra.Garnet
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex"), colour = G.C.PURPLE })
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.5, 0.5)
                    return true
                end
            }))
        end
        return {
            xchips = card.ability.extra.Sapphire,
            xmult = card.ability.extra.Ruby,
			card = card
 }
    end
end
}

-- Peacock

SMODS.Atlas {
    key = "PeacockS",
    path = "Peacock.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "peacock",
    atlas = "PeacockS",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    cost = 100,
    rarity = "busterb_Fantastic",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            SA2XChips = 11,
            SA2XMult = 11,
            SA2Mod = 1,
            odds = 4
        }
    },
    loc_txt = {
        name = "{C:gold}[DREAM CATCHER] PEACOCK{}",
        text = {
            "{C:green}#4# in #5# chance{} to",
            "apply {C:edition}Polychrome{} to a scored card in hand.",
            "Gains {C:attention}#3#{} more {X:chips,C:white}XChips{} and {X:mult,C:white}XMult{}",
            "per scored {C:edition}Polychrome{} card.",
            "{C:inactive}(Currently{} {X:chips,C:white}X#1#{} {C:inactive}Chips and {}{X:mult,C:white}X#2#{}{C:inactive} Mult.){}"
        }
    },

    in_pool = function(self, args)
        return true
    end,

    loc_vars = function(self, info_queue, card)
        local polychance, polyodds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_peacock_polychrome')
        return {
            vars = {
                card.ability.extra.SA2XChips,
                card.ability.extra.SA2XMult,
                card.ability.extra.SA2Mod,
                polychance,
                polyodds
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then

            local is_polychrome = context.other_card.edition and context.other_card.edition.polychrome
            if is_polychrome then
                card.ability.extra.SA2XChips = card.ability.extra.SA2XChips + card.ability.extra.SA2Mod
                card.ability.extra.SA2XMult = card.ability.extra.SA2XMult + card.ability.extra.SA2Mod
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize("k_upgrade_ex"), colour = G.C.PURPLE })
                return { card = card }
            else
                if SMODS.pseudorandom_probability(card, 'busterb_peacock_polychrome', 1, card.ability.extra.odds, 'busterb_peacock_polychrome') then
                    context.other_card:set_edition({ polychrome = true }, true)
                    card.ability.extra.SA2XChips = card.ability.extra.SA2XChips + card.ability.extra.SA2Mod
                    card.ability.extra.SA2XMult = card.ability.extra.SA2XMult + card.ability.extra.SA2Mod
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize("k_upgrade_ex"), colour = G.C.PURPLE })
                else
                end
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                xchips = card.ability.extra.SA2XChips,
                xmult = card.ability.extra.SA2XMult,
                card = card
            }
        end
    end
}

SMODS.Atlas {
    key = "THSonic",
    path = "THSonic.png",
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "true_hyper_sonic",
    atlas = "THSonic",
    rarity = "busterb_Fantastic",
    cost = 20,
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    blueprint_compat = true,
    perishable_compat = false,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = {
            hypermult = 1.1,
            hypermult_add = 0.01,
            hypermult_add_mod = 2
        }
    },
    loc_txt = {
        name = "{X:dark_edition,C:white}TRUE{} {X:dark_edition,C:white}HYPER{} {X:dark_edition,C:white}SONIC{}",
        text = {
            "Discarded cards, cards played, cards scored,",
            "cards held in hands, used discards, and played hands",
            "contribute to this joker's {X:dark_edition,C:white}^Mult{} by {X:dark_edition,C:white}+#2#{}.",
            "Selecting a blind multiplies added {X:dark_edition,C:white}^Mult{} by {X:dark_edition,C:white}X#3#{}.",
            "{C:inactive}(Currently {}{X:dark_edition,C:white}^#1#{}{C:inactive} Mult){}",
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = { 
                card.ability.extra.hypermult, 
                card.ability.extra.hypermult_add, 
                card.ability.extra.hypermult_add_mod 
            }
        }
    end,
    
    -- Check for discards, played cards, scored cards, held cards, used discards, and played hands to add to hypermult
    calculate = function(self, card, context)
        if not context.blueprint and (
            (context.individual and (context.cardarea == G.play or (context.cardarea == G.hand and not context.end_of_round))) or
            context.pre_discard or
            context.discard or
            (context.after and context.cardarea == G.jokers) or
            context.hand_drawn or
            context.remove_playing_cards
        ) then
            card.ability.extra.hypermult = math.min(1e300, card.ability.extra.hypermult + card.ability.extra.hypermult_add)
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "+ ^" .. card.ability.extra.hypermult,
                colour = G.C.DARK_EDITION
            })
        end

        -- Apply hypermult when joker is used
        if context.joker_main then
            return {
                e_mult = card.ability.extra.hypermult,
                message = "^".. card.ability.extra.hypermult,
                colour = G.C.DARK_EDITION,
                card = card
            }
        end
        -- Selected blind multiplies hypermult_add by hypermult_add_mod
        if context.setting_blind and not context.blueprint then
            card.ability.extra.hypermult_add = card.ability.extra.hypermult_add * card.ability.extra.hypermult_add_mod
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.DARK_EDITION,
                card = card
            }
        end
    end
}
SMODS.Atlas {
    key = "placeholder",
    path = "placeholder.png",
    px = 71,
    py = 95,
}

-- The Unholy Joker that is Sisyphus Prime v2, it's not finished yet, and i don't plan to finish it anytime soon, so i will leave it here to rot as if it was a dead god.

--SMODS.Joker {
--    key = "new_sisyphus",
--    atlas = "placeholder",
--    rarity = "busterb_Fantastic",
--    cost = 100,
--    discovered = true,
--    unlocked = true,
--    eternal_compat = true,
--    blueprint_compat = true,
    --pos = { x = 0, y = 0 },
  --  soul_pos = { x = 0, y = 1 },
--    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    --config = {
      --  extra = {
    --        xchipsndollar_mod = 1, --1
  --          xchips = 1, --2
--            money_value = 1, --3
            --stockpile = 1, --4
          --  add = 1, --5
        --    stockpile_return = 1, --6
      --      gold_seal_retrigger = 1, --7
    --        { first_hand_triggered = false },
  --           { seal = 'Gold' }
--        }
--    },
--    loc_txt = {
--        name = "{C:gold,E:1,s:2}Sisyphus Prime v2 (wip){}",
--        text = {
--            "This Joker applies gold seals on first played hand,",
--            "gains {X:chips,C:white}X#1#{} Chips and {C:money}$#1#{} Money.",
--            "each time a card with a {C:gold}gold seal{} is played.",
--            "Retriggers played cards with a {C:gold}gold seal{}",
--            "Stockpiles {X:chips,C:white}XChips{} and {C:money}Money{} for each played card,",
            --"which also resets on the final card.",
          --  "Gains an extra Stockpiling Power of {X:dark_edition,C:white}+#4#{} whenever a boss blind is selected.",
        --    "{C:inactive}Currently {}{X:chips,C:white}X#2#{}{C:inactive} Chips and {}{C:money}$#3#{C:inactive} Money.",
      --      "{C:inactive}Stockpiling Power: {}{X:dark_edition,C:white}X#5#{}{C:inactive}.){}"
     --   }
--    },
   -- loc_vars = function(self, info_queue, card)
       -- info_queue[#info_queue + 1] = { seal = 'Gold', config = { extra = 1.5 } }
        --return {
            --vars = {
--                card.ability.extra.xchipsndollar_mod,
             --   card.ability.extra.xchips,
           --     card.ability.extra.money_value,
         --       card.ability.extra.add,
         --       card.ability.extra.stockpile_return,
        --        card.ability.extra.stockpile,
      --          card.ability.extra.gold_seal_retrigger,
    --            card.ability.extra.stockpile_add,
  --          }
--        }
 --   end,
--    calculate = function(self, card, context)
--        -- Stockpile XChips and money 
--        if context.individual and context.cardarea == G.play then
--            local is_talisman = context.other_card.seal and context.other_card.seal == 'Gold'
--            if is_talisman then
--                card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchipsndollar_mod
--                card.ability.extra.money_value = card.ability.extra.money_value + card.ability.extra.xchipsndollar_mod
--                card_eval_status_text(card, 'extra', nil, nil, nil, {
--                    message = localize('k_upgrade_ex'),
--                    colour = G.C.GOLD,
--                    card = card
--                })
--            end
--            card.ability.extra.stockpile = card.ability.extra.stockpile * 2
--            local total_xchips = card.ability.extra.stockpile * card.ability.extra.xchips
--            local total_dollar = card.ability.extra.stockpile * card.ability.extra.money_value
--            if context.other_card == context.scoring_hand[#context.scoring_hand] then
--                card.ability.extra.stockpile = card.ability.extra.stockpile_return
--                card:juice_up(0.5, 0.5)
--                play_sound('holo1', 1, 0.5)
--                return {
--                    xchips = total_xchips,
--                    dollars = total_dollar,
--                }
--            end
--            return {
--                message = "Stockpiling X" .. total_xchips .. " Chips and $" .. total_dollar .. "!",
--                colour = G.C.GOLD,
--                card = card
--            }
--        end
--        -- Reset stockpile
--        if context.after then
--            card.ability.extra.stockpile = card.ability.extra.stockpile_return
--            return {
--                message = "Reset",
--                colour = G.C:inactive,
--                card = card
--            }
--        end
--        if context.setting_blind and G.GAME.blind.boss then
--            card.ability.extra.stockpile_return = card.ability.extra.add + card.ability.extra.stockpile_return
--            card.ability.extra.gold_seal_retrigger = card.ability.extra.gold_seal_retrigger + card.ability.extra.add
--            return {
--                message = localize('k_upgrade_ex'),
--                colour = G.C.EDITION,
--                card = card
--            }
--        end
--        -- Applies gold seals to the first played hand
--        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and not card.ability.extra.first_hand_triggered then
--            local talisman_cards = 0
--            for _, playing_card in ipairs(context.scoring_hand) do
--               if not playing_card.seal or not playing_card.seal == 'Gold' then
--                    playing_card:set_seal('Gold', true)
--                    talisman_cards = talisman_cards + 1
--                end
--            end
--            if talisman_cards > 0 then
--                return {
--                    message = "Applied!",
--                    colour = G.C.GOLD
--                }
--            end
--        end
        
--        -- Retriggers gold seals
--        if context.repetition and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 and not card.ability.extra.first_hand_triggered then
--            if context.other_card.seal and context.other_card.seal == 'Gold' then
--                return {
--                    repetitions = card.ability.extra.gold_seal_retrigger
--                }
--            end
--        end
--        -- Reset first hand trigger
--        if context.joker_main and G.GAME.current_round.hands_played == 0 and not card.ability.extra.first_hand_triggered then
--            card.ability.extra.first_hand_triggered = true
--            return nil, true
--        end
--        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
--            card.ability.extra.first_hand_triggered = false
--            return nil, true
--        end
--    end,
--     add_to_deck = function(self, card, from_debuff)
--        if not G.GAME.current_round.new_sisyphus_reset then
--            G.GAME.current_round.new_sisyphus_reset = true
--                    end
--                end
--}

--
-- This context is for when a voucher is bought/redeemed, don't forget this.
--
-- `context.buying_card and context.card.ability.set == "Voucher"`
--

-- ENA

SMODS.Atlas {
    key = "bbqena",
    path = "ENABBQ.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "dreamena",
    atlas = "bbqena",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    rarity = "busterb_Fantastic",
    cost = 100,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            joker_slots = 2,
            money_multiplier = 2,
            triggered = false,
            dollars = 4,
        },
},
    loc_txt = {
        name = "{C:white,E:1,s:2}DREAM{} {C:hearts,E:1,s:2}ENA{}",
        text = {
            "Spawns a random free voucher in the shop.",
            "Gains {X:gold,C:white}X$#1#{} and {C:attention}+#2#{} {C:attention}Joker Slots{}",
            "per redeemed voucher.",
            "{C:inactive}(Raked in dough from bought vouchers: {}{C:money}$#3#{C:inactive}.){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money_multiplier,
                card.ability.extra.joker_slots,
				card.ability.extra.dollars
            }
        }
    end,

    calculate = function(self, card, context)
        --Spawn a random free voucher in the shop.
        if context.starting_shop and not card.ability.extra.triggered then
                local voucher = SMODS.add_voucher_to_shop()
                voucher.cost = 0
                card.ability.extra.triggered = true
        end
        -- Buying a voucher increases moneys and joker slots
        if context.buying_card and context.card.ability.set == "Voucher" then
            G.jokers.config.card_limit = lenient_bignum(
			G.jokers.config.card_limit + math.min(100, to_big(card.ability.extra.joker_slots))
		)
            card.ability.extra.dollars = lenient_bignum(card.ability.extra.dollars * card.ability.extra.money_multiplier)
            card.ability.extra.triggered = false
        end
    end,
       calc_dollar_bonus = function(self, card)
		return lenient_bignum(card.ability.extra.dollars)
    end
}
-- Maxwell
SMODS.Atlas {
    key = "a_maxwell",
    path = "Maxwell.png",
    px = 71,
    py = 95
}
SMODS.Joker {
    key = "maxwell",
    atlas = "a_maxwell",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
    rarity = "busterb_Fantastic",
    cost = 100,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    loc_txt = {
        name = "{C:blue,E:1,s:2}MAXWELL{}",
        text = {
            "For {C:attention}every card held in hand{}, create a {C:attention}random{} {C:dark_edition}negative{} {C:attention}consumable{}.",
            "Sell this joker to spawn a {C:dark_edition}negative{} {V:1,E:1,s:1.5}Dream{} {C:attention}card{}."
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { colours = {HEX('b00b69')} } }
    end,
    calculate = function(self, card, context)
        -- For every card held in hand, create a random negative consumable
        if context.individual and context.cardarea == G.hand then
            local maxwell_notebook = pseudorandom_element(G.P_CENTER_POOLS.Consumeables, pseudoseed('maxwell')).key
            SMODS.add_card({ key = maxwell_notebook, edition = 'e_negative' })
        end
        -- sell this joker to create a negative dream card.
        if context.selling_self then
            SMODS.add_card({ key = "c_busterb_dream", edition = 'e_negative' })
        end
    end
}

-- 14th Fantastic Joker: "" - Destroys the joker to the right to create a random negative joker.

-- SMODS.Atlas {
--    key = "",
--    path = "",
--    px = 71,
--    py = 95
-- }

-- SMODS.Joker {
-- key = "",
--    atlas = "",
--    pos = { x = 0, y = 0 },
--    soul_pos = { x = 0, y = 1 },
--    pools = { ["Fantastic"] = true, ["bustjokers"] = true },
--    rarity = "busterb_Fantastic",
--    cost = 100,
--    blueprint_compat = true,
--    eternal_compat = true,
--    unlocked = true,
--    discovered = true,
--    loc_txt = {
--        name = "",
--        text = {
--            "",
--            ""
--        }
--    },
--    loc_vars = function(self, info_queue, card)
--		return { vars = {} }
--    end,
--    calculate = function(self, card, context)
--        end
--    end
-- }


-- SMODS.Atlas {
--    key = "",
--    path = "",
--    px = 71,
--    py = 95
-- }
