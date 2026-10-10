-- Ideal Joker - Rare Joker - Deal x10 Mult whenever an Ace is scored, 1 in 10 chance to spawn a red seal steel polychrome ace instead.

SMODS.Atlas {
    key = "rare",
    path = "rare.png",
    px = 71,
    py = 95
}
SMODS.Joker {
    key = "susie",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            acemult = 2,
            aceodds = 10,
            seal = 'Red'
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "generation" , "ace" , "rank", "chance", "seals", "editions", "enhancements", "xmult" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        local acechance, aceodds = SMODS.get_probability_vars(card, 1, card.ability.extra.aceodds, 'busterb_susies_idea') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
    return {vars = {number_format(acechance), number_format(aceodds), number_format(card.ability.extra.acemult)}}
    end,
    calculate = function(self, card, context)
    if context.before or context.forcetrigger then
            if SMODS.pseudorandom_probability(card, 'busterb_susies_idea', 1, card.ability.extra.aceodds, 'busterb_susies_idea') then
                SMODS.add_card{ set = "Base", rank = "A", enhancement = "m_steel", edition = "e_polychrome", seal = "Red" }
                play_sound('busterb_susielaugh')        
            end
    end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 14 and context.cardarea == G.play and not context.blueprint then
            return {
                xmult = card.ability.extra.acemult
            }
        end
     end
end
}
-- Vigilant Joker - Rare Joker - Played Lucky Cards give x1.5 Chips and $3.
SMODS.Joker{
    key = "vigilante",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            luckychance = 10,
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "modify_card", "chance", "enhancements", "xchips" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        info_queue[#info_queue + 1] = G.P_CENTERS.m_busterb_bloodmarked
        local vigichance, vigiodds = SMODS.get_probability_vars(card, 1, card.ability.extra.luckychance, 'busterb_lucky_vigi')
    return {vars = { number_format(vigichance), number_format(vigiodds) }}
    end,
    	 add_to_deck = function(self, card, from_debuff)
        play_sound("busterb_locknload")
    end,
    calculate = function(self, card, context)
        if context.before then
        for _, scored_card in ipairs(context.scoring_hand) do
            if SMODS.pseudorandom_probability(card, 'busterb_lucky_vigi', 1, card.ability.extra.luckychance, 'busterb_lucky_vigi') then
                if SMODS.has_enhancement(scored_card, 'm_lucky') then
                scored_card:set_ability("m_busterb_bloodmarked", nil, true)
                G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        func = function()
                                attention_text({
                                text = "<--o-->",
								scale = 1,
                                hold = 0.5,
                                backdrop_colour = G.C.CLEAR,
                                colour = G.C.BBBLACK,
								align = 'cm',
        						major = scored_card,
								offset = {x = 0, y = 0}
							})
                                attention_text({
                                text = "|",
								scale = 2,
                                hold = 0.5,
                                backdrop_colour = G.C.CLEAR,
                                colour = G.C.BBBLACK,
								align = 'cm',
        						major = scored_card,
								offset = {x = 0, y = G.CARD_H/2}
							})
                                attention_text({
                                text = "|",
								scale = 2,
                                hold = 0.5,
                                backdrop_colour = G.C.CLEAR,
                                colour = G.C.BBBLACK,
								align = 'cm',
        						major = scored_card,
								offset = {x = 0, y = -G.CARD_H/2}
							})
                            scored_card:juice_up()
                            play_sound("busterb_gunshot")
                            return true
                        end
                    }))
                    delay(0.5)
                    end
                end
            end
        end
    end
}
SMODS.Sound {
    key = "explode",
    path = "explode.ogg"
}
SMODS.Joker {
    key = "bombardier",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            xmultmod = 0.1,
            xmult = 1
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "hearts", "spades", "suit", "scaling", "xmult" },
    loc_vars = function(self, info_queue, card)
    return {vars = {number_format(card.ability.extra.xmultmod), number_format(card.ability.extra.xmult)}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") or context.other_card:is_suit("Hearts") then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultmod
                return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                colour = G.C.MULT,
                message_card = card
            }
            end
        end
        if context.joker_main or context.forcetrigger then
        return {
            x_mult = card.ability.extra.xmult,
            sound = "busterb_explode"
        }
    end
