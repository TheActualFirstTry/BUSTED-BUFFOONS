-- THANK YOU ASTRO

function BustB.busterb_test()
    return { -- [[1]]
        n = G.UIT.ROOT,
        config = { align = 'cm', padding = 0.2, colour = HEX('3F3F3F'), outline = 1, outline_colour = G.C.SECONDARY_SET.Spectral, r = 0.1 },
        nodes = { --[[2]] { --[[3]]
            
            n = G.UIT.C,
            config = { align = 'cm' },
            nodes = { --[[4]] {
                n = G.UIT.R,
                config = {minw = 1, minh = 1, padding = 0.15, colour = HEX('3F3F3F')},
                nodes = { {
                n = G.UIT.R,
                config = { align = 'cl' },
                nodes = { { n = G.UIT.T, config = { text = localize('k_busterb_cmd'), colour = G.C.WHILE, scale = 2 * 0.35 } } }
            },
            {
                n = G.UIT.R,
                config = { align = 'cl' },
                nodes = { { n = G.UIT.T, config = { text = localize('k_busterb_cmd_desc'), colour = G.C.WHILE, scale = 1 * 0.35 } } }
            }, },
            }, {
                n = G.UIT.R,
                config = {minw = 1, minh = 1, padding = 0.15, colour = HEX('3F3F3F')},
                nodes = {{
						n = G.UIT.R,
						nodes = {
							create_text_input({
								colour = G.C.SECONDARY_SET.Spectral,
								hooked_colour = darken(copy_table(G.C.SECONDARY_SET.Spectral), 0.3),
								w = 9,
								h = 1,
								max_length = 2500,
								extended_corpus = true,
								prompt_text = localize("k_busterb_cmd_empty"),
								ref_table = G,
								ref_value = "ENTERED_ACE",
								keyboard_offset = 1,
							}),
						},
					},},
            }, { -- [[5]]
                n = G.UIT.R,
                config = { align = 'cl' },
                nodes = { --[[6]] { --[[7]]
                n = G.UIT.R,
                config = { align = 'cl' },
                nodes = { --[[8]] {
                    n = G.UIT.C,
                    config = {minw = 1, minh = 1, padding = 0.15, colour = HEX('3F3F3F')},
                    nodes = { {
                        n = G.UIT.R,
                        config = { id = 'BBB', align = 'cm', minw = 2.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = nil, func = 'busterb_can_go_back', shadow = true, focus_args = { nav = 'wide', button = 'b' } },
                        nodes = { {
                            n = G.UIT.C,
                            config = { align = 'cm', padding = 0, no_fill = true },
                            nodes = { {
                                n = G.UIT.T, config = { bond = "Strong", text = localize("k_busterb_back"), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true, func = 'set_button_pip' or nil, focus_args = { button = 'back_button' } or nil }
                            } }
                        } }
                    } }
                }, {
                    n = G.UIT.C,
                    config = {minw = 1, minh = 1, padding = 0.15, colour = HEX('3F3F3F')},
                    nodes = {
                        {
                        n = G.UIT.R,
                        config = { id = 'BBE', align = 'cm', minw = 2.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = nil, func = 'busterb_can_enter', shadow = true, focus_args = { nav = 'wide', button = 'b' } },
                        nodes = { {
                            n = G.UIT.C,
                            config = { align = 'cm', padding = 0, no_fill = true },
                            nodes = { {
                                n = G.UIT.T, config = { Bond = "Strong", text = localize("k_busterb_enter"), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true, func = 'set_button_pip' or nil, focus_args = { button = 'execute_string' } or nil }
                            } }
                        } } 
                    },
                }
                }, { --[[9]]
                    n = G.UIT.C,
                    config = {minw = 1, minh = 1, padding = 0.15, colour = HEX('3F3F3F')},
                    nodes = { --[[10]]
                        { --[[11]]
                        n = G.UIT.R,
                        config = { id = 'BBH', align = 'cm', minw = 2.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = nil, func = 'busterb_help', shadow = true, focus_args = { nav = 'wide', button = 'b' } },
                        nodes = { --[[12]] { --[[13]]
                            n = G.UIT.C,
                            config = { align = 'cm', padding = 0, no_fill = true },
                            nodes = { --[[14]] { --[[15]]
                                n = G.UIT.T, config = { bond = "Strong", text = localize("k_busterb_help"), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true, func = 'set_button_pip' or nil, focus_args = { button = 'busterb_web' } or nil }
                            } --[[15]] } -- [[14]]
                        } --[[13]] }  --[[12]]
                    }, -- [[11]]
                } --[[10]]
                } --[[9]] } --[[8]]
                } --[[7]] } --[[6]]
            } --[[5]] } --[[4]]
        } --[[3]] } -- [[2]]
    } -- [[1]]
