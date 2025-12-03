-- Jokers Pool
SMODS.ObjectType{
    key = "bustjokers",
    default = "j_busterb_spinel",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
-- Secret Jokers
SMODS.ObjectType{
    key = "bustjokers",
    default = "j_busterb_astro",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
-- Bootleg Cards
--SMODS.ConsumableType{
--    key = "Bootleg",
--    default = "c_busterb_offer",
--    cards = {},
--    collection_rows = { 4, 4 },
--    primary_colour = HEX('40FF83'),
--    secondary_colour = HEX('40FF83'),
--    shop_rate = 0.05
--}
SMODS.ObjectType{
    key = "Fantastic",
    default = "j_busterb_spinel",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
--    shop_rate = 0.000000000001
}
SMODS.ObjectType{
    key = "Grandiose",
    default = "j_busterb_igor",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
--    shop_rate = 0.000000000000000000001
}
SMODS.ObjectType{
    key = "Dreamy",
    default = "j_busterb_saitama",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
--    shop_rate = 0.1
}
--SMODS.ObjectType{
--    key = "Anti",
--    default = "j_busterb_thrash",
--    cards = {},
--    inject = function(self)
--        SMODS.ObjectType.inject(self)
--    end,
--}