end
    
}
SMODS.Joker{
    key = "roffle",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            xmultmod = 0.1,
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "scaling", "king", "face" , "rank", "chance", "retrigger", "xmult" },
    loc_vars = function(self, info_queue, card)
            return { key = (card.edition and card.edition.negative) and "j_busterb_roffle_heavy" or nil , vars = {number_format(card.ability.extra.xmultmod)}}
    end,
    calculate = function(self, card, context)
    if context.cardarea == G.play then
        if context.repetition then
            if context.other_card:is_face() then
            return {
                repetitions = #context.scoring_hand
            }
        end
    end
        if context.individual and
        context.other_card:get_id() == 13 then
                local x = card.ability.extra.xmultmod
                context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) + x
                return { message = localize('k_upgrade_ex'), colour = G.C.MULT, card = context.other_card }
        end
    end
end
}
SMODS.Joker{
    key = "murphy",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            perma = 3
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "nine", "rank", "mult", "perma_bonus" },
    loc_vars = function(self, info_queue, card)
                return {vars = { card.ability.extra.perma }}
            end,
        calculate = function(self, card, context)
        if context.pre_joker then
            for k, v in pairs(G.hand.cards) do
                if v:get_id() == 9 and not next(SMODS.get_enhancements(v)) then
                            local enhancement = SMODS.poll_enhancement({guaranteed = true})
                            v:set_ability(enhancement)
                            SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.EPILEPSY, card = v })
                            play_sound('generic1', math.random()*0.2 + 0.9,0.5)
            end
        end
    end
end
}
SMODS.Joker{
    key = "samsontboi",
    atlas = "rare",
    rarity = 3,
    pools = { ["Food"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 1 },
    config = {
        extra = {
            perma = 0.25,
            give = 1.25,
            held = 4
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "hearts", "suit", "perma_bonus", "modify_card", "xmult", "mult"},
        loc_vars = function(self, info_queue, card)
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
                return {vars = { number_format(x), number_format(y), number_format(z) }}
            end,
        calculate = function(self, card, context)--
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
            if context.individual then---
                if context.cardarea == G.play and context.other_card:is_suit("Hearts") then
                    return { xmult = y, card = context.other_card}
                end
                if context.cardarea == G.hand and context.other_card:is_suit("Hearts") then
                SMODS.calculate_effect({mult = z, card = context.other_card})
                context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) + x
                    return { message = localize('k_upgrade_ex'), colour = G.C.MULT, card = context.other_card }
            end----
        end----
    end---
}
SMODS.Joker{
    key = "annie",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 1 },
    config = {
        extra = {
            chips = 1,
            chips_mod = 0.1
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "clubs", "suit", "xchips" },
        loc_vars = function(self, info_queue, card)
            local c = card.ability.extra.chips_mod
                if G.hand and G.hand.cards then
                    for k,v in ipairs(G.hand.cards) do
                        if v:is_suit("Clubs") then
                            c = c + 1
                        end
                    end
                else c = 0
            end
                return {vars = { number_format(card.ability.extra.chips), number_format(card.ability.extra.chips_mod), number_format(c) }}
            end,
        calculate = function(self, card, context)
        if context.before then
            local c = card.ability.extra.chips_mod
            for k,v in ipairs(G.hand.cards) do
                if v:is_suit("Clubs") then
                    c = c + 1
                end
            end
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "gain",
                scalar_table = { gain = c },
                scaling_message = {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }})
        end
        if context.joker_main and to_big(card.ability.extra.chips) > to_big(1) then
            return{xchips = card.ability.extra.chips}
        end
