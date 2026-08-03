SMODS.Atlas {
    key = "MayhemJoker",
    path = "MayhemJoker.png",
    px = 71,
    py = 95
}

SMODS.Rarity {
    key = "Emperor",
    default_weight = 0.1,
    pools = { ["Emperor"] = true },
    loc_txt = {
    name = "Emperor",
    },
    badge_colour = HEX('3F3F3F'),
    text_colour = SMODS.Gradients["busterb_epileptic"],
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.ObjectType{
    key = "mayhemjoker",
    default = "j_busterb_eggmay",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
    end,
}

SMODS.Joker{
    key = "eggmay",
    atlas = "MayhemJoker",
    rarity = "busterb_Emperor",
    pools = { ["mayhemjoker"] = true },
    cost = 1e308,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0, new = { x = 2, y = 0 } },
    config = {
        extra = {
            value = 4,
            uses = 1,
            use_gain = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.value, card.ability.extra.uses, card.ability.extra.use_gain } }
    end,
    loc_txt = {
        name = {"{C:busterb_epileptic,s:2}K R A L L{}",
                "Who are you"},
        text = {
            "{C:white,X:busterb_epileptic}^#1#{} values to",
            "all owned cards when used",
            "Gains {C:busterb_epileptic}+#3#{} use when",
            "a {C:busterb_gfreddy}Yotta card{} is used",
            "Creates a {C:busterb_gfreddy}Yotta card{}",
            "upon {C:attention}selecting blind",
            "{C:inactive}(Currently: {C:busterb_epileptic}#2#{C:inactive})"
        }
    },
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "yottacards" then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "uses",
                scalar_value = "use_gain",
                scaling_message = {
                message = "+"..card.ability.extra.use_gain,
                colour = HEX('3F3F3F'),
				text_colour = SMODS.Gradients["busterb_epileptic"],
            }})
        end
        if context.setting_blind and not context.blueprint then
            SMODS.add_card{set="yottacards", area=G.consumeables, edition = "e_negative"}
        end
    end,
    use = function(self, card, area, copier)
        for k, v in ipairs(G.jokers.cards) do
            if v.config.center_key ~= "j_busterb_eggmay" then
                Spectrallib.manipulate(v, { value = card.ability.extra.value, type = "^" })
            end
        end
        for k, v in ipairs(G.consumeables.cards) do
            Spectrallib.manipulate(v, { value = card.ability.extra.value, type = "^" })
        end
        for k, v in ipairs(G.hand.cards) do
            Spectrallib.manipulate(v, { value = card.ability.extra.value, type = "^" })
        end
        for k, v in ipairs(G.deck.cards) do
            Spectrallib.manipulate(v, { value = card.ability.extra.value, type = "^" })
        end
                        G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.5 + math.random() * 0.4,
						func = function()
							attention_text({
								text = "^",
								scale = 5,
                                hold = 1.5,
								backdrop_colour = HEX('3F3F3F'),
								colour = SMODS.Gradients["busterb_epileptic"],
								align = 'cm',
								major = card,
								pos = {x = 0, y = 0.15*G.CARD_H}
							})
							play_sound('busterb_lightning',1, 0.5)
							G.ROOM.jiggle = G.ROOM.jiggle + 35
							return true
                        end
		    }))
        delay(0.1)         
    end,
    can_use = function(self, card)
        return true
    end,
}