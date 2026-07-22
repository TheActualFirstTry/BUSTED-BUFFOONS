-- Ideal Joker - Rare Joker - Deal x10 Mult whenever an Ace is scored, 1 in 10 chance to spawn a red seal steel polychrome ace instead.
SMODS.Sound {
    key = "susielaugh",
    path = "laughsusie.ogg"
}

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
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            acemult = 2,
            aceodds = 10,
            seal = 'Red'
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        local acechance, aceodds = SMODS.get_probability_vars(card, 1, card.ability.extra.aceodds, 'busterb_susies_idea') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
    return {vars = {acechance, aceodds, card.ability.extra.acemult}}
    end,
    calculate = function(self, card, context)
    if next(SMODS.find_mod("starspace")) then
        if context.other_card and 
        context.cardarea == G.play and 
        context.other_card:get_id() == 14 and 
        context.other_card:is_suit("Hearts") and 
        context.other_card.config.center.key == 'c_base' and 
        context.scoring_name == "High Card" and 
        G.GAME.hands["High Card"].level <= to_big(10)
        then
            SMODS.add_card{ key = "j_busterb_ralsei", edition = 'e_negative', stickers = {'eternal'}, force_stickers = true }
        end
    end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'busterb_susies_idea', 1, card.ability.extra.aceodds, 'busterb_susies_idea') then
                SMODS.add_card{ set = "Base", rank = "A", enhancement = "m_steel", edition = "e_polychrome", seal = "Red" }
                play_sound('busterb_susielaugh')
            end
            if context.other_card:get_id() == 14 and context.cardarea == G.play and not context.blueprint then
            return {
                Xmult = card.ability.extra.acemult
            }
        end
     end
end
}
-- Vigilant Joker - Rare Joker - Played Lucky Cards give x1.5 Chips and $3.
SMODS.Sound{
    key = "locknload",
    path = "shotgunload.ogg"
}
SMODS.Sound{
    key = "gunshot",
    path = "shotgunshot.ogg"
}
SMODS.Sound{
    key = "vigi",
    path = "vigi1.ogg"
}
SMODS.Joker{
    key = "vigilante",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            luckyxchips = 2,
            luckydollar = 3,
            luckychance = 10,
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        local vigichance, vigiodds = SMODS.get_probability_vars(card, 1, card.ability.extra.luckychance, 'busterb_lucky_vigi')
    return {vars = { card.ability.extra.luckyxchips, card.ability.extra.luckydollar, vigichance, vigiodds }}
    end,
    	 add_to_deck = function(self, card, from_debuff)
        play_sound("busterb_locknload")
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then            
                if SMODS.has_enhancement(context.other_card, 'm_lucky') then
                return {
                    x_chips = card.ability.extra.luckyxchips,
                    dollars = card.ability.extra.luckydollar,
                    sound = "busterb_gunshot"
                }

            else
                if SMODS.pseudorandom_probability(card, 'busterb_lucky_vigi', 1, card.ability.extra.luckychance, 'busterb_lucky_vigi') then
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card:set_seal("Gold", nil, true)
                scored_card:set_ability("m_lucky", nil, true)
                G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))                    
                    play_sound("busterb_vigi")
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
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            xmultmod = 0.1,
            xmult = 1
        }
    },
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.xmultmod, card.ability.extra.xmult}}
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
        if context.joker_main then
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
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            xmultmod = 0.1,
            xmult = 1
        }
    },
    loc_vars = function(self, info_queue, card)
            return { key = (card.edition and card.edition.negative) and "j_busterb_roffle_heavy" or nil , vars = {card.ability.extra.xmultmod, card.ability.extra.xmult}}
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
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultmod
                return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                colour = G.C.MULT,
                message_card = card
                }
        end
    end
    if context.joker_main then
        return{
            xmult = card.ability.extra.xmult
        }
    end
