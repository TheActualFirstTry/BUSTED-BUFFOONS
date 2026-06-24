SMODS.Atlas {
    key = "s_packs",
    path = "bootpacks.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "a_boot",
    path = "boot.png",
    px = 71,
    py = 95
}


SMODS.Consumable{
	set = "Bootleg",
	key = "stable",
	pos = { x = 0, y = 0 },
	cost = 4,
	atlas = "a_boot",
    config = { immutable = { max_highlighted = 1} },
	can_use = function(self, card)
        local min = (G.PROFILES[G.SETTINGS.profile].cry_none and 0 or 1)
		local hand = Cryptid.get_highlighted_cards({ G.hand }, nil, min, G.hand.config.highlighted_limit)
		return #hand >= min and G.hand.config.card_limit > 0
	end,
	use = function(self, card, area, copier)
        local min = (G.PROFILES[G.SETTINGS.profile].cry_none and 0 or 1)
		local hand = Cryptid.get_highlighted_cards({ G.hand }, nil, min, G.hand.config.highlighted_limit)
		local hand_type
		if #hand >= min then
			hand_type = G.GAME.hands[G.FUNCS.get_poker_hand_info(hand)] or G.GAME.hands.cry_None
		end
		if hand_type then
                    SMODS.upgrade_poker_hands{
                        from = card,
                        parameters = { "chips", "mult"},
                        level_up = false,
                        hands = hand_type.key,
                        StatusText = "X"..(G.hand.config.card_limit*.25),
                        func = function (base, hand, param)
                            return (base*(G.hand.config.card_limit*.25))
                        end
                    }
                end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
SMODS.Consumable{
	set = "Bootleg",
	key = "switch",
	pos = { x = 1, y = 0 },
	cost = 4,
	atlas = "a_boot",
    config = { immutable = { max_highlighted = 1} },
	can_use = function(self, card)
		local min = (G.PROFILES[G.SETTINGS.profile].cry_none and 0 or 1)
		local hand = Cryptid.get_highlighted_cards({ G.hand }, nil, min, G.hand.config.highlighted_limit)
		return #hand >= min and G.hand.config.card_limit > 0
	end,
	use = function(self, card, area, copier)
		local min = (G.PROFILES[G.SETTINGS.profile].cry_none and 0 or 1)
		local hand = Cryptid.get_highlighted_cards({ G.hand }, nil, min, G.hand.config.highlighted_limit)
		local hand_type
		if #hand >= min then
			hand_type = G.GAME.hands[G.FUNCS.get_poker_hand_info(hand)] or G.GAME.hands.cry_None
		end
		if hand_type then
            local tempc = hand_type.chips
            local tempm = hand_type.mult

                        G.E_MANAGER:add_event(Event({
				func = function()
                    SMODS.upgrade_poker_hands({
                level_up = false,
				hands = hand_type.key,
				from = card,
				parameters = { "chips" },
				func = function(base, hand, param)
					return (base*0) + tempm
				end,
			})
					return true
				end,
			}))

			G.E_MANAGER:add_event(Event({
				func = function()
                    SMODS.upgrade_poker_hands({
                level_up = false,
				hands = hand_type.key,
				from = card,
				parameters = { "mult" },
				func = function(base, hand, param)
					return (base*0) + tempc
				end,
			})
					return true
				end,
			}))
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}

local upd = Game.update
function Game:update(dt)
    upd(self, dt)
    if G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.SHOP then
        if G.GAME.pending_mega_buffoon then
            local paused_for_tags = false
            for i = 1, #G.GAME.tags do
                if G.GAME.tags[i].config.type == "new_blind_choice" then
                    paused_for_tags = true
                    break
                end
            end
            if not paused_for_tags then
                local set = 'Tarot'
                local boosters = {}
                for _, v in pairs(G.P_CENTERS) do
                    if v.set == "Booster" then
                        boosters[#boosters + 1] = v
                    end
                end
                G.GAME.pending_mega_buffoon = nil
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.CONTROLLER.locks.forkboot = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local key = boosters[pseudorandom('busterb_forkboot', 1, #boosters)].key
                                local _card = Card(G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2, G.CARD_W * 1.27, G.CARD_H *
                                    1.27, G.P_CARDS.empty, G.P_CENTERS[key],
                                    { bypass_discovery_center = true, bypass_discovery_ui = true })
                                _card.cost = 0
                                _card.from_tag = true
                                G.FUNCS.use_card({ config = { ref_table = _card } })
                                _card:start_materialize()
                                G.CONTROLLER.locks.forkboot = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
        end
    end
end
SMODS.Consumable {
    key = 'forkboot',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 2, y = 0 },
    config = { select = 1 },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                G.GAME.pending_mega_buffoon = true
                return true
            end,
        }))
    end,
        can_use = function(self, card)
            return G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.SHOP
        end

}

