--Epileptic color for Grandiose
--SMODS.Gradient{
--    key = "Epileptic",
--    colours = {
--        HEX('FF0000'),
--        HEX('FF7F00'),
--        HEX('FFFF00'),
--        HEX('00FF00'),
--        HEX('00FFFF'),
--        HEX('0000FF'),
--        HEX('8B00FF'),
--        HEX('FF00FF')
--    },
--    cycle = 0.1,
--    interpolation = 'trig',
--}
SMODS.Gradient{
    key = "grand",
    colours = {
        G.C.SECONDARY_SET.Spectral,
        G.C.PURPLE,
        G.C.SECONDARY_SET.Tarot,
        G.C.RED,
        G.C.FILTER,
        G.C.GOLD,
        G.C.GREEN,
        G.C.SECONDARY_SET.Planet,
        G.C.CHIPS
    },
    cycle = 2,
    interpolation = 'trig',
}
SMODS.Gradient{
    key = "Secret",
    colours = {
        G.C.SUITS.Spades,
        G.C.PURPLE,
        G.C.RARITY.Legendary,
        G.C.TAROT
    },
    cycle = 1,
    interpolation = 'trig',
}