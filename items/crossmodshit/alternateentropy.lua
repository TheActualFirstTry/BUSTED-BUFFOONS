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
            stored_consumables = {}
        },
        immutable = {
        }
    },
    loc_txt = {
        name = "{V:1}APOLLYON{}",
        text = {
            "Use to {C:purple}Store{}",
            "{C:atteniton}all held consumables{}",
            "When the {C:attention}rightmost Joker{} is triggered",
            "all {C:purple}stored{} consumables",
            "will be {V:1,E:1}forcibly used{}",
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            colours = {SMODS.Gradients["busterb_epileptic"]}} }
    end,
        can_use = function()
        return #G.consumeables.cards > 1
    end,
    use = function(self, card)
        for i, v in pairs(G.consumeables.cards) do
            if v ~= card then
                local c = v
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    delay = 0.5,
                    func = function()
                        play_sound("entr_void_suck")
                        card.ability.extra.stored_consumables[#card.ability.extra.stored_consumables+1] = c.config.center.key
                        SMODS.destroy_cards(c)
                        return true
                    end
                })
            end
        end
    end,
    calculate = function(self, card, context)
        local rightmost = G.jokers.cards[#G.jokers.cards]
        if (context.post_trigger and not context.other_card.debuff) or context.forcetrigger and context.other_card ~= self and context.other_card == rightmost then
            for _, key in ipairs(card.ability.extra.stored_consumables) do
            if key then
                local dummy = Spectrallib.get_dummy(G.P_CENTERS[key], card.area, card)
                Spectrallib.forcetrigger{
                    card = dummy,
                    silent = true
                }
            end
        end
    end
end
--[[
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
--]]
}
--[[
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
--]]

SMODS.Joker{
    key = "geryon",
    atlas = "Grandholder",
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
        name = "{V:1}Geryon{}",
        text = {
            "{C:attention}Prismatic cards",
            "can appear in shop"
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            colours = {SMODS.Gradients["busterb_epileptic"]}} }
    end,
    calculate = function(self, card, context)
        if context.create_shop_card then --1
            if SMODS.pseudorandom_probability(card, 'busterb_geryon', 1, 5, 'busterb_geryon', true) then --2
                return {
                    shop_create_flags = {
                        set = "Enhanced",
                        enhancement = "m_entr_prismatic"
                }
            }
        end--2
    end--1

end
}
