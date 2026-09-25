
function ease_x_ante(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local ante_UI = G.hand_text_area.ante
          mod = mod or 0
          local text = 'X'
          local col = G.C.BLUE
          local ccol = G.C.RED
          if mod < 0 then
              text = 'X-'
              col = G.C.RED
              ccol = G.C.BLUE
          end
          G.GAME.round_resets.ante = G.GAME.round_resets.ante * mod
          G.GAME.round_resets.ante_disp = G.GAME.round_resets.ante_disp * mod
          check_and_set_high_score('furthest_ante', G.GAME.round_resets.ante)
          ante_UI.config.object:update()
          G.HUD:recalculate()
          --Popup text next to the chips in UI showing number of chips gained/lost
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 0.7,
            cover = ante_UI.parent,
            cover_colour = col,
            align = 'cm',
            })
          --Play a chip sound
          play_sound('highlight2', 0.685, 0.2)
          play_sound('generic1', 0.77)
          play_sound('xchips', 0.77)
          return true
      end
    }))
    local initial = G.GAME.round_resets.ante
    local changed = G.GAME.round_resets.ante * mod
    SMODS.calculate_context({
        ante_change = true,
        amount = changed,
        initial = initial,
        from_shop = (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.SMODS_REDEEM_VOUCHER) or nil,
        from_consumeable = (G.STATE == G.STATES.PLAY_TAROT) or nil,
        from_scoring = (G.STATE == G.STATES.HAND_PLAYED) or nil,
    })

end
function ease_d_ante(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local ante_UI = G.hand_text_area.ante
          mod = mod or 0
          local text = '/'
          local col = G.C.PURPLE
          local ccol = G.C.RED
          if mod < 0 then
              text = '/-'
              col = G.C.RED
              ccol = G.C.PURPLE
          end
          G.GAME.round_resets.ante = G.GAME.round_resets.ante / mod
          G.GAME.round_resets.ante_disp = G.GAME.round_resets.ante_disp / mod
          check_and_set_high_score('furthest_ante', G.GAME.round_resets.ante)
          ante_UI.config.object:update()
          G.HUD:recalculate()
          --Popup text next to the chips in UI showing number of chips gained/lost
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 1.5,
            cover = ante_UI.parent,
            cover_colour = col,
            align = 'cm',
            })
          --Play a chip sound
          play_sound('highlight2', 0.65, 0.4)
          play_sound('generic1', 0.77)
          play_sound('xchips', 0.77)
          return true
      end
    }))
    local initial = G.GAME.round_resets.ante
    local changed = G.GAME.round_resets.ante / mod
    SMODS.calculate_context({
        ante_change = true,
        amount = changed,
        initial = initial,
        from_shop = (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.SMODS_REDEEM_VOUCHER) or nil,
        from_consumeable = (G.STATE == G.STATES.PLAY_TAROT) or nil,
        from_scoring = (G.STATE == G.STATES.HAND_PLAYED) or nil,
    })
end

function ease_e_ante(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local ante_UI = G.hand_text_area.ante
          mod = mod or 0
          local text = '^'
          local col = G.C.BBBLACK
          local ccol = G.C.RED
          if mod < 0 then
              text = 'sqrt'
              col = G.C.RED
              ccol = G.C.BBBLACK
          end
          G.GAME.round_resets.ante = G.GAME.round_resets.ante ^ mod
          G.GAME.round_resets.ante_disp = G.GAME.round_resets.ante_disp ^ mod
          check_and_set_high_score('furthest_ante', G.GAME.round_resets.ante)
          ante_UI.config.object:update()
          G.HUD:recalculate()
          --Popup text next to the chips in UI showing number of chips gained/lost
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 2,
            cover = ante_UI.parent,
            cover_colour = col,
            colour = ccol,
            align = 'cm',
            })
          --Play a chip sound
          play_sound('highlight2', 0.59, 0.6)
          play_sound('generic1', 0.67)
          play_sound('slib_echips', 0.77)
          return true
      end
    }))
    local initial = G.GAME.round_resets.ante
    local changed = G.GAME.round_resets.ante ^ mod
    SMODS.calculate_context({
        ante_change = true,
        amount = changed,
        initial = initial,
        from_shop = (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.SMODS_REDEEM_VOUCHER) or nil,
        from_consumeable = (G.STATE == G.STATES.PLAY_TAROT) or nil,
        from_scoring = (G.STATE == G.STATES.HAND_PLAYED) or nil,
    })
