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