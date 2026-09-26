SMODS.Atlas {
    key = "djkr",
    path = "Dreamy.png",
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "saitama",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    attributes = { "bustb_d", "all_bb", "bustj", "passive" },
    config = {
        extra = {  
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_busterb_Fantasy", set = "Spectral"}
        return { vars = { } }
    end,

    calculate = function(self, card, context)
    if context.card_added then
        for _, joker in ipairs(G.jokers.cards) do
            SMODS.debuff_card(joker, "prevent_debuff", "j_busterb_saitama")
        end
    end
end,
add_to_deck = function(self, card, from_debuff)
    for _, joker in ipairs(G.jokers.cards) do
        SMODS.debuff_card(joker, "prevent_debuff", "j_busterb_saitama")
    end
end,
    remove_from_deck = function(self, card, from_debuff)
        for _, joker in ipairs(G.jokers.cards) do
            SMODS.debuff_card(joker, false, "j_busterb_saitama")
        end
    end,
}
SMODS.Joker {
    key = "alienx",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    config = {
        extra = {  
        },
        immutable = { ante = 2 }
    },
    attributes = { "bustb_d", "all_bb", "bustj", "prevents_death", "space", "hand_level" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.immutable.ante } }
    end,

    calculate = function(self, card, context)
        if context.forcetrigger then
            ease_d_ante(math.abs(card.ability.immutable.ante))
                    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
        delay(1.3)
        SMODS.upgrade_poker_hands({ instant = true })
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })

    end
        if context.end_of_round and context.game_over and context.main_eval then
            ease_d_ante(math.abs(card.ability.immutable.ante))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
        delay(1.3)
        SMODS.upgrade_poker_hands({ instant = true })
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = "Seconded!",
                    saved = 'Death Prevention Motion Carried!',
                    colour = G.C.UI.TEXT_DARK
                }
            end
        end
}

--thank you PinkFocalors.
--local nope = Card.set_debuff
--function Card:set_debuff(should_debuff)
--	if #SMODS.find_card('j_busterb_saitama') > 0 then
--		return false
--	elseif (((self.config or {}).center or {}).debuff_immune or (((self.config or {}).center or {}).rarity or 1) == 6) and should_debuff == true then
--		card_status_text(self, 'Immune', nil, 0.05*self.T.h, G.C.RED, nil, 0.6, nil, nil, 'bm', 'cancel', 1, 0.9)
--		return false
--	else
--		nope(self, should_debuff)
--	end
--end

SMODS.Joker{
    key = "ko",
    atlas = "djkr",
    pos = { x = 0, y = 1 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    rarity = "busterb_Dreamy",
    cost = 16,
    blueprint_compat = true, 
    demicolon_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    attributes = { "bustb_d", "all_bb", "hand_level", "hand_type" },
    config = {
        extra = { p_chips = 10, p_chips_inc = 20 },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.p_chips , card.ability.extra.p_chips_inc }}
    end,
    calculate = function(self, card, context)
        if context.using_consumeable then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "p_chips",
                scalar_value = "p_chips_inc",
                scaling_message = {
                message = "+" .. (card.ability.extra.p_chips + card.ability.extra.p_chips_inc).." Chips",
                colour = G.C.CHIPS
            }})
        end
        if (context.end_of_round and context.main_eval) or context.forcetrigger then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            local most_played = _handname
            SMODS.upgrade_poker_hands{
                hands = { most_played },
                level_up = false,
                parameters = { "chips" },
                func = function (base, hand, param)
                    return base + card.ability.extra.p_chips
                end
 
            }
        end
    end
}

