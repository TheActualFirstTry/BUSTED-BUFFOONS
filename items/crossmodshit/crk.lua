SMODS.Atlas{
    key = "SilentSalt",
    path = "SSC.png",
    px = 71,
    py = 95
}

local SilentSaltYap = {
    'I have no words for you.',
    "Is this what you believe in?",
    'I will cut you down.',
    'All beliefs are meant to crumble.',
    "The corrupted are beyond redemption.",
    'Prove your worth to me.',
    "Though I have fallen... Another shall rise..."
}

SMODS.Joker{
    key = 'crk_silentsalt',
    loc_txt = {
        name = 'Silent Salt Cookie',
        text = {
          'Playing cards are {X:default,C:white}Silenced{}',
          'gains {X:attention,C:white}^#2#{} Mult per card silenced.',
          '{C:default,s:1.2,E:1}#3#{}',
          '{X:attention,C:white,s:2}^#1#{s:2,C:attention} Mult{}',
        },
    },
    atlas = 'SilentSalt', 
    rarity = "ninehund_icon",
    cost = 25,
    unlocked = true,
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true,
    perishable_compat = true, 
    pos = {x = 0, y = 0},
    soul_pos = {x = 0, y = 2, extra9 = {x = 0, y = 1}},
    config = { 
      extra = {
        emult = 1,
        gain = 0.1,
        gainwiped = .2,
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.m_busterb_silenced
        return {vars = {center.ability.extra.emult,center.ability.extra.gain, SilentSaltYap[math.random(#SilentSaltYap)]}}
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge('Beast', HEX('66041E'), G.C.WHITE, 1)
        badges[#badges+1] = create_badge('Cookie Run: Kingdom', G.C.GREY, G.C.WHITE, 0.8)
    end,
    calculate = function(self,card,context)
        if context.pre_joker then
            for k, v in pairs(context.full_hand) do
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.6,
                    func = function()
                        v:juice_up()
                        if v.config.center_key ~= "m_busterb_silenced" then
                            v:set_ability(G.P_CENTERS.m_busterb_silenced)
                            v:set_edition(nil)
                            v:set_seal(nil)
                            play_sound('generic1', math.random()*0.2 + 0.9,0.5)
                            card.ability.extra.emult = card.ability.extra.emult + card.ability.extra.gain
                            SMODS.calculate_effect({ message = "+^"..card.ability.extra.gain.." Mult", colour = G.C.FILTER, instant = true}, card)
                        end
                        return true
                    end
                })) 
            end
        end
        if context.joker_main then
            return {
                card = card,
                emult = card.ability.extra.emult,
                message = '^' .. card.ability.extra.emult,
                colour = G.C.FILTER
            }
        end
    end,
}