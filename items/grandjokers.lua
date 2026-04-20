SMODS.Atlas{
    key = "Grandholder",
    path = "Grandholder.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "a_igor",
    path = "IGOR.png",
    px = 71,
    py = 95
}
local IGORTalk = {
    'Stay the fuck away from me...',
    'I need to get her out the picture.',
    "I don't know what's harder, letting go or just being okay with it.",
    "I don't love you anymore...",
    "Don't leave, it's my fault!",
    "He's coming!",
    "Are we still friends?",
    "Exactly what you run from, you end up chasing.",
    "I can't even buy a home in private..."
}
SMODS.Joker{
    key = "igor",
    atlas = "a_igor",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra ={
            em = 0.01,
            emtotal = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.em, card.ability.extra.emtotal, colours = {HEX('f7b4c6'), SMODS.Gradients["busterb_eemultgradient"]}} }
    end,
    calculate = function(self, card, context)
        if context.before then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                faces = faces + 1
                scored_card:set_ability('m_busterb_crystallized', nil, true)
                G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))                    
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "emtotal",
                scalar_value = "em",
                scaling_message = {
                message = "^^" ..card.ability.extra.emtotal.. " Mult",
                colour = SMODS.Gradients["busterb_eemultgradient"]
}
            })
            end
        end
if faces > 0 then
                return {
                    message = IGORTalk[math.random(#IGORTalk)],
                    colour = HEX('f7b4c6')
                }
            end
        end
        if context.joker_main then
                SMODS.calculate_effect ({
                    eemult = card.ability.extra.emtotal,
                    message = "^" ..card.ability.extra.emtotal.. " Mult",
                    colour = SMODS.Gradients["busterb_eemultgradient"],
                    card = card
                })
    end
end
}
SMODS.Atlas{
    key = "Flowey",
    path = "Asriel.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "asriel",
    atlas = "Flowey",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
    extra = {
      emult = 1,
      echips = 1,
      emult_gain = 1.5,
      echips_gain = 1.5,
      triggered = false
        }
    },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('polychrome', nil, card.ARGS.send_to_shader)
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.emult,
            card.ability.extra.echips,
            card.ability.extra.emult_gain,
            card.ability.extra.echips_gain,
            colours = {HEX('DBD8FF'),SMODS.Gradients["busterb_eechipsgradient"],SMODS.Gradients["busterb_eemultgradient"]}
        } }
    end,
    calculate = function(self, card, context)
         if context.starting_shop and not card.ability.extra.triggered then
     local booster = SMODS.add_booster_to_shop("p_spectral_mega_1")
	 booster.cost = 0
      card.ability.extra.triggered = true
    end
    if context.open_booster then
      card.ability.extra.triggered = false
    end
    if context.using_consumeable then
        if context.consumeable.config.center.key == "c_soul" then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "echips",
                scalar_value = "echips_gain",
                scaling_message = {
                message = "^" ..card.ability.extra.echips.. " Chips",
                colour = SMODS.Gradients["busterb_eechipsgradient"]
            }
            })
        end 
    if context.consumeable.config.center.key == "c_busterb_dream" then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "emult",
                scalar_value = "emult_gain",
                scaling_message = {
                message = "^" ..card.ability.extra.emult.. " Mult",
                colour = SMODS.Gradients["busterb_eemultgradient"]
            }
            })
    end
    end
    if context.joker_main then
      return {
        e_mult = card.ability.extra.emult,
        e_chips = card.ability.extra.echips
      }
    end
      if context.skipping_booster then
        local hopesanddreams = pseudorandom_element(G.P_CENTER_POOLS.Spectral, pseudoseed('asrielspawnsaspectral')).key
        SMODS.add_card({key = hopesanddreams, area = G.consumeables, edition = "e_negative", key_append = "asrielspawnsaspectral"})
    end