SMODS.Joker {
    key = "peridot",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    attributes = { "bustb_d", "all_bb", "bustj", "passive", "value_manip", "gem" },
    config = {
        extra = { vm = 1.1, triggered = false }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.vm } }
    end,

    calculate = function(self, card, context)
        if context.starting_shop and not card.ability.extra.triggered then
     local booster = SMODS.add_booster_to_shop("p_busterb_s_pack_1")
	 booster.cost = 0
      card.ability.extra.triggered = true
    end
    if context.open_booster then
      card.ability.extra.triggered = false
    end
    if (context.skipping_booster and not context.blueprint) or context.forcetrigger then
        local left, right = card.area.cards[card.rank-1], card.area.cards[card.rank+1]
                if left and left.config.center.key ~= "j_busterb_peridot" then
					Spectrallib.manipulate(right, { value = card.ability.extra.vm })
                SMODS.calculate_effect({ message = "X" ..card.ability.extra.vm, colour = G.C.FILTER}, left)
				end 
                if right and right.config.center.key ~= "j_busterb_peridot" then
					Spectrallib.manipulate(right, { value = card.ability.extra.vm })
                SMODS.calculate_effect({ message = "X".. card.ability.extra.vm, colour = G.C.FILTER}, right)
				end
        end
    end
}
SMODS.Joker {
    key = "isaac",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    attributes = { "bustb_d", "all_bb", "bustj", "scaling", "generation" },
    config = { immutable = { roll_rounds = 0, total_rounds = 3, round_add = 1 } },
    loc_vars = function(self, info_queue, card)
        local rarity = (G.GAME.current_round.busterb_isaac_rarity or {}).rarity or 'busterb_Dreamy'
        return { vars = { card.ability.immutable.roll_rounds, card.ability.immutable.total_rounds, localize(rarity, "isaac_rarities"), colours = { HEX('b00b69'), HEX('5e7297') } } }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
                            G.E_MANAGER:add_event(Event{
                    trigger = 'after',
                        delay = 0.4,
                        func = function()
                            local c = SMODS.add_card({ set = "Joker", attributes = { "bustb_d" }, area = G.jokers, edition = 'e_negative', key_append = "busterb_isaac" })
--                            local c = SMODS.add_card({ set = "Joker", attributes = { "bustb_d" }, area = G.jokers, edition = 'e_negative', key_append = "busterb_isaac" })
                            SMODS.calculate_effect({ message = "Added!", colour = G.C.GRANDIOSE}, c)
                            return true
                        end
                    })

        end
        if context.end_of_round and context.main_eval then
            SMODS.scale_card(card, {
                ref_table = card.ability.immutable,
                ref_value = "roll_rounds",
                scalar_value = "round_add",
            })
        if (to_big(card.ability.immutable.roll_rounds) >= to_big(card.ability.immutable.total_rounds)) then
                G.E_MANAGER:add_event(Event{
                    trigger = 'after',
                        delay = 0.4,
                        func = function()
                            local c = SMODS.add_card({ set = "Joker", attributes = { "bustb_d" }, area = G.jokers, edition = 'e_negative', key_append = "busterb_isaac" })
--                            local c = SMODS.add_card({ set = "Joker", attributes = { "bustb_d" }, area = G.jokers, edition = 'e_negative', key_append = "busterb_isaac" })
                            SMODS.calculate_effect({ message = "Added!", colour = G.C.GRANDIOSE}, c)
                            return true
                        end
                    })
                card.ability.immutable.roll_rounds = 0
            SMODS.calculate_effect({ message = "Reset!", colour = G.C.FILTER}, card)
        end
    end
end
}
--[[]]
local function reset_busterb_isaac_rarity()
-- one for main use
G.GAME.current_round.busterb_isaac_rarity = G.GAME.current_round.busterb_isaac_rarity or { rarity = "busterb_Dreamy" }
    local raritytable = {}
    for k, v in ipairs({ "Common", "Uncommon", "Rare", "busterb_Dreamy", "Legendary", "busterb_Fantastic" }) do
        if v ~= G.GAME.current_round.busterb_isaac_rarity.rarity then raritytable[#raritytable+1] = v end
        end
    local jkr = pseudorandom_element(raritytable, "busterb_isaac".. G.GAME.round_resets.ante)
    G.GAME.current_round.busterb_isaac_rarity.rarity = jkr
-- one for display
G.GAME.current_round.busterb_isaac_rarity = G.GAME.current_round.busterb_isaac_rarity or { display = "Dreamy" }
    local display = {}
    for k, v in ipairs({ "Common", "Uncommon", "Rare", "Dreamy", "Legendary", "Fantastic" }) do
        if v ~= G.GAME.current_round.busterb_isaac_rarity.display then display[#display+1] = v end
        end
    local jkrd = pseudorandom_element(display, "busterb_isaac".. G.GAME.round_resets.ante)
G.GAME.current_round.busterb_isaac_rarity.display = jkrd
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_busterb_isaac_rarity()
end
--]]

