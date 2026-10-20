
--Bonus Effects

local function s_loc_vars(_, _, _, eff_table)
    return { vars = { SMODS.signed(eff_table.config.extra) }}
end
local function g_loc_vars(_, _, _, eff_table)
    return { vars = { eff_table.config.extra }}
end

local function hyper_loc_vars(_, _, _, eff_table)
    return { vars = { eff_table.config.arrow, eff_table.config.num }}
end

local function im_loc_vars(_, _, _, eff_table)
    return { vars = { eff_table.config.immutable }}
end

local function sim_loc_vars(_, _, _, eff_table)
    return { vars = { SMODS.signed(eff_table.config.immutable) }}
end

    Spectrallib.BonusEffect {
        key = "immutable_xblindsize",
        calculate = function(self, card, eff_table, context)
            if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                return { xblindsize = eff_table.config.immutable }
            end
        end,
        loc_vars = im_loc_vars,
        attributes = { "xblindsize" }
    }
        Spectrallib.BonusEffect {
        key = "dollars",
        calculate = function(self, card, eff_table, context)
            if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                return { dollars = eff_table.config.extra }
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "economy" }
    }
--[[
    Spectrallib.BonusEffect {
        key = "xdollars",
        calculate = function(self, card, eff_table, context)
            if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                ease_dollars(G.GAME.dollars*(eff_table.config.extra-1))
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "economy" }
    }
--]]    
    Spectrallib.BonusEffect {
        key = "consumable",
        calculate = function(self, card, eff_table, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            local c = SMODS.create_card({set = "Consumeables"})
                    c:add_to_deck()
                    G.consumeables:emplace(c)
                return {
                    message = "Added!",
                    colour = G.C.FILTER,
                   card = c
                }
            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "generation" }
    }
    Spectrallib.BonusEffect {
        key = "rare_card",
        calculate = function(self, card, eff_table, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if v.hidden  and not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
                local random_key = pseudorandom_element(pool, "random_rare_consumeable")
                    if random_key then local c = SMODS.add_card{key = random_key}
                return {
                    message = "Added!",
                    colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                   card = c
                }
            end
        end
    end,
        loc_vars = s_loc_vars,
        attributes = { "generation" }
    }
    Spectrallib.BonusEffect {
        key = "hand_level",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        level_up = eff_table.config.extra,
                        hands = context.scoring_name,
                    }
            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "hand_type" }
    }

        Spectrallib.BonusEffect {
        key = "ascend",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        ascension_power = math.min(10,eff_table.config.extra),
                        hands = context.scoring_name,
                    }
            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "asc_power" }
    }        
    
    Spectrallib.BonusEffect {
        key = "plus_hands",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        level_up = false,
                        hands = context.scoring_name,
                        StatusText = "+"..(eff_table.config.extra),
                        func = function (base, hand, param)
                            return (base+(eff_table.config.extra))
                        end
                    }
            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "hand_type" }
    }
    Spectrallib.BonusEffect {
        key = "hypermult",
        calculate = function(self, card, eff_table, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            return { hypermult = {eff_table.config.arrow, eff_table.config.num}, colour = G.C.BBBLACK, text_colour = Spectrallib.emult }
            end
        end,
        loc_vars = hyper_loc_vars,
        attributes = { "hypermult" }
    }
    Spectrallib.BonusEffect {
        key = "hypermoney",
        calculate = function(self, card, eff_table, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            ease_hyper_dollars(eff_table.config.num, eff_table.config.arrow)
            end
        end,
        loc_vars = hyper_loc_vars,
        attributes = { "economy" }
    }
    Spectrallib.BonusEffect {
        key = "hyperchips",
        calculate = function(self, card, eff_table, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            return { hyperchips = {eff_table.config.arrow, eff_table.config.num}, colour = G.C.BBBLACK, text_colour = Spectrallib.echips }
            end
        end,
        loc_vars = hyper_loc_vars,
        attributes = { "hyperchips" }
    }
    Spectrallib.BonusEffect {
        key = "hyperasc",
        calculate = function(self, card, eff_table, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            return { hyper_asc = {eff_table.config.arrow, eff_table.config.num}, message = "{"..tostring(math.abs(eff_table.config.arrow)).."}"..tostring(math.abs(eff_table.config.num)).."Asc", remove_default_message = true, colour = G.C.BBBLACK, text_colour = SMODS.Gradients["busterb_GoldenFreddyGradient"] }
            end
        end,
        loc_vars = hyper_loc_vars,
        attributes = { "hyperchips" }
    }
    Spectrallib.BonusEffect {
        key = "m_power",
        calculate = function(self, card, eff_table, context)
        if (context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger) and not context.blueprint and not context.repetition then
            mysterypower(1,2)
            end
        end,
        loc_vars = function (_, _, _, eff_table)
            local txt = BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]
            return { vars = { txt }}
        end,
        attributes = { "passive" }
    }
    Spectrallib.BonusEffect {
        key = "edollars",
        calculate = function(self, card, eff_table, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            ease_e_dollars(eff_table.config.extra)
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "economy" }
    }
    Spectrallib.BonusEffect {
        key = "op_up",
        add_to_deck = function (self, card, eff_table)
				play_sound('busterb_mus',1)
				G.ROOM.jiggle = G.ROOM.jiggle + 35
                change_operator(math.floor(math.abs(eff_table.config.immutable)))
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1].config.colour = G.C.GRANDIOSE
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1]:juice_up(15,15)
        end,
        remove_from_deck = function (self, card, eff_table)
                change_operator(-(math.floor(math.abs(eff_table.config.immutable))))
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1].config.colour = G.C.RED
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1]:juice_up(15,15)
        end,        loc_vars = im_loc_vars,
        attributes = { "passive" }
    }
    Spectrallib.BonusEffect {
        key = "op_1",
        add_to_deck = function (self, card, eff_table)
				play_sound('busterb_mus',1)
				G.ROOM.jiggle = G.ROOM.jiggle + 35
                change_operator(1)
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1].config.colour = G.C.GRANDIOSE
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1]:juice_up(15,15)
        end,
        remove_from_deck = function (self, card, eff_table)
                change_operator(-1)
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1].config.colour = G.C.RED
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1]:juice_up(15,15)
        end,        loc_vars = im_loc_vars,
        attributes = { "passive" }
    }
        Spectrallib.BonusEffect {
        key = "forcetrigger_all",
        calculate = function(self, card, eff_table, context)
        if (context.joker_main or (context.main_scoring and context.cardarea == G.play)) then
            for k,v in ipairs(card.area.cards) do
                if v ~= self and Spectrallib.card_is_forcetriggerable(v) then
                        Spectrallib.forcetrigger{card = v}
                    end
				end
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "forcetrigger" }
    }
        Spectrallib.BonusEffect {
        key = "deckspawn",
        calculate = function(self, card, eff_table, context)
        if ((context.end_of_round and context.main_eval) or context.forcetrigger) and not context.blueprint and not context.repetition then
            local c = SMODS.add_card{set = "Back", area = G.consumeables}
            SMODS.calculate_effect({ message = localize("k_busterb_added")}, c)
        end
        end,
        loc_vars = g_loc_vars,
        attributes = { "passive" }
    }
    Spectrallib.BonusEffect {
        key = "x_hands",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        level_up = false,
                        hands = context.scoring_name,
                        StatusText = "X"..(eff_table.config.extra),
                        func = function (base, hand, param)
                            return (base*(eff_table.config.extra))
                        end
                    }
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "hand_type" }
    }
    Spectrallib.BonusEffect {
        key = "create_copy",
        calculate = function(self, card, eff_table, context)
        if ((context.end_of_round and context.main_eval) or context.forcetrigger) and not context.blueprint and not context.repetition then
            if not (card.edition or {}).negative then
                    G.E_MANAGER:add_event(Event({
                    func = function()
                    local copy = copy_card(card)
                    copy:set_edition("e_negative", true)
                    card.area:emplace(copy)
                    return true
                    end
                }))
            end
        end
    end,
        loc_vars = g_loc_vars,
        attributes = { "hand_type" }
    }
        Spectrallib.BonusEffect {
        key = "x_adj_joker",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
                local left, right = card.area.cards[card.rank-1], card.area.cards[card.rank+1]
                if left then
					Spectrallib.manipulate(left, { value = eff_table.config.extra })
                SMODS.calculate_effect({ message = "X" ..eff_table.config.extra, colour = G.C.DARK_EDITION}, left)
				end 
                if right then
					Spectrallib.manipulate(right, { value = eff_table.config.extra })
                SMODS.calculate_effect({ message = "X".. eff_table.config.extra, colour = G.C.DARK_EDITION}, right)
				end

            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "value_manip" }
    }

        Spectrallib.BonusEffect {
        key = "plus_adj_joker",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
                local left, right = card.area.cards[card.rank-1], card.area.cards[card.rank+1]
                if left then
					Spectrallib.manipulate(left, { value = eff_table.config.extra, type = "+" })
                SMODS.calculate_effect({ message = "+" ..eff_table.config.extra, colour = G.C.FILTER}, left)
				end 
                if right then
					Spectrallib.manipulate(right, { value = eff_table.config.extra, type = "+" })
                SMODS.calculate_effect({ message = "+".. eff_table.config.extra, colour = G.C.FILTER}, right)
				end

            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "value_manip" }
    }
        Spectrallib.BonusEffect {
        key = "e_adj_joker",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
                local left, right = card.area.cards[card.rank-1], card.area.cards[card.rank+1]
                if left then
					Spectrallib.manipulate(left, { value = eff_table.config.extra, type = "^" })
                SMODS.calculate_effect({ message = "^" ..eff_table.config.extra, colour = G.C.BLACK, text_colour = G.C.DARK_EDITION}, left)
				end 
                if right then
					Spectrallib.manipulate(right, { value = eff_table.config.extra, type = "^" })
                SMODS.calculate_effect({ message = "^".. eff_table.config.extra, colour = G.C.BLACK, text_colour = G.C.DARK_EDITION}, right)
				end

            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "value_manip" }
    }

        Spectrallib.BonusEffect {
        key = "forcetrigger",
        calculate = function(self, card, eff_table, context)
        if (context.joker_main or (context.main_scoring and context.cardarea == G.play)) then
                local left, right = card.area.cards[card.rank-1], card.area.cards[card.rank+1]
                if left and Spectrallib.card_is_forcetriggerable(left) then
                    Spectrallib.forcetrigger{card = left}
				end 
                if right and Spectrallib.card_is_forcetriggerable(right) then
                    Spectrallib.forcetrigger{card = right}
				end

            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "forcetrigger" }
    }

        Spectrallib.BonusEffect {
        key = "x_selfmanip",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
            	Spectrallib.manipulate(card, { value = eff_table.config.extra, type = "X" })
                SMODS.calculate_effect({ message = "X" ..eff_table.config.extra, colour = G.C.DARK_EDITION}, card)
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "value_manip" }
    }
        Spectrallib.BonusEffect {
        key = "plus_selfmanip",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
            	Spectrallib.manipulate(card, { value = eff_table.config.extra, type = "+" })
                SMODS.calculate_effect({ message = "+" ..eff_table.config.extra, colour = G.C.FILTER}, card)
            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "value_manip" }
    }
        Spectrallib.BonusEffect {
        key = "e_selfmanip",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
            	Spectrallib.manipulate(card, { value = eff_table.config.extra, type = "^" })
                SMODS.calculate_effect({ message = "^" ..eff_table.config.extra, colour = G.C.BLACK, text_colour = G.C.DARK_EDITION}, card)
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "value_manip" }
    }
        Spectrallib.BonusEffect {
        key = "random_jade",
        calculate = function(self, card, eff_table, context)
        if context.setting_blind or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                local left, right = card.area.cards[card.rank-1], card.area.cards[card.rank+1]
                if left then
                        Spectrallib.add_bonus_effect(left, BustB.poll_BB_effect_jade("busterb_jade") )
                        G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = localize("k_upgrade_ex"),
								scale = 1,
                                hold = 1.5,
                                backdrop_colour = G.C.BLACK,
								colour = G.C.DARK_EDITION,
								align = 'cm',
								major = left,
								offset = {x = 0, y = 0}
							})
							play_sound('busterb_mus',1, 0.5)
							left:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 20
							return true
                        end
						}))   
				end 
                if right then
                        Spectrallib.add_bonus_effect(right, BustB.poll_BB_effect_jade("busterb_jade") )
                        G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = localize("k_upgrade_ex"),
								scale = 1,
                                hold = 1.5,
                                backdrop_colour = G.C.BLACK,
								colour = G.C.DARK_EDITION,
								align = 'cm',
								major = right,
								offset = {x = 0, y = 0}
							})
							play_sound('busterb_mus',1, 0.5)
							right:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 20
							return true
                        end
						}))   
				end
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "passive" }
    }
        Spectrallib.BonusEffect {
        key = "rare_effects",
        calculate = function(self, card, eff_table, context)
        if context.setting_blind or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                local left, right = card.area.cards[card.rank-1], card.area.cards[card.rank+1]
                if left then
                        Spectrallib.add_bonus_effect(left, BustB.poll_busted_eff("busterb_busted_effects") )
                          G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                           func = function()
                            play_sound("busterb_bang")
                           return true
                       end
                    }))
                    delay(0.4)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                           func = function()
                            play_sound("busterb_note")
                            play_sound("busterb_gonerlaugh")
                            G.ROOM.jiggle = G.ROOM.jiggle + 100
                           return true
                       end
                    }))
            G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = localize("k_busterb_upgrade"),
								scale = 7.5,
                                hold = 4,
                                backdrop_colour = HEX("3f3f3f"),
								colour = G.C.GRANDIOSE,
								align = 'cm',
								major = left,
								offset = {x = 0, y = 0}
							})
							play_sound('busterb_mus',1, 0.5)
							left:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
						}))
				end 
                if right then
                        Spectrallib.add_bonus_effect(right, BustB.poll_busted_eff("busterb_busted_effects") )
                          G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                           func = function()
                            play_sound("busterb_bang")
                           return true
                       end
                    }))
                    delay(0.4)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                           func = function()
                            play_sound("busterb_note")
                            play_sound("busterb_gonerlaugh")
                            G.ROOM.jiggle = G.ROOM.jiggle + 100
                           return true
                       end
                    }))
            G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = localize("k_busterb_upgrade"),
								scale = 7.5,
                                hold = 4,
                                backdrop_colour = HEX("3f3f3f"),
								colour = G.C.GRANDIOSE,
								align = 'cm',
								major = right,
								offset = {x = 0, y = 0}
							})
							play_sound('busterb_mus',1, 0.5)
							right:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
						}))
				end
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "passive" }
    }
        Spectrallib.BonusEffect {
        key = "all_hands",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
                    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'.. eff_table.config.extra })
        delay(1.3)
        SMODS.upgrade_poker_hands({ instant = true, level_up = eff_table.config.extra })
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
        end
        end,
        loc_vars = s_loc_vars,
        attributes = { "hand_type" }
    }

        Spectrallib.BonusEffect {
        key = "all_asc",
        calculate = function(self, card, eff_table, context)
        if (context.before or (context.main_scoring and context.cardarea == G.play)) or context.forcetrigger then
            local amt = amt or 0
        local me = copier or card
        delay(0.4)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
        )
        delay(1.0)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.2,
          func = function()
            play_sound("tarot1")
            ease_colour(G.C.UI_CHIPS, copy_table(Spectrallib.get_asc_colour(1 * amt + math.min(10,eff_table.config.extra))), 0.1)
            ease_colour(G.C.UI_MULT, copy_table(Spectrallib.get_asc_colour(1 * amt + math.min(10,eff_table.config.extra))), 0.1)
            Spectrallib.pulse_flame(0.01, sunlevel)
            me:juice_up(0.8, 0.5)
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              blockable = false,
              blocking = false,
              delay = 1.2,
              func = function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                ease_colour(G.C.UI_MULT, G.C.RED, 1)
                return true
              end,
            }))
            return true
          end,
        }))
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+ ..." })
        delay(1.0)
        delay(2.6)
                SMODS.upgrade_poker_hands{
                    from = card,
                    parameters = { },
                    ascension_power = eff_table.config.extra,
                    instant = true,
                }

        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
        end
        end,
        loc_vars = s_loc_vars,
        attributes = { "value_manip" }
    }

    BustB.BB_effect_pool_jade = {
    {key = "slib_score", min = 12, max = 150, factor = 0.1,},
    {key = "slib_chips", min = 1, max = 20 },
    {key = "slib_mult", min = 1, max = 15 },
    {key = "slib_asc", min = 12, max = 100, factor = 0.1,},
    {key = "slib_x_asc", min = 12, max = 100, factor = 0.1,},
    {key = "slib_xchips", min = 15, max = 125, factor = 0.1, },
    {key = "slib_echips", min = 105, max = 1250, factor = 0.01, },
    {key = "slib_xmult", min = 15, max = 130, factor = 0.1, },
    {key = "slib_emult", min = 110, max = 1350, factor = 0.01, },
    {key = "slib_xscore", min = 12, max = 150, factor = 0.1,},
    {key = "slib_balance"},
    {key = "slib_partial_swap", min = 10, max = 100, factor = 0.01, },
    {key = "slib_hands", min = 1, max = 5,},
    {key = "slib_discards", min = 1, max = 5,},
    {key = "slib_h_size", min = 1, max = 5,},
    {key = "slib_joker_slot", min = 1, max = 5,},
    {key = "slib_consumable_slot", min = 1, max = 10,},
    {key = "slib_cashout", min = 3, max = 10,},
    {key = "slib_type_xmult", min = 20, max = 70, factor = 0.1, },
    {key = "busterb_hand_level", min = 1, max = 100},
    {key = "busterb_ascend", min = 1, max = 20},
    {key = "busterb_plus_hands", min = 1, max = 100},
    {key = "busterb_x_hands", min = 2, max = 10},
    {key = "busterb_x_adj_joker", min = 12, max = 150, factor = 0.1},
    {key = "busterb_plus_adj_joker", min = 1, max = 250},
    {key = "busterb_e_adj_joker", min = 105, max = 1250, factor = 0.01},
    {key = "busterb_x_selfmanip", min = 12, max = 150, factor = 0.1},
    {key = "busterb_plus_selfmanip", min = 1, max = 250},
    {key = "busterb_e_selfmanip", min = 105, max = 1250, factor = 0.01},
    {key = "busterb_forcetrigger"},
    {key = "busterb_all_asc", min = 1, max = 10},    
    {key = "busterb_all_hands", min = 1, max = 10},    
    {key = "busterb_random_jade"},    
    {key = "busterb_consumable"},
    {key = "busterb_rare_card"},
}