end
}
SMODS.Atlas{
    key = "jimbussy",
    path = "Jimbo.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "joker",
    atlas = "jimbussy",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
        },
        immutable = { valuemodification = 4, valuecap = 1e100 }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.immutable.valuemodification, " ", colours = {SMODS.Gradients["busterb_balatro"], SMODS.Gradients["busterb_epileptic"]}} }
    end,
calculate = function(self, card, context)
  if context.ante_change or context.forcetrigger then
    for i, joker in ipairs(G.jokers.cards) do
        if joker.config.center.key ~= "j_busterb_joker" then
        Spectrallib.manipulate(joker, { value = card.ability.immutable.valuemodification })
      end
    end
    SMODS.calculate_effect({message = "X" ..card.ability.immutable.valuemodification, colour = SMODS.Gradients["busterb_balatro"], card = card})
  end
end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}
-- gray image of thinking baby meme
local oldgetcurrentpool = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)
  if next(SMODS.find_card('j_busterb_joker')) then
    if _type == 'Joker' and _append == 'sho' then
        local poll = pseudorandom('rarity'..G.GAME.round_resets.ante.._append)
        if poll < (1/20) then
            _legendary = true
        end
    end
  end
    return oldgetcurrentpool(_type, _rarity, _legendary, _append)
end

local oldcardsetcost = Card.set_cost
function Card:set_cost()
    local g = oldcardsetcost(self)
    if next(SMODS.find_card('j_busterb_joker')) then
      if self:is_rarity('Legendary') then self.cost = 0 end
    return g
  end
end

SMODS.Sound{
    key = "gfreddyyap",
    path = "g_freddy_yap.ogg",
}

SMODS.Sound{
    key = "gfreddygiggle",
    path = "g_freddy_giggle.ogg",
}

SMODS.Atlas{
    key = "g_freddy",
    path = "GFreddy.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "golden_freddy",
    atlas = "g_freddy",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 500,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    config = {
        extra = {
            jokerslot = 1,
        },
        immutable = {
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            " ",
            colours = { SMODS.Gradients["busterb_GoldenFreddyGradient"] }
        } }
    end,
    add_to_deck = function(self, card, from_debuff)
        play_sound("busterb_gfreddyyap")
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss or context.forcetrigger then
--            local souldream = pseudorandom(pseudoseed("busterb_gfreddysoul"), 1, 2)
--            if souldream == 1 then 
--                local c = SMODS.create_card({key = "c_busterb_dream", edition = "e_negative"})
--                    c:add_to_deck()
--                    G.consumeables:emplace(c)
--            end
--            if souldream == 2 then 
--                local c = SMODS.create_card({key = "c_busterb_slumber", edition = "e_negative"})
--                    c:add_to_deck()
--                    G.consumeables:emplace(c)
--            end
                local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if v.hidden  and not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
                local random_key = pseudorandom_element(pool, "random_rare_consumeable")
                    if random_key then SMODS.add_card{key = random_key} end
                return {
                    message = "Har Har Har!",
                    sound = "busterb_gfreddygiggle",
                    colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                   card = card
                }            
            end
        end
}
SMODS.Sound{
    key = "pepparry",
    path = "sfx_parry.ogg"
}
SMODS.Sound{
    key = "pepyell",
    path = "peppinoangryscream.ogg"
}
SMODS.Sound{
    key = "pepangry",
    path = "peppinoangryscream2.ogg"
}

