SMODS.ObjectType{
    key = "Ritualistic",
    default = "j_busterb_thrash",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
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