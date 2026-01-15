--busterb_admin_dt = 0
SMODS.Atlas({
	key = 'atlas_Admin',
	path = 'admin.png', -- contained in assets folders
	px = 71, py = 95,
	atlas_table = 'ANIMATION_ATLAS', -- this line tells SMODS that this is an animated atlas
	frames = 2, -- the number of frames in your animation
	fps = 2 -- the fps to play your animation in (defaults to 10 if not included)
})
--SMODS.Atlas({
--	key = 'atlas_Admin',
--	path = 'admin.png',
--	px = 71, py = 95,
--})


SMODS.Consumable{
    set = "Spectral",
	name = "admin",
	key = "admin",
	pos = { x = 0, y = 0 },
	cost = 4,
    loc_txt = {
        name = "ADMINISTRATOR",
        text = {"???"}
    },
	atlas = "atlas_Admin",
	can_use = function(self, card)
		return true
	end,
	config = { immutable = { state = 1, ctr = 0} },
--        update = function(self, card, dt)
--    busterb_admin_dt = busterb_admin_dt + dt;
--    if busterb_admin_dt > 0.5 then
--        busterb_admin_dt = 0
--      self.pos.y = (self.pos.y == 0) and 1 or 0
--    end
--	card.children.floating_sprite:set_sprite_pos({ x = busterb_admin_dt, y = 0 })
--end,
	use = function(self, card, area, copier)

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
				colour = HEX("030b1e"),
				outline_colour = G.C.SECONDARY_SET.Spectral,
				contents = {
					{
						n = G.UIT.R,
						nodes = {
							create_text_input({
								colour = G.C.SECONDARY_SET.Spectral,
								hooked_colour = darken(copy_table(G.C.SECONDARY_SET.Spectral), 0.3),
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
								colour = G.C.SECONDARY_SET.Spectral,
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
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end
}