SMODS.Atlas{
    key = "a_peddito",
    path = "peddito.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "peddito",
    atlas = "a_peddito",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    unlocked = true,
    discovered = true,
    config = {extra = {emult = 1},
    immutable = { gain = .25, dp = 1, tallyup = 1, tally = 0, deduction = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {
             card.ability.immutable.dp,
             card.ability.immutable.gain,
             card.ability.extra.emult,
             card.ability.immutable.tally,
             card.ability.immutable.deduction,
             card.ability.immutable.tallyup,
             " ",
             colours = {HEX('d868a0'),SMODS.Gradients["busterb_eemultgradient"]}
            } }
    end,
    calculate = function(self, card, context)
if to_big(card.ability.extra.emult) > to_big(1) then
    if context.joker_main then 
    return{
    message = "YEEEEOOOW!!!",
    eemult = card.ability.extra.emult,
    colour = HEX('d868a0'),
    sound = "busterb_pepangry",
    card = card
    }
end    
end
if context.end_of_round then
        if context.main_eval and context.beat_boss then
    card.ability.immutable.dp = card.ability.immutable.dp + card.ability.immutable.gain
    SMODS.calculate_effect({message = "+" ..card.ability.immutable.gain.. " Revive", sound = "busterb_pepyell", colour = HEX('d868a0'), card = card})
end

if (context.game_over and card.ability.immutable.dp > 0.99) or context.forcetrigger then
    card.ability.immutable.dp = card.ability.immutable.dp - card.ability.immutable.deduction
    SMODS.calculate_effect ({
                    message = "-" ..card.ability.immutable.deduction.. " Revive",
                    colour = HEX('d868a0'),
                    card = card
                })
    card.ability.immutable.tally = card.ability.immutable.tally + card.ability.immutable.tallyup
    SMODS.calculate_effect ({
                    message = "+" ..card.ability.immutable.tallyup.. " Tally",
                    colour = HEX('d868a0'),
                    card = card
                })
    card.ability.extra.emult = card.ability.extra.emult + (card.ability.immutable.tally/2)
    SMODS.calculate_effect ({
                    message = "^^" ..card.ability.extra.emult.. " Mult",
                    colour = SMODS.Gradients["busterb_eemultgradient"],
                    card = card
                })
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
                SMODS.calculate_effect ({
                    message = "!!!", sound = "busterb_pepparry",
--                    message = "-" ..card.ability.immutable.deduction.. " Revive / ^^" ..card.ability.extra.emult.. " Mult",
                    saved = "You're lucky.",
                    colour = HEX('d868a0'),
                    card = card
                })
end
end
end
}
SMODS.Atlas{
    key = "QD",
    path = "QueenDeltarune.png",
    px = 71,
    py = 95
} 
SMODS.Sound{
    key = "deltabomb",
    path = "deltarune-explosion.ogg"
}
SMODS.Joker{
    key = "queen",
    atlas = "QD",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 500,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    config = {
        extra = {
            xmult = 10,
            emult = 1,
            xmultmod = 10,
            emultmod = 1
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_gros_michel
		return { 
            background_colour = G.C.BLACK,
            text_colour = G.C.WHITE,
            vars = { 
            card.ability.extra.xmult,
            card.ability.extra.emult,
            card.ability.extra.xmultmod,
            card.ability.extra.emultmod
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                xmult = card.ability.extra.xmult,
                emult = card.ability.extra.emult,
                sound = "busterb_explode",
                colour = SMODS.Gradients["busterb_eemultgradient"]
            }
        end
        if context.setting_blind or context.forcetrigger then
            SMODS.add_card{key = "j_gros_michel", edition = "e_negative"}
        end
            if context.joker_type_destroyed and context.card.config.center.key == "j_gros_michel" then 
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "emult",
                scalar_value = "emultmod",
                colour = SMODS.Gradients["busterb_eemultgradient"]
            })
            end
            if context.selling_card and context.card.config.center.key == "j_gros_michel" then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmultmod",
                colour = G.C.RED
            })
            end
    end
}
SMODS.Atlas{
    key = "thedoise",
    path = "Doise.png",
    px = 71,
    py = 95
} 
SMODS.Sound{
    key = "doag",
    path = "Doag.ogg"
}
SMODS.Sound{
    key = "doawaw",
    path = "Doawaw.ogg"
}
SMODS.Sound{
    key = "doiseded",
    path = "DoiseScream.Wav"
}
SMODS.Joker{
key = "doise",
    atlas = "thedoise",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 500,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    config = {
        extra = {
            odds = 2
        },
        immutable = {
            minchips = 100,
            maxchips = 1e100
        }
    },
    loc_vars = function(self, info_queue, card)
        local doisechance, doiseodds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_doisechange')
        return { vars = {
             card.ability.immutable.maxchips,
             card.ability.immutable.minchips,
             " ",
             doisechance,
             doiseodds,
             colours = {HEX('48A0F8'),SMODS.Gradients["busterb_eechipsgradient"]}
            } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        play_sound("busterb_doiseded")
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'busterb_doisechange', 1, card.ability.extra.odds, 'busterb_doisechange') then
            return {
                xchips = pseudorandom('busterb_doisexchips', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                message = "Woag",
                sound = "busterb_doag"
            }
        else
            return {
                echips = pseudorandom('busterb_doiseechips', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                message = "DOAG",
                sound = "busterb_doawaw",
                colour = SMODS.Gradients["busterb_eechipsgradient"]
            }
        end
    end
end
}
SMODS.Atlas{
    key = "orange",
    path = "TSC.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "tsc",
    atlas = "orange",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 500,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
        extra = {
            eechips = 1,
            eechipsincrement = 0.01,
        },
        immutable = {
            eecap = 700,
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.eechips, 
            card.ability.extra.eechipsincrement, 
            " "} }
    end,
    calculate = function(self, card, context)

        if context.joker_main then
            return {
                eechips = card.ability.extra.eechips
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
                for k, v in pairs(G.hand.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.6,
                    func = function()
                        v:juice_up()
                        if v.config.center_key ~= "m_busterb_nanotech" then
                            v:set_ability(G.P_CENTERS.m_busterb_nanotech)
                            v:set_edition(nil)
                            v:set_seal(nil)
                            play_sound('generic1', math.random()*0.2 + 0.9,0.5)
                            SMODS.scale_card(card, {
                                ref_table = card.ability.extra,
                                ref_value = "eechips",
                                scalar_value = "eechipsincrement",
                                colour = SMODS.Gradients["busterb_eechipsgradient"]
                            })
                        end
                        return true
                    end
                })) 
            end
        end
    end
}