SMODS.Joker{
    key = "harley",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    eternal_compat = true,
    pos = { x = 2, y = 1 },
    attributes = { "bustb_d", "all_bb", "bustj", "retrigger" },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
calculate = function(self, card, context)
		if
			context.retrigger_joker_check
			and not context.retrigger_joker
			and not (context.other_card.ability and context.other_card.ability.key == "j_busterb_harley")
		then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
		end
		if
			context.repetition
			and context.cardarea == G.play
		then
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = card,
			}
		end
	end,
}
SMODS.Sound{
    key = "pizzafacelaugh",
    path = "Pizzaface.ogg"
}
SMODS.Joker{
    key = "pizzaface",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    eternal_compat = true,
    pos = { x = 1, y = 1 },
    attributes = { "bustb_d", "all_bb", "bustj", "boss_blind", "destroy_card", "generation", "spectral" },
    config = { immutable = { boss_size = 1.25 } },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = "c_busterb_Fantasy", set = "Spectral"}
		return { vars = { center.ability.immutable.boss_size } }
	end,
    calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint and context.blind.boss and not card.getting_sliced and not context.retrigger_joker and not context.repetition then
			local eval = function(card)
				return not card.REMOVED and not G.RESET_JIGGLES
			end
			juice_card_until(card, eval, true)
			card.gone = false
			G.GAME.blind.chips = G.GAME.blind.chips ^ card.ability.immutable.boss_size
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.HUD_blind:recalculate()
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound("busterb_pizzafacelaugh")
							delay(0.4)
							return true
						end,
					}))
					SMODS.calculate_effect({message = "Good luck, Paisano!", colour = G.C.DARK_EDITION}, card)
					return true
				end,
			}))
		end
		if
			((context.end_of_round
			and not context.individual
			and not context.repetition
            and not context.retrigger_joker
			and not context.blueprint
			and G.GAME.blind.boss)
			or context.forcetrigger)
			and not card.gone
		then
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.0,
				func = function()
					SMODS.add_card{key = "c_busterb_Fantasy", edition = "e_negative"}
					return true
				end,
			}))
			if not SMODS.is_eternal(card) then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
			end
			card.gone = true
		end
	end,
}
SMODS.Sound{
    key = "dbzpowerup",
    path = "DBZPowerup.ogg"
}
SMODS.Joker{
    key = "vegeta",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 1 },
    attributes = { "bustb_d", "all_bb", "bustj", "asc","scaling", "hands" },
    config = { 
        extra = { 
            asc = 4,
            powerup = 1.5
        } 
    },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.asc, card.ability.extra.powerup } }
	end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "asc",
                operation = "X",
                scalar_value = "powerup",
                scaling_message = {
                message = "X" ..card.ability.extra.powerup,
                sound = "busterb_dbzpowerup", 
                colour = G.C.GOLD
            }
            })
        end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.asc > to_big(1) then
            SMODS.calculate_effect({ asc = card.ability.extra.asc}, card)
        end
    end
}
SMODS.Joker{
    key = "thanos",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 2 },
    attributes = { "bustb_d", "all_bb", "bustj", "infinity", "generation", "hands" },
    config = { 
        extra = { 
        } 
    },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.powerup, colours = {HEX('FFB570')} } }
	end,
    calculate = function(self, card, context)
        if (SMODS.last_hand_oneshot and context.after and context.main_eval and not context.blueprint) or context.forcetrigger then
        SMODS.add_card{set="Infinity"}
        SMODS.calculate_effect({message = "+1 Infinity Card", colour = HEX('FFB570')}, card)
        end
    end
}
SMODS.Joker{
    key = "lapis",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 1, y = 2 },
    attributes = { "bustb_d", "all_bb", "bustj", "xchips", "passive", "suit", "clubs", "seals", "enhancements", "editions", "gem" },
    config = { 
        extra = { 
            xchips = 2
        } 
    },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips } }
	end,
    calculate = function(self, card, context)
        if context.modify_scoring_hand and not context.blueprint then
                    if context.other_card:is_suit("Clubs") or
                    (context.other_card.edition and (context.other_card.edition.foil)) or
                    SMODS.has_enhancement(context.other_card, 'm_bonus') or
                    context.other_card:get_seal() == 'Blue' then
                        return {
                            add_to_hand = true,
                        }
                    end
                end

                if context.individual and context.cardarea == G.play then
                    if context.other_card:is_suit("Clubs") or
                    (context.other_card.edition and (context.other_card.edition.foil)) or
                    SMODS.has_enhancement(context.other_card, 'm_bonus') or
                    context.other_card:get_seal() == 'Blue' then
                        return({xchips = card.ability.extra.xchips})
                    end
                end
            end
        
}