end
}
SMODS.Joker{
    key = "murphy",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            perma = 9
        }
    },
        loc_vars = function(self, info_queue, card)
                return {vars = { card.ability.extra.perma }}
            end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 9 then
                    context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.perma
                    return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
                end
            end
        end
}
SMODS.Joker{
    key = "samsontboi",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 1 },
    config = {
        extra = {
            perma = 0.25,
            give = 1.5,
            held = 4
        }
    },
        loc_vars = function(self, info_queue, card)
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
                return {vars = { x, y, z }}
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
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 1 },
    config = {
        extra = {
            perma = 0.5,
            give = 2,
            held = 10
        }
    },
        loc_vars = function(self, info_queue, card)
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
                return {vars = { x, y, z }}
            end,
        calculate = function(self, card, context)--
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
    end---
}
SMODS.Joker{
    key = "cerebella",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            perma = .25,
            give = 3,
            held = 5
        }
    },
        loc_vars = function(self, info_queue, card)
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
                return {vars = { x, y, z }}
            end,
        calculate = function(self, card, context)--
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
            if context.individual then---
                if context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
                    return { asc = y, card = context.other_card}
                end
                if context.cardarea == G.hand and context.other_card:is_suit("Diamonds") then
                SMODS.calculate_effect({dollars = z, card = context.other_card})
                context.other_card.ability.slib_perma_plus_asc = (context.other_card.ability.slib_perma_plus_asc or 0) + x
                    return { message = localize('k_upgrade_ex'), colour = G.C.GOLD, card = context.other_card }
            end----
        end----
    end---
}

SMODS.Joker{
    key = "spade_king",
    atlas = "rare",
    rarity = 3,
    pools = { ["bustjokers"] = true },
    cost = 8,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 2 },
    config = {
        extra = {
            perma = 1,
            give = 2,
            held = 25
        }
    },
        loc_vars = function(self, info_queue, card)
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
                return {vars = { x, y, z }}
            end,
        calculate = function(self, card, context)--
            local x = card.ability.extra.perma
            local y = card.ability.extra.give
            local z = card.ability.extra.held
            if context.individual then---
                if context.cardarea == G.play and context.other_card:is_suit("Spades") then
                    return { xscore = y, card = context.other_card}
                end
                if context.cardarea == G.hand and context.other_card:is_suit("Spades") then
                SMODS.calculate_effect({score = z, card = context.other_card})
                context.other_card.ability.perma_repetitions = (context.other_card.ability.perma_repetitions or 0) + x
                    return { message = localize('k_upgrade_ex'), colour = G.C.PURPLE, card = context.other_card }
            end----
        end----
    end---
}

