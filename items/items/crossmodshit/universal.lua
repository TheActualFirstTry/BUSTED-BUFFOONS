SMODS.Gradient{
    key = "universalgradient",
    colours = {
        HEX("ED3BAF"),
        HEX("00E4FF")
    },
    cycle = 1,
    interpolation = 'linear',
}
SMODS.ObjectType{
    key = "Universal",
    default = "j_busterb_ralsei",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
SMODS.Rarity {
    key = "Universal",
    loc_txt = {
    name = "Universal",
    },
    default_weight = 0,
    pools = { ["Universal"] = true },
    badge_colour = SMODS.Gradients["busterb_universalgradient"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}