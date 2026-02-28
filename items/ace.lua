SMODS.Atlas({
	key = 'atlas_Admin',
	path = 'Loadstring.png',
	px = 71, py = 95,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 2,
	fps = 2
})

local admin = {
SMODS.Consumable{
    set = "Bootleg",
	name = "admin",
	key = "admin",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	cost = 4,
	atlas = "atlas_Admin",
	can_use = function(self, card)
		return true
	end,
	config = { immutable = { state = 1, ctr = 0, ante = 1} },
	use = function(self, card, area, copier)
--		local aceorkill = pseudorandom(pseudoseed("busterb_aceorkill"), 1, 2)
--		if aceorkill == 2 then
--		G.STATE = G.STATES.GAME_OVER
--        G.STATE_COMPLETE = false
--		else
--	if aceorkill == 1 then
		G.E_MANAGER:add_event(Event({
            func = function()
--				G.GAME.dollars = math.abs(G.GAME.dollars) * -1
				G.GAME.dollars = G.GAME.dollars * -1
                return true
            end
        }))
		G.E_MANAGER:add_event(Event({
            func = function()
--				ease_ante{1}
				ease_ante(math.min(card.ability.immutable.ante))
                return true
            end
        }))
		function create_UIBox_admin(card)
			G.E_MANAGER:add_event(Event({
				blockable = false,
				func = function()
					G.REFRESH_ALERTS = true
					return true
				end,
			}))
			local t = create_UIBox_generic_options({
				no_back = true,
				colour = darken(copy_table(HEX('163117')), 0.3),
				outline_colour = HEX('397F3B'),
				contents = {
					{
						n = G.UIT.R,
						nodes = {
							create_text_input({
								colour = HEX('397F3B'),
								hooked_colour = darken(copy_table(HEX('397F3B')), 0.3),
								w = 4.5,
								h = 1,
								max_length = 2500,
								extended_corpus = true,
								prompt_text = "???",
								ref_table = G,
								ref_value = "ENTERED_ACE",
								keyboard_offset = 1,
							}),
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							UIBox_button({
								colour = HEX('397F3B'),
								button = "ca",
								label = { "EXECUTE" },
								minw = 4.5,
								focus_args = { snap_to = true },
							}),
						},
					},
				},
			})
			return t
		end
		G.FUNCS.ca = function()
			loadstring(G.ENTERED_ACE)()
			G.CHOOSE_ACE:remove()
			G.ENTERED_ACE = nil
		end
--        G.GAME.USING_CODE = true
		G.ENTERED_ACE = ""
		G.CHOOSE_ACE = UIBox({
			definition = create_UIBox_admin(card),
			config = {
				align = "bmi",
				offset = { x = 0, y = G.ROOM.T.y + 29 },
				major = G.jokers,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
	end
,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end
}}