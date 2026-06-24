SMODS.Atlas {
    key = "elec",
    path = "Electric.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "crystal",
    path = "Crystallized.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "nano",
    path = "Nanotech.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "blood",
    path = "Bloodmarked.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "ice",
    path = "Frost.png",
    px = 71,
    py = 95
}

SMODS.Enhancement {
    key = 'electric',
    atlas = "elec",
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 1, gain = .25 }, immutable = { retrigger_max = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
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
    atlas = "crystal",
    pos = { x = 0, y = 0 },
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
    atlas = "nano",
    pos = { x = 0, y = 0 },
    config = { h_x_chips = 2.5, x_chips = 1.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_chips, card.ability.x_chips } }
    end,
}

SMODS.Enhancement {
    key = 'electric',
    atlas = "elec",
    pos = { x = 0, y = 0 },
    config = { retrigger = 1, immutable = { retrigger_max = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
		if context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = card,
			}
		end
	end,
}

SMODS.Enhancement {
    key = 'bloodmarked',
    atlas = "blood",
    pos = { x = 0, y = 0 },
    config = { extra = { Emult = 1.5 } , immutable = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Emult } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return { emult = card.ability.extra.Emult }
        end
		if (context.pre_discard and context.cardarea == G.hand and card.highlighted) then 
            SMODS.destroy_cards(card)
        end
	end,
}

SMODS.Enhancement {
    key = 'frost',
    atlas = "ice",
    shatters = true,
    pos = { x = 0, y = 0 },
    config = { extra = { Echips = 1.5, unscore = 10, remaining = 10 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Echips, card.ability.extra.unscore, card.ability.extra.remaining } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring then
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