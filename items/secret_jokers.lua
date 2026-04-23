-- Nostalgic Spinel - Deals X6000 Mult for every scored Queen.
-- Astro - Doubles XChips at the end of the round.
SMODS.Atlas{
    key = "a_astro",
    path = "ASTRO.PNG",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "astro",
    atlas = "a_astro",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    cost = 1e100,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
        extra = {
            eechips = 1,
            eechipsincrement = 0.1,
            eechipsincrementmultiplier = 2,
            jokerslot = 1,
        },
        immutable = {
            slotlimit = 100
        }
    },

    loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.eechips, 
            card.ability.extra.eechipsincrement, 
            card.ability.extra.eechipsincrementmultiplier, 
            colours = {HEX('00FFFF'), SMODS.Gradients["busterb_eechipsgradient"]}} }
    end,
    calculate = function(self, card, context)

            if context.card_added and context.card.config.center.key == "j_star_astro" then
                G.jokers:change_size((-G.jokers.config.card_limit) + math.min(G.jokers.config.card_limit + card.ability.extra.jokerslot, card.ability.immutable.slotlimit))
                end
        if context.joker_main then
            return {
                eechips = card.ability.extra.eechips
            }
        end
        if context.end_of_round and context.main_eval then
                card.ability.extra.eechips = card.ability.extra.eechips + card.ability.extra.eechipsincrement
                return {
                message = "^^".. card.ability.extra.eechips .. " Chips",
                colour = HEX('00FFFF'),
                card = card
                }
            end
        if context.ante_change then
            card.ability.extra.eechipsincrement = card.ability.extra.eechipsincrement * card.ability.extra.eechipsincrementmultiplier
                return {
                message = "^^".. card.ability.extra.eechipsincrement .. " Increment",
                colour = HEX('00FFFF'),
                card = card
                }
            end
        end
}
SMODS.Blind:take_ownership('bl_goad', {
    set_blind = function (self)
        G.GAME.blind.effect.onlyspades = true
        print("goaded")
    end,
    calculate = function (self, blind, context)
    if context.individual and context.cardarea == G.play and not context.other_card:is_suit("Spades", true) then
    print("loser")
        G.GAME.blind.effect.onlyspades = false
    end
end,
    defeat = function (self)
    if G.GAME.blind.effect.onlyspades and not next(SMODS.find_card('j_busterb_astro')) then
        SMODS.add_card{ key = "j_busterb_astro", edition = 'e_negative', stickers = {'eternal'}, force_stickers = true }
        G.GAME.blind.effect.onlyspades = false
        print("winner")
    end
end
})
local ThomasYap = {
    "I'm at Arby's, have fun!",
    "Screw you, take this!",
    "I love tall and hunky women, don't tell anyone, here you go.",
    "Duplicare is the GOAT, if you have Cryptid enabled, SPAWN HIM NOWWWWWW!!!",
    "I messed up, NOOOOO!!!",
    "Are you accepting requests? This is all i have...",
    "I hope to rival that one mod in terms of brokenness, it's the mod formerly known as-",
    "Welcome to the boulevard, this is my calling card.",
    "Har har har, har har!",
    "You win a prize!!!",
    "Go Wild!",
    ":)",
    "Circus (Chicken Mix) - Five Nights at Freddy's",
    "{1e308}1e308 Mult",
    "Infinity Mult"
}
SMODS.Atlas{
    key = "a_thomas",
    path = "Thomas.PNG",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "thomas",
    atlas = "a_thomas",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    cost = 1e100,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    config = {
        extra = {
            jokerslot = 1,
            eemult = 1,
            eemult_gain = 0.1,
            gain_gain = 0.1
        },
        immutable = {
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_busterb_mugen", set = "Spectral"}
		return { vars = { 
            card.ability.extra.eemult,
            card.ability.extra.eemult_gain,
            card.ability.extra.gain_gain,
            colours = { SMODS.Gradients["busterb_Thomasgradient"], SMODS.Gradients["busterb_eemultgradient"] }
        } }
    end,
    calculate = function(self, card, context)
        if context.card_added and context.card.config.center.key == "j_busterb_spinel" then
            SMODS.calculate_effect({
                    message = "SPINEL??",
                    colour = SMODS.Gradients["busterb_Thomasgradient"],
                    card = card
                })
        end
        if context.end_of_round and context.main_eval or context.forcetrigger then
                SMODS.add_card({ key = "c_busterb_mugen", area = G.consumeables })
                SMODS.calculate_effect({
                    message = ThomasYap[math.random(#ThomasYap)],
                    colour = SMODS.Gradients["busterb_Thomasgradient"],
                    card = card
                })
            end
            if context.using_consumeable then
        if context.consumeable.config.center.key == "c_busterb_mugen" then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "eemult",
                scalar_value = "eemult_gain",
                scaling_message = {
                message = "^^" ..card.ability.extra.eemult.. " Mult",
                colour = SMODS.Gradients["busterb_eemultgradient"]
            }
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "eemult_gain",
                scalar_value = "gain_gain",
                scaling_message = {
                message = ThomasYap[math.random(#ThomasYap)],
                colour = SMODS.Gradients["busterb_Thomasgradient"]
            }
            })
            end
        end
        if context.joker_main then 
        return{
            message = "^^" ..card.ability.extra.eemult.. " Mult",
            eemult = card.ability.extra.eemult,
            colour = SMODS.Gradients["busterb_eemultgradient"],
            card = card
            }
        end
    end
}

--Spawn Condition for Thomas
print("thing")
SMODS.Blind:take_ownership('bl_final_bell', {
    set_blind = function (self)
        if G.GAME.round_resets.ante == 8 and not next(SMODS.find_card('j_busterb_thomas')) then
        G.GAME.blind.effect.antething = true
        print("final_bell")
        else
        G.GAME.blind.effect.antething = false
        print("no_final_bell")
        end
    end,
    calculate = function (self, blind, context)
        if not next(SMODS.find_card('j_busterb_thomas')) then
    if context.selling_card and context.card.config.center.key == "c_busterb_mugen" then
--        G.E_MANAGER:add_event(Event({
--                    func = function()
--                        play_sound('tarot1')
--        				SMODS.juice_up_blind()
--		        		blind:wiggle()
--		        		blind.triggered = true
--        				G.GAME.blind.chips = to_big(G.GAME.blind.chips ^ 100)
--        				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
--                        return true
--                    end
--                }))
        G.GAME.blind.effect.soldcryptid = true
        print("ready")
        return{
            xblindsize = G.GAME.blind.chips ^ 100
        }
    end
end
    if context.end_of_round and context.game_over and context.main_eval then
            G.GAME.blind.effect.antething = false
            G.GAME.blind.effect.soldcryptid = false
            ease_ante(-G.GAME.round_resets.ante)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
                return {
                    message = "!!!",
                    saved = 'Oops!',
                    colour = G.C.UI.TEXT_DARK
                }
            end
end,
    defeat = function (self)
    if G.GAME.blind.effect.antething and G.GAME.blind.effect.soldcryptid and not next(SMODS.find_card('j_busterb_thomas')) then
        SMODS.add_card{ key = "j_busterb_thomas", edition = 'e_negative', stickers = {'eternal'}, force_stickers = true }
        G.GAME.blind.effect.antething = false
        G.GAME.blind.effect.soldcryptid = false
        print("superwinner")
    end
end
})

--Art and Code by Camostar34, teehee! Special thanks to FirstTry for letting me be a guest joker in his mod and guiding me with the art direction. 

to_big = to_big or function(x) return x end
SMODS.Atlas({
    key = "secretsamson",
    path = "secretsamson-Sheet.png",
    px = 71,
    py = 95
})




SMODS.Joker{
    key = "samson",
    atlas = "secretsamson",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    cost = 1e100,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,

    config = {
        extra = {
            bonus = 1.2,
            bank  = 0,
            -- jokerslot = ?  -- if you actually use this, define it here
        },
        immutable = {
            slotlimit = 100,
            bonus = 1.2,
            bank = 0
        }
    },



    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.immutable.bonus,
                colours = { HEX("fd913e"), SMODS.Gradients["busterb_eechipsgradient"] }
            }
        }
    end,

    calculate = function(self, card, context)
        -- When Samson is added, double money 
        if context.card_added
           and context.card
           and context.card.config
           and context.card.config.center
           and context.card.config.center.key == "j_smsn_secrectsamson"
        then
            return { dollars = to_big(G.GAME.dollars)}
        end

        local bonus = card.ability.immutable.bonus or 1
        local bank  = card.ability.immutable.bank

        if (not to_big(bank) or to_big(bank) <= to_big(0)) and G.GAME and to_big(G.GAME.dollars) then
            bank = to_big(G.GAME.dollars)
        end
        if not to_big(bank) or to_big(bank) <=  to_big(0) then
            return
        end


        if context.individual
           and not context.blueprint
           and context.cardarea == G.play 
           and context.other_card
           and (SMODS.has_enhancement(context.other_card, "m_gold")
                or context.other_card.seal == "Gold")
        then
            local new_bank = bank ^ bonus
            local delta    = math.floor(new_bank - bank)

            if to_big(delta) <= to_big(0) then
                return
            end

            card.ability.immutable.bank = new_bank

            return {
                dollars = delta,
                emult   = bonus,
            }
        end
if context.individual
           and not context.blueprint
           and context.cardarea == G.hand
           and context.other_card and not context.end_of_round
           and (SMODS.has_enhancement(context.other_card, "m_gold")
                or context.other_card.seal == "Gold")
        then
            local new_bank = bank ^ bonus
            local delta    = math.floor(new_bank - bank)

            if to_big(delta) <=  to_big(0) then
                return
            end

            card.ability.immutable.bank = new_bank

            return {
                dollars = delta,
                emult   = bonus,
            }
        end

    end,
}
-- Spawn Condition for Samson
print("thing")
SMODS.Blind:take_ownership('bl_ox', {
    set_blind = function (self)
        if G.GAME.dollars >= 1e50 and not next(SMODS.find_card('j_busterb_samson')) then
        G.GAME.blind.effect.dollarthing = true
        print("ox")
        end
    end,
    calculate = function (self, blind, context)
        if not next(SMODS.find_card('j_busterb_samson')) then
            local temper = context.using_consumeable and context.consumeable.config.center.key == "c_temperance"
    if temper then
--        G.E_MANAGER:add_event(Event({
--                    func = function()
--                        play_sound('tarot1')
--        				SMODS.juice_up_blind()
--		        		blind:wiggle()
--		        		blind.triggered = true
--        				G.GAME.blind.chips = to_big(G.GAME.blind.chips ^ 100)
--        				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
--                        return true
--                    end
--                }))
        G.GAME.blind.effect.soldtemp = true
        ease_dollars((-G.GAME.dollars)*2)
        print("ready")
    end
end
    if context.end_of_round and context.game_over and context.main_eval then
            G.GAME.blind.effect.dollarthing = false
            G.GAME.blind.effect.soldtemp = false
            ease_ante(-G.GAME.round_resets.ante)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
                return {
                    message = "!!!",
                    saved = 'Oops!',
                    colour = G.C.UI.TEXT_DARK
                }
            end
end,
    defeat = function (self)
    if G.GAME.blind.effect.dollarthing and G.GAME.blind.effect.soldtemp and not next(SMODS.find_card('j_busterb_samson')) then
        SMODS.add_card{ key = "j_busterb_samson", edition = 'e_negative', stickers = {'eternal'}, force_stickers = true }
        ease_dollars(((-G.GAME.dollars)))
        G.GAME.blind.effect.dollarthing = false
        G.GAME.blind.effect.soldtemp = false
        print("superwinner")
    end
end
})

SMODS.Atlas{
    key = "a_hedera",
    path = "Hedera.png",
    px = 71,
    py = 95
}

local function count_mod()
    seen = {}
    for _, c in ipairs(G.playing_cards or {}) do
        local ed = c.edition and c.edition.key
        local seal = c:get_seal()
        local enh = (SMODS.get_enhancements(c))
        if ed then seen[ed] = true end
        if seal then seen[seal] = true end
        for key in pairs(enh) do seen[key] = true end
    end
    local mods = 0
for _, mod in pairs(seen) do
  if mod then mods = mods + 1 end
end
return mods
end

SMODS.Joker{
    key = "hedera",
    atlas = "a_hedera",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 1e100,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
        extra = {
            cm = 0.33,
        },
        immutable = {

        }
    },

    loc_vars = function(self, info_queue, card)
        local cnt = count_mod()
		return {
            vars = {
                (((card.ability.extra.cm * cnt) + 1)),
                card.ability.extra.cm,
            },
        }
    end,
        calculate = function (self, card, context)
        if context.before and not context.blueprint then
            local cnt = count_mod()
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            local most_played = _handname
            local cm = ((card.ability.extra.cm * cnt) + 1)
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.DARK_EDITION,
                func = function()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        level_up = false,
                        hands = most_played,
                        StatusText = "^^"..cm,
                        func = function (base, hand, param)
                            return to_big(base):arrow(2, cm)
                        end
                    }
                end
            }
        end
        if context.end_of_round and context.main_eval or context.forcetrigger then
            local itemtray = {
                "c_familiar",
                "c_grim",
                "c_incantation"
            }
                local g = pseudorandom_element(itemtray, "busterb_hedera")
            SMODS.add_card({key = g, area = G.consumeables, edition = "e_negative", key_append = "busterb_hedera"})
            end
    end,
}
SMODS.Blind:take_ownership('bl_final_heart', {
    set_blind = function (self)
        if G.GAME.round_resets.ante == 8 and not next(SMODS.find_card('j_busterb_hedera')) then
        G.GAME.blind.effect.hedera = true
        print("hedera")
    end
    end,
    calculate = function (self, blind, context)
        if context.using_consumeable and context.consumeable.config.center.key == "c_judgement" and not next(SMODS.find_card('j_busterb_hedera')) then
            for k, v in ipairs(G.deck.cards) do
                local card_id = v:get_id()
                if card_id ~= 14 or not v:is_face() then
                    SMODS.destroy_cards(v)
                end
            end
            G.GAME.blind.effect.finale = true
            print("finale")
        end
        if context.selling_card and not next(SMODS.find_card('j_busterb_hedera')) then
            if context.card.config.center.key == "c_soul" and not next(SMODS.find_card('j_busterb_hedera')) then
            G.GAME.blind.effect.over = true
            print("over")
            return {
                xblindsize = G.GAME.blind.chips ^ 1.5,
            }
        end
        if context.selling_card and context.card.config.center.key == "c_busterb_dream" and not next(SMODS.find_card('j_busterb_hedera')) then
            ease_dollars(0)
            G.GAME.dollars = -1e100
            G.GAME.blind.effect.hell = true
            print("hell")
        end
    end
    end,
    defeat = function (self)
    if G.GAME.blind.effect.hedera and G.GAME.blind.effect.finale and G.GAME.blind.effect.over and G.GAME.blind.effect.hell and not next(SMODS.find_card('j_busterb_hedera')) then
        SMODS.add_card{ key = "j_busterb_hedera", edition = 'e_negative', stickers = {'eternal'}, force_stickers = true }
        G.GAME.blind.effect.hedera = false
        G.GAME.blind.effect.finale = false
        G.GAME.blind.effect.over = false
        G.GAME.blind.effect.hell = false
        ease_dollars(0)
        G.GAME.dollars = 0
        print("hederawinner")
    end
end
})
SMODS.Atlas{
    key = "v",
    path = "Vessel.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "vessel",
    atlas = "v",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 1e100,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = {}, immutable = { score = 0, odds = 2 } },
    loc_vars = function(self, info_queue, card)
        local pinorare, pinoodds = SMODS.get_probability_vars(card, 1, card.ability.immutable.odds, 'busterb_unstable')
        return { vars = { card.ability.immutable.score, pinorare, pinoodds } }
    end,
    calculate = function (self, card, context)
        if context.final_scoring_step then
            if SMODS.pseudorandom_probability(card, 'busterb_unstable', 1, card.ability.immutable.odds, 'busterb_unstable', true) then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind.chips = card.ability.immutable.score
                        G.hand_text_area.blind_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
            else
                return {
                    xmult = card.ability.immutable.score,
                    xchips = card.ability.immutable.score,
                    colour = G.C.DARK_EDITION,
                    score = card.ability.immutable.score
                }
        end
    end