--[[
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
            if context.individual then---
                if context.cardarea == G.play and context.other_card:is_suit("Clubs") then
                    return { xchips = y, card = context.other_card}
                end
                if context.cardarea == G.hand and context.other_card:is_suit("Clubs") then
                SMODS.calculate_effect({chips = z, card = context.other_card})
                context.other_card.ability.perma_x_chips = (context.other_card.ability.perma_x_chips or 0) + x
                    return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS, card = context.other_card }
            end----
        end----
--]]
    end---
}
SMODS.Joker{
    key = "cerebella",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            dollars = 4,
            asc = 4
        },
        immutable = {
            d = 0,
            d_max = 4
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "diamonds", "suit", "asc", "economy" },
        loc_vars = function(self, info_queue, card)
            local x = card.ability.extra.dollars
            local y = card.ability.extra.asc
                return {vars = { number_format(x), number_format(y) }}
            end,
        calculate = function(self, card, context)
            if context.after then
                card.ability.immutable.d = 0
            end
            local x = card.ability.extra.dollars
            local y = card.ability.extra.asc
            if context.before then
            for k,v in ipairs(context.full_hand) do
                if v:is_suit("Diamonds") then
                    card.ability.immutable.d = card.ability.immutable.d + 1
                end
            end
            if card.ability.immutable.d >= card.ability.immutable.d_max then
                return { dollars = x }
            end
        end
        if context.joker_main then
            local c = false
            for k,v in ipairs(G.hand.cards) do
                if v:is_suit("Diamonds") then
                    c = true
                    break
                end
            end
            if c == true then
                return { asc = y }
            end
        end
    end
}

SMODS.Joker{
    key = "spade_king",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 2 },
    config = {
        extra = {
            score = 1.5,
        }
    },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "spades", "suit", "xscore" },
        loc_vars = function(self, info_queue, card)
            local x = card.ability.extra.score
                return {vars = { number_format(x) }}
            end,
        calculate = function(self, card, context)--
            local x = card.ability.extra.score
            if context.individual and context.other_card:is_suit("Spades") and (context.cardarea == G.play or context.cardarea == G.hand) then
                    return { xscore = x, card = context.other_card }
                end
            end
}

SMODS.Joker {
    key = "walter",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 1, y = 2 },
    config = { extra = { sell_value = 2 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.extra.sell_value),
            }
        }
    end,
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "sell_value", "economy" },
    calculate = function(self, card, context)
        if (context.selling_card and context.card.ability.consumeable) or context.forcetrigger then
            for _, area in ipairs({ G.jokers }) do
                for _, other_card in ipairs(area.cards) do
                    if other_card.set_cost then
                        other_card.ability.extra_value = (other_card.ability.extra_value or 0) +
                            card.ability.extra.sell_value
                        other_card:set_cost()
                    end
                end
            end
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}

SMODS.Joker {
    key = "reda",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 2, y = 2 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "enhancements", "passive", "retrigger", "boss_blind" },
    config = { extra = { vmod = 1 }, immutable = { vm = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_busterb_bloodmarked
        return {
            vars = {
                card.ability.immutable.vm,
            }
        }
    end,
    calculate = function(self, card, context)
        		if
			context.repetition
			and context.cardarea == G.play
            and SMODS.has_enhancement(context.other_card, "m_busterb_bloodmarked")
		then
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = card,
			}
		end

end,
}
--[[
local has_no_suit_ref = SMODS.has_no_suit
function SMODS.has_no_suit(card)
  if next(SMODS.find_card("j_busterb_reda")) and SMODS.has_enhancement(card, "m_busterb_glittery") then
    return false
  end
  return has_no_suit_ref(card)
end

local has_any_suit_ref = SMODS.has_any_suit
function SMODS.has_any_suit(card)
  if next(SMODS.find_card("j_busterb_reda")) and SMODS.has_enhancement(card, "m_busterb_glittery") then
    return true
  end
  return has_any_suit_ref(card)
end
]]


