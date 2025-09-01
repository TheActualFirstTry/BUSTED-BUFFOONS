-- Jokers Pool
SMODS.ObjectType{
    key = "bustjokers",
    default = "j_busterb_spinel",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
-- Mechanical Cards
SMODS.ConsumableType{
    key = "mechanical",
    default = "c_busterb_offer",
    cards = {},
    collection_rows = { 4, 4 },
    primary_colour = HEX('40FF83'),
    secondary_colour = HEX('40FF83'),
    shop_rate = 0.05
}
SMODS.ObjectType{
    key = "Fantastic",
    default = "j_busterb_spinel",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
SMODS.ObjectType{
    key = "Grandiose",
    default = "j_busterb_asriel",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
--SMODS.ObjectType{
--    key = "Ritualistic",
--    default = "j_busterb_thrash",
--    cards = {},
--    inject = function(self)
--        SMODS.ObjectType.inject(self)
--    end,
--}
--SMODS.ObjectType{
--    key = "Anti",
--    default = "j_busterb_thrash",
--    cards = {},
--    inject = function(self)
--        SMODS.ObjectType.inject(self)
--    end,
--}
