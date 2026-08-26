
--Bonus Effects

local function s_loc_vars(_, _, _, eff_table)
    return { vars = { SMODS.signed(eff_table.config.extra) }}
end
local function g_loc_vars(_, _, _, eff_table)
    return { vars = { eff_table.config.extra }}
end
    Spectrallib.BonusEffect {
        key = "busterb_consumable",
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
        key = "busterb_rare_card",
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
        key = "busterb_hand_level",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
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
        key = "busterb_ascend",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        ascension_power = eff_table.config.extra,
                        hands = context.scoring_name,
                    }
            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "asc_power" }
    }        
    
    Spectrallib.BonusEffect {
        key = "busterb_plus_hands",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
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
        key = "busterb_x_hands",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
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
        key = "busterb_x_adj_joker",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                local mypos = nil
		        for i = 1, #G.jokers.cards do
			        if G.jokers.cards[i] == card then
				        mypos = i
			    	    break
		    	    end
		        end
                if G.jokers.cards[mypos - 1] then
					Spectrallib.manipulate(G.jokers.cards[mypos-1], { value = eff_table.config.extra })
                SMODS.calculate_effect({ message = "X" ..eff_table.config.extra, colour = G.C.DARK_EDITION}, G.jokers.cards[mypos-1])
				end 
                if G.jokers.cards[mypos + 1] then
					Spectrallib.manipulate(G.jokers.cards[mypos+1], { value = eff_table.config.extra })
                SMODS.calculate_effect({ message = "X".. eff_table.config.extra, colour = G.C.DARK_EDITION}, G.jokers.cards[mypos+1])
				end

            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "value_manip" }
    }

        Spectrallib.BonusEffect {
        key = "busterb_plus_adj_joker",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                local mypos = nil
		        for i = 1, #G.jokers.cards do
			        if G.jokers.cards[i] == card then
				        mypos = i
			    	    break
		    	    end
		        end
                if G.jokers.cards[mypos - 1] then
					Spectrallib.manipulate(G.jokers.cards[mypos-1], { value = eff_table.config.extra, type = "+" })
                SMODS.calculate_effect({ message = "+" ..eff_table.config.extra, colour = G.C.FILTER}, G.jokers.cards[mypos-1])
				end 
                if G.jokers.cards[mypos + 1] then
					Spectrallib.manipulate(G.jokers.cards[mypos+1], { value = eff_table.config.extra, type = "+" })
                SMODS.calculate_effect({ message = "+".. eff_table.config.extra, colour = G.C.FILTER}, G.jokers.cards[mypos+1])
				end

            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "value_manip" }
    }
        Spectrallib.BonusEffect {
        key = "busterb_e_adj_joker",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                local mypos = nil
		        for i = 1, #G.jokers.cards do
			        if G.jokers.cards[i] == card then
				        mypos = i
			    	    break
		    	    end
		        end
                if G.jokers.cards[mypos - 1] then
					Spectrallib.manipulate(G.jokers.cards[mypos-1], { value = eff_table.config.extra, type = "^" })
                SMODS.calculate_effect({ message = "^" ..eff_table.config.extra, colour = G.C.BLACK, text_colour = G.C.DARK_EDITION}, G.jokers.cards[mypos-1])
				end 
                if G.jokers.cards[mypos + 1] then
					Spectrallib.manipulate(G.jokers.cards[mypos+1], { value = eff_table.config.extra, type = "^" })
                SMODS.calculate_effect({ message = "^".. eff_table.config.extra, colour = G.C.BLACK, text_colour = G.C.DARK_EDITION}, G.jokers.cards[mypos+1])
				end

            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "value_manip" }
    }

        Spectrallib.BonusEffect {
        key = "busterb_forcetrigger",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                local mypos = nil
		        for i = 1, #G.jokers.cards do
			        if G.jokers.cards[i] == card then
				        mypos = i
			    	    break
		    	    end
		        end
                if G.jokers.cards[mypos - 1] then
                    Spectrallib.forcetrigger(G.jokers.cards[mypos-1])
				end 
                if G.jokers.cards[mypos + 1] then
                    Spectrallib.forcetrigger(G.jokers.cards[mypos+1])
				end

            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "forcetrigger" }
    }

        Spectrallib.BonusEffect {
        key = "busterb_x_selfmanip",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            	Spectrallib.manipulate(card, { value = eff_table.config.extra, type = "X" })
                SMODS.calculate_effect({ message = "X" ..eff_table.config.extra, colour = G.C.DARK_EDITION}, card)
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "value_manip" }
    }
        Spectrallib.BonusEffect {
        key = "busterb_plus_selfmanip",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            	Spectrallib.manipulate(card, { value = eff_table.config.extra, type = "+" })
                SMODS.calculate_effect({ message = "+" ..eff_table.config.extra, colour = G.C.FILTER}, card)
            end
        end,
        loc_vars = g_loc_vars,
        attributes = { "value_manip" }
    }
        Spectrallib.BonusEffect {
        key = "busterb_e_selfmanip",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            	Spectrallib.manipulate(card, { value = eff_table.config.extra, type = "^" })
                SMODS.calculate_effect({ message = "^" ..eff_table.config.extra, colour = G.C.BLACK, text_colour = G.C.DARK_EDITION}, card)
            end
        end,
        loc_vars = s_loc_vars,
        attributes = { "value_manip" }
    }
        Spectrallib.BonusEffect {
        key = "busterb_random_jade",
        calculate = function(self, card, eff_table, context)
        if context.setting_blind or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
                local mypos = nil
		        for i = 1, #G.jokers.cards do
			        if G.jokers.cards[i] == card then
				        mypos = i
			    	    break
		    	    end
		        end
                if G.jokers.cards[mypos - 1] then
                        Spectrallib.add_bonus_effect(G.jokers.cards[mypos-1], BustB.poll_BB_effect_jade("busterb_jade") )
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
								major = G.jokers.cards[mypos-1],
								offset = {x = 0, y = 0}
							})
							play_sound('holo1',1, 0.5)
							G.jokers.cards[mypos-1]:juice_up(1, 0.2)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
						}))   
				end 
                if G.jokers.cards[mypos + 1] then
                        Spectrallib.add_bonus_effect(G.jokers.cards[mypos+1], BustB.poll_BB_effect_jade("busterb_jade") )
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
								major = G.jokers.cards[mypos+1],
								offset = {x = 0, y = 0}
							})
							play_sound('holo1',1, 0.5)
							G.jokers.cards[mypos+1]:juice_up(1, 0.2)
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
        key = "busterb_all_hands",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
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
        key = "busterb_all_asc",
        calculate = function(self, card, eff_table, context)
        if context.before or (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
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
            ease_colour(G.C.UI_CHIPS, copy_table(Spectrallib.get_asc_colour(1 * amt + eff_table.config.extra)), 0.1)
            ease_colour(G.C.UI_MULT, copy_table(Spectrallib.get_asc_colour(1 * amt + eff_table.config.extra)), 0.1)
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