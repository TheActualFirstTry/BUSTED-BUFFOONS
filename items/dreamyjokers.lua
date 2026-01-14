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
    cost = 12,
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
    cost = 12,
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
    cost = 12,
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
            "when scoring cards, this joker",
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
    if context.joker_main then
        SMODS.calculate_effect({ mult = card.ability.extra.mult, chips = card.ability.extra.chips, xmult = card.ability.extra.xmult, xchips = card.ability.extra.xchips, dollars = card.ability.extra.money, colour = G.C.DARK_EDITION, instant = true}, card)
    end
  if context.scoring_hand and context.cardarea == G.play then
    local powincrease = pseudorandom(pseudoseed("busterb_ko"), 1, 5)
  card.ability.immutable.pow = card.ability.immutable.pow + powincrease
  SMODS.calculate_effect({ message = "+" ..powincrease.. "POW", colour = G.C.DARK_EDITION, instant = true}, card)
  if to_big(card.ability.immutable.pow) >= to_big(100) then
    card.ability.extra.mult = card.ability.extra.mult * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
    card.ability.extra.chips = card.ability.extra.chips * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
    card.ability.extra.xmult = card.ability.extra.xmult * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
    card.ability.extra.xchips = card.ability.extra.xchips * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
    card.ability.extra.money = card.ability.extra.money * to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease))
            SMODS.calculate_effect({ message = "X" ..to_number(math.min(card.ability.immutable.valueincreasecap, card.ability.extra.valueincrease)), colour = G.C.DARK_EDITION, instant = true}, card)
      card.ability.immutable.pow = card.ability.immutable.reset 
    SMODS.calculate_effect({ message = "POW Meter Reset!", colour = G.C.DARK_EDITION, instant = true}, card)
		end
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
    cost = 12,
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
                if G.jokers.cards[mypos + 1] then
					Cryptid.manipulate(G.jokers.cards[mypos+1], { value = card.ability.extra.vm })
                SMODS.calculate_effect({ message = "X" ..card.ability.extra.vm, colour = G.C.FILTER, instant = true}, card)
				end
				if G.jokers.cards[mypos - 1] then
					Cryptid.manipulate(G.jokers.cards[mypos-1], { value = card.ability.extra.vm })
                SMODS.calculate_effect({ message = "X".. card.ability.extra.vm, colour = G.C.FILTER, instant = true}, card)
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
    cost = 12,
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
--            SMODS.calculate_effect({ message = card.ability.immutable.roll_rounds .."/".. card.ability.immutable.total_rounds , colour = G.C.FILTER, instant = true}, card)
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
                SMODS.calculate_effect({ message = "1", colour = G.C.RARITY.Common, instant = true}, card)
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
                SMODS.calculate_effect({ message = "2", colour = G.C.RARITY.Uncommon, instant = true}, card)
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
                SMODS.calculate_effect({ message = "3", colour = G.C.RARITY.Rare, instant = true}, card)
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
                            SMODS.calculate_effect({ message = "4", colour = HEX('2735cf'), instant = true}, card)
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
                            SMODS.calculate_effect({ message = "5", colour = G.C.RARITY.Legendary, instant = true}, card)
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
                            SMODS.calculate_effect({ message = "6", colour = HEX('b00b69'), instant = true}, card)
                            SMODS.add_card({ set = "Fantastic", area = G.jokers, edition = 'e_negative', key_append = "busterb_isaac" })
                            return true
                        end
                    })
            end
            card.ability.immutable.roll_rounds = 0
            SMODS.calculate_effect({ message = "Reset!", colour = G.C.FILTER, instant = true}, card)
            end
        end
    end
}