local PinoTalk = {
    'Okay paisano, here is-a your order.',
    'Enjoy-a your pizza.',
    "Here, now move along! I have other things to do.",
    "Hope this pays-a my debts.",
    "Don't-a forget to leave a tip!",
}
local RarePino = {
    "You're a pretty lucky one, aren't you?",
    "Ooh, how do you know about-a this?",
    "You've won the lottery, paisano!",
    "This-a one is on the house!",
    "That blue guy is hiding something..."
}
SMODS.Joker {
    key = "peppino",
    unlocked = true, 
    atlas = "djkr",
    blueprint_compat = true, 
    demicolon_compat = true,
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
--    pino = true,
    rarity = "busterb_Dreamy",
    cost = 16,
    pos = { x = 2, y = 2 },
    attributes = { "bustb_d", "all_bb", "bustj", "generation", "pizza", "scaling", "xmult" },
    config = { extra = { xmult = 1, xmult_mod = .5 }, immutable = { odds = 25 } },
    loc_vars = function(self, info_queue, card)
        local pinorare, pinoodds = SMODS.get_probability_vars(card, 1, card.ability.immutable.odds, 'busterb_pinorare')
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, pinorare, pinoodds } }
    end,
    use = function(self, card, area, copier)
                    if SMODS.pseudorandom_probability(card, 'busterb_pinorare', 1, card.ability.immutable.odds, 'busterb_pinorare', true) then
                SMODS.add_card({ key = "c_busterb_special" })
                play_sound('busterb_jackpot')
                SMODS.calculate_effect{
                        message = RarePino[math.random(#RarePino)],
                        card = card
                    }
            else
            ease_dollars(-5)
            SMODS.add_card({ set = "Pizza", area = G.consumeables})
            play_sound('busterb_cashregister')
            SMODS.calculate_effect{
                    message = PinoTalk[math.random(#PinoTalk)],
                    card = card
                }
            end
    end,
        can_use = function(self, card)
        return (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) and ((G.GAME.dollars - G.GAME.bankrupt_at) >= 5)
        end,
    calculate = function(self, card, context)
        if context.pinobuy and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) and ((G.GAME.dollars - G.GAME.bankrupt_at) >= 5) then
            if SMODS.pseudorandom_probability(card, 'busterb_pinorare', 1, card.ability.immutable.odds, 'busterb_pinorare', true) then
                SMODS.add_card({ key = "c_busterb_special" })
                play_sound('busterb_jackpot')
                SMODS.calculate_effect{
                        message = RarePino[math.random(#RarePino)],
                        card = card
                    }
            else
            ease_dollars(-5)
            SMODS.add_card({ set = "Pizza", area = G.consumeables})
            play_sound('busterb_cashregister')
            SMODS.calculate_effect{
                    message = PinoTalk[math.random(#PinoTalk)],
                    card = card
                }
            end
        end
        if context.using_consumeable and context.consumeable.ability.set == "Pizza" then
        SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                scaling_message = {
                message = "X" .. (card.ability.extra.xmult + card.ability.extra.xmult_mod) .. " Mult",
                colour = G.C.MULT
            }})
        end
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end
}
SMODS.Joker{
    key = "noise",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 2 },
    attributes = { "bustb_d", "all_bb", "bustj", "passive","hands" },
    config = { 
        extra = { 
            hand = 1
        } 
    },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.powerup } }
	end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            ease_hands_played(card.ability.extra.hand)
        end
    end
}
SMODS.Joker{
    key = "bear5",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true, 
    demicolon_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 3 },
    config = { 
        extra = { 
            perma = 0.5,
            asc = 5,
            dollars = 25,
            scoring = 5

        } 
    },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    attributes = { "bustb_d", "all_bb", "bustj", "emult", "echips", "xscore", "modify_card", "economy", "rank", "five", "asc" },
    loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 5 then
            local bear5 = pseudorandom(pseudoseed("busterb_bear5"), 1, 5)
            if bear5 == 1 then
                return { dollars = card.ability.extra.dollars, sound = "busterb_maltigi" }
            end
            if bear5 == 2 then
                card:juice_up(10, 10)
                context.other_card.ability.slib_perma_e_mult = (context.other_card.ability.slib_perma_e_mult or 0) +
                card.ability.extra.perma
                play_sound("busterb_bear5",1,0.1)
            return {
                message = localize('k_upgrade_ex'),
                colour = SMODS.Gradients["busterb_eemultgradient"],
            }
            end
            if bear5 == 3 then
                card:juice_up(10, 10)
                context.other_card.ability.slib_perma_e_chips = (context.other_card.ability.slib_perma_e_chips or 0) +
                card.ability.extra.perma
                play_sound("busterb_bear5",1,0.1)
                return {
                message = localize('k_upgrade_ex'),
                colour = SMODS.Gradients["busterb_eechipsgradient"],
            }
            end
            if bear5 == 4 then
                return { asc = card.ability.extra.asc, sound = "busterb_maltigi" }
            end
            if bear5 == 5 then
                return { xscore = card.ability.extra.scoring, sound = "busterb_maltigi" }
            end
        end
    end
}

