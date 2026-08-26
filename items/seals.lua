SMODS.Seal {
key = 'butterfly',
pos = { x = 5, y = 6 },
atlas = 'non',
config = { },
badge_colour = SMODS.Gradients['busterb_balatro'],
loc_vars = function(self, info_queue, card)
return { vars = {  } }
end,
calculate = function(self, card, context)
            if context.final_scoring_step or context.forcetrigger then
                return { balance = true }
            end
end,
}
SMODS.Seal {
key = 'periwinkle',
pos = { x = 1, y = 6 },
atlas = 'non',
config = { },
badge_colour = G.C.SECONDARY_SET.Spectral,
loc_vars = function(self, info_queue, card)
return { vars = {  } }
end,
calculate = function(self, card, context)
if (context.main_scoring and (context.cardarea == G.play or context.cardarea == G.hand)) or context.forcetrigger then
    if SMODS.last_hand_oneshot then
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                SMODS.add_card{set="Spectral"}
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return { message = "+1 Spectral", colour = G.C.SECONDARY_SET.Spectral }
        end
    end
end
end,
}

SMODS.Seal {
key = 'sun',
pos = { x = 0, y = 6 },
atlas = 'non',
badge_colour = SMODS.Gradients['busterb_GoldenFreddyGradient'],
config = { extra = { asc = 0.25 } },
loc_vars = function(self, info_queue, card)
return { vars = { self.config.extra.asc } }
end,
    calculate = function (self, card, context)
            if (context.before) or context.forcetrigger then
                    local c = self.config.extra
                        SMODS.upgrade_poker_hands{
                        from = card,
                        hands = context.scoring_name,
                        ascension_power = c.asc
                    }
            end
        end
}

SMODS.Seal {
key = 'lime',
pos = { x = 2, y = 6 },
atlas = 'non',
badge_colour = SMODS.Gradients['busterb_technopotentgradient'],
config = { asc = 1 },
loc_vars = function(self, info_queue, card)
return { vars = {  } }
end,
    calculate = function (self, card, context)
        if context.cardarea == G.hand and context.main_scoring or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Bootleg' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
end
}

SMODS.Seal {
key = 'burgundy',
pos = { x = 3, y = 6 },
atlas = 'non',
badge_colour = G.C.INFINITY,
config = { },
loc_vars = function(self, info_queue, card)
return { vars = {  } }
end,
    calculate = function (self, card, context)
            if (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit <= #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Infinity' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
end
}
SMODS.Seal {
key = 'pizza_seal',
pos = { x = 4, y = 6 },
atlas = 'non',
badge_colour = G.C.PIZZA,
config = { },
loc_vars = function(self, info_queue, card)
return { vars = {  } }
end,
    calculate = function (self, card, context)
            if (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Pizza' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
    end
}
SMODS.Seal {
key = 'galaxy',
pos = { x = 6, y = 6 },
badge_colour = G.C.SECONDARY_SET.Planet,
atlas = 'non',
config = { level = .5 },
loc_vars = function(self, info_queue, card)
return { vars = { self.config.level*100 } }
end,
    calculate = function (self, card, context)
    if (context.before) or context.forcetrigger then
                local c = self.config
                SMODS.upgrade_poker_hands{
                from = card,
                hands = context.scoring_name,
                level_up = c.level,
            }
        end
    end
}

SMODS.Seal {
key = 'gateway',
pos = { x = 7, y = 6 },
badge_colour = G.C.DARK_EDITION,
atlas = 'non',
config = { extra = { scoring = 1, gain = 0.25 } },
loc_vars = function(self, info_queue, card)
return { vars = { self.config.extra.scoring, self.config.extra.gain } }
end,
    calculate = function (self, card, context)
        if context.before then
            if context.cardarea == G.play then
                SMODS.scale_card(card, {
                ref_table = self.config.extra,
                ref_value = "scoring",
                scalar_value = "gain",
                scaling_message = {
                message = "^".. self.config.extra.scoring + self.config.extra.gain .." Mult",
                colour = SMODS.Gradients["busterb_eemultgradient"]
            }
            })
        end
    end
    if context.main_scoring or context.forcetrigger then
        if context.cardarea == G.play then
        return {
            emult = self.config.extra.scoring
            }
        end
    end
end
}