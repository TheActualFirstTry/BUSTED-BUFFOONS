SMODS.ObjectType{
    key = "Insanity",
    default = "j_busterb_apollyon",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
--SMODS.ObjectType{
--    key = "Ecstatic",
--    default = "j_busterb_herobrine",
--    cards = {},
--    inject = function(self)
--        SMODS.ObjectType.inject(self)
--    end,
--}
SMODS.Gradient{
    key = "insane",
    colours = {
        HEX('0093D3'),
        HEX('CC016B'),
        HEX('FFF10D'),
        HEX('000000'),
    },
    cycle = 2,
    interpolation = 'trig',
}
SMODS.Rarity {
    key = "Insanity",
    loc_txt = {
    name = "Insanity",
    },
    default_weight = 0.1,
    pools = { ["Insanity"] = true },
    badge_colour = SMODS.Gradients["busterb_insane"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
--SMODS.Rarity {
--    key = "Ecstatic",
--    loc_txt = {
--    name = "Ecstatic",
--    },
--    default_weight = 0.1,
--    pools = { ["Ecstatic"] = true },
--    badge_colour = HEX('00ffbf'),
--    get_weight = function(self, weight, object_type)
--        return weight
--    end,
--}