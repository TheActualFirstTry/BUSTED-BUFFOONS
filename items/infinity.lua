SMODS.Atlas {
    key = "a_ic",
    path = "inf.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'mugen',
    set = 'Spectral',
    atlas = "non",
    cost = 4, pos = { x = 3, y = 7 },
    hidden = true,
    can_repeat_soul = true,
    soul_set = 'Infinity',
    config = {
    extra = {
      delta = -1
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { " ", colours = { SMODS.Gradients["busterb_Secret"], SMODS.Gradients["busterb_epileptic"] } } }
	end,
can_use = function(self, card)
    return #G.jokers.cards < G.jokers.config.card_limit
  end,

  use = function(self, card, area, copier)
    busterb_use_consumable_animation(card, nil, function()
      if #G.jokers.cards < G.jokers.config.card_limit then
        G.SETTINGS.paused = true

        local selectable_jokers = {}

        for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
          if not (   
                v.rarity == "jen_ritualistic" or
                 v.rarity == "jen_transcendent" or
                 v.rarity == "jen_omegatranscendent" or
                 v.rarity == "jen_omnipotent" or 
                 v.rarity == "jen_miscellaneous" or
                 v.rarity == "busterb_Secret" or 
                 v.rarity == "busterb_technopotent"
            ) then
            selectable_jokers[#selectable_jokers + 1] = v
          end
        end

        -- If the list of jokers is empty, we want at least one option so the user can leave the menu
        if #selectable_jokers <= 0 then
          selectable_jokers[#selectable_jokers + 1] = G.P_CENTERS.j_joker
        end

        G.FUNCS.overlay_menu {
          config = { no_esc = true },
          definition = mugen_apostle_of_wands_collection_UIBox(
            selectable_jokers,
            { 5, 5, 5 },
            {
              no_materialize = true,
              modify_card = function(other_card, center)
                other_card.sticker = get_joker_win_sticker(center)
                busterb_create_select_card_ui(other_card, G.jokers)
              end,
              h_mod = 1.05,
            }
          ),
        }
      end
    end)
  end
}

SMODS.Consumable {
    key = 'marshall',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 0, y = 0 },
    config = {
    extra = { val = 1.5 }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.val } }
	end,
can_use = function(self, card)
    return #G.jokers.cards > 0
  end,

  use = function(self, card, area, copier)
    local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
						Spectrallib.manipulate(v, { value = card.ability.extra.val })
						check = true
				end
			end
			if check then
                return { message = localize("k_upgrade_ex"), colour = HEX('E36956'), card = self }
			end
  end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'virtuality',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 1, y = 0 },
    config = { immutable = { v = 50 }},
can_use = function(self, card)
		return G.STATE == G.STATES.SHOP
	end,

 use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent - card.ability.immutable.v
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))

    G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                G.shop:remove()
        G.shop = nil
        G.SHOP_SIGN:remove()
        G.SHOP_SIGN = nil
        G.GAME.current_round.used_packs = nil
        G.STATE_COMPLETE = false
        G:update_shop()
                return true
            end
        }))
                return true
            end
        }))
                return true
            end
        }))
        delay(0.6)
end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'prison_flame',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 2, y = 0 },
    config = {
    extra = {
        xlevel = 2
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xlevel, colours = {HEX('E36956')} } }
	end,
can_use = function(self, card)
    return true
  end,

  use = function(self, card, area, copier)
        update_hand_text({delay = 0}, {
        handname = localize("k_all_hands"),
        level = "...",
        mult = "#",
        chips = "..."
    })
    delay(2)
    Spectrallib.event(function ()
        play_sound('tarot1')
        return true
    end)
    update_hand_text({delay = 0}, {
        handname = localize("k_level_mult"),
        chips = "...",
        mult = "X"
    })
    delay(1)
    BustB.JUICE_CARD_EVENT(card, 0.2)
    for k,v in pairs(G.GAME.hands) do
	G.GAME.hands[k].l_mult = G.GAME.hands[k].l_mult * card.ability.extra.xlevel
    end
    update_hand_text(BustB.uht_snd(0.7, 0.9, 0), {
        mult = "X"..card.ability.extra.xlevel,
        StatusText = true
    })
    delay(2)
	Spectrallib.reset_to_none()

        end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'blue_sky',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 3, y = 0 },
    config = {
    extra = {
        xlevel = 2
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xlevel, colours = {HEX('E36956')} } }
	end,