SMODS.Joker {
    key = "walter",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 1, y = 2 },
    config = { extra = { sell_value = 2 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.sell_value,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.consumeable then
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
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 2, y = 2 },
    config = { extra = { vmod = 1 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_busterb_glittery
        return {
            vars = {
                card.ability.extra.vmod,
            }
        }
    end,
    calculate = function(self, card, context)
    if context.before then
        for k,v in ipairs(G.play.cards) do
            if SMODS.has_enhancement(v,"m_busterb_glittery") then
                v.ability.perma_repetitions = (v.ability.perma_repetitions or 0) + card.ability.extra.vmod
                SMODS.calculate_effect({message = "+" ..card.ability.extra.vmod.. " Repetitions", colour = SMODS.Gradients["busterb_grand"], card = v})
            end
        end
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
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 3, y = 2 },
    config = { extra = { triggered = false }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return {
            vars = {
                card.ability.extra.vmod,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.beat_boss and not card.ability.extra.triggered then
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
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 0, y = 3 },
    config = { extra = { triggered = false }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_busterb_bbpack_1
        return {
            vars = {
                card.ability.extra.vmod,
            }
        }
    end,
    calculate = function(self, card, context)
   if (context.starting_shop or context.ending_shop) and card.ability.extra.triggered then
     local booster = SMODS.add_booster_to_shop("p_busterb_bbpack_1")
	 booster.cost = 0
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
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 1, y = 3 },
    config = { extra = { x = 1.5, face = 2.5, switch = "sad" }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
                local x = card.ability.extra.x
        local face = card.ability.extra.face        

        return {
            vars = {
                x, face
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
    blueprint_compat = true,
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 2, y = 3 },
    config = { extra = { ga = 4, rn = 7 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.ga,
                card.ability.extra.rn
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
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 3, y = 3 },
    config = { extra = {  }, immutable = { garn = 47, garn_47 = 0 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.immutable.garn,
                card.ability.immutable.garn_47
            }
        }
    end,
        add_to_deck = function(self, card, from_debuff)
    end,
        remove_from_deck = function(self, card, from_debuff)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
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
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 0, y = 4 },
    config = {
        extra = {
        },
        immutable = {
            minchips = 1,
            maxchips = 5,
            maxerchips = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        play_sound("busterb_maltigi")
    end,
    calculate = function(self, card, context)
    if context.setting_blind and G.GAME.blind.boss then
        card:juice_up(100,100)
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
            return {
                score = pseudorandom('busterb_cupcake2', card.ability.immutable.maxerchips, card.ability.immutable.minchips),
                chips = pseudorandom('busterb_cupcake2', card.ability.immutable.maxerchips, card.ability.immutable.minchips),
                mult = pseudorandom('busterb_cupcake2', card.ability.immutable.maxerchips, card.ability.immutable.minchips),
                asc = pseudorandom('busterb_cupcake2', card.ability.immutable.maxerchips, card.ability.immutable.minchips),
                sound = "busterb_lightning",
                volume = 0.4,
                colour = SMODS.Gradients["busterb_grand"],
                card = card
            }
        else
            return {
                score = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                chips = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                mult = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
                asc = pseudorandom('busterb_cupcake', card.ability.immutable.maxchips, card.ability.immutable.minchips),
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
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 1, y = 4 },
    config = { extra = { mult = 8, chips = 24, asc = 2, score = 50 }, immutable = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild        
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
	local ret = {}
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
            ret.mult = card.ability.extra.mult
        end
            if context.other_card:is_suit("Clubs") then
            ret.chips = card.ability.extra.chips
        end
            if context.other_card:is_suit("Spades") then
            ret.score = card.ability.extra.score
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
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 2, y = 4 },
    config = { extra = { asc = 1, gain = 2, trigger = false }, immutable = { revert = 1 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.asc,
                card.ability.extra.gain,            }
        }
    end,
    calculate = function(self, card, context)
        local eval = function(card) return card.ability.extra.trigger == true end
        juice_card_until(card, eval, false)
        if context.joker_main then
            if card.ability.extra.trigger then
                SMODS.calculate_effect({
                asc = card.ability.extra.asc,
                sound = "busterb_gigapunch",
                volume = 0.4,
                colour= SMODS.Gradients["busterb_gfreddy"],
                message= "PUNCH!!!"},card)
                card.ability.extra.asc = card.ability.immutable.revert
                card.ability.extra.trigger = false
                else
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "asc",
                scalar_value = "gain",
                scaling_message = {
                message = "+" .. (card.ability.extra.asc + card.ability.extra.gain).." Ascension Power",
                colour = G.C.GOLD
            }})
        end
    end
    if context.after then
        local cap = card.children.center
        cap:set_sprite_pos({x = 2, y = 4})
    end
end,
    can_use = function(self,card)
        return G.GAME.blind.in_blind
    end,
    use = function(self, card, area, copier)
        local cap = card.children.center
        cap:set_sprite_pos({x = 0, y = 5})
        card.ability.extra.trigger = true
                SMODS.calculate_effect({
                sound = "busterb_cast",
                volume = 0.4,
                colour= SMODS.Gradients["busterb_gfreddy"],
                message= "Falcon..."},card)
    end
}

SMODS.Joker {
    key = "reset_spinel",
    unlocked = true, 
    atlas = "rare",
    blueprint_compat = false,
    pools = { ["bustjokers"] = true },
    rarity = 3,
    cost = 8,
    pos = { x = 3, y = 4 },
    config = { extra = { xmult = 1, xmult_mod = 6 }, immutable = { } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult_mod,                
            }
        }
    end,
    calculate = function(self, card, context)
if to_big(card.ability.extra.xmult) > to_big(1) then
        if context.joker_main then
            return {xmult = card.ability.extra.xmult}
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
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                scaling_message = {
                message = "X" ..(card.ability.extra.xmult + card.ability.extra.xmult_mod).. " Mult",
                colour = G.C.MULT
            }})
            end
        end
    end
}
