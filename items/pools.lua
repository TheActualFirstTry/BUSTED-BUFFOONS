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
    key = "Secret",
    default = "j_busterb_astro",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
SMODS.Atlas {
    key = "atlas_undiscovered_inf",
    path = "UndiscoveredInf.png",
    px = 71,
    py = 95
}
SMODS.UndiscoveredSprite {
    key = "Infinity",
    atlas = "atlas_undiscovered_inf",
    pos = {
        x = 0,
        y = 0
    }
}
SMODS.ConsumableType{
    key = "Infinity",
    loc_txt = {
        collection = 'Infinity Cards', 
        name = 'Infinity',
        undiscovered = {
            name = '???',
            text = {
                'Just find it idk',
            } 
        }
    },
    default = "c_busterb_marshall",
    cards = {},
    collection_rows = { 4, 4 },
    primary_colour = HEX('E36956'),
    secondary_colour = HEX('FFB570'),
    shop_rate = 0.05,
    select_card = 'consumeables'
}
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
SMODS.ObjectType{
    key = "inf_packs",
    default = "inf_pack_1",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}
--SMODS.ObjectType{
--    key = "Anti",
--    default = "j_busterb_thrash",
--    cards = {},
--    inject = function(self)
--        SMODS.ObjectType.inject(self)
--    end,
--}