function BustB.poll_BB_effect_jade(seed)
    seed = seed or "busterb_jade"
    local eff_table = pseudorandom_element(BustB.BB_effect_pool_jade, seed.."_type")
    local config = {}
    if eff_table.get_config then
        config = eff_table.get_config(seed)
    elseif eff_table.min and eff_table.max then
        config.extra = pseudorandom(seed, eff_table.min, eff_table.max) * (eff_table.factor or 1)
    end
    return eff_table.key, config
end

    BustB.BB_effect_pool = {
    {key = "slib_score", min = 12, max = 150, factor = 0.1,},
    {key = "slib_chips", min = 1, max = 20 },
    {key = "slib_mult", min = 1, max = 15 },
    {key = "slib_asc", min = 12, max = 100, factor = 0.1,},
    {key = "slib_xchips", min = 15, max = 125, factor = 0.1, },
    {key = "slib_echips", min = 105, max = 1250, factor = 0.01, },
    {key = "slib_xmult", min = 15, max = 130, factor = 0.1, },
    {key = "slib_emult", min = 110, max = 1350, factor = 0.01, },
    {key = "slib_xscore", min = 12, max = 150, factor = 0.1,},
    {key = "slib_x_asc", min = 12, max = 100, factor = 0.1,},
    {key = "slib_balance"},
    {key = "slib_partial_swap", min = 10, max = 100, factor = 0.01, },
    {key = "slib_hands", min = 1, max = 5,},
    {key = "slib_discards", min = 1, max = 5,},
    {key = "slib_h_size", min = 1, max = 5,},
    {key = "slib_joker_slot", min = 1, max = 5,},
    {key = "slib_consumable_slot", min = 1, max = 10,},
    {key = "slib_cashout", min = 3, max = 10,},
    {key = "slib_type_xmult", min = 20, max = 70, factor = 0.1, },
    {key = "busterb_hand_level", min = 1, max = 100},
    {key = "busterb_ascend", min = 1, max = 20},
    {key = "busterb_plus_hands", min = 1, max = 100},
    {key = "busterb_x_hands", min = 2, max = 10},
    {key = "busterb_x_selfmanip", min = 12, max = 150, factor = 0.1},
    {key = "busterb_plus_selfmanip", min = 1, max = 250},
    {key = "busterb_e_selfmanip", min = 105, max = 1250, factor = 0.01},
    {key = "busterb_all_asc", min = 1, max = 10},
    {key = "busterb_all_hands", min = 1, max = 10},
}

