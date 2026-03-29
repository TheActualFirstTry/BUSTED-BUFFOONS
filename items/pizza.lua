SMODS.Atlas {
    key = "a_pizza",
    path = "Pizzas.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'plain',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 0, y = 0 },
    config = {
    extra = {
        max_highlighted = 3,
        chips = 10,
        mult = 4
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, card.ability.extra.chips, card.ability.extra.mult, colours = {HEX('E36956')} } }
	end,
	can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
		local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.max_highlighted)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            highlighted.ability.perma_bonus = highlighted.ability.perma_bonus + card.ability.extra.chips
                            highlighted.ability.perma_mult = highlighted.ability.perma_mult + card.ability.extra.mult
                            highlighted:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end
}
SMODS.Consumable {
    key = 'pineapple',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 1, y = 0 },
    config = {
    extra = {
        max_highlighted = 3,
        dollars = 3,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, card.ability.extra.dollars, colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
		local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.max_highlighted)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            highlighted.ability.perma_p_dollars = highlighted.ability.perma_p_dollars + card.ability.extra.dollars
                            highlighted:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end
}
SMODS.Consumable {
    key = 'pepperoni',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 2, y = 0 },
    config = {
    extra = {
        max_highlighted = 2,
        x_mult = 0.2,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, card.ability.extra.x_mult, colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
		local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.max_highlighted)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            highlighted.ability.perma_x_mult = highlighted.ability.perma_x_mult + card.ability.extra.x_mult
                            highlighted:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end
}
SMODS.Consumable {
    key = 'mushroom',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 3, y = 0 },
    config = {
    extra = {
        max_highlighted = 2,
        x_chips = 0.2,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, card.ability.extra.x_chips, colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
		local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.max_highlighted)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            highlighted.ability.perma_x_chips = highlighted.ability.perma_x_chips + card.ability.extra.x_chips
                            highlighted:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end
}
SMODS.Consumable {
    key = 'pepper',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 4, y = 0 },
    config = {
    extra = {
        max_highlighted = 1,
        repetitions = 1,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, card.ability.extra.repetitions, colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
		local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.max_highlighted)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            highlighted.ability.perma_repetitions = highlighted.ability.perma_repetitions + card.ability.extra.repetitions
                            highlighted:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end
}

SMODS.Consumable {
    key = 'supreme',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 0, y = 1 },
    config = {
    extra = {
        max_highlighted = 1,
        repetitions = 1,
        dollars = 1,
        chips = 10,
        mult = 4,
        x_mult = 0.1,
        x_chips = 0.1,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted,
        card.ability.extra.dollars, -- 2
        card.ability.extra.chips, -- 3
         card.ability.extra.mult, -- 4
         card.ability.extra.x_mult, -- 5
         card.ability.extra.x_chips, -- 6
         card.ability.extra.repetitions, -- 7
         colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
		local cards = Spectrallib.get_highlighted_cards({ G.hand }, card, 1, card.ability.extra.max_highlighted)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            highlighted.ability.perma_p_dollars = highlighted.ability.perma_p_dollars + card.ability.extra.dollars
                            highlighted.ability.perma_bonus = highlighted.ability.perma_bonus + card.ability.extra.chips
                            highlighted.ability.perma_mult = highlighted.ability.perma_mult + card.ability.extra.mult
                            highlighted.ability.perma_x_mult = highlighted.ability.perma_x_mult + card.ability.extra.x_mult
                            highlighted.ability.perma_x_chips = highlighted.ability.perma_x_chips + card.ability.extra.x_chips
                            highlighted.ability.perma_repetitions = highlighted.ability.perma_repetitions + card.ability.extra.repetitions
                            highlighted:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end
}

SMODS.Consumable {
    key = 'magic',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 1, y = 1 },
    config = {
    extra = {
        max_highlighted = 3,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local tarot_pool = get_current_pool('Tarot')
            local tarotget = pseudorandom_element(tarot_pool, 'busterb_tarotfetch')
            local it = 1
            while tarotget == 'UNAVAILABLE' do
                it = it + 1
                tarotget = pseudorandom_element(tarot_pool, 'busterb_tarotfetch_re'..it)
            end
                    G.hand.highlighted[i]:set_ability(tarotget, true, nil, tarot_pool)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}
SMODS.Consumable {
    key = 'cosmic',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 2, y = 1 },
    config = {
    extra = {
        max_highlighted = 2,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local planet_pool = get_current_pool('Planet')
            local planetget = pseudorandom_element(planet_pool, 'busterb_planetfetch')
            local it = 1
            while planetget == 'UNAVAILABLE' do
                it = it + 1
                planetget = pseudorandom_element(planet_pool, 'busterb_planetfetch_re'..it)
            end
            G.hand.highlighted[i]:set_ability(planetget, true, nil, planet_pool)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}
SMODS.Consumable {
    key = 'ghost',
    set = 'Pizza',
    atlas = "a_pizza",
    pos = { x = 3, y = 1 },
    config = {
    extra = {
        max_highlighted = 1,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local spectral_pool = get_current_pool('Spectral')
            local spectralget = pseudorandom_element(spectral_pool, 'busterb_spectralfetch')
            local it = 1
            while spectralget == 'UNAVAILABLE' do
                it = it + 1
                spectralget = pseudorandom_element(spectral_pool, 'busterb_spectralfetch_re'..it)
            end
            G.hand.highlighted[i]:set_ability(spectralget, true, nil, spectral_pool)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}
                    
SMODS.Consumable {
    key = 'special',
    set = 'Pizza',
    atlas = "a_pizza",
    hidden = true,
    can_repeat_soul = true,
    soul_set = "Pizza",
    pos = { x = 4, y = 1 },
    config = {
    extra = {
        max_highlighted = 1,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, colours = {HEX('E36956')} } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if v.hidden  and not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
                local random_key = pseudorandom_element(pool, "random_rare_consumeable")
            G.hand.highlighted[i]:set_ability(random_key, true, nil, pool)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}
