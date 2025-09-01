SMODS.Atlas{
    key = "Grandholder",
    path = "Grandholder.png",
    px = 71,
    py = 95
}
-- SMODS.Atlas{
--    key = "Flowey",
--    path = "Flowey.png",
--    px = 71,
--    py = 95
-- }
SMODS.Atlas{
    key = "a_igor",
    path = "IGOR.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "igor",
    atlas = "a_igor",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra ={
            EEM = 0.1,
            EEMTOTAL = 1
        }
    },
    loc_txt = {
        name = "{V:1,s:2}IGOR{}",
        text = {
            "Destroys played {C:attention}Queens{},",
            "Gains {X:spectral,C:white}^^#1#{} Mult whenever a {C:attention}Queen{} is scored",
            "{c:inactive}Currently {X:spectral,C:white}^^#2#{C:inactive} Mult){}"
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.EEM, card.ability.extra.EEMTOTAL, colours = {HEX('f7b4c6')}} }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card:get_id() == 12 and context.cardarea == G.play then
                card.ability.extra.EEMTOTAL = (card.ability.extra.EEMTOTAL) + card.ability.extra.EEM
                card_eval_status_text(card,"extra",nil,nil,nil,
				{ message = localize("k_upgrade_ex"), colour = G.C.FILTER }
			)
                return {remove = true}
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    ee_mult = card.ability.extra.EEMTOTAL
                }
    end
end
}
-- SMODS.Joker{
--    key = "",
--    atlas = "Grandholder",
--    pos = { x = 0, y = 0 },
--    soul_pos = { x = 0, y = 1, inbetweener = { x = 0, y = 2 } },
--    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
--    rarity = "busterb_Grandiose",
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