SMODS.Joker {
    key = "yahiamice",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = false,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 3, y = 2 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "editions", "passive", "boss_blind" },
    config = { extra = { triggered = false }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.end_of_round and context.beat_boss and not card.ability.extra.triggered) or context.forcetrigger then
            card.ability.extra.triggered = true
        end

        if (context.starting_shop or context.ending_shop) and card.ability.extra.triggered then
            for i = 1, #G.shop_jokers.cards do
                G.shop_jokers.cards[i]:set_edition({negative = true}, true)
                card.ability.extra.triggered = false
            end
        end
    end,
}
SMODS.Joker {
    key = "muscle_man",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = false,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 0, y = 3 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "passive", "boss_blind" },
    config = { extra = { triggered = false }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
   if ((context.starting_shop or context.ending_shop) and card.ability.extra.triggered) or context.forcetrigger then
    local packs = {
        "p_busterb_bbpack_1",
        "p_busterb_bbpack_2",
        "p_busterb_bbpack_3",
        "p_busterb_bbpack_4"
    }
    local g = pseudorandom_element(packs, "j_busterb_muscle_man")
     local booster = SMODS.add_booster_to_shop(g)
      card.ability.extra.triggered = false
    end
        if context.end_of_round and context.beat_boss and not card.ability.extra.triggered then
            card.ability.extra.triggered = true
        end
    end,
}

SMODS.Joker {
    key = "gangle",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 1, y = 3 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "suit", "hearts", "diamonds", "spades", "clubs", "face" },
    config = { extra = { x = 1.5, face = 2.5, switch = "sad" }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
                local x = card.ability.extra.x
        local face = card.ability.extra.face        

        return {
            vars = {
                number_format(x), number_format(face)
            }
        }
    end,
    calculate = function(self, card, context)
        local x = card.ability.extra.x
        local face = card.ability.extra.face        
        local gangle = card.children.center
        if context.setting_blind and not context.blueprint then
            --sad gangle = switch 0, happy gangle = switch 1
            if card.ability.extra.switch == "sad" then
                card.ability.extra.switch = "happy"
                G.E_MANAGER:add_event(Event({
                func = function()
                gangle:juice_up(0.3, 0.3)
			    gangle:set_sprite_pos({x = 1, y = 3})
                play_sound('tarot1')
                return true
            end
            }))
            SMODS.calculate_effect({colour=G.C.BLUE,message="Sad"},card)
            else
                card.ability.extra.switch = "sad"
                G.E_MANAGER:add_event(Event({
                func = function()
                gangle:juice_up(0.3, 0.3)
			    gangle:set_sprite_pos({x = 1, y = 5})
                play_sound('tarot1')
                return true
            end
            })) 
            SMODS.calculate_effect({colour=G.C.GOLD,message="Happy"},card)
        end
    end
    if context.individual and context.cardarea == G.play then
        local c = context.other_card
        if card.ability.extra.switch == "happy" then
            if c:is_suit("Clubs") or c:is_suit("Spades") then
                if c:is_face() then
                    return { xchips = face }
                else
                return { xchips = x }
            end
        end
    end
        if card.ability.extra.switch == "sad" then
            if c:is_suit("Hearts") or c:is_suit("Diamonds") then
                if c:is_face() then
                    return { xmult = face }
                else
                return { xmult = x }
            end
        end
    end
end
end
}

SMODS.Joker {
    key = "garn47",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 2, y = 3 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "passive", "hand_size", "hands" },
    config = { extra = { ga = 4, rn = 7 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.extra.ga),
                number_format(card.ability.extra.rn)
            }
        }
    end,
        add_to_deck = function(self, card, from_debuff)
        local ga = card.ability.extra.ga
        local rn = card.ability.extra.rn
        SMODS.change_play_limit(ga)
		SMODS.change_discard_limit(ga)
        G.hand:change_size(rn)
    end,
        remove_from_deck = function(self, card, from_debuff)
        local ga = card.ability.extra.ga
        local rn = card.ability.extra.rn
        SMODS.change_play_limit(-ga)
		SMODS.change_discard_limit(-ga)
        G.hand:change_size(-rn)
    end,
    calculate = function(self, card, context)
    end
}


