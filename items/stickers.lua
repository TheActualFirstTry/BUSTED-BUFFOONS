SMODS.Atlas{
    key = "omega",
    path = "omega.png",
    px = 71,
    py = 95
}

SMODS.Sticker {
    key = "omega",
    atlas = "omega",
    badge_colour = HEX '8a71e1',
    pos = { x = 0, y = 0 },
    rate = 0,
    config = { card_area = 0, card_limit = 1 },
    calculate = function(self, card, context)
        if card.debuff then card:set_debuff(false) end
    if context.check_eternal and context.other_card == card then
        return {no_destroy = {override_compat = true}}
    end
    if context.joker_type_destroyed and context.card == card then
        return {no_destroy = true}
    end
end,
draw = function(self, card, layer)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		G.shared_stickers["busterb_omega"].role.draw_major = card
		G.shared_stickers["busterb_omega"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
		G.shared_stickers["busterb_omega"]:draw_shader(
			"polychrome",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
		G.shared_stickers["busterb_omega"]:draw_shader(
			"voucher",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
	end,
apply = function(self, card, val)
    card.ability.busterb_omega = true
    if card.debuff then card:set_debuff(false) end
end
}
local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    if not self.ability.busterb_omega or self.bypass_selfdestruct or self.children.price then
        return start_dissolveref(self, ...)
    end
end