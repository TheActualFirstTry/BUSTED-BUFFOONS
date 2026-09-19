SMODS.Rarity {
    key = "Fantastic",
    default_weight = 0.1,
    badge_colour = HEX('b00b69'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Secret",
    default_weight = 0,
    badge_colour = SMODS.Gradients["busterb_SecretG"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Grandiose",
    default_weight = 0,
    badge_colour = SMODS.Gradients["busterb_grand"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Dreamy",
    default_weight = 0.01,
    badge_colour = HEX('5e7297'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "technopotent",
    default_weight = 0,
    badge_colour = HEX('3F3F3F'),
    text_colour = SMODS.Gradients["busterb_technopotentgradient"],
    badge_shader = "busterb_gaia_badge",
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "Other",
    default_weight = 0,
    badge_colour = HEX('3f3f3f'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}