SMODS.Joker {
    key = "carr",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 3, y = 3 },
    config = { extra = {  }, immutable = { garn = 47, garn_47 = 0 } },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "generation", "hands", "scaling" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.immutable.garn),
                number_format(card.ability.immutable.garn_47)
            }
        }
    end,
        add_to_deck = function(self, card, from_debuff)
    end,
        remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self, card, context)
        if context.after or context.forcetrigger then
            card.ability.immutable.garn_47 = card.ability.immutable.garn_47 + 1
            SMODS.calculate_effect({message = localize("k_upgrade_ex"),colour = G.C.BLACK},card)
            if card.ability.immutable.garn_47 == card.ability.immutable.garn then
                local pool = {}
                for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if v.hidden  and not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
                local random_key = pseudorandom_element(pool, "random_rare_consumeable")
                    if random_key then SMODS.add_card{key = random_key} end
                    card.ability.immutable.garn_47 = 0
                    SMODS.destroy_cards(card)
                return {
                    message = "Goodbye.",
                    colour = G.C.BLACK,
                   card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = "cupcake",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 0, y = 4 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "mult","chips","asc","score","boss_blind","economy","xblindsize", "xscore", "food" },
    config = {
        extra = {
            minchips = 1,
            maxchips = 5,
            maxerchips = 10
        },
        immutable = {
            minchips = 1,
            maxchips = 5,
            maxerchips = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { 
            background_colour = SMODS.Gradients["busterb_grand"],
            text_colour = G.C.WHITE,
            vars = { " "
            } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        play_sound("busterb_maltigi")
    end,
    calculate = function(self, card, context)
    if context.forcetrigger then
        local c = card
 				local ret = {}
                G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = "X",
								scale = 5,
                                hold = 1.5,
								colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
								backdrop_colour = SMODS.Gradients["busterb_grand"],
								align = 'cm',
								major = c,
								offset = {x = 0, y = 0}
							})
							play_sound('busterb_lightning',1, 0.5)
							c:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
						}))
                    ret.score = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)                        
					ret.mult = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.chips = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.plus_asc = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.xscore = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.dollars = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.xblind_size = (1/(pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)))
                    return ret
        end
        if context.setting_blind and G.GAME.blind.boss then
        card:juice_up(50,100)
        SMODS.calculate_effect({
                sound = "busterb_star",
                volume = 0.4,
                colour= SMODS.Gradients["busterb_grand"],
                message= "???"},card)
    end
    if context.before and G.GAME.blind.boss then
        SMODS.calculate_effect({
                sound = "busterb_cast",
                volume = 0.4,
                colour= SMODS.Gradients["busterb_grand"],
                message= "!!!"},card)
                delay(1)
    end
        if context.individual and context.cardarea == G.play then
            if G.GAME.blind.boss then
            local c = context.other_card
				local ret = {}
                G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = "X",
								scale = 5,
                                hold = 1.5,
								colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
								backdrop_colour = SMODS.Gradients["busterb_grand"],
								align = 'cm',
								major = c,
								offset = {x = 0, y = 0}
							})
							play_sound('busterb_lightning',1, 0.5)
							c:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
						}))
                    ret.score = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)                        
					ret.mult = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.chips = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.plus_asc = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.xscore = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.dollars = pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)
                    ret.xblind_size = (1/(pseudorandom('busterb_cupcake2', card.ability.extra.maxerchips, card.ability.immutable.minchips)))
                    return ret 
        else
            return {
                score = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                chips = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                mult = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                asc = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                dollars = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                message = "HUH???",
                sound = "busterb_huh",
                colour = SMODS.Gradients["busterb_grand"],
                card = card
            }
        end
    end