can_use = function(self, card)
    return true
  end,

  use = function(self, card, area, copier)
        update_hand_text({delay = 0}, {
        handname = localize("k_all_hands"),
        level = "...",
        mult = "...",
        chips = "#"
    })
    delay(2)
    Spectrallib.event(function ()
        play_sound('tarot1')
        return true
    end)
    update_hand_text({delay = 0}, {
        handname = localize("k_level_chips"),
        chips = "X",
        mult = "..."
    })
    delay(1)
    BustB.JUICE_CARD_EVENT(card, 0.2)
    for k,v in pairs(G.GAME.hands) do
	G.GAME.hands[k].l_chips = G.GAME.hands[k].l_chips * card.ability.extra.xlevel
    end
    update_hand_text(BustB.uht_snd(0.7, 0.9, 0), {
        chips = "X"..card.ability.extra.xlevel,
        StatusText = true
    })
    delay(2)
	Spectrallib.reset_to_none()

        end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'wicked_witch',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 0, y = 1 },
    config = {
    extra = 2
    },
can_use = function(self, card)
    return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
    end,
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra, colours = {HEX('E36956')} } }
	end,
  use = function(self, card, area, copier)
    for i = 1, math.min(self.config.extra, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Infinity' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.Consumable {
    key = 'manny',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 1, y = 1 },
    config = {
    extra = {
        min = 10,
        max = 1000
    }
  },
can_use = function(self, card)
    return #G.hand.cards > 0
    end,
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra, colours = {HEX('E36956')} } }
	end,
  use = function(self, card, area, copier)
    for i, v in ipairs(G.hand.cards) do
        local randommoney = (pseudorandom(pseudoseed("busterb_randommoney"), self.config.extra.min, self.config.extra.max) / 100)
				if v ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            v.ability.perma_p_dollars = v.ability.perma_p_dollars + randommoney
                            v:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.Consumable {
    key = 'jackal',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 2, y = 1 },
    config = {
    extra = {
        min = 1,
        max = 5
    }
  },
can_use = function(self, card)
    return #G.hand.cards > 0
    end,
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra, colours = {HEX('E36956')} } }
	end,
  use = function(self, card, area, copier)
    for i, v in ipairs(G.hand.cards) do
        local randomrepeat = (pseudorandom(pseudoseed("busterb_randomrepeat"), self.config.extra.min, self.config.extra.max))
				if v ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            v.ability.perma_repetitions = v.ability.perma_repetitions + randomrepeat
                            v:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
--literally adversary
SMODS.Consumable {
    key = 'blackberserker',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 0, y = 2 },
    config = {
    extra = {
        min = 1,
        max = 5
    }
  },
	can_use = function(self, card)
		return #G.jokers.cards > 0
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local target = #G.jokers.cards == 1 and G.jokers.cards[1] or G.jokers.cards[math.random(#G.jokers.cards)]
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		for i = 1, #G.jokers.cards do
			local percent = 1.15 - (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.jokers.cards[i]:flip()
					play_sound("card1", percent)
					G.jokers.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.jokers.cards do
			local CARD = G.jokers.cards[i]
			local percent = 0.85 + (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					CARD:flip()
					if not CARD.edition then
						CARD:set_edition({ negative = true })
					end
					play_sound("card1", percent)
					CARD:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot2")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			func = function()
				ease_x_ante(2)
				return true
			end,
		}))
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.Consumable {
    key = 'metamon',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 3, y = 1 },
        config = { extra = { jokers = 1 }, immutable = { xscore = 1.25 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.jokers, card.ability.immutable.xscore } }
    end,

    can_use = function(self, card)
        local highlighted = Spectrallib.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)
        return #highlighted <= card.ability.extra.jokers and #highlighted > 0
    end,

    use = function(self, card, area, copier)
        for i, c in ipairs(Spectrallib.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)) do
            local copy = copy_card(c)
            copy:set_edition("e_negative", true)
            G.jokers:emplace(copy)
            Spectrallib.add_bonus_effect(copy, "busterb_immutable_xblindsize", {immutable = card.ability.immutable.xscore})
        end
    end,

 
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.Consumable {
    key = 'demiurgos',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 1, y = 2 },
        config = { extra = { jokers = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.jokers } }
    end,

    can_use = function(self, card)
        local highlighted = Spectrallib.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)
        return #highlighted <= card.ability.extra.jokers and #highlighted > 0
    end,

    use = function(self, card, area, copier)
        for i, v in pairs(Spectrallib.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)) do
            if not v.entr_aleph or v.busterb_omega then
                v:start_dissolve()
                ease_x_dollars{2}
            end
        end
    end,


   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}


