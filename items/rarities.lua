SMODS.Rarity {
    key = "Fantastic",
    default_weight = 0.1,
    pools = { ["Fantastic"] = true },
    badge_colour = HEX('b00b69'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Secret",
    default_weight = 0,
    pools = { ["Secret"] = true },
    badge_colour = SMODS.Gradients["busterb_SecretG"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Grandiose",
    default_weight = 0,
    pools = { ["Grandiose"] = true },
    badge_colour = SMODS.Gradients["busterb_grand"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Dreamy",
    default_weight = 0.01,
    pools = { ["Dreamy"] = true },
    badge_colour = HEX('5e7297'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Other",
    default_weight = 0,
    pools = { ["Other"] = true },
    badge_colour = HEX('000000'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}