function BustB.poll_BB_effect(seed)
    seed = seed or "BustB_effects"
    local eff_table = pseudorandom_element(BustB.BB_effect_pool, seed.."_type")
    local config = {}
    if eff_table.get_config then
        config = eff_table.get_config(seed)
    elseif eff_table.min and eff_table.max then
        config.extra = pseudorandom(seed, eff_table.min, eff_table.max) * (eff_table.factor or 1)
    end
    return eff_table.key, config
end

    BustB.BB_nano_pool = {
    {key = "slib_chips", min = 1, max = 20 },
    {key = "slib_mult", min = 1, max = 15 },
    {key = "slib_xchips", min = 15, max = 145, factor = 0.1, },
    {key = "slib_xmult", min = 15, max = 100, factor = 0.1, },
    {key = "slib_asc", min = 12, max = 100, factor = 0.1,},
    {key = "slib_score", min = 12, max = 150, factor = 0.1,},
    {key = "slib_xscore", min = 12, max = 150, factor = 0.1,},
    {key = "slib_partial_swap", min = 10, max = 100, factor = 0.01, },
    {key = "slib_h_size", min = 1, max = 5,},
    {key = "busterb_hand_level", min = 1, max = 10},
    {key = "busterb_ascend", min = 1, max = 5},
    {key = "busterb_plus_hands", min = 1, max = 10},
    {key = "busterb_x_hands", min = 12, max = 50, factor = 0.1},
    {key = "busterb_plus_selfmanip", min = 1, max = 250, factor = 0.1},
}

