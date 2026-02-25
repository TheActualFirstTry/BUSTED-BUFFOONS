SMODS.ObjectType{
    key = "AWAKENED",
    default = "j_busterb_unik",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
SMODS.Gradient{
    key = "Unik",
    colours = {
        G.C.SUITS.Spades,
        G.C.PURPLE,
        G.C.WHITE,
        HEX('A8329D')
    },
    cycle = 1,
    interpolation = 'trig',
}
SMODS.Rarity {
    key = "AWAKENED",
    loc_txt = {
    name = "AWAKENED",
    },
    default_weight = 0,
    pools = { ["AWAKENED"] = true },
    badge_colour = SMODS.Gradients["busterb_Unik"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}