-- Ideal Joker - Rare Joker - Deal x10 Mult whenever an Ace is scored, 1 in 10 chance to spawn a red seal steel polychrome ace instead.
SMODS.Sound {
    key = "susielaugh",
    path = "laughsusie.ogg"
}

SMODS.Atlas {
    key = "idea",
    path = "susieidea.png",
    px = 71,
    py = 95
}
SMODS.Joker {
        key = "susie",
    atlas = "idea",
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
            aceodds = 10
        }
    },
    loc_txt = {
        name = "Susie's Idea",
        text = { "Deals {X:mult,C:white}X#3#{} Mult whenever an {C:attention}Ace{} is scored.",
                 "{s:0.8,C:inactive}({}{s:0.8,C:green}#1# in #2# chance{}{s:0.8,C:inactive} when scoring cards to spawn a {}{s:0.8,C:red}Red Seal{} {s:0.8}Steel{} {C:dark_edition,s:0.8}Polychrome{}{C:attention,s:0.8} Ace{}{C:inactive,s:0.8}.){}"
            
        }
    },
    loc_vars = function(self, info_queue, card)
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
SMODS.Atlas {
    key = "vigilance",
    path = "Vigi.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "vigilante",
    atlas = "vigilance",
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
            luckyxchips = 2,
            luckydollar = 3,
            luckychance = 10
        }
    },
    loc_txt = {
        name = "Wanted Poster",
        text = { 
            "Scored {C:attention}lucky cards{} give {X:chips,C:white}X#1#{} Chips and {C:money}$#2#{}.",
            "{C:green}#3# in #4#{} chance to add a {C:attention}lucky{} Ace card to deck."
     }
    },
    loc_vars = function(self, info_queue, card)
        local vigichance, vigiodds = SMODS.get_probability_vars(card, 1, card.ability.extra.luckychance, 'busterb_lucky_vigi')
    return {vars = { card.ability.extra.luckyxchips, card.ability.extra.luckydollar, vigichance, vigiodds }}
    end,
    	 add_to_deck = function(self, card, from_debuff)
        play_sound("busterb_locknload")
    end,
    calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and not context.blueprint then
                if SMODS.pseudorandom_probability(card, 'busterb_lucky_vigi', 1, card.ability.extra.luckychance, 'busterb_lucky_vigi') then
                    SMODS.add_card{ set = "Base", rank = "A", enhancement = "m_lucky"}
                    play_sound("busterb_vigi")
                end     
                if SMODS.has_enhancement(context.other_card, 'm_lucky') then
                return {
                    x_chips = card.ability.extra.luckyxchips,
                    dollars = card.ability.extra.luckydollar,
                    sound = "busterb_gunshot"
                }
            end
        end
    end
}
SMODS.Atlas {
    key = "bittles",
    path = "Bombardier.png",
    px = 71,
    py = 95
}
SMODS.Sound {
    key = "explode",
    path = "explode.ogg"
}
SMODS.Joker {
    key = "bombardier",
    atlas = "bittles",
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
            xmultmod = 0.1,
            xmult = 1
        }
    },
    loc_txt = {
        name = "Bombardier",
        text = { 
            "Gains {X:mult,C:white}X#1#{} Mult if {C:spade}Spades{} or {C:hearts}Hearts{} are scored",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
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

SMODS.Atlas{
    key = "lite",
    path = "roffle.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "roffle",
    atlas = "lite",
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
            xmultmod = 0.1,
            xmult = 1
        }
    },
    loc_txt = {
        name = "Duke of Faces",
        text = { 
            "Retriggers {C:attention}scored face cards{} based on",
            "{C:attention}how many cards{} are in {C:attention}played hand{}",
            "Gain {X:mult,C:white}X#1#{} Mult anytime a {C:attention}King{} is scored",
            "{C:inactive}(Currently: {X:mult,C:white}X#2# {C:inactive} Mult)"
             }
    },
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.xmultmod, card.ability.extra.xmult}}
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
SMODS.Atlas{
    key = "obv",
    path = "murphy.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "murphy",
    atlas = "obv",
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
            xmultmod = 9,
            xmult = 1,
            nineodds = 9
        }
    },
    loc_txt = {
        name = "Duke of Nines",
        text = { 
            "{C:green}#3# in #4#{} chance to gain {X:mult,C:white}X#1#{} Mult from scored {C:attention}9s",
            "{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)"
             }
    },
        loc_vars = function(self, info_queue, card)
            local ninechance, nineodds = SMODS.get_probability_vars(card, 1, card.ability.extra.nineodds, 'busterb_dukenines')
                return {vars = { card.ability.extra.xmultmod, card.ability.extra.xmult, ninechance, nineodds }}
            end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 9 then
                    if SMODS.pseudorandom_probability(card, 'busterb_dukenines', 1, card.ability.extra.nineodds, 'busterb_dukenines') then
                        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultmod
                        return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                        colour = G.C.MULT,
                        message_card = card
                        }
                    end
                end
            end
            if context.joker_main then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
}