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
        max = 100
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
        max = 100
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