end
}

--Spawn Condition for Vessel
SMODS.Blind:take_ownership('bl_final_vessel', {
    set_blind = function (self)
        if G.GAME.round_resets.ante == 8 and not next(SMODS.find_card('j_busterb_vessel')) then
        G.GAME.blind.effect.vesselspawn = true
        print("vesselspawn")
    end
    end,
    calculate = function (self, blind, context)
        if context.end_of_round and context.game_over and context.main_eval then
            G.GAME.blind.effect.vesselspawn = false
            ease_ante(-G.GAME.round_resets.ante)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
                return {
                    message = "!!!",
                    saved = 'Oops!',
                    colour = G.C.UI.TEXT_DARK
                }
            end
            if context.selling_card and not next(SMODS.find_card('j_busterb_vessel')) then
                if context.card.config.center.key == "c_soul" and not next(SMODS.find_card('j_busterb_vessel')) then
                G.GAME.blind.effect.trial = true
                print("trial")
            end
            end
            if G.GAME.blind.effect.trial and not next(SMODS.find_card('j_busterb_vessel')) then
    if context.individual and context.cardarea == G.play then        
        return {
            xblindsize = (G.GAME.blind.chips/16),
        }
    end
end
end,
    defeat = function (self)
    if G.GAME.blind.effect.vesselspawn and G.GAME.blind.effect.trial and not next(SMODS.find_card('j_busterb_vessel')) then
        SMODS.add_card{ key = "j_busterb_vessel", edition = 'e_negative', stickers = {'eternal'}, force_stickers = true }
        G.GAME.blind.effect.vesselspawn = false
        G.GAME.blind.effect.trial = false
        print("vesselwinner")
    end
end
})