function BustB.poll_nano_effect(seed)
    seed = seed or "BustB_effects"
    local eff_table = pseudorandom_element(BustB.BB_nano_pool, seed.."_type")
    local config = {}
    if eff_table.get_config then
        config = eff_table.get_config(seed)
    elseif eff_table.min and eff_table.max then
        config.extra = pseudorandom(seed, eff_table.min, eff_table.max) * (eff_table.factor or 1)
    end
    return eff_table.key, config
end

BustB.BB_hestia_pool = {
    {key = "slib_echips", min = -105, max = -1250, factor = 0.01, },
    {key = "slib_emult", min = -110, max = -1350, factor = 0.01, },
    {key = "slib_xchips", min = -150, max = -1450, factor = 0.1, },
    {key = "slib_xmult", min = -150, max = -1000, factor = 0.1, },
    {key = "slib_asc", min = -120, max = -1000, factor = 0.1,},
    {key = "slib_xscore", min = -120, max = -1500, factor = 0.1,},
}

function BustB.poll_hestia(seed)
    seed = seed or "BustB_hestia"
    local eff_table = pseudorandom_element(BustB.BB_hestia_pool, seed.."_type")
    local config = {}
    if eff_table.get_config then
        config = eff_table.get_config(seed)
    elseif eff_table.min and eff_table.max then
        config.extra = pseudorandom(seed, eff_table.min, eff_table.max) * (eff_table.factor or 1)
    end
    return eff_table.key, config