SMODS.Consumable {
    key = 'pull',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 3, y = 0 },
    config = { select = 1 },
            can_use = function(self, card)
            local num = #Spectrallib.get_highlighted_cards({G.shop_jokers}, card, 1, card.ability.select)
        return (num > 0 and num <= card.ability.select) and ((#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or (#G.jokers.cards < G.jokers.config.card_limit))
        end,
    use = function(self, card2, area, copier)
                local cards = Spectrallib.get_highlighted_cards({G.shop_jokers}, card2, 1, card2.ability.select)
        for i, v in pairs(cards) do
            local card = cards[i]
            G.E_MANAGER:add_event(Event({
                func = function()
                    local copy = copy_card(card)
                    if card.ability.set == "Joker" then
                        if G.jokers.config.card_limit > #G.jokers.cards then
                        G.jokers:emplace(copy)
                        end
                    end
                        if card.ability.consumeable then
                            if G.consumeables.config.card_limit > #G.consumeables.cards then
                            G.consumeables:emplace(copy)
                            end
                        end
                    return true
                end
            }))
        end
    end,
}
SMODS.Consumable{
    key = 'reset',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 0, y = 1 },
    cost = 4,
use = function(self, card, area, copier)
     local used_card = copier or card
        if #G.jokers.highlighted == 1 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.jokers.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.jokers.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.jokers.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.jokers.highlighted[i]:set_edition(nil, true)
                        return true
                    end
                }))
            end
            for i = 1, #G.jokers.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        local total = 0
                    for k, v in pairs(SMODS.Sticker.obj_table) do
                        if G.jokers.highlighted[i].ability and G.jokers.highlighted[i].ability[k] then
                            G.jokers.highlighted[i]:remove_sticker(k)
                            total = total + 1
                        end
                end
                        return true
                    end
                }))
            end
            for i = 1, #G.jokers.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.jokers.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        return (#G.jokers.highlighted == 1)
    end,
}
SMODS.Sound{
    key = "token",
    path = "e_gilded.ogg"
}
SMODS.Consumable{
    key = 'comp',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 1, y = 1 },
    cost = 4,
    can_use = function(self,card)
        return true
    end,
    use = function(self, card, area, copier)
        local tag_pool = get_current_pool('Tag')
    local selected_tag = pseudorandom_element(tag_pool, 'busterb_comp')
    local it = 1
    while selected_tag == 'UNAVAILABLE' do
    it = it + 1
    selected_tag = pseudorandom_element(tag_pool, 'busterb_comp_resample'..it)
    end
    add_tag(Tag(selected_tag, false, 'Small'))
            play_sound("busterb_token")
    end
}
SMODS.Consumable{
    key = 'nil',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 2, y = 1 },
    cost = 4,
    config = { select = 1 },
    can_use = function(self,card)
        local num = #Spectrallib.get_highlighted_cards({G.jokers, G.consumeables, G.hand}, card, 1, card.ability.select)
        return num > 0 and num <= card.ability.select
    end,
    use = function(self, card, area, copier)
        local cards = Spectrallib.get_highlighted_cards({G.jokers, G.consumeables, G.hand}, card, 1, card.ability.select)
        for i, v in pairs(cards) do
            local card = cards[i]
            G.E_MANAGER:add_event(Event({
                func = function()
                    v.ability.busterb_nilcard = true
                    v:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                    return true
                end
            }))
        end
    end
}
SMODS.Consumable{
    key = 'print',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 3, y = 1 },
    cost = 4,
    config = { cards = 5, mod_conv = 'm_busterb_nanotech' },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            return { vars = { self.config.cards, self.config.mod_conv, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
    can_use = function(self,card)
        return G.GAME.blind.in_blind
    end,
    use = function(self, card, area, copier)
        for i = 1, self.config.cards do
            SMODS.add_card{set = "Playing Card", enhancement = self.config.mod_conv }
        end
    end
}

SMODS.Consumable{
    key = 'https',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 0, y = 2 },
    cost = 4,
    config = { cards = 5, mod_conv = 'm_busterb_nanotech' },
    can_use = function(self,card)
        return true
    end,
    use = function(self, card, area, copier)
        local freemoney = (2*(G.GAME.round * G.GAME.round_resets.ante))
        ease_dollars(freemoney)
        end
}


