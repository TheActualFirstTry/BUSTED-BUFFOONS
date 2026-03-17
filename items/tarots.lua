SMODS.Atlas {
    key = "conduct",
    path = "Conductor.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "inject",
    path = "Injector.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "mtr",
    path = "Matrix.png",
    px = 71,
    py = 95
}

SMODS.Consumable {
    key = 'conductor',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "conduct",
    config = { max_highlighted = 2, mod_conv = 'm_busterb_electric' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'injector',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "inject",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_crystallized' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'matrix',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "mtr",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_nanotech' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}