SMODS.Rarity {
    key = "Fantastic",
    loc_txt = {
    name = "Fantastic",
    },
    default_weight = 0.1,
    pools = { ["Fantastic"] = true },
    badge_colour = HEX('b00b69'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
-- The ONLY Crossmod Joker ATM
SMODS.Rarity {
    key = "Ritualistic",
    loc_txt = {
    name = "Ritualistic",
    },
    default_weight = 0,
    pools = { ["Ritualistic"] = true },
    badge_colour = HEX('000000'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Grandiose",
    loc_txt = {
    name = "Grandiose",
    },
    default_weight = 0,
    pools = { ["Grandiose"] = true },
    badge_colour = 'gradients_grand',
    get_weight = function(self, weight, object_type)
        return weight
    end,
}