SMODS.Atlas {
    key = "atlas_Mugen",
    path = "Mugen.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'mugen',
    set = 'Spectral',
    atlas = "atlas_Mugen",
    pos = { x = 0, y = 0 },
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
          if not (   v.rarity == "jen_ritualistic" or
                 v.rarity == "jen_transcendent" or
                 v.rarity == "jen_omegatranscendent" or
                 v.rarity == "jen_omnipotent" or 
                 v.rarity == "jen_miscellaneous"
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

SMODS.Atlas {
    key = "atlas_Virtual",
    path = "Virtuality.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "atlas_Marshall",
    path = "Marshall.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'marshall',
    set = 'Infinity',
    atlas = "atlas_Marshall",
    pos = { x = 0, y = 0 },
    config = {
    extra = 1.5
  },
loc_vars = function(self, info_queue, card)
		return { vars = { number_format(self.config.extra) } }
	end,
can_use = function(self, card)
    return #G.jokers.cards > 0
  end,

  use = function(self, card, area, copier)
    local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.manipulate(v, { value = self.config.extra })
						check = true
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = HEX('E36956') }
				)
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
    atlas = "atlas_Virtual",
    pos = { x = 0, y = 0 },
    config = {
  },
can_use = function(self, card)
		return G.STATE == G.STATES.SHOP
	end,

 use = function(self, card, area, copier)
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
SMODS.Atlas {
    key = "atlas_PrisonFlame",
    path = "PrisonFlame.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'prison_flame',
    set = 'Infinity',
    atlas = "atlas_PrisonFlame",
    pos = { x = 0, y = 0 },
    config = {
    extra = {
        min = 10,
        max = 1000
    }
  },
can_use = function(self, card)
    return #G.hand.cards > 0
  end,

  use = function(self, card, area, copier)
    for i, v in ipairs(G.hand.cards) do
        local randomxmult = (pseudorandom(pseudoseed("busterb_randomxmult"), self.config.extra.min, self.config.extra.max) / 100)
				if v ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            v.ability.perma_x_mult = v.ability.perma_x_mult + randomxmult
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
SMODS.Atlas {
    key = "atlas_BlueSky",
    path = "BlueSky.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'blue_sky',
    set = 'Infinity',
    atlas = "atlas_BlueSky",
    pos = { x = 0, y = 0 },
    config = {
    extra = {
        min = 10,
        max = 1000
    }
  },
can_use = function(self, card)
    return #G.hand.cards > 0
  end,

  use = function(self, card, area, copier)
    for i, v in ipairs(G.hand.cards) do
        local randomxchips = (pseudorandom(pseudoseed("busterb_randomxchips"), self.config.extra.min, self.config.extra.max) / 100)
				if v ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            v.ability.perma_x_chips = v.ability.perma_x_chips + randomxchips
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
SMODS.Atlas {
    key = "atlas_WickedWitch",
    path = "WickedWitch.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'wicked_witch',
    set = 'Infinity',
    atlas = "atlas_WickedWitch",
    pos = { x = 0, y = 0 },
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

SMODS.Atlas {
    key = "atlas_Manny",
    path = "Manny.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'manny',
    set = 'Infinity',
    atlas = "atlas_Manny",
    pos = { x = 0, y = 0 },
    config = {
    extra = {
        min = 10,
        max = 1000
    }
  },
can_use = function(self, card)
    return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
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

SMODS.Atlas {
    key = "atlas_Jackal",
    path = "Jackal.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'jackal',
    set = 'Infinity',
    atlas = "atlas_Jackal",
    pos = { x = 0, y = 0 },
    config = {
    extra = {
        min = 1,
        max = 5
    }
  },
can_use = function(self, card)
    return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
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
SMODS.Atlas {
    key = "atlas_BlackBerserker",
    path = "BlackBerserk.png",
    px = 71,
    py = 95
}
--literally adversary
SMODS.Consumable {
    key = 'blackberserker',
    set = 'Infinity',
    atlas = "atlas_BlackBerserker",
    pos = { x = 0, y = 0 },
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
				ease_ante(1)
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

SMODS.Atlas {
    key = "atlas_Metamon",
    path = "Ditto.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'metamon',
    set = 'Infinity',
    atlas = "atlas_Metamon",
    pos = { x = 0, y = 0 },
        config = { extra = { jokers = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.jokers } }
    end,

    can_use = function(self, card)
        local highlighted = Cryptid.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)
        return #highlighted <= card.ability.extra.jokers and #highlighted > 0
    end,

    use = function(self, card, area, copier)
        for i, c in ipairs(Cryptid.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)) do
            local copy = copy_card(c)
            copy:set_edition("e_negative", true)
            G.jokers:emplace(copy)
        end
    end,

    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end,

   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.Atlas {
    key = "atlas_Demiurgos",
    path = "Demi.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'demiurgos',
    set = 'Infinity',
    atlas = "atlas_Demiurgos",
    pos = { x = 0, y = 0 },
        config = { extra = { jokers = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.jokers } }
    end,

    can_use = function(self, card)
        local highlighted = Cryptid.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)
        return #highlighted <= card.ability.extra.jokers and #highlighted > 0
    end,

    use = function(self, card, area, copier)
        for i, v in pairs(Cryptid.get_highlighted_cards({G.jokers}, card, 1, card.ability.extra.jokers)) do
            if not v.entr_aleph then
                v:start_dissolve()
            end
        end
    end,

    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end,

   draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}