SMODS.Consumable {
    key = 'meija',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 2, y = 2 },
    config = { extra = { num_copies = 3 }, immutable = { selected = 1 } },
	misprintize_caps = { extra = { num_copies = 100 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		return { vars = { card.ability.extra.num_copies } }
	end,
	    can_use = function(self, card)
        return #G.consumeables.cards > 0 and (G.consumeables.cards[1].config.center_key ~= "c_busterb_meija")
    end,

    use = function(self, card, area, copier)
                for i = 1, card.ability.extra.num_copies do
                     G.E_MANAGER:add_event(Event({
                func = function()
                    local copy = copy_card(G.consumeables.cards[1])
                    if Incantation then
						copy:setQty(1)
					end
                    copy:set_edition("e_negative", true)
                    copy:add_to_deck()
                    G.consumeables:emplace(copy)
                    return true
                end
            }))
            SMODS.calculate_effect{message = localize("k_duplicated_ex"), colour = G.C.DARK_EDITION, card = G.consumeables.cards[1]}
        end	
    end,

 
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}

SMODS.Consumable {
    key = 'crazycat',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 3, y = 2 },
    config = {
    extra = { val = 1.5 }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.val } }
	end,
can_use = function(self, card)
    return #G.consumeables.cards > 0
  end,

  use = function(self, card, area, copier)
    local check = false
			for i, v in pairs(G.consumeables.cards) do
				if v ~= card then
						Spectrallib.manipulate(v, { value = card.ability.extra.val })
						check = true
				end
			end
			if check then
                return { message = localize("k_upgrade_ex"), colour = HEX('E36956'), card = self }
			end
  end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.Consumable {
    key = 'otw',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 0, y = 3 },
    config = {
    select = 1,
    extra = { jokers = 1 }
  },
 use = function(self, card, area, copier)
        for i, card in pairs(Spectrallib.get_highlighted_cards({G.jokers}, card, 1, card.ability.select)) do
            card.ability.busterb_omega = true
            card:set_edition("e_negative")
            card:juice_up()

        end
    end,
    can_use = function(self, card)
        local highlighted = Spectrallib.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)
        return #highlighted <= card.ability.extra.jokers and #highlighted > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set="Other", key = "busterb_omega"}
        q[#q+1] = G.P_CENTERS.e_negative
        return {
            vars = {
                card.ability.select,
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
SMODS.Consumable {
    key = 'beatrix',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 1, y = 3 },
    config = {
    extra = { max_highlighted = 1, multiuse = 2 }
  },
can_use = function(self, card)
    return #G.consumeables.cards > 0
  end,
  use = function(self, card, area, copier)
    local check = false
			for i, v in pairs(G.consumeables.cards) do
				if v ~= card then
                        v.ability.cry_multiuse = ((v.ability.cry_multiuse or 1) + self.config.extra.multiuse)
						check = true
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = "+"..self.config.extra.multiuse.. " Multiuse", colour = HEX('E36956') }
				)
			end
  end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.extra.max_highlighted, card.ability.extra.multiuse, colours = {HEX('E36956')}
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
SMODS.Consumable {
    key = 'blackc',
    set = 'Infinity',
    atlas = "a_ic",
    cost = 4, pos = { x = 2, y = 3 },
    config = {
    extra = { val = 1.5}
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.val } }
	end,
can_use = function(self, card)
    return #G.hand.cards > 0
  end,

  use = function(self, card, area, copier)
    local check = false
			for i, v in pairs(G.hand.cards) do
				if v ~= card then
						Spectrallib.manipulate(v, { value = card.ability.extra.val })
						check = true
				end
			end
			if check then
                return { message = localize("k_upgrade_ex"), colour = HEX('E36956'), card = self }
			end
  end,
   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'soulabyss',
    set = 'Infinity',
    atlas = "a_ic",
    hidden = true,
    can_repeat_soul = true,
    soul_set = 'Infinity',

    cost = 4, pos = { x = 3, y = 3 },
    config = { extra = { jokers = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.jokers } }
    end,

    can_use = function(self, card)
        local highlighted = Spectrallib.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)
        return #highlighted <= card.ability.extra.jokers and #highlighted > 0
    end,

    use = function(self, card, area, copier)
        for i, v in pairs(Spectrallib.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)) do
            if not v.entr_aleph or v.busterb_omega then
                v:start_dissolve()
                G.GAME.banned_keys[v.config.center.key] = true
                local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if v.hidden  and not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) then pool[#pool+1] = v.key end
                end
                local random_key = pseudorandom_element(pool, "random_rare_consumeable")
                    if random_key then SMODS.add_card{key = random_key} end
            end
        end
    end,


   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}