end

BustB.busted_effects = {
    {key = "sbe_busterb_hypermoney", arrow = { min = 4, max = 10 }, num = { min = 4, max = 10 }},
    {key = "sbe_busterb_hyperchips", arrow = { min = 4, max = 10 }, num = { min = 4, max = 10 }},
    {key = "sbe_busterb_hypermult", arrow = { min = 4, max = 10 }, num = { min = 4, max = 10 }},
    {key = "sbe_busterb_hyperasc", arrow = { min = 4, max = 10 }, num = { min = 4, max = 10 }},
    {key = "sbe_busterb_edollars", min = 11, max = 100, factor = 0.1},
    {key = "sbe_busterb_op_1"},
    {key = "sbe_busterb_m_power"},
    {key = "sbe_busterb_forcetrigger_all"},
    {key = "sbe_busterb_deckspawn"},
    {key = "busterb_rare_card"},
    {key = "busterb_random_jade"},
}

function BustB.poll_busted_eff(seed)
    seed = seed or "BustB_busted_effects"
    local eff_table = pseudorandom_element(BustB.busted_effects, seed.."_type")
    local config = {}
    if eff_table.get_config then
        config = eff_table.get_config(seed)
    elseif eff_table.min and eff_table.max then
        config.extra = pseudorandom(seed, eff_table.min, eff_table.max) * (eff_table.factor or 1)
        elseif eff_table.immutable then
        config.immutable = config.immutable or 1
    else
        if eff_table.arrow and eff_table.arrow.min and eff_table.arrow.max then
            config.arrow = pseudorandom(seed .. "_arrow", eff_table.arrow.min, eff_table.arrow.max) * (eff_table.factor or 1)
        end
        
        if eff_table.num and eff_table.num.min and eff_table.num.max then
            config.num = pseudorandom(seed .. "_num", eff_table.num.min, eff_table.num.max) * (eff_table.factor or 1)
        end
    end

    return eff_table.key, config
end