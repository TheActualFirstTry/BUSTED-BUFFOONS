SMODS.Atlas{
    key = "a_unik",
    path = "UNIK.PNG",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "unik",
    atlas = "a_unik",
    rarity = "busterb_AWAKENED",
    pools = { ["AWAKENED"] = true},
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
            eechipsincrement = 0.07,
        },
        immutable = {
            eecap = 700,
        }
    },
    loc_txt = {
        name = "{V:1,s:2}Awakened UNIK{}",
        text = {
            "Converts {V:1}cards held in hand{} into {B:1,C:white}PINK#3#CARDS{}",
            "Gains {B:1,C:white}^^#2#{} {V:1}Chips{} for every card",
            "converted into a {B:1,C:white}PINK#3#CARD{}.",
            "{C:inactive}(Currently {B:1,C:white}^^#1#{V:1} Chips{C:inactive}){}"
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.eechips, 
            card.ability.extra.eechipsincrement, 
            " ",
            colours = {SMODS.Gradients["busterb_Unik"]}} }
    end,
    calculate = function(self, card, context)

        if context.joker_main then
            return {
                eechips = card.ability.extra.eechips
            }
        end
        if context.end_of_round and context.main_eval then
                for k, v in pairs(G.hand.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.6,
                    func = function()
                        v:juice_up()
                        if v.config.center_key ~= "m_unik_pink" then
                            v:set_ability(G.P_CENTERS.m_unik_pink)
                            v:set_edition(nil)
                            v:set_seal(nil)
                            play_sound('generic1', math.random()*0.2 + 0.9,0.5)
                            card.ability.extra.eechips = card.ability.extra.eechips + card.ability.extra.eechipsincrement
                            SMODS.calculate_effect({ message = "^^"..card.ability.extra.eechips.." Chips", colour = SMODS.Gradients["busterb_Unik"], instant = true}, card)
                        end
                        return true
                    end
                })) 
            end
        end
    end
}
--Sell Awakwening while selecting UNIK's Mod UNIK to spawn Busted Buffoons' UNIK.
SMODS.current_mod.calculate = function (self, context)
if context.selling_card and 
context.card.config.center.key == 'c_unik_gateway' and 
G.jokers.highlighted[1] and 
G.jokers.highlighted[1].config.center.key == 'j_unik_unik' then
    G.jokers.highlighted[1]:set_ability('j_busterb_unik')
    end
end