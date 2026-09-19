
--[[]]
SMODS.Blind {
    name = "Zeus",
    mblind = true,
    unskippable = true,
    key = 'zeus',
    pos = { x = 0, y = 0 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 5.1e20,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('5663a7'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    set_blind = function(self)
        SMODS.add_card{key="c_busterb_conductor"}
    end,
	calculate = function(self, blind, context)
    if not blind.disabled and context.debuff_card and not SMODS.has_enhancement(context.debuff_card, 'm_busterb_electric') then
        if SMODS.is_playing_card(context.debuff_card) then
            return {debuff = true}
        end
    end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
        if context.after or context.pre_discard then
            SMODS.add_card{key="c_busterb_conductor"}
        end
    if context.individual and context.cardarea == G.hand and not context.end_of_round then
        if context.other_card.debuff then
            SMODS.calculate_effect({ eblindsize = 1.25, card = context.other_card })
    	end
    end
end
}
--]]

BustB.HadesHands = { "High Card", "Two Pair", "Straight", "Straight Flush", "Flush", "Full House", "Pair", "Four of a Kind", "Three of a Kind", "Full House" }

SMODS.Blind {
    name = "Hades",
    mblind = true,
    unskippable = true,
    key = 'hades',
    pos = { x = 0, y = 1 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 5.1e20,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('a77156'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    set_blind = function(self)
    end,
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                for _, poker_hand in ipairs(BustB.HadesHands) do
                    BustB.HadesHands[poker_hand] = true
                end
            end
                if BustB.HadesHands[context.scoring_name] then
                    return {
                        debuff = true
                    }
                end
            end 
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}

SMODS.Blind {
    name = "Hermes",
    mblind = true,
    unskippable = true,
    key = "hermes",
    atlas = "mblinds",
    pos = { x = 0, y = 2 },
    attributes = { "m_blind" },
    mult = 7.1e10,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('56a799'),
    loc_vars = function(self, info_queue, blind)
--        info_queue[#info_queue + 1] = G.P_CENTERS.k_busterb_mythical_blind
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.before then
                print("before")
                if context.scoring_name ~= "Straight" then
                print("context.scoring_name ~= 'Straight'")
                    local prev = math.floor(G.GAME.dollars * 0.1)
                    ease_dollars(-prev)
                    local x = 1 + (prev * 0.1)
                        G.GAME.blind.chips = math.floor(G.GAME.blind.chips * x)
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.hand_text_area.blind_chips:juice_up()
                end
            end
    end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}

SMODS.Blind {
    name = "Heracles",
    mblind = true,
    unskippable = true,
    key = 'heracles',
    pos = { x = 0, y = 3 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 1e250,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('a7568c'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    disable = function(self)
       if G.GAME.blind.chips >= 7.1e10 then
        G.GAME.blind.chips = G.GAME.blind.chips ^ 0.5
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.hand_text_area.blind_chips:juice_up()
        end
    end,
	calculate = function(self, blind, context)        
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
        if context.individual and context.cardarea == "unscored" then
                return {eblindsize = 0.5, card = context.other_card}
        end
    end
}

SMODS.Blind {
    name = "Poseidon",
    mblind = true,
    unskippable = true,
    key = 'poseidon',
    pos = { x = 0, y = 4 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 5.1e20,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('568ca7'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
	calculate = function(self, blind, context)
    if not blind.disabled then
        if context.individual and context.cardarea == "unscored" then
            SMODS.calculate_effect({ echips = 0.95, card = context.other_card })
        end
    end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}

SMODS.Blind {
    name = "Ares",
    mblind = true,
    unskippable = true,
    key = 'ares',
    pos = { x = 0, y = 5 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 1.1e19,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('a75663'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    set_blind = function(self)
        SMODS.add_card{key="c_busterb_marksman"}
    end,
	calculate = function(self, blind, context)        
        if not blind.disabled then
            if context.after then
                local sable = {}
                for k,v in ipairs(G.hand.cards) do
                        if not SMODS.has_enhancement(v, 'm_busterb_bloodmarked') then
                            sable[#sable+1] = v                        
                        end
                SMODS.destroy_cards(v)
            end
            SMODS.add_card{key="c_busterb_marksman"}
        end
         if context.pre_discard then
            SMODS.add_card{key="c_busterb_marksman"}
        end
   end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}
SMODS.Blind {
    name = "Artemis",
    mblind = true,
    unskippable = true,
    key = 'artemis',
    pos = { x = 0, y = 6 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 5.6e18,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('56a771'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
	calculate = function(self, blind, context)        
        if not blind.disabled then
            if context.debuff_hand then
               	for k, v in ipairs(context.scoring_hand) do
        			if not v:is_suit("Clubs") then
		        		return { debuff = true,
                                debuff_text = localize("k_busterb_artemis_debuff")
                                }
	        		end
        		end
            end
        end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}

SMODS.Blind {
    name = "Hephaestus",
    mblind = true,
    unskippable = true,
    key = 'hephaestus',
    pos = { x = 0, y = 7 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 5.6e18,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('7c3d2b'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
	calculate = function(self, blind, context)        
        if not blind.disabled then
            if context.final_scoring_step and not ( SMODS.calculate_round_score() > G.GAME.blind.chips ) then
                SMODS.calculate_effect({ xchips = 0, xmult = 0, silent = true, card = blind })
            end
        end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}

SMODS.Blind {
    name = "Aphrodite",
    mblind = true,
    unskippable = true,
    key = 'aphrodite',
    pos = { x = 0, y = 8 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 3.5e10,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('e46c9c'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
	calculate = function(self, blind, context)        
        if not blind.disabled then
            if context.after and #G.jokers.cards > 0 then
                local v = pseudorandom_element(G.jokers.cards,"bl_busterb_aphrodite")
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                           func = function()
                            if not v.ability.busterb_weak then
                            v:add_sticker("busterb_weak",true)
                            v:juice_up()
                            play_sound("tarot1")
                            end
                           return true
                       end
                    }))
                end
            end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}

SMODS.Blind {
    name = "Dionysus",
    mblind = true,
    unskippable = true,
    key = 'dionysus',
    pos = { x = 0, y = 9 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 7.1e10,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('7156a7'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    set_blind = function(self)
        BustB.DionysusDrunk = false
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if (context.selling_card and context.card.ability.set == "Joker") or context.using_consumeable then
                BustB.DionysusDrunk = true
            end
            if context.debuff_hand then
                if BustB.DionysusDrunk ~= true then
                    return { 
                        debuff = true,
                        debuff_text = localize("k_busterb_dionysus_debuff")
                    }
                end
            end
            if context.after then
                BustB.DionysusDrunk = false
            end
        end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
    end
}

SMODS.Blind {
    name = "Thanatos",
    mblind = true,
    unskippable = true,
    key = 'thanatos',
    pos = { x = 0, y = 10 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 7.1e10,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('332b7c'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    calculate = function(self, blind, context)
    if not blind.disabled then
        if context.after then
            return { escore = 0.5 }
        end
    end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}

SMODS.Blind {
    name = "Erebus",
    mblind = true,
    unskippable = true,
    key = 'erebus',
    pos = { x = 0, y = 11 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 4.8e21,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('373737'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    calculate = function(self, blind, context)
    if not blind.disabled then
        if context.after or context.pre_discard then
            local cardtable = {}
            for k,v in ipairs(G.hand.cards) do
                if v.highlighted == false then
                    cardtable[#cardtable+1] = v
                end
            end
            SMODS.destroy_cards(cardtable)
        end
    end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}


--[[]]
SMODS.Blind {
    name = "Apollo",
    mblind = true,
    unskippable = true,
    key = 'apollo',
    pos = { x = 0, y = 12 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 4.8e21,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('ffde74'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    calculate = function(self, blind, context)
    if not blind.disabled then
        if context.individual and not context.end_of_round then
            if context.cardarea == G.hand then
                return { asc = -10 }
            end
        end
    end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}
--]]

SMODS.Blind {
    name = "Chronos",
    mblind = true,
    unskippable = true,
    key = 'chronos',
    pos = { x = 0, y = 13 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 4.8e21,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('267a5a'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    calculate = function(self, blind, context)
    if not blind.disabled then
            if (context.after or context.pre_discard) and #G.jokers.cards > 0 then
                local v = pseudorandom_element(G.jokers.cards,"bl_busterb_chronos")
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                           func = function()
                            if not v.ability.perishable then
                                v.ability.perishable = true
                                v:add_sticker("perishable",true)
                                v:juice_up()
                                play_sound("tarot1")
                            end
                           return true
                       end
                    }))
                    for k,c in ipairs(G.jokers.cards) do
                        if c.ability.perishable then
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.2,
                                   func = function()
                                    c:calculate_perishable()
                                   return true
                               end
                            }))
                    end
                end
            end
        end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}

SMODS.Blind {
    name = "Hestia",
    mblind = true,
    unskippable = true,
    key = 'hestia',
    pos = { x = 0, y = 14 },
    atlas = 'mblinds',
    attributes = { "m_blind" },
    mult = 8.4e11,
    dollars = 0,
    boss = { },
    in_pool = function(self)
        return false
    end,
    boss_colour = HEX('7a3726'),
    loc_vars = function(self, info_queue, blind)
    return { vars = {  } }
    end,
    calculate = function(self, blind, context)
    if not blind.disabled then
        if context.setting_blind and G.jokers.config.card_limit > 0 then
        local empty = G.jokers.config.card_limit - #G.jokers.cards
            for i = 1, math.min(25, empty) do
                local c = SMODS.add_card{attributes = {"food"}, area = G.jokers, force_stickers = true, stickers = { "eternal" } }
                Spectrallib.add_bonus_effect(c, BustB.poll_hestia("busterb_hestia") )
            end
        end
    end
    if context.end_of_round and context.main_eval and G.STATE_COMPLETE == true and not context.game_over then
    if BustB.mythic == true then
    eldritchspawn("mythical_blind")
BustB.mythic = false
    end
    end
end
}