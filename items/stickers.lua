SMODS.Sticker {
    key = "omega",
    atlas = "non",
    badge_colour = G.C.GRANDIOSE,
    pos = { x = 0, y = 5 },
    rate = 0,
    config = { extra_slots_used = -1},
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
	if card.ability.busterb_fragile then card.ability.busterb_fragile = false end
	if card.ability.busterb_weak then card.ability.busterb_weak = false end
	if card.ability.busterb_perishable then card.ability.perishable = false end
	if card.ability.busterb_rental then card.ability.rental = false end
    if card.debuff then card:set_debuff(false) end
end
}
function Card:set_omega(_omega)
	self.ability.busterb_omega = _omega
	if self.ability.busterb_fragile then self.ability.busterb_fragile = false end
	if self.ability.busterb_weak then self.ability.busterb_weak = false end
	local total = 0
                            for k, v in pairs(SMODS.Sticker.obj_table) do
                                if --[[self.ability and]] self.ability[k] then
                                    self:remove_sticker(k)
                                    self:set_weak(false)
                                    self:set_fragile(false)
                                    total = total + 1
                                end
                            end
    if self.debuff then self:set_debuff(false) end
end

SMODS.Sticker {
    key = "electronic",
    atlas = "non",
    badge_colour = HEX'39ffb2',
    pos = { x = 4, y = 5 },
    rate = 0,
    config = { card_area = 0, card_limit = 1 },
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) and Spectrallib.card_is_forcetriggerable(card) then
            Spectrallib.forcetrigger { card = card }
        end
    end
}

function Card:set_electronic(_electronic)
	self.ability.busterb_electronic = _electronic
end


SMODS.Sticker {
    key = "faulty",
    atlas = "non",
    badge_colour = HEX'ffde74',
    pos = { x = 1, y = 5 },
    rate = 0,
    config = { repeatmin = 1, repeatmax = 3 },
    loc_vars = function(self, info_queue, card)
    local min = self.config.repeatmin
    local max = self.config.repeatmax
        return { vars = { min, max } }        
    end,
    calculate = function(self, card, context)
    local min = self.config.repeatmin
    local max = self.config.repeatmax
		if
			context.retrigger_joker_check
			and (context.other_card.ability and context.other_card.ability.key == card.key)
		then
				return {
					message = localize("k_again_ex"),
					repetitions = math.min(min,max),
					card = card,
				}
		end
		if
			context.repetition
			and context.other_card == card
		then
			return {
				message = localize("k_again_ex"),
				repetitions = math.min(min,max),
				card = card,
			}
		end
	end,
}

function Card:calculate_fragile()
	if not self.ability.frag then
		if self.ability.busterb_fragile and SMODS.pseudorandom_probability(self, "busterb_fragile", 1, 10, "Fragile Sticker") then
			self.ability.frag = true
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					self.T.r = -0.2
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							if self.area then
								self.area:remove_card(self)
							end
							self:remove()
							self = nil
							return true
						end,
					}))
					return true
				end,
			}))
			card_eval_status_text(self, "jokers", nil, nil, nil, { message = localize("k_busterb_dead_ex"), delay = 0.1 })
			return true
		elseif self.ability.busterb_fragile then
			card_eval_status_text(self, "jokers", nil, nil, nil, { message = localize("k_safe_ex"), delay = 0.1 })
			return false
		end
	end
	return false
end
function Card:set_fragile(_fragile)
	self.ability.busterb_fragile = _fragile
end

SMODS.Sticker({
	badge_colour = HEX("c0d9ff"),
	key = "fragile",
	atlas = "non",
	pos = { x = 3, y = 5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card, 1, 10, "Fragile Sticker") } }
	end,
--    default_compat = false,
--    compat_exceptions = { sets = { Joker = true } },
    should_apply = function(self, card, center, area, bypass_roll)
        return not card.eternal or not card.ability.busterb_omega == true
    end,
    apply = function(self, card, val)
    if card.debuff then card:set_debuff(false) end
    end,
	calculate = function(self, card, context)
    if card.debuff then card:set_debuff(false) end
		if
			context.end_of_round
			and context.main_eval
			and not context.repetition
		then
			card:calculate_fragile()
		end
	end,
})

--[[

			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							self:set_debuff(true)
							return true
						end,
					}))
					return true
				end,
			}))


]]

function Card:set_weak(_weak)
    self.ability.busterb_weak = _weak
end
SMODS.Sticker({
	badge_colour = HEX("ff97c9"),
	key = "weak",
	atlas = "non",
	pos = { x = 2, y = 5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card, 1, 2, "Weak Sticker") } }
	end,
--    default_compat = false,
--    compat_exceptions = { sets = { Joker = true } },
    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] then print("applied") Spectrallib.manipulate(card, { value = 0.5, type = "X" }) end 
		if not card.ability[self.key] then print("remove") Spectrallib.manipulate(card, { value = 2, type = "X" }) end
		end,
	calculate = function(self, card, context)
end
})