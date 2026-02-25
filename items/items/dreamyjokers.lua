SMODS.Atlas {
    key = "opm",
    path = "Saitama.png",
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "saitama",
    atlas = "opm",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    config = {
        extra = {  
        }
    },
    loc_txt = {
        name = "Saitama",
        text = {
            "Prevents {s:1.5,C:spectral}Fantasy{} from {C:red}destroying jokers{},",
            "Also prevents jokers from being {C:red}debuffed{}."
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.money, card.ability.extra.xchips_mod, card.ability.extra.dollar_mod } }
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
SMODS.Atlas {
    key = "AX",
    path = "AlienX.png",
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "alienx",
    atlas = "AX",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    config = {
        extra = {  
        }
    },
    loc_txt = {
        name = "Alien X",
        text = {
            "Prevents death, {C:red}self destructs{}",
            "and sets ante to 0."
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.money, card.ability.extra.xchips_mod, card.ability.extra.dollar_mod } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
            ease_ante(-G.GAME.round_resets.ante)
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

SMODS.Atlas{
    key = "kaio",
    path = "ko.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "ko",
    atlas = "kaio",
    pos = { x = 0, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    rarity = "busterb_Dreamy",
    cost = 16,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra = { mult = 4, chips = 10, xmult = 2, xchips = 2.5, money = 3, valueincrease = 2 },
        immutable = { powincreasecap = 10, pow = 1, powcap = 100, valueincreasecap = 100, reset = 0 }
    },
    loc_txt = {
        name = "K.O.",
        text = {
            "{X:dark_edition,C:white}POW#5#Meter{} increases by a random amount", 
            "when playing hands, this joker",
            "gains {X:dark_edition,C:white}X#1#{}{C:attention} values{}",
            "when the {X:dark_edition,C:white}POW#5#Meter{}",
            "fills up completely and resets to #2#.",
            "{X:dark_edition,C:white}POW:#5##3#/100{}",
            "{C:mult}[Mult = #7#, {X:mult,C:white}X#9#{}{C:mult} ]",
            "{C:chips}[Chips = #8#, {X:chips,C:white}X#10#{}{C:chips} ]",
            "{C:gold}[Money = #11# ]"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
          math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease), 
          card.ability.immutable.reset, 
          card.ability.immutable.pow, 
          card.ability.immutable.powincreasecap, 
          " ",
          card.ability.immutable.powcap,
        card.ability.extra.mult, 
        card.ability.extra.chips, 
        card.ability.extra.xmult, 
        card.ability.extra.xchips, 
        card.ability.extra.money }}
    end,
calculate = function(self, card, context)
  if context.before then
    local powincrease = pseudorandom(pseudoseed("busterb_ko"), 1, 5)
  card.ability.immutable.pow = card.ability.immutable.pow + powincrease
  SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.DARK_EDITION}, card)
  if to_big(card.ability.immutable.pow) >= to_big(card.ability.immutable.valueincreasecap) then
    card.ability.extra.mult = card.ability.extra.mult * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
    card.ability.extra.chips = card.ability.extra.chips * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
    card.ability.extra.xmult = card.ability.extra.xmult * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
    card.ability.extra.xchips = card.ability.extra.xchips * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
    card.ability.extra.money = card.ability.extra.money * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
            SMODS.calculate_effect({ message = "X" ..to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease)), colour = G.C.DARK_EDITION}, card)
      card.ability.immutable.pow = card.ability.immutable.reset 
    SMODS.calculate_effect({ message = "POW Meter Reset!", colour = G.C.DARK_EDITION}, card)
		end
  end
  if context.joker_main then
        return({
            mult = lenient_bignum(card.ability.extra.mult), 
            chips = lenient_bignum(card.ability.extra.chips),
            xmult = lenient_bignum(card.ability.extra.xmult), 
            xchips = lenient_bignum(card.ability.extra.xchips), 
            dollars = lenient_bignum(card.ability.extra.money), 
        })
    end
end
}

