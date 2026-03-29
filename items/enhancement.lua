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
            return { remove = true }
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
		if (context.pre_discard and context.cardarea == G.hand and card.highlighted) then 
            if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
            return { remove = true }
        end
        end
	end,
}