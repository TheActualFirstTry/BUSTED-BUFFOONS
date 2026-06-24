SMODS.Atlas {
    key = "conduct",
    path = "Conductor.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "inject",
    path = "Injector.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "mtr",
    path = "Matrix.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "marks",
    path = "Marksman.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "blizz",
    path = "Blizzard.png",
    px = 71,
    py = 95
}
SMODS.Consumable {
    key = 'conductor',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "conduct",
    config = { max_highlighted = 2, mod_conv = 'm_busterb_electric' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'injector',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "inject",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_crystallized' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'matrix',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "mtr",
    config = { create = 1 },
	misprintize_caps = { create = 100 },
    loc_vars = function(self, info_queue, card)
		return { vars = { Spectrallib.safe_get(card, "ability", "create") or self.config.create } }
	end,
--    config = { max_highlighted = 1, mod_conv = 'm_busterb_nanotech' },
--    loc_vars = function(self, info_queue, card)
--        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
--        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
--    end
can_use = function(self, card)
		return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
	end,
	use = function(self, card, area, copier)
		local forceuse = G.cry_force_use
		for i = 1, math.min(card.ability.consumeable.create, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards or forceuse then
						play_sound("timpani")
						local _card = create_card("Bootleg", G.consumeables, nil, nil, nil, nil, nil, "busterb_nanotech")
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						card:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
		end
		delay(0.6)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
    SMODS.Consumable {
    key = 'marksman',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "marks",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_bloodmarked' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'blizzard',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "blizz",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_frost' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}