SMODS.Atlas {
    key = "Peri",
    path = "Peridot.png",
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "peridot",
    atlas = "Peri",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    config = {
        extra = {  vm = 1.1
        }
    },
    loc_txt = {
        name = "Peridot",
        text = {
            "If played hand contains only {C:attention}Aces, 2s, 3s, 4s, {}or{C:attention} 5s{},",
            "adjacent joker values are multiplied by {C:attention}x#1#{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.vm } }
    end,

    calculate = function(self, card, context)
           local check = true
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			if context.scoring_hand then
				for k, v in ipairs(context.full_hand) do
					if
						v:get_id() == 6
						or v:get_id() == 7
						or v:get_id() == 8
						or v:get_id() == 9
						or v:get_id() == 10
						or v:get_id() == 11
						or v:get_id() == 12
						or v:get_id() == 13
					then
						check = false
					end
				end
			end
			if check then
                local mypos = nil
		        for i = 1, #G.jokers.cards do
			        if G.jokers.cards[i] == card then
				        mypos = i
			    	    break
		    	    end
		        end
                if G.jokers.cards[mypos - 1] then
					Cryptid.manipulate(G.jokers.cards[mypos-1], { value = card.ability.extra.vm })
                SMODS.calculate_effect({ message = "< X" ..card.ability.extra.vm, colour = G.C.FILTER}, card)
				end 
                if G.jokers.cards[mypos + 1] then
					Cryptid.manipulate(G.jokers.cards[mypos+1], { value = card.ability.extra.vm })
                SMODS.calculate_effect({ message = "X".. card.ability.extra.vm.. " >", colour = G.C.FILTER}, card)
				end
			end
		end
    end
}
SMODS.Atlas {
    key = "Isaac",
    path = "Isaac.png",
    px = 71,
    py = 95,
}
SMODS.Joker {
    key = "isaac",
    atlas = "Isaac",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    config = { immutable = { roll_rounds = 0, total_rounds = 3, round_add = 1 } },
    loc_txt = {
        name = "Isaac",
        text = {
            "After {C:attention}#2#{} rounds, this joker will",
            "{C:attention}spawn a random {C:dark_edition}negative {C:attention}joker",
            "based on what number lands",
            "{C:inactive}(Rounds: #1#/#2#)",            
            "{s:0.5,C:common}1 = Common {s:0.5,C:uncommon}2 = Uncommon {s:0.5,C:rare}3 = Rare",
            "{s:0.5,V:2}4 = Dreamy {s:0.5,C:legendary}5 = Legendary {s:0.5,V:1}6 = Fantastic",
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.immutable.roll_rounds, card.ability.immutable.total_rounds, colours = { HEX('b00b69'), HEX('2735cf') } } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
--            SMODS.calculate_effect({ message = card.ability.immutable.roll_rounds .."/".. card.ability.immutable.total_rounds , colour = G.C.FILTER}, card)
            SMODS.scale_card(card, {
                ref_table = card.ability.immutable,
                ref_value = "roll_rounds",
                scalar_value = "round_add",
--                message = card.ability.immutable.roll_rounds .."/".. card.ability.immutable.total_rounds,
--                colour = G.C.RED
            })
        if (to_big(card.ability.immutable.roll_rounds) >= to_big(card.ability.immutable.total_rounds)) then
            local randomjoker = pseudorandom(pseudoseed("busterb_isaac"), 1, 6)
            if randomjoker == 1 then
                G.E_MANAGER:add_event(Event{
                    trigger = 'after',
                        delay = 0.4,
                        func = function()
                SMODS.calculate_effect({ message = "1", colour = G.C.RARITY.Common}, card)
                SMODS.add_card({ set = "Joker", rarity = "Common", edition = 'e_negative', key_append = "busterb_isaac" })
                            return true
                        end
                    })
            end
            if randomjoker == 2 then
                G.E_MANAGER:add_event(Event{
                    trigger = 'after',
                        delay = 0.4,                    
                        func = function()
                SMODS.calculate_effect({ message = "2", colour = G.C.RARITY.Uncommon}, card)
                SMODS.add_card({ set = "Joker", rarity = "Uncommon", edition = 'e_negative', key_append = "busterb_isaac" })
                            return true
                        end
                    })
            end
            if randomjoker == 3 then
                G.E_MANAGER:add_event(Event{
                    trigger = 'after',
                        delay = 0.4,
                        func = function()
                SMODS.calculate_effect({ message = "3", colour = G.C.RARITY.Rare}, card)
                SMODS.add_card({ set = "Joker", rarity = "Rare", edition = 'e_negative', key_append = "busterb_isaac" })
                            return true
                        end
                    })
            end
            if randomjoker == 4 then
                G.E_MANAGER:add_event(Event{
                    trigger = 'after',
                        delay = 0.4,
                        func = function()
                            SMODS.calculate_effect({ message = "4", colour = HEX('2735cf')}, card)
                            SMODS.add_card({ set = "Dreamy", area = G.jokers, edition = 'e_negative', key_append = "busterb_isaac" })
                            return true
                        end
                    })
            end
            if randomjoker == 5 then
                G.E_MANAGER:add_event(Event{
                    trigger = 'after',
                        delay = 0.4,
                        func = function()
                            SMODS.calculate_effect({ message = "5", colour = G.C.RARITY.Legendary}, card)
                            SMODS.add_card({ set = "Joker", rarity = "Legendary", edition = 'e_negative', key_append = "busterb_isaac" })
                            return true
                        end
                    })
            end
            if randomjoker == 6 then
                G.E_MANAGER:add_event(Event{
                    trigger = 'after',
                        delay = 0.4,
                        func = function()
                            SMODS.calculate_effect({ message = "6", colour = HEX('b00b69')}, card)
                            SMODS.add_card({ set = "Fantastic", area = G.jokers, edition = 'e_negative', key_append = "busterb_isaac" })
                            return true
                        end
                    })
            end
            card.ability.immutable.roll_rounds = 0
            SMODS.calculate_effect({ message = "Reset!", colour = G.C.FILTER}, card)
            end
        end
    end
}
SMODS.Atlas{
    key = "hq",
    path = "Harley.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "harley",
    atlas = "hq",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    loc_txt = {
        name = "Harley Quinn",
        text = {
            "{C:attention}Retrigger{} all {C:attention}Jokers{}",
            "and {C:attention}playing cards{} once"
        }
    },
calculate = function(self, card, context)
		if
			context.retrigger_joker_check
			and not context.retrigger_joker
			and not (context.other_card.ability and context.other_card.ability.key == "harley")
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
SMODS.Atlas{
    key = "pizzaf",
    path = "pizzaface.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "pizzaface",
    atlas = "pizzaf",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    config = { immutable = { boss_size = 2 } },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.immutable.boss_size } }
	end,
    loc_txt = {
        name = "Pizzaface",
        text = {
            "{X:red,C:white}^#1#{} {C:attention}Boss Blind{} size",
            "When {C:attention}Boss Blind{} is beaten, create a ",
            "{C:dark_edition}negative {C:spectral}Fantasy{} card and {C:red}self-destruct"
        }
    },
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
			or context.force_trigger)
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
SMODS.Atlas{
    key = "avegeta",
    path = "Vegeta.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "vegeta",
    atlas = "avegeta",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    config = { 
        extra = { 
            mult = 2, 
            xmult = 2.5, 
            powerup = 1.5
        } 
    },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.powerup } }
	end,
    loc_txt = {
        name = "Vegeta",
        text = {
            "Gain {X:gold,C:white}X#3#{C:mult} Mult{} and {X:mult,C:white}XMult",
            "When playing your {C:attention}Final hand.{}",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} and {X:mult,C:white}X#2#{C:inactive})"
        }
    },
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 then
            card.ability.extra.mult = card.ability.extra.mult * card.ability.extra.powerup
            card.ability.extra.xmult = card.ability.extra.xmult * card.ability.extra.powerup
            SMODS.calculate_effect({ message = "X" ..card.ability.extra.powerup, sound = "busterb_dbzpowerup", colour = G.C.GOLD}, card)
        end
        if context.joker_main then
            SMODS.calculate_effect({ mult = card.ability.extra.mult, xmult = card.ability.extra.xmult}, card)
        end
    end
}
SMODS.Atlas{
    key = "athanos",
    path = "Thanos.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "thanos",
    atlas = "athanos",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    config = { 
        extra = { 
        } 
    },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.powerup, colours = {HEX('FFB570')} } }
	end,
    loc_txt = {
        name = "Thanos",
        text = {
            "If {C:attention}blind{} is {C:attention}beaten{} in {C:attention}one hand",
            "create 2 {V:1}Infinity{} cards"
        }
    },
    calculate = function(self, card, context)
        if context.after and SMODS.last_hand_oneshot then
        SMODS.add_card{set="Infinity"}
        SMODS.calculate_effect({message = "+1 Infinity Card", colour = HEX('FFB570')}, card)
        end
    end
}
SMODS.Atlas{
    key = "ll",
    path = "Lapis.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "lapis",
    atlas = "ll",
    rarity = "busterb_Dreamy",
    cost = 16,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    config = { 
        extra = { 
            xchips = 2
        } 
    },
    pools = { ["Dreamy"] = true, ["bustjokers"] = true },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips } }
	end,
    loc_txt = {
        name = "Lapis Lazuli",
        text = {
            "{C:blue}Blue Seal{}, {C:blue}Bonus{}, {C:blue}Foil{}, and{} {C:blue}Club{} Cards",
            "{C:attention}always score{} and give {C:white,X:chips}X#1#{} Chips"
        }
    },
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