end
}
SMODS.Joker {
    key = "jevil",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 1, y = 4 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "mult","chips","asc","score","enhancements" },
    config = { extra = { mult = 8, chips = 24, asc = 2, score = 2 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild        
        return {
            vars = {
                number_format(card.ability.extra.mult),
                number_format(card.ability.extra.chips),
                number_format(card.ability.extra.asc),
                number_format(card.ability.extra.score)
            }
        }
    end,
    calculate = function(self, card, context)
        local ret = {}
        if context.forcetrigger then
            ret.mult = card.ability.extra.mult
            ret.chips = card.ability.extra.chips
            ret.xscore = card.ability.extra.score
            ret.asc = card.ability.extra.asc
            return ret
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
            ret.mult = card.ability.extra.mult
        end
            if context.other_card:is_suit("Clubs") then
            ret.chips = card.ability.extra.chips
        end
            if context.other_card:is_suit("Spades") then
            ret.xscore = card.ability.extra.score
        end
            if context.other_card:is_suit("Diamonds") then
            ret.asc = card.ability.extra.asc
        end
        return ret
    end
end
}

SMODS.Joker {
    key = "captain",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 2, y = 4 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "asc","scaling" },
    config = { extra = { asc = 1, gain = 2, trigger = false }, immutable = { revert = 1 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.extra.asc),
                number_format(card.ability.extra.gain),            }
        }
    end,
    calculate = function(self, card, context)
        local eval = function(card) return card.ability.extra.trigger == true end
        juice_card_until(card, eval, false)
        if context.joker_main or context.forcetrigger then
            if card.ability.extra.trigger then
                local ret = {}
                G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
						attention_text({
								text = "PUNCH",
								scale = 2.5,
                                hold = 1.5,
								backdrop_colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
								align = 'bm',
								major = card,
								offset = {x = 0, y = 0.15*G.CARD_H}
							})
							play_sound('busterb_gigapunch',1, 0.5)
							card:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
						}))
                        ret.plus_asc = card.ability.extra.asc
                return ret
                else
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "asc",
                scalar_value = "gain",
                operation = "X",
                scaling_message = {
                message = "+" .. (card.ability.extra.asc * card.ability.extra.gain).." Ascension Power",
                colour = G.C.GOLD
            }})
        end
    end
    if context.after then
        local cap = card.children.center
        cap:set_sprite_pos({x = 2, y = 4})
        if card.ability.extra.trigger then
        card.ability.extra.asc = card.ability.immutable.revert
        card.ability.extra.trigger = false
        end
    end
end,
    can_use = function(self,card)
        return G.GAME.blind.in_blind
    end,
    use = function(self, card, area, copier)
        local cap = card.children.center
        cap:set_sprite_pos({x = 0, y = 5})
        card.ability.extra.trigger = true
                    G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
						attention_text({
								text = "FALCON",
								scale = 2.5,
                                hold = 1.5,
								backdrop_colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
								align = 'bm',
								major = card,
								offset = {x = 0, y = 0.15*G.CARD_H}
							})
							play_sound('busterb_cast',1, 0.5)
							card:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
						}))

    end
}

SMODS.Joker {
    key = "reset_spinel",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    demicolon_compat = true,
    pools = { ["bustjokers"] = true, ["all_bb_joker"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 3, y = 4 },
    attributes = { "bustb_s", "bustb_d", "all_bb", "bustj", "mult", "ace", "face", "rank", "gem" },
    config = { extra = { mult = 1, mult_mod = 6 }, immutable = { } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.extra.mult),
                number_format(card.ability.extra.mult_mod),
            }
        }
    end,
    calculate = function(self, card, context)
        if to_big(card.ability.extra.mult) > to_big(1) then
            if context.joker_main or context.forcetrigger then
            return {mult = card.ability.extra.mult}
    end
end
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
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_mod",
                scaling_message = {
                message = "+" ..(card.ability.extra.mult + card.ability.extra.mult_mod).. " Mult",
                colour = G.C.MULT
            }})
            end
        end
    end
}