end
function ease_x_ante_win(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local ante_UI = G.hand_text_area.ante
          mod = mod or 0
          local text = 'X'
          local col = G.C.BBBLACK
          local ccol = G.C.RED
          if mod < 0 then
              text = 'X-'
              col = G.C.RED
              ccol = G.C.BBBLACK
          end
          G.GAME.win_ante = G.GAME.win_ante * mod
          ante_UI.config.object:update()
          G.HUD:recalculate()
          --Popup text next to the chips in UI showing number of chips gained/lost
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 2,
            cover = ante_UI.parent,
            cover_colour = col,
            colour = ccol,
            align = 'cm',
            })
          --Play a chip sound
          play_sound('highlight2', 0.585, 0.4)
          play_sound('generic1', 0.77)
          play_sound('xchips', 0.77)
          return true
      end
    }))
end
function ease_ante_win(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local ante_UI = G.hand_text_area.ante
          mod = mod or 0
          local text = '+'
          local col = G.C.FILTER
          local ccol = G.C.WHITE
          if mod < 0 then
              text = '-'
              col = G.C.RED
              ccol = G.C.WHITE
          end
          G.GAME.win_ante = G.GAME.win_ante + mod
          ante_UI.config.object:update()
          G.HUD:recalculate()
          --Popup text next to the chips in UI showing number of chips gained/lost
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 2,
            cover = ante_UI.parent,
            cover_colour = col,
            colour = ccol,
            align = 'cm',
            })
          --Play a chip sound
          play_sound('highlight2', 0.685, 0.2)
          play_sound('generic1')
          return true
      end
    }))
end

function ease_x_dollars(mod, instant)
    local function _mod(mod)
        local dollar_UI = G.HUD:get_UIE_by_ID('dollar_text_UI')
        mod = mod or 0
        local text = 'X'..localize('$')
        local ccol = G.C.GOLD
        local col = G.C.BLACK
        if mod < 0 then
            text = '-X'..localize('$')
            ccol = G.C.RED              
            col = G.C.BLACK          
        else
          inc_career_stat('c_dollars_earned', mod)
        end
        --Ease from current chips to the new number of chips
        G.GAME.dollars = G.GAME.dollars * mod
        check_and_set_high_score('most_money', G.GAME.dollars)
        check_for_unlock({type = 'money'})
        dollar_UI.config.object:update()
        G.HUD:recalculate()
        --Popup text next to the chips in UI showing number of chips gained/lost
        attention_text({
          text = text..tostring(math.abs(mod)),
          scale = 1.2, 
          hold = 1,
          cover = dollar_UI.parent,
          cover_colour = ccol,
          colour = col,
          align = 'cm',
          })
        --Play a chip sound
                play_sound('coin6',.65)
                play_sound('xchips',.65)
    end
    if instant then
        _mod(mod)
    else
        G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            _mod(mod)
            return true
        end
        }))
    end
    local initial_dollars = G.GAME.dollars
    local changed = G.GAME.dollars * mod
    SMODS.dollars_changed = changed
    if SMODS.ease_dollars_calc then return end
    SMODS.calculate_context({
        money_altered = true,
        amount = changed,
        initial = initial_dollars,
        from_shop = (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.SMODS_REDEEM_VOUCHER) or nil,
        from_consumeable = (G.STATE == G.STATES.PLAY_TAROT) or nil,
        from_scoring = (G.STATE == G.STATES.HAND_PLAYED) or nil,
        from_cashout = SMODS.money_from_cashout or nil,
    })
end
function ease_d_dollars(mod, instant)
    local function _mod(mod)
        local dollar_UI = G.HUD:get_UIE_by_ID('dollar_text_UI')
        mod = mod or 0
        local text = '/'..localize('$')
        local ccol = G.C.GOLD
        local col = G.C.RED
        if mod < 0 then
            text = '-/'..localize('$')
            ccol = G.C.RED
            col = G.C.GOLD
        else
          inc_career_stat('c_dollars_earned', mod)
        end
        --Ease from current chips to the new number of chips
        G.GAME.dollars = G.GAME.dollars / mod
        check_and_set_high_score('most_money', G.GAME.dollars)
        check_for_unlock({type = 'money'})
        dollar_UI.config.object:update()
        G.HUD:recalculate()
        --Popup text next to the chips in UI showing number of chips gained/lost
        attention_text({
          text = text..tostring(math.abs(mod)),
          scale = 1.2, 
          hold = 1,
          cover = dollar_UI.parent,
          cover_colour = ccol,
          colour = col,
          align = 'cm',
          })
        --Play a chip sound
                play_sound('coin6',.65)
                play_sound('xchips',.65)
    end
    if instant then
        _mod(mod)
    else
        G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            _mod(mod)
            return true
        end
        }))
    end
    local initial_dollars = G.GAME.dollars
    local changed = G.GAME.dollars / mod
    SMODS.dollars_changed = changed
    if SMODS.ease_dollars_calc then return end
    SMODS.calculate_context({
        money_altered = true,
        amount = changed,
        initial = initial_dollars,
        from_shop = (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.SMODS_REDEEM_VOUCHER) or nil,
        from_consumeable = (G.STATE == G.STATES.PLAY_TAROT) or nil,
        from_scoring = (G.STATE == G.STATES.HAND_PLAYED) or nil,
        from_cashout = SMODS.money_from_cashout or nil,
    })
