-- Nostalgic Spinel - Deals X6000 Mult for every scored Queen.
-- Astro - Doubles XChips at the end of the round.
SMODS.Atlas{
    key = "secjkr",
    path = "Unseen.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "astro",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 1e50,
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
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "eechips",
                scalar_value = "eechipsincrement",
                scaling_message = {
                message = "^^" ..card.ability.extra.eechips.. " Chips",
                colour = SMODS.Gradients["busterb_eechipsgradient"]
            }
            })
            end
        if context.ante_change then
                        SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "eechipsincrement",
                operation = "X",
                scalar_value = "eechipsincrementmultiplier",
                scaling_message = {
                message = "Hee hee hee!",
                colour = SMODS.Gradients["busterb_eechipsgradient"]
            }
            })
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
        SMODS.add_card{ key = "j_busterb_astro", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
        G.GAME.blind.effect.onlyspades = false
        print("winner")
    end
end
})
local ThomasYap = {
    "I'm hiding something.",
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
    ":D",
    "Circus (Chicken Mix) - Five Nights at Freddy's",
    "{1e308}1e308 Mult",
    "Infinity Mult"
}
SMODS.Joker{
    key = "thomas",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 1 },
    soul_pos = { x = 2, y = 1, new = { x = 1, y = 1 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    forcetrigger_compat = true,
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
        SMODS.add_card{ key = "j_busterb_thomas", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
        G.GAME.blind.effect.antething = false
        G.GAME.blind.effect.soldcryptid = false
        print("superwinner")
    end
end
})

--Art and Code by Camostar34, teehee! Special thanks to FirstTry for letting me be a guest joker in his mod and guiding me with the art direction. 

to_big = to_big or function(x) return x end

SMODS.Joker{
    key = "samsonoc",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 2 },
    soul_pos = { x = 1, y = 2, new = { x = 2, y = 2 } },
    cost = 1e50,
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
        SMODS.add_card{ key = "j_busterb_samson", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
        ease_dollars(((-G.GAME.dollars)))
        G.GAME.blind.effect.dollarthing = false
        G.GAME.blind.effect.soldtemp = false
        print("superwinner")
    end
end
})

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
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 3 },
    soul_pos = { x = 2, y = 3, new = { x = 1, y = 3 } },
    cost = 1e50,
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
        SMODS.add_card{ key = "j_busterb_hedera", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
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
SMODS.Joker{
    key = "vessel",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 4 },
    soul_pos = { x = 2, y = 4, new = { x = 1, y = 4 } },
    cost = 1e50,
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
        SMODS.add_card{ key = "j_busterb_vessel", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
        G.GAME.blind.effect.vesselspawn = false
        G.GAME.blind.effect.trial = false
        print("vesselwinner")
    end
end
})
SMODS.Joker{
    key = "ruby",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 5 },
    soul_pos = { x = 2, y = 5, new = { x = 1, y = 5 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = {}, immutable = { number = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.immutable.number } }
    end,
    calculate = function (self, card, context)
                if context.using_consumeable and not context.blueprint then
                    for i = 1, card.ability.immutable.number do
                    local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
            local random_key = pseudorandom_element(pool, "ruby")
                    if random_key then SMODS.add_card{key = random_key, edition = "e_negative"} end
        end
    end
end
}
SMODS.Joker{
    key = "grahkon",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 6 },
    soul_pos = { x = 2, y = 6, new = { x = 1, y = 6 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = { slots = 2, chipmult = 2, }, immutable = { vmin = 10, vmax = 1000, cmmin = 10, cmmax = 1000, vm = 2 } },
    loc_vars = function(self, info_queue, card)
--        info_queue[#info_queue+1] = {key = "grahkon_list", set = "Other"}
        return { vars = { card.ability.extra.chipmult, card.ability.immutable.vm, card.ability.extra.slots } }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return{
                echips = card.ability.extra.chipmult,
                emult = card.ability.extra.chipmult,
            }
        end
        if SMODS.last_hand_oneshot and context.after and context.main_eval and not context.blueprint then
            local grahkon = pseudorandom(pseudoseed("busterb_grahkon"), 1, 8)
            if grahkon == 1 then
                SMODS.calculate_effect({
                message = "1",
                colour = G.C.GREEN,
                card = card
            })
            local grahkonvm = (pseudorandom(pseudoseed("busterb_grahkonvm"), card.ability.immutable.vmin, card.ability.immutable.vmax) / 100)
                local mypos = nil
		        for i = 1, #G.jokers.cards do
			        if G.jokers.cards[i] == card then
				        mypos = i
			    	    break
		    	    end
		        end
                if G.jokers.cards[mypos - 1] then
					Spectrallib.manipulate(G.jokers.cards[mypos-1], { value = card.ability.immutable.vm })
                SMODS.calculate_effect({ message = "< X" ..card.ability.immutable.vm, colour = G.C.GREEN}, card)
				end 
                if G.jokers.cards[mypos + 1] then
					Spectrallib.manipulate(G.jokers.cards[mypos+1], { value = card.ability.immutable.vm })
                SMODS.calculate_effect({ message = "X".. card.ability.immutable.vm.. " >", colour = G.C.GREEN}, card)
				end
        end
        if grahkon == 2 then
                SMODS.calculate_effect({
                message = "2",
                colour = G.C.GREEN,
                card = card
            })
            local grahkoncm = (pseudorandom(pseudoseed("busterb_grahkonvm"), card.ability.immutable.cmmin, card.ability.immutable.cmmax) / 100)
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chipmult",
                scalar_value = "gain",
                scalar_table = { gain = grahkoncm + card.ability.extra.chipmult },
                scaling_message = {
                    message = "^" .. card.ability.extra.chipmult .. " Mult",
                    colour = G.C.GREEN
                }
            })
    end
    if grahkon == 3 then
                SMODS.calculate_effect({
                message = "3",
                colour = G.C.GREEN,
                card = card
            })
        local tag_pool = get_current_pool('Tag')
        local selected_tag = pseudorandom_element(tag_pool, 'busterb_grahkon')
        local it = 1
        while selected_tag == 'UNAVAILABLE' do
            it = it + 1
            selected_tag = pseudorandom_element(tag_pool, 'busterb_grahkon_resample'..it)
        end
        add_tag(Tag(selected_tag, false, 'Small'))
    end
    if grahkon == 4 then
                SMODS.calculate_effect({
                message = "4",
                colour = G.C.GREEN,
                card = card
            })
        for i, v in pairs(SMODS.Sticker.obj_table) do
            if context.other_card ~= self and context.other_card == G.jokers.cards[1] then
            local jkr = {}
			    for i = 1, #G.jokers.cards do
				    if G.jokers.cards[i] ~= card then
					    jkr[#jokers + 1] = G.jokers.cards[i]
    				end
	    		end
                            jkr:remove_sticker(i)
                        end
                    end
                end
                if grahkon == 5 then
                SMODS.calculate_effect({
                message = "5",
                colour = G.C.GREEN,
                card = card
            })
                    local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
            local random_key = pseudorandom_element(pool, "ruby")
                    if random_key then SMODS.add_card{key = random_key} end
            end
            if grahkon == 6 then
                SMODS.calculate_effect({
                message = "6",
                colour = G.C.GREEN,
                card = card
            })
                                    local rarity_map = {
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
local _, key = pseudorandom_element(SMODS.Rarities, "cogito")
           key = rarity_map[key] or key
        local card = SMODS.add_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.jokers }
            end
            if grahkon == 7 then
                SMODS.calculate_effect({
                message = "7",
                colour = G.C.GREEN,
                card = card
            })
                G.jokers:change_size(math.min(100, card.ability.extra.slots))
            end
            if grahkon == 8 then
                SMODS.calculate_effect({
                message = "8",
                colour = G.C.GREEN,
                card = card
            })
                G.consumeables:change_size(math.min(100, card.ability.extra.slots))
            end
        end
end
}

