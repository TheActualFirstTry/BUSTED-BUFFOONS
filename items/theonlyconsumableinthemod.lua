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
    soul_rate = 0.75,
    can_repeat_soul = true,
    soul_set = 'Planet',
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
   key = 'busterb_dream',
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