end
function ease_e_dollars(mod, instant)
    local function _mod(mod)
        local dollar_UI = G.HUD:get_UIE_by_ID('dollar_text_UI')
        mod = mod or 0
        local text = '^'..localize('$')
        local ccol = G.C.BLACK
        local col = SMODS.Gradients["busterb_GoldenFreddyGradient"]
        if mod < 0 then
            text = 'sqrt'..localize('$')
            ccol = G.C.BLACK
            col = Spectrallib.emult
        else
          inc_career_stat('c_dollars_earned', mod)
        end
        --Ease from current chips to the new number of chips
        G.GAME.dollars = G.GAME.dollars * mod
        check_and_set_high_score('most_money', G.GAME.dollars)
        check_for_unlock({type = 'money'})
        dollar_UI.config.object:update()
        G.HUD:recalculate()
        --Popup text next to the chips in UI showing number of chips gained/lost
        attention_text({
          text = text..tostring(math.abs(mod)),
          scale = 1.2, 
          hold = 1.5,
          cover = dollar_UI.parent,
          cover_colour = ccol,
          colour = col,
          align = 'cm',
          })
        --Play a chip sound
                play_sound('coin6',.35)
                play_sound('coin7',.35)
                play_sound('slib_echips',.35)
    end
    if instant then
        _mod(mod)
    else
        G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            _mod(mod)
            return true
        end
        }))
    end
    local initial_dollars = G.GAME.dollars
    local changed = G.GAME.dollars ^ mod
    SMODS.dollars_changed = changed
    if SMODS.ease_dollars_calc then return end
    SMODS.calculate_context({
        money_altered = true,
        amount = changed,
        initial = initial_dollars,
        from_shop = (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.SMODS_REDEEM_VOUCHER) or nil,
        from_consumeable = (G.STATE == G.STATES.PLAY_TAROT) or nil,
        from_scoring = (G.STATE == G.STATES.HAND_PLAYED) or nil,
        from_cashout = SMODS.money_from_cashout or nil,
    })
end


function updatehandtext()
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = "text", chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        delay(1.3)
        update_hand_text({ delay = 0 }, { chips = '^'})
        ease_colour(G.C.UI_CHIPS, SMODS.Gradients["busterb_bigbang"])
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
            attention_text({
                text = "   ^",
                scale = 1.2, 
                hold = 1,
                cover = G.HUD:get_UIE_by_ID('hand_chips').parent,
                cover_colour = G.C.BLACK,
                colour = SMODS.Gradients["busterb_bigbang"],
                align = 'cm',
                offset = { x = 0, y = 0.02}
              })
                play_sound('slib_echips')
                return true
            end
        }))
        delay(1.3)
        update_hand_text({ delay = 0 }, { mult = '^' })
        ease_colour(G.C.UI_MULT, SMODS.Gradients["busterb_bigbang"])
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
            attention_text({
                text = "^   ",
                scale = 1.2, 
                hold = 1,
                cover = G.HUD:get_UIE_by_ID('hand_mult').parent,
                cover_colour = G.C.BLACK,
                colour = SMODS.Gradients["busterb_bigbang"],
                align = 'cm',
                offset = { x = 0, y = 0.02}
              })
                play_sound('slib_emult')
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        delay(1.3)
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              blockable = false,
              blocking = false,
              delay = 1.2,
              func = function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                ease_colour(G.C.UI_MULT, G.C.RED, 1)
                return true
              end,
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
        { mult = 0, chips = 0, handname = '', level = '' })

end

