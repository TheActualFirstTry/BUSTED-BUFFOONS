SMODS.Atlas {
    key = "atlas_Dream",
    path = "Dream.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'dream',
    set = 'Spectral',
    atlas = "atlas_Dream",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1, draw = function(card, scale_mod, rotate_mod)
        local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
            0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
            (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
        local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
            0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
        card.children.floating_sprite.role.draw_major = card
        card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod,
            nil,
            0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
        card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end,},
    soul_rate = 0.1,
    can_repeat_soul = true,
    soul_set = 'Spectral',
    loc_txt = {
        name = "Dream",
        text = {"Creates a random {V:1,E:2}Fantastic{} joker", "{s:0.8,C:inactive}(Must have room.){}"}
    },
loc_vars = function(self, info_queue, card)
		return { vars = { colours = {HEX('b00b69')} } }
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = "busterb_Fantastic" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.DrawStep {
   key = 'busterb_Dream',
   order = 50,
   func = function(card)
       if card.config.center.key == "c_busterb_dream" and (card.config.center.discovered or card.bypass_discovery_center) then
           local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
               0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
               (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
           local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
               0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
       end
   end,
   conditions = { vortex = false, facing = 'front' },
}
SMODS.Atlas {
    key = "atlas_Fantasy",
    path = "Fantasy.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'Fantasy',
    set = 'Spectral',
    atlas = "atlas_Fantasy",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1} },
    soul_rate = 0.1,
    can_repeat_soul = true,
    soul_set = 'Spectral',
    loc_txt = {
        name = "Fantasy",
        text = {"Creates a random {V:1,E:2}Grandiose{} joker", "{s:0.8,C:inactive}Destroys all held jokers, also needs room :({}"}
    },
loc_vars = function(self, info_queue, card)
		return { vars = { colours = {SMODS.Gradients["busterb_grand"]} } }
	end,
    use = function(self, card, area, copier)
        if not next(SMODS.find_card('j_busterb_saitama')) then
        local deletable_jokers = {}
		for k, v in pairs(G.jokers.cards) do
			if not SMODS.is_eternal(v) then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
        G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					v:start_dissolve(nil, _first_dissolve)
					_first_dissolve = true
				end
				return true
			end,
		}))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "busterb_Grandiose", nil, nil, nil, "busterb_Fantasy")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
            end
        }))
        delay(0.6)
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = "busterb_Grandiose" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end
end,
can_use = function(self, card)
        return G.jokers
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.DrawStep {
   key = 'busterb_Fantasy',
   order = 50,
   func = function(card)
       if card.config.center.key == "c_busterb_Fantasy" and (card.config.center.discovered or card.bypass_discovery_center) then
           local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
               0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
               (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
           local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
               0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
       end
   end,
   conditions = { vortex = false, facing = 'front' },
}

SMODS.Atlas {
    key = "atlas_Slumber",
    path = "Slumber.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'slumber',
    set = 'Spectral',
    atlas = "atlas_Slumber",
    pos = { x = 0, y = 0 },
    soul_rate = 0.1,
    can_repeat_soul = true,
    soul_set = 'Spectral',
    loc_txt = {
        name = "Slumber",
        text = {"Creates a random {V:1,E:2}Dreamy{} joker", "{s:0.8,C:red}No drawback at the moment.{}"}
    },
loc_vars = function(self, info_queue, card)
		return { vars = { colours = {HEX('2735cf')} } }
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = "busterb_Dreamy" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
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
    loc_txt = {
        name = "MUGEN",
        text = {"Create any {C:attention}Joker{} of","{B:1,C:white,s:1.5}YOUR#1#CHOICE{}","{s:0.5,C:inactive}(Must have room.)"}
    },
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
          if (  v.rarity == 1 or
                v.rarity == 2 or 
                v.rarity == 3 or 
                v.rarity == 4 or
                v.rarity == "busterb_Dreamy" or 
                v.rarity == "cry_exotic" or
                v.rarity == "busterb_Fantastic" or
                v.rarity == "busterb_Grandiose" or
                v.rarity == "entr_entropic" or
                v.rarity == "busterb_Secret" or
                v.rarity == "cry_cursed" or
                v.rarity == "cry_candy" or
                v.rarity == "cry_epic" or
                v.rarity == "unik_detrimental" or 
                v.rarity == 'unik_ancient' or
                v.rarity == "valk_supercursed" or
                v.rarity == 'valk_renowned' or
                v.rarity == 'valk_exquisite' or 
                v.rarity == "jen_junk" or
                v.rarity == "crp_mythic" or
                v.rarity == "crp_outlandish" or
                v.rarity == "crp_cipe" or
                v.rarity == "crp_refined" or
                v.rarity == "crp_plentiful" or
                v.rarity == "crp_divine" or
                v.rarity == "crp_self-insert" or
                v.rarity == "crp_abysmal" or
                v.rarity == "crp_trash" or
                v.rarity == "crp_well-done" or
                v.rarity == "tau_tauic"                
--                v.rarity == 1 or
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
    loc_txt = {
        name = "Marshall",
        text = {"{C:attention}All jokers owned{} gain {C:attention}x#1#{} values"}
    },
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
    loc_txt = {
        name = "Virtuality",
        text = {"Resets the shop."}
    },
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
    loc_txt = {
        name = "Prison Flame",
        text = {"{C:attention}All cards in hand{} gain {C:green}random {X:mult,C:white}XMult{}"}
    },
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
    loc_txt = {
        name = "Blue Sky",
        text = {"{C:attention}All cards in hand{} gain {C:green}random {X:chips,C:white}XChips{}"}
    },
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
    loc_txt = {
        name = "Wicked Witch",
        text = {"Creates {V:1}#1#{} {B:1,C:white}Infinity{} cards"}
    },
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