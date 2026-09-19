SMODS.Consumable {
    key = 'conductor',
    set = 'Tarot',
    pos = { x = 0, y = 0 },
    atlas = "non",
    config = { max_highlighted = 3, mod_conv = 'm_busterb_electric' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'injector',
    set = 'Tarot',
    pos = { x = 1, y = 0 },
    atlas = "non",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_crystallized' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'matrix',
    set = 'Tarot',
    pos = { x = 2, y = 0 },
    atlas = "non",
    config = { max_highlighted = 2, mod_conv = 'm_busterb_nanotech' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }	end,
}
    SMODS.Consumable {
    key = 'marksman',
    set = 'Tarot',
    pos = { x = 4, y = 0 },
    atlas = "non",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_bloodmarked' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'blizzard',
    set = 'Tarot',
    pos = { x = 3, y = 0 },
    atlas = "non",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_frost' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'unicorn',
    set = 'Tarot',
    pos = { x = 5, y = 0 },
    atlas = "non",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_glittery' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'splendor',
    set = 'Tarot',
    pos = { x = 6, y = 0 },
    atlas = "non",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_solar' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
    SMODS.Consumable {
    key = 'interloper',
    set = 'Tarot',
    pos = { x = 7, y = 0 },
    atlas = "non",
    config = { max_highlighted = 1, mod_conv = 'm_busterb_nebular' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}