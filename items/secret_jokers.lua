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
            eechipsincrement = 1,
            eechipsincrementmultiplier = 2,
            jokerslot = 1,
        },
        immutable = {
            slotlimit = 100
        }
    },
    loc_txt = {
        name = "{V:1,s:2}Stultus Astronomicus{}",
        text = {
            "Gains {B:2,C:white}^^#2#{} chips at the end of the round.",
            "Multiply gained {B:2,C:white}^^Chips{} by {B:1,C:white}#3#{} when ante changes.",
            "{C:inactive}(Currently {B:2,C:white}^^#1#{C:inactive} Chips){}"
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
--Spawn Condition for Astro
SMODS.current_mod.calculate = function (self, context)
    if context.setting_blind and G.GAME.blind.boss and G.GAME.blind.config.blind.key == "bl_goad" then
        G.GAME.blind.effect.onlyspades = true -- set the initial value
    end
    if context.individual and context.cardarea == G.play and G.GAME.blind.boss and not --[[Important this is not]] context.other_card:is_suit("Spades") then
        -- beeg line ^^
        G.GAME.blind.effect.onlyspades = false -- ohhh noooo, the guy played a card that wasnt spade whilst being in a boss
    end
    if context.end_of_round and G.GAME.blind.boss and context.main_eval and G.GAME.blind.effect.onlyspades then -- Dont need to check for goad, since its only ever true if goad is the boss
        -- give astro
        SMODS.add_card{ key = "j_busterb_astro", edition = 'e_negative', stickers = {'eternal'}, force_stickers = true }
        print("winner")
    end
end