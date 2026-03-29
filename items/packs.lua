SMODS.Atlas {
    key = "inf_pack1",
    path = "infpack1.png",
    px = 71,
    py = 95
}
SMODS.Booster {
    key = 'inf_pack_1',
    atlas = 'inf_pack1', 
    pos = { x = 0, y = 0 },
    pools = {["inf_packs"] = true, ["booster"] = true},
    discovered = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('FFB570'), 0.4), lighten(HEX("3E2347"), 0.2), lighten(HEX('E36956'), 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX('E36956')} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Pizzabox",


    create_card = function(self, card, i)
        ease_background_colour(HEX("272736"))
        return SMODS.create_card({
            set = "Infinity",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "busterb_soulable_inf"
            })
    end,
    in_pool = function() return true end
}

SMODS.Atlas {
    key = "boxes",
    path = "pizzabox.png",
    px = 71,
    py = 95
}
SMODS.Booster {
    key = 'pizzabox1',
    atlas = 'boxes', 
    pos = { x = 0, y = 0 },
    pools = {["pizzaboxes"] = true, ["booster"] = true},
    discovered = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('bc1006'), 0.4), lighten(HEX("748645"), 0.2), lighten(HEX('ffd28d'), 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX('bc1006')} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Pizzabox",


    create_card = function(self, card, i)
        ease_background_colour(HEX("bc1006"))
        return SMODS.create_card({
            set = "Pizza",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "busterb_soulable_pizza"
            })
    end,
    in_pool = function() return true end
}

SMODS.Booster {
    key = 'pizzabox2',
    atlas = 'boxes', 
    pos = { x = 1, y = 0 },
    pools = {["pizzaboxes"] = true, ["booster"] = true},
    discovered = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('bc1006'), 0.4), lighten(HEX("748645"), 0.2), lighten(HEX('ffd28d'), 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX('bc1006')} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Pizzabox",


    create_card = function(self, card, i)
        ease_background_colour(HEX("bc1006"))
        return SMODS.create_card({
            set = "Pizza",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "busterb_soulable_pizza"
            })
    end,
    in_pool = function() return true end
}
SMODS.Booster {
    key = 'jumbo_pizzabox',
    atlas = 'boxes', 
    pos = { x = 2, y = 0 },
    pools = {["pizzaboxes"] = true, ["booster"] = true},
    discovered = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('bc1006'), 0.4), lighten(HEX("748645"), 0.2), lighten(HEX('ffd28d'), 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    draw_hand = false,
    config = {
        extra = 5,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX('bc1006')} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Pizzabox",


    create_card = function(self, card, i)
        ease_background_colour(HEX("bc1006"))
        return SMODS.create_card({
            set = "Pizza",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "busterb_soulable_pizza"
            })
    end,
    in_pool = function() return true end
}
SMODS.Booster {
    key = 'mega_pizzabox',
    atlas = 'boxes', 
    pos = { x = 3, y = 0 },
    pools = {["pizzaboxes"] = true, ["booster"] = true},
    discovered = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('bc1006'), 0.4), lighten(HEX("748645"), 0.2), lighten(HEX('ffd28d'), 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    draw_hand = false,
    config = {
        extra = 5,
        choose = 2, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX('bc1006')} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Pizzabox",


    create_card = function(self, card, i)
        ease_background_colour(HEX("bc1006"))
        return SMODS.create_card({
            set = "Pizza",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "busterb_soulable_pizza"
            })
    end,
    in_pool = function() return true end
}
SMODS.Atlas{
    key = "Gem",
    path = "Gem.png",
    px = 71,
    py = 95
}
SMODS.Booster{
    key = "gem",
	kind = "Spectral",
	no_doe = true,
	atlas = "Gem",
	pos = { x = 0, y = 0 },
	config = { extra = 2, choose = 1 },
	cost = 0,
	weight = 0,
	draw_hand = false,
	update_pack = SMODS.Booster.update_pack,
	loc_vars = SMODS.Booster.loc_vars,
	ease_background_colour = function(self)
		ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
	end,
	create_UIBox = function(self)
		return create_UIBox_spectral_pack()
	end,
	particles = function(self)
		G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
			timer = 0.015,
			scale = 0.1,
			initialize = true,
			lifespan = 3,
			speed = 0.2,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
			fill = true,
		})
		G.booster_pack_sparkles.fade_alpha = 1
		G.booster_pack_sparkles:fade(1, 0)
	end,
	create_card = function(self, card, i)
		if
			i % 2 == 1
			and Cryptid.enabled("c_busterb_Fantasy") == true
			and not G.GAME.banned_keys["c_busterb_Fantasy"]
			and not (G.GAME.used_jokers["c_busterb_Fantasy"] and not next(find_joker("Showman")))
		then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_busterb_Fantasy")
		elseif
			not (G.GAME.used_jokers["c_busterb_mugen"] and not next(find_joker("Showman"))) and not G.GAME.banned_keys["c_busterb_mugen"]
		then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_busterb_mugen")
		else
			return create_card("Spectral", G.pack_cards, nil, nil, true, true)
		end
	end,
	group_key = "k_spectral_pack",
	in_pool = function()
		return false
	end,
}