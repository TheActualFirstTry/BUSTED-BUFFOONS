SMODS.Enhancement {
    key = 'electric',
    atlas = "non",
    pos = { x = 0, y = 9 },
    demicolon_compat = true,
    config = { extra = { mult = 1, gain = .25 }, immutable = { retrigger_max = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring or context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "gain",
                scaling_message = {
                message = "+".. card.ability.extra.gain .." Mult",
                colour = G.C.MULT
            }
            })
            return {
                mult = card.ability.extra.mult
            }
        end
		if context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = 2,
				card = card,
			}
		end
	end,
}
SMODS.Enhancement {
    key = 'crystallized',
    atlas = "non",
    pos = { x = 1, y = 9 },
    demicolon_compat = true,
    config = { Xmult = 2.5, x_chips = 2.5, extra = { odds = 8 } },
    shatters = true,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_crystal')
        return { vars = { numerator, denominator, card.ability.x_chips, card.ability.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and
            SMODS.pseudorandom_probability(card, 'busterb_crystal', 1, card.ability.extra.odds) then
            card.glass_trigger = true -- SMODS addition
            SMODS.destroy_cards(card)
        end
    end,
}
SMODS.Enhancement {
    key = 'nanotech',
    atlas = "non",
    pos = { x = 2, y = 9 },
    config = { triggered = false },
    demicolon_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if (context.before and context.cardarea == G.play) or context.forcetrigger then
            if not card.ability.triggered then
            card.ability.triggered = true
            Spectrallib.add_bonus_effect(card, BustB.poll_nano_effect("BustB_effects"))
                    G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = localize("k_upgrade_ex"),
								scale = 1,
                                hold = 1.5,
                                backdrop_colour = G.C.BLACK,
								colour = G.C.DARK_EDITION,
								align = 'cm',
								major = card,
								offset = {x = 0, y = 0}
							})
							play_sound('busterb_cast',1, 0.5)
							card:juice_up(1, 0.2)
							return true
                        end
				}))   
        end
    end
end
}

SMODS.Enhancement {
    key = 'bloodmarked',
    atlas = "non",
    pos = { x = 3, y = 9 },
    demicolon_compat = true,
    config = { extra = { Emult = 1.5 } , immutable = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Emult } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring or context.forcetrigger then
            return { emult = card.ability.extra.Emult }
        end
		if (context.pre_discard and context.cardarea == G.hand and card.highlighted) then 
            SMODS.destroy_cards(card)
        end
	end,
}

SMODS.Enhancement {
    key = 'frost',
    atlas = "non",
    shatters = true,
    pos = { x = 4, y = 9 },
    config = { extra = { Echips = 1.5, unscore = 10, remaining = 10 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Echips, card.ability.extra.unscore, card.ability.extra.remaining } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring or context.forcetrigger then
        if context.cardarea == G.play then
            return { echips = card.ability.extra.Echips }
        else
		if context.cardarea == G.hand then
  if card.ability.extra.unscore < 1 then
    card.glass_trigger = true
    SMODS.destroy_cards(card)
  else
    card.ability.extra.unscore = card.ability.extra.unscore - 1
    return { message = card.ability.extra.unscore.."/"..card.ability.extra.remaining }
  end
end
end
end
end,
}

SMODS.Enhancement {
    key = 'glittery',
    atlas = "non",
    pos = { x = 5, y = 9 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { score = 50, chips = 20, mult = 5, asc = 2.5 },
    loc_vars = function(self, info_queue, card)
        local c = card.ability
        return { vars = { c.score,c.chips,c.mult,c.asc } }
    end,
    calculate = function(self, card, context)
    if context.cardarea == G.play and context.main_scoring or context.forcetrigger then
        local c = card.ability
        return { score = c.score, chips = c.chips, mult = c.mult, asc = c.asc }
     end
end
}

SMODS.Enhancement {
    key = 'solar',
    atlas = "non",
    pos = { x = 0, y = 8 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { asc = 2.5 },
    loc_vars = function(self, info_queue, card)
        local c = card.ability
        return { vars = { c.asc, c.asc/2 } }
    end,
    calculate = function(self, card, context)
            if context.main_scoring or context.forcetrigger then
                if context.cardarea == G.play then
                return { asc = self.config.asc/2 }
            end
            if context.cardarea == G.hand then
                return { asc = self.config.asc }
            end
        end
end
}

SMODS.Enhancement {
    key = 'nebular',
    atlas = "non",
    pos = { x = 1, y = 8 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { level = 2 },
    loc_vars = function(self, info_queue, card)
        local c = card.ability
        return { vars = { c.level } }
    end,
    calculate = function(self, card, context)
    local c = self.config
            if context.main_scoring or context.forcetrigger then
                if context.cardarea == G.play then
                    return {
                    chips = (G.GAME.hands[context.scoring_name].chips),
                    mult = (G.GAME.hands[context.scoring_name].mult),
                    }
                end
                if context.cardarea == G.hand then
                    return {
                    chips = (G.GAME.hands[context.scoring_name].chips*c.level),
                    mult = (G.GAME.hands[context.scoring_name].mult*c.level),
                    }
                end
            end
        end
}