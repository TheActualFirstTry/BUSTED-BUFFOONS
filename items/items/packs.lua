SMODS.Atlas {
    key = "inf_pack1",
    path = "infpack1.png",
    px = 71,
    py = 95
}
SMODS.Booster {
    key = 'inf_pack_1',
    atlas = 'inf_pack1', 
    pos = { x = 0, y = 0 },
    pools = {["inf_packs"] = true, ["booster"] = true},
    discovered = true,
    loc_txt= {
        name = 'Infinity Pack',
        text = { "Pick {C:attention}#1#{} of",
                "{C:attention}#2#{} {B:1,C:white}Infinity{} cards", },
        group_name = "Infinity Pack",
    },
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('FFB570'), 0.4), lighten(HEX("3E2347"), 0.2), lighten(HEX('E36956'), 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX('E36956')} } }
    end,

    weight = 1,
    cost = 5,
    kind = "InfinityPack",


    create_card = function(self, card, i)
        ease_background_colour(HEX("272736"))
        return SMODS.create_card({
            set = "Infinity",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "busterb_soulable_inf"
            })
    end,
    in_pool = function() return true end
}