SMODS.Joker {
    key = "cesare",
    atlas = "djkr",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 1, y = 3 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true},
    attributes = { "bustb_d", "all_bb", "bustj", "prevents_death" },
    config = {
        extra = {  
        },
        immutable = { ante = -8 }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.immutable.ante } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
        if ((G.GAME.dollars - G.GAME.bankrupt_at) >= 5) then
            ease_dollars(-(G.GAME.dollars/2))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
                return {
                    message = "Nope!",
                    saved = 'Not just yet!',
                    colour = G.C.UI.TEXT_DARK
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'amazo',
    cost = 16,
    rarity = 'busterb_Dreamy',
    atlas = 'djkr',
    pos = { x = 2, y = 3 },
    blueprint_compat = true, 
    demicolon_compat = true,
    attributes = { "bustb_d", "all_bb", "bustj", "copying" },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true, ["all_bb_joker"] = true}, 
      loc_vars = function(self, info_queue, card)
    if card.area and card.area == G.jokers then
      local left_joker = nil
      local right_joker = nil
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
          left_joker = G.jokers.cards[i - 1]
          right_joker = G.jokers.cards[i + 1]
        end
      end
      local left_compatible = left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat
      local right_compatible = right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat

      local main_end = { {
        n = G.UIT.C,
        config = { align = "bm", minh = 0.4 },
        nodes = { {
          n = G.UIT.C,
          config = {
            ref_table = card,
            align = "m",
            colour = left_compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
            r = 0.05,
            padding = 0.06
          },
          nodes = { {
            n = G.UIT.T,
            config = {
              text = ' ' .. localize('k_' .. (left_compatible and 'compatible' or 'incompatible')) .. ' ',
              colour = G.C.UI.TEXT_LIGHT,
              scale = 0.32 * 0.8
            }
          } }
        }, {
          n = G.UIT.C,
          config = {
            ref_table = card,
            align = "m",
            colour = right_compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
            r = 0.05,
            padding = 0.06
          },
          nodes = { {
            n = G.UIT.T,
            config = {
              text = ' ' .. localize('k_' .. (right_compatible and 'compatible' or 'incompatible')) .. ' ',
              colour = G.C.UI.TEXT_LIGHT,
              scale = 0.32 * 0.8
            }
          } }
        } }
      } }

      return { main_end = main_end }
    end
  end,
    calculate = function(self, card, context)
        if not G.jokers then return nil end
        local right_effect, left_effect = nil, nil

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                local right_joker = G.jokers.cards[i + 1]
                local left_joker = G.jokers.cards[i - 1]

                if right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat then
                    right_effect = SMODS.blueprint_effect(card, right_joker, context)
                end

                if left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat then
                    left_effect = SMODS.blueprint_effect(card, left_joker, context)
                end

                break
            end
        end

        if right_effect or left_effect then
            local merged = SMODS.merge_effects(
                { right_effect or {} },
                { left_effect or {} }
            )

            return merged
        else
            return nil
        end
    end
}