end
BustB.busterb_begin_test = function()
        G.SETTINGS.paused = true
        G.ENTERED_ACE = ""
		G.FUNCS.overlay_menu({
        definition = BustB.busterb_test(),
        config = {
            align = 'cm',
            offset = { x = 0, y = 10 },
            major = G.ROOM_ATTACH,
			bond = "Weak",
            no_esc = true,
			instance_type = "POPUP",
        }
    })
    return true
end

G.FUNCS.execute_string = function()
            G.SETTINGS.paused = false
            loadstring(G.ENTERED_ACE)()
            G.SETTINGS.paused = false
            G.FUNCS.exit_overlay_menu()
            G.SETTINGS.paused = false
			G.ENTERED_ACE = nil
            G.SETTINGS.paused = false
        end

G.FUNCS.back_button = function()
            G.SETTINGS.paused = false
            G.FUNCS.exit_overlay_menu()
            G.SETTINGS.paused = false
			G.ENTERED_ACE = nil
            G.SETTINGS.paused = false
        end
G.FUNCS.clear_string = function()
            G.ENTERED_ACE = nil
            G.ENTERED_ACE = ""
        end



G.FUNCS.busterb_help = function(e)
--    local func = true
--    if func then
        e.config.button = 'busterb_web'
        e.config.colour = G.C.SECONDARY_SET.Spectral
--    else
--        e.config.button = nil
--    end
end

G.FUNCS.busterb_can_go_back = function(e)
    local func = true
    if func then
        e.config.button = 'back_button'
        e.config.colour = G.C.SECONDARY_SET.Spectral
    else
        e.config.button = nil
    end
end

G.FUNCS.busterb_can_enter = function(e)
    local func = true
    if func then
        e.config.button = 'execute_string'
        e.config.colour = G.C.SECONDARY_SET.Spectral
    else
        e.config.button = nil
    end
end
G.FUNCS.busterb_can_clear = function(e)
    local func = true
    if func then
        e.config.button = 'clear_string'
        e.config.colour = G.C.RED
    else
        e.config.button = nil
    end
end


G.FUNCS.busterb_web = function()
        love.system.openURL("https://docs.smods.dev/")
end



local admin = {
SMODS.Consumable{
    set = "Spectral",
	name = "admin",
	key = "admin",
	pos = { x = 0, y = 0 },
	cost = 4,
	atlas = "atlas_Admin",
    hidden = true,
	no_collection = true,
	can_repeat_soul = true,
    soul_set = 'Bootleg',
	config = { immutable = { state = 1, ctr = 0, ante = 1} },
	use = function(self, card, area, copier)
--		local aceorkill = pseudorandom(pseudoseed("busterb_aceorkill"), 1, 2)
--		if aceorkill == 2 then
--			G.SETTINGS.paused = true
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
    busterb_use_consumable_animation(card, nil, function()
--        G.SETTINGS.paused = true
        BustB.busterb_begin_test()
    end)
--end
--end
end
,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
	can_use = function(self, card)
		return true
    end,
}}
--[[
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
				colour = HEX('0b0d11'),
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
]]
