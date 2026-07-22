SMODS.Enhancement {
    key = 'electric',
    atlas = "non",
    pos = { x = 0, y = 9 },
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
    atlas = "non",
    pos = { x = 1, y = 9 },
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
    config = { chips = 1, mult = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_chips, card.ability.x_chips } }
    end,
    calculate = function(self, card, context)
        if (context.pre_discard and context.cardarea == G.hand and card.highlighted) then
            local nano = pseudorandom(pseudoseed("busterb_nano"), 1, 5)
            if nano == 1 then
            for i = 1, 1 do
            local card = SMODS.add_card{set = "Playing Card"}
            local edition = SMODS.poll_edition({guaranteed = true, key = "busterb_package"})
            local enhancement_type = pseudorandom_element({"Enhanced","Enhanced","Enhanced","Joker","Consumeables","Voucher","Booster"}, pseudoseed("package"))
            local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] or (enhancement_type == "Joker" and SMODS.Rarities[G.P_CENTERS[enhancement].rarity]
                and (
                    SMODS.Rarities[G.P_CENTERS[enhancement].rarity].get_weight
                    or (SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight and SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight > 0)
                )) do
                enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            end
            local seal = SMODS.poll_seal{guaranteed = true, key = "package"}
            card:set_edition(edition)
            card:set_ability(G.P_CENTERS[enhancement])
            card:set_seal(seal)
        end
        end
        if nano == 2 then
            SMODS.add_card{set="Joker",area=G.jokers}
        end 
        if nano == 3 then
            SMODS.add_card{set="Consumeables",area=G.consumeables}
        end
        if nano == 4 then
            SMODS.add_card({set="Booster",area=G.consumeables})
        end
        if nano == 5 then
            SMODS.add_card{set="Voucher",area=G.consumeables}
        end
            SMODS.destroy_cards(card)
        end
    end
}

SMODS.Enhancement {
    key = 'bloodmarked',
    atlas = "non",
    pos = { x = 3, y = 9 },
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
    atlas = "non",
    shatters = true,
    pos = { x = 4, y = 9 },
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
    if context.cardarea == G.play and context.main_scoring then
        local c = card.ability
        return { score = c.score, chips = c.chips, mult = c.mult, asc = c.asc }
     end
end
}