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
                        itemcut[#itemcut+1] = G.consumeables.cards[i]
                    end
                end
                if #itemcut > 0 then
                    for _, v in ipairs(itemcut) do
                        v.getting_sliced = true
                        G.E_MANAGER:add_event(Event({func = function()
                            card:juice_up(0.8, 0.8)
                            v:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                    end
                    if context.post_trigger then
    local other_joker
    for k, v in pairs(G.jokers.cards) do
        if v == card then
            other_joker = G.jokers.cards[k+1]
        end
    end
    if context.joker_main then
--    if other_joker == context.other_card then
        for k, v in pairs(G.busterb_savedconsumeables) do
            Cryptid.forcetrigger(v)
        end
    end
end
    end
end
end
end
}

local oldcardremove = Card.remove
function Card:remove()
    if self.ability.consumeable and G.I.CARD[2] then
        local card = G.I.CARD[2]
        G.busterb_savedconsumeables = G.busterb_savedconsumeables or {}
        local old_ability = copy_table(card.ability)
        local old_center = card.config.center
        local old_center_key = card.config.center_key
        card:set_ability(key, nil, 'quantum')
        card:update(0.016)
        table.insert(G.busterb_savedconsumeables, SMODS.shallow_copy(card))
        local fakecard = G.busterb_savedconsumeables[#G.busterb_savedconsumeables]
        fakecard.ability = copy_table(fakecard.ability)
        for k, v in pairs({'T', 'VT', 'CT'}) do
            fakecard[v] = copy_table(fakecard[v])
        end
        fakecard.config = SMODS.shallow_copy(fakecard.config)
        card.ability = old_ability
        card.config.center = old_center
        card.config.center_key = old_center_key
    end
    return oldcardremove(self)
end