SMODS.Atlas{
    key = "hellsing",
    path = "Alucard.png",
    px = 71,
    py = 95
}
--
SMODS.Joker{
    key = "alucard",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    atlas = "hellsing",
    blueprint_compat = true,
    demicoloncompat = true,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 500,
    config = {
        extra = {
            eemult = 1,
            eemult_gain = 0.1,
        },
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.eemult,
                card.ability.extra.eemult_gain,
                colours = { HEX("BC1006") }
            },
        }
    end,

    calculate = function(self, card, context)
                if (context.before and not context.blueprint) or context.forcetrigger then
            local scalar = 0

            for _, card in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(card)) and not card.debuff and not card.vampired then
                    scalar = scalar + 1
                    card.vampired = true
                    card:set_ability("c_base", nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up()
                            card.vampired = nil
                            return true
                        end,
                    }))
                end
            end
            SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "eemult",
                    scalar_value = "gain",
                    scalar_table = { gain = scalar * card.ability.extra.eemult_gain },
                })
        end
        if context.discard then
            context.other_card:set_ability('m_busterb_bloodmarked', nil, true)
        end
        if context.joker_main or context.forcetrigger then
            return { eemult = card.ability.extra.eemult }
        end
    end,
}

SMODS.Atlas{
    key = "vajra",
    path = "Vajram.png",
    px = 71,
    py = 95
}
--
SMODS.Joker{
    key = "vajram",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    atlas = "vajra",
    blueprint_compat = true,
    demicoloncompat = true,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 500,
    config = {
        extra = {
            eemult = 1,
            gauge = 1,
            gauge_gain = 1
        },
        immutable = {
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.eemult,
                card.ability.extra.gauge,
                card.ability.extra.gauge_gain,
                 " ",
                colours = { HEX("BC1006") }
            },
        }
    end,

    calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "gauge",
                scalar_value = "gauge_gain",
                scaling_message = {
                        message = ( card.ability.extra.gauge + card.ability.extra.gauge_gain ) .. " Gauge",
                        colour = HEX("BC1006"),
                    },
            })
        end
    if context.end_of_round and context.main_eval and not context.blueprint then
        card.ability.extra.gauge = card.ability.extra.gauge * 0.25
        SMODS.calculate_effect ({
                    message = card.ability.extra.gauge .. " Gauge",
                    colour = HEX("BC1006"),
                    card = card
                })
        SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "eemult",
                    scalar_value = "gain",
                    scalar_table = { gain = card.ability.extra.gauge * card.ability.extra.eemult },
                    scaling_message = {
                        message = "^^" .. ( card.ability.extra.gauge * card.ability.extra.eemult ) .. " Mult",
                        colour = SMODS.Gradients["busterb_eemultgradient"]
                    },
                })
    end
        if context.joker_main then
            return{
                emult = card.ability.extra.gauge,
                eemult = card.ability.extra.eemult,
                colour = HEX("BC1006")
            }
        end
