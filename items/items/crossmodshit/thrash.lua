SMODS.Atlas{
    key = "tmachine",
    path = "Thrash.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "thrash",
    atlas = "tmachine",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    pools = { ["Ritualistic"] = true },
    rarity = "busterb_Ritualistic",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra ={
            HM = 1,
            HMTOTAL = 4,
            HMMAIN = 1.5
        }
    },
    loc_txt = {
        name = "{V:1,s:2}THRASH MACHINE{}",
        text = {
            "Destroys played {C:attention}Queens{},",
            "Increase Mult operator by {B:2,C:white}#4##1##5#{} whenever a {C:attention}Queen{} is destroyed",
            "{C:inactive}(Currently {B:2,C:white}#4##2##5##3#{C:inactive} Mult){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.HM, card.ability.extra.HMTOTAL, card.ability.extra.HMMAIN, "{", "}", colours = {HEX('BAD8FF'), SMODS.Gradients["busterb_epileptic"] }} }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card:get_id() == 12 and context.cardarea == G.play then
                card.ability.extra.HMTOTAL = (card.ability.extra.HMTOTAL) + card.ability.extra.HM
                card_eval_status_text(card,"extra",nil,nil,nil,
                { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
            )
                return {remove = true}
        end
        if context.joker_main then
                return {
                    hypermult = {card.ability.extra.HMTOTAL, card.ability.extra.HMMAIN}
                }
    end
end
}
SMODS.Atlas{
    key = "marble",
    path = "Marble.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "godsmarble",
    atlas = "marble",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    rarity = 3,
    cost = 100,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {},
    loc_txt = {
        name = "Forbidden Relic",
        text = {
            "Find the rune",
            "and sell this joker",
            "{B:2,C:white}To#1#spawn#1#the#1#machine"
        }
    },
    loc_vars = function(self, info_queue, card)
    return { vars = { " ",colours = {HEX('BAD8FF'), SMODS.Gradients["busterb_epileptic"] }} }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            for k, v in pairs(SMODS.find_card('j_para_jokerrune')) do
                if not SMODS.is_eternal(v) then
                SMODS.destroy_cards(v)
                SMODS.add_card({key = 'j_busterb_thrash'})
                end
            end
        end
    end
}