SMODS.Consumable{
    key = "pool",
    set = "Bootleg",
    atlas = "a_boot",
    pos = { x = 1, y = 2 },
    config = {
        select = 1
    },
    use = function(self, card, area, copier)
        G.GAME.poolbootleg = G.GAME.poolbootleg or {}
        for i, card in pairs(Spectrallib.get_highlighted_cards({G.jokers, G.consumeables}, card, 1, card.ability.select)) do
            G.GAME.poolbootleg[#G.GAME.poolbootleg+1] = card.config.center.key
            card:start_dissolve()
        end
        

    end,
    can_use = function(self, card)
        local cards = Spectrallib.get_highlighted_cards({G.jokers, G.consumeables}, card, 1, card.ability.select)
        return #cards > 0 and #cards <= card.ability.select
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

function create_bootlegs(area, seed)
        if G.GAME.poolbootleg and #G.GAME.poolbootleg > 0 then
        for i, v in pairs(G.GAME.poolbootleg) do
            local num = pseudorandom("boot_pool")
            if num <= 0.03 then
                local c = v
                return create_card(G.P_CENTERS[c].set, area or G.pack_cards, nil, nil, true, true, c)
            end
        end
    end

    return SMODS.create_card({
            set = "Bootleg",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "busterb_soulable_boot"
            })
end

SMODS.Consumable{
    key = "package",
    set = "Bootleg",
    atlas = "a_boot",
    pos = { x = 2, y = 2 },
    config = {
        amount = 1
    },
        use = function(self, card, area, copier)
            for i = 1, card.ability.amount do
            local card = SMODS.add_card{set = "Playing Card"}
            local edition = SMODS.poll_edition({guaranteed = true, key = "busterb_package"})
            local enhancement_type = pseudorandom_element({"Enhanced","Enhanced","Enhanced","Joker","Consumeables","Voucher","Booster"}, pseudoseed("package"))
            local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] or (enhancement_type == "Joker" and SMODS.Rarities[G.P_CENTERS[enhancement].rarity]
                and (
                    SMODS.Rarities[G.P_CENTERS[enhancement].rarity].get_weight
                    or (SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight and SMODS.Rarities[G.P_CENTERS[enhancement].rarity].default_weight > 0)
                )) do
                enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed("package")).key
            end
            local seal = SMODS.poll_seal{guaranteed = true, key = "package"}
            card:set_edition(edition)
            card:set_ability(G.P_CENTERS[enhancement])
            card:set_seal(seal)
        end
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.amount
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

SMODS.Consumable{
    key = 'flag',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 3, y = 2 },
    cost = 4,
    config = {
    extra = {
        max_highlighted = 1,
        repetitions = 1,
        minval = 110,
        maxval = 1000
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted, (card.ability.extra.minval/100), card.ability.extra.maxval/100 } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.jokers }, card, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
  use = function(self, card, area, copier)
		local cards = Spectrallib.get_highlighted_cards({ G.jokers }, card, 1, card.ability.extra.max_highlighted)
        local randomval = (pseudorandom(pseudoseed("busterb_randomval"), self.config.extra.minval, self.config.extra.maxval) / 100)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            Spectrallib.manipulate(highlighted, { value = randomval })
                            highlighted:juice_up(0.3, 0.3)
                            play_sound("tarot1")
                            return true
                        end
                    }))
                end
            end
        end
}

SMODS.Consumable {
    key = 'badge',
    set = 'Bootleg',
    atlas = "a_boot",
    pos = { x = 0, y = 3 },
    config = {
    extra = {
        max_highlighted = 5,
    }
  },
loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_highlighted } }
	end,
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.max_highlighted)
        return #selected > 0 and #selected <= card.ability.extra.max_highlighted
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:add_sticker('eternal',true)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}
SMODS.Consumable{
    key = "row",
    set = "Bootleg",
    atlas = "a_boot",
	pos = { x = 1, y = 3 },
	config = {},
	cost = 4,
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				return true
			end,
		}))
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound("card1", percent)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.cards do
			local card = G.hand.cards[i]
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					card:flip()
                    assert(SMODS.modify_rank(card, 1))
					play_sound("tarot2", percent)
					card:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
