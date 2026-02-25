SMODS.Atlas{
    key = "a_apollyon",
    path = "Apollyon.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "apollyon",
    atlas = "a_apollyon",
    rarity = "busterb_Insanity",
    pools = { ["Insanity"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    cost = 250,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
        extra = {
        },
        immutable = {
        }
    },
    loc_txt = {
        name = "{V:1,s:2}APOLLYON{}",
        text = {
            "{C:red}Destroys{} {C:atteniton}all consumables{}",
            "at the end of the round",
            "When joker to the right triggers,",
            "all sliced consumables will be {V:1,E:1}forcibly used{}",
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            colours = {SMODS.Gradients["busterb_epileptic"]}} }
    end,
    calculate = function(self, card, context)
if context.end_of_round and not card.getting_sliced and (context.individual or context.repetition) then
            if G.consumeables and #G.consumeables.cards > 0 then
                local itemcut = {}
                for i = 1, #G.consumeables.cards do
                    if not G.consumeables.cards[i].ability.eternal and not G.consumeables.cards[i].getting_sliced then
                        itemcut[#itemcut+1] = G.consumeables.cards[i].config.center_key
                    end
                end
                if #itemcut > 0 then
                    for _, c in ipairs(itemcut) do
                        c.getting_sliced = true
                        G.E_MANAGER:add_event(Event({func = function()
                            card:juice_up(0.8, 0.8)
                            card:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                        SMODS.calculate_effect{message = "!!!"}
                    end
                    local retted
        for i, v in pairs(itemcut) do
            local dummy = Entropy.GetDummy(G.P_CENTERS[v], G.consumeables.cards, card, true)
            local ret, retr = Cryptid.forcetrigger(dummy, context)
            if ret or retr then SMODS.calculate_effect{message =  localize{type = "name_text", set = G.P_CENTERS[v].set, key = v}, card = card} end
            if ret and ret.card == dummy then ret.card = card end
            for index, effect in pairs(ret or {}) do
                SMODS.calculate_individual_effect(ret, dummy, index, effect)
                retted = true
            end
            if retr then retted = true end
        end
        if retted then return nil, true end
    end
end
end 
end
}