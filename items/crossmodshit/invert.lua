SMODS.Atlas {
    key = "atlas_Ecstasy",
    path = "Ecstasy.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'Ecstasy',
    set = 'Omen',
    atlas = "atlas_Ecstasy",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1} },
    soul_rate = 0.1,
    can_repeat_soul = true,
    soul_set = 'Omen',
    loc_txt = {
        name = "Ecstasy",
        text = {"Creates a random {V:1,E:2}Insanity{} joker", "{s:0.8,C:inactive}(Destroys all held jokers){}"}
    },
    inversion = "c_busterb_Fantasy",
loc_vars = function(self, info_queue, card)
		return { vars = { colours = {SMODS.Gradients["busterb_insane"]} } }
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
				local card = create_card("Joker", G.jokers, nil, "busterb_Insanity", nil, nil, nil, "busterb_Ecstasy")
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
                SMODS.add_card({ set = 'Joker', rarity = "busterb_Insanity" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end
end,
can_use = function(self, card)
        return true
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
