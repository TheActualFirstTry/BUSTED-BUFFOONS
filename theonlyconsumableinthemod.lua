SMODS.Atlas {
    key = "atlas_Dream",
    path = "DreamSpectral.png",
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
   key = 'busterb_Fantasy',
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
    key = 'fantasy',
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
   key = 'busterb_fantasy',
   order = 50,
   func = function(card)
       if card.config.center.key == "c_busterb_fantasy" and (card.config.center.discovered or card.bypass_discovery_center) then
           local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
               0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
               (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
           local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
               0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
       end
   end,
   conditions = { vortex = false, facing = 'front' },
}

--SMODS.Atlas {
-- key = "atlas_Offer",
-- path = "Offer.png",
-- px = 71,
-- py = 95
--}
-- I lied -- NEW CONSUMABLE = SUPPLY AND DEMAND  
-- CARD TYPE/POOL = CONSUMABLE/Bootleg CARD
-- I've decided to not add this for now, but you're supposed to use this with a selected card so it can appear in the shop at random. Ignore it's name Offer, it's now called Supply and Demand in my notes.
--SMODS.Consumable {
--    key = 'offer',
--    set = 'Bootleg',
--    atlas = "atlas_Offer",
--    pos = { x = 0, y = 0 },
--    soul_pos = { x = 0, y = 1, draw = function(card, scale_mod, rotate_mod)
--        local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
--            0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
--            (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
--        local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
--            0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
--        card.children.floating_sprite.role.draw_major = card
--        card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod,
--            nil,
--            0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
--        card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
--    end,},
--    soul_rate = 0.01,
--    can_repeat_soul = true,
--    soul_set = 'Bootleg',
--    
--    loc_txt = {
--        name = "Offer",
--        text = {
-- "1 of 6 Gifts will be given:",
-- "A random {C:attention}Non-Common or Non-Uncommon Joker{}",
-- "A random {V:1}Fantastic{} Joker",
-- "2 {C:legendary}Legendary{} Jokers",
-- "10 Random Negative Spectral Cards",
-- "1 {C:dark_edition}Negative {C:attention}Judgement{}, 1 {C:dark_edition}Negative {C:spectral}Wraith{}, 1 {C:dark_edition}Negative {C:legendary}Soul{}, and 1 {C:dark_edition}Negative {V:1}Dream{}",
-- "{C:spectral,X:white}Minos Prime{}"
--}
--    },
-- loc_vars = function(self, info_queue, card)
-- return { vars = { colours = {HEX('b00b69')} } }
-- end,
    -- When used, the card will give 1 of 6 things
--    use = function(self, card, area, copier)