function mysterypower(min,max)
    local SymbolsUNT = {
    "+",
    "X",
    "/",
    "<",
    ">",
    "#",
    "^",
    "!",
    "-",
    "%",
    "?",
    "||",
    "$",
    "*",
    ";",
    ":",
    "nil",
    "nan",
    "inf",
    "ERROR"
}
local CharacterUNT = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
}

        for i = 1, math.random(min,max) do
		G.hand:change_size(math.random(0.01,5))
        G.jokers:change_size(math.random(0.01,5))
        G.consumeables:change_size(math.random(0.01,5))
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + math.random(0.01,5)
        ease_hands_played(math.random(0.01,5))
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + math.random(0.01,5)
        ease_discard(math.random(0.01,5))
        SMODS.change_play_limit(math.random(0.01,5))
		SMODS.change_discard_limit(math.random(0.01,5))
        change_shop_size(math.random(0.01,5))
		SMODS.change_voucher_limit(math.random(0.01,5))
		SMODS.change_booster_limit(math.random(0.01,5))
		ease_ante(-math.random(0.01,5))
                        G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0,
						func = function()
							attention_text({
--								text = CharacterUNT[math.random(#CharacterUNT)]..SymbolsUNT[math.random(#SymbolsUNT)]..math.random(0.01,100)..CharacterUNT[math.random(#CharacterUNT)]..SymbolsUNT[math.random(#SymbolsUNT)]..math.random(0.01,100),
                                text = BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)]..BustB.charUNT[math.random(#BustB.charUNT)],
								scale = math.random(0.01,5),
                                hold = 1.5,
                                backdrop_colour = HEX("3f3f3f"),
								align = 'cm',
        						major = G.ROOM_ATTACH,
								offset = {x = math.random(-5,5), y = math.random(-5,5)}
							})
                            	attention_text({
                                text = "+"..math.random(1,100000).." Mult",
								scale = math.random(0.01,5),
                                hold = 1.5,
                                backdrop_colour = G.C.RED,
								align = 'cm',
        						major = G.ROOM_ATTACH,
								offset = {x = math.random(-5,5), y = math.random(-5,5)}
							})
                            	attention_text({
                                text = "+"..math.random(1,100000),
								scale = math.random(0.01,5),
                                hold = 1.5,
                                backdrop_colour = G.C.BLUE,
								align = 'cm',
        						major = G.ROOM_ATTACH,
								offset = {x = math.random(-5,5), y = math.random(-5,5)}
							})                            	
                            attention_text({
                                text = localize("slib_forcetrigger_ex"),
								scale = math.random(0.01,5),
                                hold = 1.5,
                                backdrop_colour = G.C.PURPLE,
								align = 'cm',
        						major = G.ROOM_ATTACH,
								offset = {x = math.random(-5,5), y = math.random(-5,5)}
							})
							play_sound('slib_forcetrigger')
							play_sound('chips1',math.random(0.6,1.2))
							play_sound('multhit1',math.random(0.6,1.2))
							play_sound('busterb_mystery',1, 0.5)
							G.ROOM.jiggle = G.ROOM.jiggle + 15
							return true
                        end
						}))   
                    end
end

--[[
            attention_text({
                text = "X$"..mod,
                scale = 1.2, 
                hold = 4,
                cover = G.HUD:get_UIE_by_ID('dollar_text_UI').parent,
                cover_colour = G.C.BLACK,
                colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                align = 'cm',
                offset = { x = 0, y = 0.02}
              })
                play_sound('coin6',.35)
                play_sound('coin7',.35)
                play_sound('slib_echips',.35)
]]
--[[
            attention_text({
                text = "^$"..mod,
                scale = 1.2, 
                hold = 4,
                cover = G.HUD:get_UIE_by_ID('dollar_text_UI').parent,
                cover_colour = G.C.BLACK,
                colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                align = 'cm',
                offset = { x = 0, y = 0.02}
              })
                play_sound('coin6',.65)
                play_sound('xchips',.65)
]]
--[[
            attention_text({
                text = "SCORE!!!",
                scale = 1, 
                hold = 4,
                cover = G.HUD:get_UIE_by_ID('chip_UI_count').parent,
                cover_colour = G.C.PURPLE,
                colour = G.C.WHITE,
                align = 'cm',
                offset = { x = 0, y = 0.02}
              })
                play_sound('coin6',.65)
                play_sound('xchips',.65)
]]

function p_anim( times, int, b_col, col, x, y, hold, sx, sy, dtime, area )
    for i = 1, times or 10 do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = dtime or 0.9,
            func = function()
                            attention_text({
                                text = int or "Mult",
								scale = math.random(sx or 0.01,sy or 5),
                                hold = hold or 1,
                                backdrop_colour = b_col or G.C.BLACK,
                                colour = col or G.C.WHITE,
								align = 'cm',
        						major = area or G.ROOM_ATTACH,
								offset = {x = x or 0, y = y or 0}
							})
                            return true
                        end
                    }))
                end
            end

--p_anim( times, int, b_col, col, x, y, hold, sx, sy, dtime, area )
