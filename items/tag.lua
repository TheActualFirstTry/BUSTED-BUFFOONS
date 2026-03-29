SMODS.Atlas{
    key = "dtag",
    path = "dtag.png",
    px = 34,
    py = 34
}

SMODS.Tag{
	key = "dreamy",
	atlas = "dtag",
	pos = { x = 0, y = 0 },
	min_ante = 2,
	config = { type = "store_joker_create" },
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local rares_in_posession = { 0 }
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.rarity == "busterb_Dreamy" and not rares_in_posession[v.config.center.key] then
					rares_in_posession[1] = rares_in_posession[1] + 1
					rares_in_posession[v.config.center.key] = true
				end
			end
			local card
			if #G.P_JOKER_RARITY_POOLS.busterb_Dreamy > rares_in_posession[1] then
				card = create_card("Joker", context.area, nil, "busterb_Dreamy", nil, nil, nil, "cry_eta")
				create_shop_card_ui(card, "Joker", context.area)
				card.states.visible = false
				tag:yep("+", G.C.RARITY.busterb_Dreamy, function()
					card:start_materialize()
					card.misprint_cost_fac = 0.5
					card:set_cost()
					return true
				end)
			else
				tag:nope()
			end
			tag.triggered = true
			return card
		end
	end,
}
SMODS.Atlas{
    key = "Itag",
    path = "Itag.png",
    px = 34,
    py = 34
}
SMODS.Tag {
    key = "immortal",
    atlas = "Itag",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_busterb_inf_pack_1
		return { vars = {} }
	end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', HEX('FFB570'), function()
                local booster = SMODS.create_card { key = 'p_busterb_inf_pack_1', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
SMODS.Atlas{
    key = "Ptag",
    path = "Ptag.png",
    px = 34,
    py = 34
}
SMODS.Tag {
    key = "delivery",
    atlas = "Ptag",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_busterb_mega_pizzabox
		return { vars = {} }
	end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', HEX('bc1006'), function()
                local booster = SMODS.create_card { key = 'p_busterb_mega_pizzabox', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
SMODS.Atlas {
    key = "Cry",
    path = "Crine.png",
    px = 34,
    py = 34
}
SMODS.Tag {
	order = 13,
	atlas = "Cry",
	pos = { x = 0, y = 0 },
	config = { type = "new_blind_choice", odds = 4 },
	min_ante = 2,
	key = "crine",
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = { set = "Tag", key = "tag_busterb_rose" }
		return { vars = { SMODS.get_probability_vars(self, 1, self.config.odds, "Rose Tag") } }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			if SMODS.pseudorandom_probability(card, "busterb_crine", 1, tag.config.odds, "Rose Tag") then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
					local rose = Tag("tag_busterb_rose")
					add_tag(rose)
					tag.triggered = true
					rose:apply_to_run({ type = "new_blind_choice" })
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
			else
				tag:nope()
				tag.triggered = true
				for i = 1, #G.GAME.tags do
					if G.GAME.tags[i] ~= tag then
						if G.GAME.tags[i]:apply_to_run({ type = "new_blind_choice" }) then
							break
						end
					end
				end
			end
			tag.triggered = true
			return true
		end
	end,
}
SMODS.Atlas{
    key =  "r",
    path = "Rose.png",
    px = 34,
    py = 34
}
SMODS.Tag {
    atlas = "r",
	pos = { x = 0, y = 0 },
	config = { type = "new_blind_choice" },
	key = "rose",
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_spectral_normal_1
		info_queue[#info_queue + 1] = { set = "Spectral", key = "c_busterb_mugen" }
		info_queue[#info_queue + 1] = { set = "Spectral", key = "c_busterb_Fantasy" }
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
				local key = "p_busterb_gem"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	in_pool = function()
		return false
	end,
}