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
        name = "Ideal Joker",
        text = { "Deals {X:mult,C:white}X#3#{} Mult whenever an {C:attention}Ace{} is scored.",
                 "{s:0.8,C:inactive}({}{s:0.8,C:green}#1# in #2# chance{}{s:0.8,C:inactive} when scoring cards to spawn a {}{s:0.8,C:red}Red Seal{} {s:0.8}Steel{} {C:dark_edition,s:0.8}Polychrome{}{C:attention,s:0.8} Ace{}{C:inactive,s:0.8}.){}"
            
        }
    },
    loc_vars = function(self, info_queue, card)
    local acechance, aceodds = SMODS.get_probability_vars(card, 1, card.ability.extra.aceodds, 'busterb_susies_idea') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
    return {vars = {acechance, aceodds, card.ability.extra.acemult}}
    end,
    calculate = function(self, card, context)
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
            odds = 10
        }
    },
    loc_txt = {
        name = "Vigilant Joker",
        text = { 
            "Scored {C:attention}lucky cards{} give {X:chips,C:white}X#1#{} Chips and {C:money}$#2#{}.",
            "{C:green}#3# in #4#{} chance to add a {C:attention}lucky{} Ace card to deck."
     }
    },
    loc_vars = function(self, info_queue, card)
        local vigichance, vigiodds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_lucky_vigi')
    return {vars = { card.ability.extra.luckyxchips, card.ability.extra.luckydollar, vigichance, vigiodds }}
    end,
    	 add_to_deck = function(self, card, from_debuff)
        play_sound("busterb_locknload")
    end,
    calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and not context.blueprint then
                if SMODS.pseudorandom_probability(card, 'busterb_lucky_vigi', 1, card.ability.extra.odds, 'busterb_lucky_vigi') then
                    SMODS.add_card{ set = "Base", rank = "A", enhancement = "m_lucky"}
                    play_sound("busterb_vigi")
                end     
                if SMODS.has_enhancement(context.other_card, 'm_lucky') then
                return {
                    x_chips = card.ability.extra.luckyxchips,
                    dollars = card.ability.extra.luckydollar,
                    play_sound("busterb_gunshot")
                }
            end
        end
    end
}