SMODS.Joker{
    key = "hawaii",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 7 },
    soul_pos = { x = 2, y = 7, new = { x = 1, y = 7 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = { dollars = 10, select_mod = 1 }, immutable = { number = 2, reduce = 0.5, discards = 23, discards_remaining = 23 } },
    loc_vars = function(self, info_queue, card)
--        local tribvalue = 0
--            for _, c in ipairs(G.deck.cards) do
--                if c:is_face() then tribvalue = tribvalue + 1 end
--            end
--        info_queue[#info_queue+1] = {key = "hawaii_triboulet", set = "Other"}
--        info_queue[#info_queue+1] = {key = "hawaii_perkeo", set = "Other"}
 --       info_queue[#info_queue+1] = {key = "hawaii_canio", set = "Other"}
 --       info_queue[#info_queue+1] = {key = "hawaii_yorick", set = "Other"}
 --       info_queue[#info_queue+1] = {key = "hawaii_chicot", set = "Other"}
--        info_queue[#info_queue+1] = {key = "hawaii_powers", set = "Other"}
        return { vars = { card.ability.immutable.number, card.ability.immutable.discards, card.ability.immutable.discards_remaining, " ", card.ability.extra.select_mod, card.ability.extra.dollars } }
    end,
    calculate = function (self, card, context)
        local tribvalue = 0
            for _, c in ipairs(G.deck.cards) do
                if c:is_face() then tribvalue = tribvalue + 1 end
            end
        -- Perkeo's Spirit
        if context.ending_shop and not context.blueprint then
            SMODS.add_card{key="j_perkeo",edition="e_negative"}
        end
        -- Triboulet's Wits
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                xmult = tribvalue
            }
        end
        -- Canio's Madness
        if context.individual and context.cardarea == 'unscored' then
                    if context.other_card:is_face() then
            return {
                dollars = tribvalue
            }
        end
    end
        -- Yorick's Truth
        if context.discard and not context.blueprint then
            if card.ability.immutable.discards_remaining <= 1 then
                card.ability.immutable.discards_remaining = card.ability.immutable.discards
                -- See note about SMODS Scaling Manipulation on the wiki
                SMODS.change_play_limit(card.ability.extra.select_mod)
        		SMODS.change_discard_limit(card.ability.extra.select_mod)
                return {
                    message = "+" .. card.ability.extra.select_mod,
                    colour = SMODS.Gradients["busterb_SecretG"],
                    delay = 0.2
                }
            else
                card.ability.immutable.discards_remaining = card.ability.immutable.discards_remaining - 1
                return nil, true -- This is for Joker retrigger purposes
            end
        end
        -- Chciot's Will
        if context.setting_blind and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind.chips = G.GAME.blind.chips * card.ability.immutable.reduce
                        G.hand_text_area.blind_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
        end
end
}

SMODS.Joker{
    key = "jade",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 8 },
    soul_pos = { x = 2, y = 8, new = { x = 1, y = 8 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = { emult = 1 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.emult } }
    end,
    calculate = function (self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.denominator / 2
            }
        end
        if context.pseudorandom_result and context.result then
        SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "emult",
                scalar_table = {val = context.numerator},
                scalar_value = "val"
            })
        end
        if context.joker_main then
            return { emult = card.ability.extra.emult}
        end
end
}

SMODS.Joker{
    key = "crystal",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 9 },
    soul_pos = { x = 2, y = 9, new = { x = 1, y = 9 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = { extra = {  }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.jokers and #G.jokers.cards or 1 } }
    end,
    calculate = function (self, card, context)
        		if
			context.retrigger_joker_check
			and not context.retrigger_joker
			and not (context.other_card.ability and context.other_card.ability.key == "j_busterb_crystal")
		then
				return {
					message = localize("k_again_ex"),
					repetitions = #G.jokers.cards,
                    colour = G.C.BLUE,
					card = card,
				}
		end

end
}
SMODS.Joker{
    key = "sappy",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 10 },
    soul_pos = { x = 2, y = 10, new = { x = 1, y = 10 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = { emult = 1 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.emult } }
    end,
    calculate = function (self, card, context)
      if context.pre_discard then
         local carddraw = 0
         for i, c in ipairs(context.full_hand) do
            if c and not c.config.sappy_discard then
			c.config.sappy_discard = true
		end
            G.E_MANAGER:add_event(Event({
                func = function()
                   c:juice_up(0.5, 0.5)
                   card:juice_up(0.5, 0.5)

                   return true
                end
            }))

        c.ability.slib_perma_e_mult = (c.ability.slib_perma_e_mult or 1) + card.ability.extra.emult
        SMODS.calculate_effect({card = c, message = "^"..c.ability.slib_perma_e_mult+card.ability.extra.emult.." Mult", exp_asc = card.ability.extra.emult, colour = SMODS.Gradients["busterb_eemultgradient"] })
        end
        end
      if context.discard then
        local c = context.other_card
          G.E_MANAGER:add_event(Event({
              blocking = false,
              func = function()
                  if G.STATE ~= G.STATES.SELECTING_HAND then return false end
                  G.E_MANAGER:add_event(Event({
                      func = function()
                        if c.config.sappy_discard then
                          draw_card(G.discard, G.hand, 0, 'down', nil, c, 0.07)
                          c.config.sappy_discard = nil
                        end
                          return true
                      end
                  }))

                  return true
              end
          }))
      end
   end
}

SMODS.Joker{
    key = "revo",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 11 },
    soul_pos = { x = 2, y = 11, new = { x = 1, y = 11 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = {  }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_busterb_print
        return { vars = {  } }
    end,
    add_to_deck = function(self, card, from_debuff)
    SMODS.add_card{key="c_busterb_print"}
    end,
    calculate = function (self, card, context)
        if ( ( context.using_consumeable and context.consumeable.config.center_key == "c_busterb_print" ) and not context.blueprint and not context.retrigger_joker ) or context.forcetrigger then
            SMODS.add_card{key="c_busterb_print"}
            local nano = pseudorandom(pseudoseed("busterb_nano"), 1, 5)
            if nano == 1 then
            for i = 1, 1 do
            local card = SMODS.add_card{set = "Playing Card"}
            local edition = SMODS.poll_edition({guaranteed = true, key = "busterb_package"})
            local enhancement_type = pseudorandom_element({"Enhanced","Enhanced","Enhanced","Joker","Consumeables","Voucher","Booster"}, pseudoseed("package"))
            local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] or (enhancement_type == "Joker" and SMODS.Rarities[G.P_CENTERS[enhancement].rarity]
                and (
                    SMODS.Rarities[G.P_CENTERS[enhancement].rarity].get_weight
                    or (SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight and SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight > 0)
                )) do
                enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            end
            local seal = SMODS.poll_seal{guaranteed = true, key = "package"}
            card:set_edition(edition)
            card:set_ability(G.P_CENTERS[enhancement])
            card:set_seal(seal)
        end
        end
        if nano == 2 then
            SMODS.add_card{set="Joker",area=G.jokers}
        end 
        if nano == 3 then
            SMODS.add_card{set="Consumeables",area=G.consumeables}
        end
        if nano == 4 then
            SMODS.add_card({set="Booster",area=G.consumeables})
        end
        if nano == 5 then
            SMODS.add_card{set="Voucher",area=G.consumeables}
        end
    end
    if context.setting_blind and not context.blueprint then
        for k,v in ipairs(G.jokers.cards) do
        if v.config.center.key == "j_busterb_alucard" then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('busterb_crit', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                card_eval_status_text(card, "extra", nil, nil, nil, {
				message = "Critical Hit!",
				colour = G.C.GREEN,
				no_juice = true,
			})
        local rarity_map = {
  busterb_technopotent = "busterb_Grandiose",
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

local _, key = pseudorandom_element(SMODS.Rarities, "cogito")
           key = rarity_map[key] or key
        local c = SMODS.add_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.jokers }
        SMODS.calculate_effect{card=c,message="???"}
			return nil, true
		    end
        end
    end
end
end
}

SMODS.Joker{
    key = "aikoyori",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 12 },
    soul_pos = { x = 2, y = 12, new = { x = 1, y = 12 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    config = { extra = { emult = 2 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.emult } }
    end,
    calculate = function (self, card, context)
        if context.setting_blind or context.forcetrigger then
            if (#SMODS.find_card("j_busterb_aikoyori") + (G.GAME.aiko_buffer or 0) < 32) or G.GAME.modifiers.entr_gfb then
                G.GAME.aiko_buffer = (G.GAME.aiko_buffer or 0) + 1
                G.E_MANAGER:add_event(Event{
                    func = function()
                        local card2 = copy_card(card)
                        card.area:emplace(card2)
                        card2:add_to_deck()
                        G.GAME.aiko_buffer = 0
                        return true
                    end
                })
            end
        end
        if context.joker_main then
            return { emult = card.ability.extra.emult, colour = SMODS.Gradients["busterb_eemultgradient"] }
        end
    end,
        add_to_deck = function(self, card, from_debuff)
            G.jokers:change_size(1)
    end,
        remove_from_deck = function(self, card, from_debuff)
            G.jokers:change_size(-1)
    end,

}

SMODS.Joker{
    key = "nxkoo",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 13 },
    soul_pos = { x = 2, y = 13, new = { x = 1, y = 13 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = false,
    config = { extra = { e = 1, e_mod = 0.5, e_mod2 = 1.5 }, immutable = {  } },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
   local count = 0
    for _, v in pairs(SMODS.Mods) do
      if v.can_load then
        count = count + 1
      end
    end
    return {vars = {card.ability.extra.e, 1 + card.ability.extra.e * count, card.ability.extra.e_mod, card.ability.extra.e_mod2}}
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, v in pairs(SMODS.Mods) do
        if v.can_load then
          count = count + 1
          card.ability.extra.e = count
        end
      end
      return {message = "FAHHHHHHH!!!", sound = "busterb_fahhh", colour = SMODS.Gradients["busterb_epileptic"],escore = (1 + card.ability.extra.e * count)}
    end
      if context.pre_discard then
         for i, c in ipairs(context.full_hand) do
            if c:is_suit('Hearts') then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "e",
                scalar_value = "e_mod",
                scaling_message = {
                message = "^" ..card.ability.extra.e+card.ability.extra.e_mod.. " Score",
                colour = SMODS.Gradients["busterb_unstable"],
                sound = "busterb_fahhh1"
            }
            })

        end
    end
end
    if context.individual and context.cardarea == G.play then
        if SMODS.has_enhancement(context.other_card, 'm_wild') then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "e",
                scalar_value = "e_mod2",
                scaling_message = {
                message = "^" ..card.ability.extra.e+card.ability.extra.e_mod2.. " Score",
                colour = SMODS.Gradients["busterb_unstable"],
                sound = "busterb_fahhh1"
            }
            })
        end
  end
end
  
}

SMODS.Joker{
    key = "theia",
    atlas = "secjkr",
    rarity = "busterb_Secret",
    pools = { ["Secret"] = true},
    pos = { x = 0, y = 14 },
    soul_pos = { x = 2, y = 14, new = { x = 1, y = 14 } },
    cost = 1e50,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    config = { extra = { asc = 1, x_asc = 1, stack = 2, stack_mod = 1, stack_re = 1 }, immutable = { final_stack = 1 } },
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.asc, card.ability.extra.x_asc, card.ability.extra.stack, card.ability.extra.stack_mod, G.play and #G.play.cards or 0, " "}}
  end,
        add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(1e100)
		SMODS.change_discard_limit(1e100)
    end,
        remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-1e100)
		SMODS.change_discard_limit(-1e100)
    end,
  calculate = function(self, card, context)
        if context.modify_scoring_hand and not context.blueprint then
            return {
                add_to_hand = true
            }
        end
        if context.individual and context.cardarea == G.play then
            card.ability.extra.stack = card.ability.extra.stack * 2
            local total_asc = (card.ability.extra.stack * card.ability.extra.x_asc)
            if context.other_card == context.scoring_hand[#context.scoring_hand] then
                local ret = {}
                local c = context.other_card
                G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = "[ ]",
								scale = 5,
                                hold = 1.5,
                                backdrop_colour = G.C.BLACK,
								colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
								align = 'cm',
								major = c,
								offset = {x = 0, y = 0}
							})
							play_sound('busterb_gigapunch',1, 0.5)
							c:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
						}))   
                        ret.x_asc = total_asc
                        return ret     
            end
            return {
                asc = card.ability.extra.asc,
                message = "Accumulating X" .. total_asc .. " Asc Power",
                colour = G.C.BLACK,
                text_colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                card = card
            }
    end
            if context.after then
            card.ability.extra.stack = card.ability.extra.stack_re
            return {
                message = "Reset",
                colour = G.C.BLACK,
                text_colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                card = card
            }
        end
                if context.setting_blind and context.main_eval and not context.blueprint and G.GAME.blind.boss then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "stack_re",
                scalar_value = "stack_mod",
                scaling_message = {
                message = "+" .. card.ability.extra.stack_mod .. " Power!",
                colour = G.C.BLACK,
                text_colour = SMODS.Gradients["busterb_GoldenFreddyGradient"]
            }})
            card.ability.extra.stack = card.ability.extra.stack_re
        end
--        if context.joker_main then
--            return { exp_asc = #G.play.cards}
--        end
end
  
}
