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
    cost = 1e308,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
        extra = {
            Xchips = 1,
            Xchipsincrement = 1,
            Xchipsincrementmultiplier = 2,
            jokerslot = 1,
        },
        immutable = {
            slotlimit = 100
        }
    },
    loc_txt = {
        name = "{V:1,s:2}Stultus Astronomicus{}",
        text = {
            "Gains {X:chips,C:white}X#2#{} chips at the end of the round.",
            "Multiply gained {X:chips,C:white}XChips{} by {B:1,C:white}#3#{} when ante changes.",
            "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} chips){}"
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.Xchips, 
            card.ability.extra.Xchipsincrement, 
            card.ability.extra.Xchipsincrementmultiplier, 
            colours = {HEX('00FFFF')}} }
    end,
    calculate = function(self, card, context)

            if context.card_added and context.card.config.center.key == "j_star_astro" then
                G.jokers:change_size((-G.jokers.config.card_limit) + math.min(G.jokers.config.card_limit + card.ability.extra.jokerslot, card.ability.immutable.slotlimit))
                end
        if context.joker_main then
            return {
                xchips = card.ability.extra.Xchips
            }
        end
        if context.end_of_round and context.main_eval then
                card.ability.extra.Xchips = card.ability.extra.Xchips + card.ability.extra.Xchipsincrement
                return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xchips } },
                colour = HEX('00FFFF')
                }
            end
        if context.ante_change then
            card.ability.extra.Xchipsincrement = card.ability.extra.Xchipsincrement * card.ability.extra.Xchipsincrementmultiplier
                return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xchipsincrement } },
                colour = HEX('00FFFF')
                }
            end
        end
}