--SMODS.Suit.obj_buffer
SMODS.Consumable{
    key = "column",
    set = "Bootleg",
    atlas = "a_boot",
	pos = { x = 2, y = 3 },
	config = {},
	cost = 4,
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				return true
			end,
		}))
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound("card1", percent)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.cards do
			local card = G.hand.cards[i]
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					card:flip()
                    local function getSuits()
                        if suits then
                            return suits
                        end
                        suits = {}
                        for k, v in pairs(G.C.SUITS) do
                            table.insert(suits, k)
                        end
                        return suits
                    end
                for i, v in ipairs(getSuits()) do
                    if card.base.suit == v then
                        local _next = i - 1
                        if _next < 1 then
                            card:change_suit(suits[#suits])
                        else
                            card:change_suit(suits[_next])
                        end
                        break
                end
            end
					play_sound("tarot2", percent)
					card:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}

SMODS.Consumable{
    key = 'path',
    set = 'Bootleg',
    atlas = 'a_boot',
    pos = { x = 3, y = 3 },
    cost = 4,
    config = { ante = 1 },
        loc_vars = function(self, info_queue, card)
            return { vars = { self.config.ante } }
    end,
    can_use = function(self,card)
        return true
    end,
    use = function(self, card, area, copier)
        local ante = self.config.ante
        if G.GAME.round_resets.ante % 2 == 0 or G.GAME.round_resets.ante % -2 == 0 then
            ease_ante(-ante)
        else
            if G.GAME.round_resets.ante % 2 == 1 or G.GAME.round_resets.ante % -2 == -1 then
                ease_ante(ante)
            end
        end
    end
}

SMODS.Booster {
    key = 's_pack_1',
    atlas = 's_packs', 
    pos = { x = 0, y = 0 },
    pools = {["s_packs"] = true, ["booster"] = true},
    discovered = true,
    disable_shine = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('97f1cf'), 0.4), lighten(HEX("1ac282"), 0.2), lighten(HEX('0f734d'), 0.2) },
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
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("1ac282")} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Bootleg",

        ease_background_colour = function(self)
		ease_colour(HEX("f3f3f3"), HEX("1ac282"))
		ease_background_colour({ new_colour = HEX("1ac282"), special_colour = G.C.BLACK, contrast = 2 })
	end,

    create_card = function (self, card, i) 
        return create_bootlegs()
    end,
    in_pool = function() return true end
}

SMODS.Booster {
    key = 's_pack_2',
    atlas = 's_packs', 
    pos = { x = 1, y = 0 },
    pools = {["s_packs"] = true, ["booster"] = true},
    discovered = true,
    disable_shine = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('97f1cf'), 0.4), lighten(HEX("1ac282"), 0.2), lighten(HEX('0f734d'), 0.2) },
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
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("1ac282")} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Bootleg",

            ease_background_colour = function(self)
		ease_colour(HEX("f3f3f3"), HEX("1ac282"))
		ease_background_colour({ new_colour = HEX("1ac282"), special_colour = G.C.BLACK, contrast = 2 })
	end,

    create_card = function (self, card, i) 
        return create_bootlegs()
    end,
    in_pool = function() return true end
}

SMODS.Booster {
    key = 's_pack_j',
    atlas = 's_packs', 
    pos = { x = 2, y = 0 },
    pools = {["s_packs"] = true, ["booster"] = true},
    discovered = true,
    disable_shine = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('97f1cf'), 0.4), lighten(HEX("1ac282"), 0.2), lighten(HEX('0f734d'), 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    draw_hand = false,
    config = {
        extra = 5,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("1ac282")} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Bootleg",

            ease_background_colour = function(self)
		ease_colour(HEX("f3f3f3"), HEX("1ac282"))
		ease_background_colour({ new_colour = HEX("1ac282"), special_colour = G.C.BLACK, contrast = 2 })
	end,

    create_card = function (self, card, i) 
        return create_bootlegs()
    end,
    in_pool = function() return true end
}

SMODS.Booster {
    key = 's_pack_m',
    atlas = 's_packs', 
    pos = { x = 3, y = 0 },
    pools = {["s_packs"] = true, ["booster"] = true},
    discovered = true,
    disable_shine = true,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(HEX('97f1cf'), 0.4), lighten(HEX("1ac282"), 0.2), lighten(HEX('0f734d'), 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    draw_hand = false,
    config = {
        extra = 5,
        choose = 2, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("1ac282")} } }
    end,

    weight = 1,
    cost = 5,
    kind = "Bootleg",

            ease_background_colour = function(self)
		ease_colour(HEX("f3f3f3"), HEX("1ac282"))
		ease_background_colour({ new_colour = HEX("1ac282"), special_colour = G.C.BLACK, contrast = 2 })
	end,

        create_card = function (self, card, i) 
        return create_bootlegs()
    end,
    in_pool = function() return true end
}