end
}
SMODS.Atlas{
    key = "a_caine",
    path = "Caine.png",
    px = 71,
    py = 95
}
--
SMODS.Joker{
    key = "caine",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    atlas = "a_caine",
    caine = true,
    blueprint_compat = true,
    demicoloncompat = true,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 500,
    config = {
        extra = {
            more = 1,
            redeem = 1
        },
        immutable = {
            more = 1,
            redeem = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.redeem,
                card.ability.extra.more,
                 " ",
            },
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            if context.beat_boss then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "redeem",
                    scalar_value = "more",
                    scaling_message = {
                        message = "+" .. card.ability.extra.more .. " Redeem",
                        colour = HEX("48A0F8"),
                    },
                })
            end
        end
        if context.cainebutton and card.ability.extra.redeem > 0 then
            card.ability.extra.redeem = card.ability.extra.redeem - card.ability.immutable.more
            SMODS.calculate_effect ({
                    message = "-" .. card.ability.extra.more .. " Redeem",
                    colour = HEX("48A0F8"),
                    card = card
                })
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                func = function()
            
                    local area
                    if G.STATE == G.STATES.HAND_PLAYED then
                        if not G.redeemed_vouchers_during_hand then
                            G.redeemed_vouchers_during_hand =
                                CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
                        end
                        area = G.redeemed_vouchers_during_hand
                    else
                        area = G.play
                    end
                    local card = create_card("RedeemableBacks", G.play, nil, nil, nil, nil, nil, "entr_large_deck")
                    if card.config.center.key == "j_joker" then
                        card:set_ability(G.P_CENTERS.b_red)
                    end
                    card:add_to_deck()
                    area:emplace(card)
                    card.cost = 0
                    card:redeem_deck()
                    return true
                end
            })
            return nil, true
        end
    end
}
SMODS.Atlas{
    key = "bigbang",
    path = "BBD.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "bbd",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    atlas = "bigbang",
    blueprint_compat = true,
    demicoloncompat = true,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    cost = 500,
    config = {
        extra = {
            pokerhand = 2,
            asc = 5
        },
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.pokerhand,
                card.ability.extra.asc,
                 " ",
            },
        }
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 then
        return{
                message = localize("k_upgrade_ex"),
                colour = G.C.DARK_EDITION,
                func = function()
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        level_up = false,
                        hands = context.scoring_name,
                        StatusText = "^"..card.ability.extra.pokerhand,
                        func = function (base, hand, param)
                            return to_big(base):pow(card.ability.extra.pokerhand)
                        end
                    }
                end,
            }
    end
end
}