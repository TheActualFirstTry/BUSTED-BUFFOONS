--        local card = SMODS.create_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.shop_jokers }
--        create_shop_card_ui(card, "Joker", G.shop_jokers)
--        card:set_cost()

SMODS.Atlas{
    key = "vouch",
    path = "voucher.png",
    px = 71,
    py = 95
}

SMODS.Voucher {
    key = "indus",
    atlas = "vouch",
    pos = { x = 0, y = 0 },
    config = { extra = { shop_slots = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { " ", lenient_bignum(card.ability.extra.shop_slots), colours = {SMODS.Gradients["busterb_epileptic"]} } }
    end,
    
    redeem = function(self, card)
                  if G.STATE == G.STATES.SHOP then
local rarity_map = {
  busterb_Grandiose = 'busterb_Dreamy',
  busterb_Secret = 'busterb_Fantastic',
  busterb_technopotent = "busterb_Fantastic",
  Common = 'Rare',
  Uncommon = 'Rare',
  cry_cursed = 'cry_exotic',
  crp_abysmal = 'crp_mythic',
  unik_detrimental = 'unik_ancient',
  valk_supercursed = 'valk_exquisite',
  jen_junk = 'Rare',
  jen_omegatranscendent = 'cry_exotic',
  jen_omnipotent = 'cry_exotic',
  jen_transcendent = 'cry_exotic',
  jen_ritualistic = 'cry_exotic',
  jen_miscellaneous = 'Rare',
  bos_transcendent = 'bos_exotic',
  bos_miscellaneous = 'Rare',
  gj_detri = "gj_uniq",
  ocstobal_challengeexclusive = "ocstobal_omega",
  ocstobal_absolute_curse = "ocstobal_beyondexotic",
  ocstobal_cursed = "ocstobal_unique"
}
local _, key = pseudorandom_element(SMODS.Rarities, "cogito")
   key = rarity_map[key] or key
       if context.create_shop_card then
            card:juice_up(0.3, 0.5)
                return {
                    shop_create_flags = {
                        set = "Joker",
                        rarity = key,
                        edition = "e_negative",
                        }
                    }
                end
            end
        end,
    calculate = function(self, card, context)
        if (context.reroll_shop or context.starting_shop) then
            local rarity_map = {
  busterb_Grandiose = 'busterb_Dreamy',
  busterb_Secret = 'busterb_Fantastic',
  Common = 'Rare',
  Uncommon = 'Rare',
  cry_cursed = 'cry_exotic',
  crp_abysmal = 'crp_mythic',
  unik_detrimental = 'unik_ancient',
  valk_supercursed = 'valk_exquisite',
  jen_junk = 'Rare',
  jen_omegatranscendent = 'cry_exotic',
  jen_omnipotent = 'cry_exotic',
  jen_transcendent = 'cry_exotic',
  jen_wondrous = 'cry_exotic',
  jen_ritualistic = 'cry_exotic',
  jen_miscellaneous = 'Rare'
}
local _, key = pseudorandom_element(SMODS.Rarities, "cogito")
           key = rarity_map[key] or key
        local c = SMODS.create_card { set = "Joker", rarity = key, edition = 'e_negative' }
        G.shop_jokers:emplace(c)
        create_shop_card_ui(c, "Joker", G.shop_jokers)
        card:set_cost()
        end
    end,
 }

SMODS.Voucher {
    key = "top",
    atlas = "vouch",
    pos = { x = 0, y = 1 },
    config = { extra = { shop_slots = 1 } },
    requires = { "v_busterb_indus" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue+1] = {set="Other", key = "busterb_omega"}
        return { vars = { " ", lenient_bignum(card.ability.extra.shop_slots), colours = {SMODS.Gradients["busterb_epileptic"]} } }
    end,
    
    redeem = function(self, card)
                  if G.STATE == G.STATES.SHOP then
        local c = SMODS.create_card { set = "Joker", rarity = "busterb_Grandiose", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
        G.shop_jokers:emplace(c)
        create_shop_card_ui(c, "Joker", G.shop_jokers)
        card:set_cost()
        local c = SMODS.create_card { set = "Joker", rarity = "busterb_Secret", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
        G.shop_jokers:emplace(c)
        create_shop_card_ui(c, "Joker", G.shop_jokers)
        card:set_cost()
                  end
    end,
    calculate = function(self, card, context)
if (context.reroll_shop or context.starting_shop) then
        local c = SMODS.create_card { set = "Joker", rarity = "busterb_Grandiose", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
        G.shop_jokers:emplace(c)
        create_shop_card_ui(c, "Joker", G.shop_jokers)
        card:set_cost()
        local c = SMODS.create_card { set = "Joker", rarity = "busterb_Secret", edition = 'e_negative', stickers = {'busterb_omega'}, force_stickers = true }
        G.shop_jokers:emplace(c)
        create_shop_card_ui(c, "Joker", G.shop_jokers)
        card:set_cost()
                  end

    end,
}

SMODS.Voucher {
    key = "stargazer",
    atlas = "vouch",
    pos = { x = 1, y = 0 },
    config = { extra = { asc = 1, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local chance, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_stargazer')
        return {
            vars = {
                card.ability.extra.asc,
                chance,
                odds
            }
        }
    end,
    calculate = function (self, card, context)
    if context.poker_hand_changed then
        if SMODS.pseudorandom_probability(card, 'busterb_stargazer', 1, card.ability.extra.odds, 'busterb_stargazer') then
--                    Spectrallib.l_asc{context.scoring_name,card,card.ability.extra.asc}
--[[]]
                    SMODS.upgrade_poker_hands{
                        from = card,
                        hands = context.scoring_name,
                        ascension_power = card.ability.extra.asc or 1
                    }
--]]
                end
            end
        end
}

SMODS.Voucher {
    key = "forever",
    atlas = "vouch",
    pos = { x = 1, y = 1 },
    requires = { "v_busterb_stargazer" },
    config = { extra = { asc = 1, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local chance, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_forever')
        return {
            vars = {
                card.ability.extra.asc,
                chance,
                odds
            }
        }
    end,    
    calculate = function (self, card, context)
            if context.poker_hand_changed then
                if SMODS.pseudorandom_probability(card, 'busterb_forever', 1, card.ability.extra.odds, 'busterb_forever') then
                    Spectrallib.asc_level_up(card,card.ability.extra.asc or 1,card.ability.extra.asc or 1)
                end
            end
        end
}

local Souperman = Spectrallib.has_tether
function Spectrallib.has_tether()
    if next(SMODS.find_card('v_busterb_forever')) then
        return true
    end
    return Souperman()
end


SMODS.Voucher {
    key = "phantasm",
    atlas = "vouch",
    pos = { x = 2, y = 0 },
    config = { extra = { asc = 1, odds = 4 } },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        local chance, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_phantasm')
        return {
            vars = {
                card.ability.extra.asc,
                chance,
                odds
            }
        }
    end,    
    calculate = function (self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Spectral" then
                if SMODS.pseudorandom_probability(card, 'busterb_phantasm', 1, card.ability.extra.odds, 'busterb_phantasm') then
                    local c = SMODS.create_card({set = "Infinity", edition = "e_negative"})
                    c:add_to_deck()
                    G.consumeables:emplace(c)
                end
            end
        end
}
SMODS.Voucher {
    key = "eternity",
    atlas = "vouch",
    pos = { x = 2, y = 1 },
    requires = { "v_busterb_phantasm" },
    config = { extra = { asc = 1, odds = 4 } },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        local chance, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_eternity')
        return {
            vars = {
                card.ability.extra.asc,
                chance,
                odds
            }
        }
    end,    
    calculate = function (self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Infinity" then
                if SMODS.pseudorandom_probability(card, 'busterb_eternity', 1, card.ability.extra.odds, 'busterb_eternity') then
                    local c = SMODS.create_card({set = "Spectral", edition = "e_negative"})
                    c:add_to_deck()
                    G.consumeables:emplace(c)
                end
            end
        end
}

SMODS.Voucher {
    key = "dealmaker",
    atlas = "vouch",
    pos = { x = 3, y = 0 },
    config = { extra = { odds = 4 }, immutable = { divide = 0.5 } },
    loc_vars = function(self, info_queue, card)
        local chance, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'busterb_dealmaker')
        return {
            vars = {
                card.ability.immutable.divide*100,
                chance,
                odds
            }
        }
    end,    
    calculate = function (self, card, context)
    local d = card.ability.immutable.divide
        if context.money_altered and context.amount < 0 then
                if SMODS.pseudorandom_probability(card, 'busterb_dealmaker', 1, card.ability.extra.odds, 'busterb_dealmaker') then
                    ease_dollars(math.abs(context.amount*d))
                end
            end
        end
}

SMODS.Voucher {
    key = "bigshot",
    atlas = "vouch",
    pos = { x = 3, y = 1 },
    requires = { "v_busterb_dealmaker" },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,    
    calculate = function (self, card, context)
        if context.money_altered and context.amount < 0 then
                    ease_dollars(math.abs(context.amount))
                end
            end
}
SMODS.Voucher {
    key = "scrap_merch",
    atlas = "vouch",
    pos = { x = 4, y = 0 },
    config = { extra = { rate = 2.4, display = 2 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.display,
            }
        }
    end,    
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                 G.GAME.bootleg_rate = 4 * card.ability.extra.rate
                return true
            end
        }))
    end,
}

SMODS.Voucher {
    key = "scrap_ty",
    atlas = "vouch",
    pos = { x = 4, y = 1 },
    requires = { "v_busterb_scrap_merch" },
    config = { extra = { rate = 8, display = 4} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.display,
            }
        }
    end,    
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.bootleg_rate = 4 * card.ability.extra.rate
                return true
            end
        }))
    end,
}

SMODS.Voucher {
    key = "endurance",
    atlas = "vouch",
    pos = { x = 0, y = 2 },
    config = { extra = { singular = 1 }, immutable = { operator = 1, win_ante = 2 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.immutable.operator,
                card.ability.immutable.win_ante,
            }
        }
    end,    
    redeem = function(self, card)
        local add = card.ability.extra.singular
        G.E_MANAGER:add_event(Event({
            func = function()
				play_sound('busterb_mus',1)
                	attention_text({
						scale = 2,
						text = "+"..card.ability.immutable.operator.." Operator",
                        colour = G.C.GRANDIOSE,
						hold = 2,
						align = "cm",
						offset = { x = 0, y = 0 },
						major = G.play,
                    })
					G.ROOM.jiggle = G.ROOM.jiggle + 35                    
                change_operator(card.ability.immutable.operator)
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1].config.colour = G.C.GRANDIOSE
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1]:juice_up(15,15)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.win_ante = G.GAME.win_ante * card.ability.immutable.win_ante
                play_sound("slib_eblindsize", 1)
					attention_text({
						scale = 2,
						text = "X"..card.ability.immutable.win_ante.." Ante",
                        colour = G.C.RED,
						hold = 2,
						align = "cm",
						offset = { x = 0, y = -2.7 },
						major = G.play,
                    })
                return true
            end
        }))
    end,

}

SMODS.Voucher {
    key = "marathon",
    atlas = "vouch",
    pos = { x = 0, y = 3 },
    requires = { "v_busterb_endurance" },
    config = { extra = { singular = 1 }, immutable = { operator = 1, win_ante = 2 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.immutable.operator,
                card.ability.immutable.win_ante,
            }
        }
    end,    
    redeem = function(self, card)
        local add = card.ability.extra.singular
        G.E_MANAGER:add_event(Event({
            func = function()
				play_sound('busterb_mus',1)
                	attention_text({
						scale = 2,
						text = "+"..card.ability.immutable.operator.." Operator",
                        colour = G.C.GRANDIOSE,
						hold = 2,
						align = "cm",
						offset = { x = 0, y = 0 },
						major = G.play,
                    })
					G.ROOM.jiggle = G.ROOM.jiggle + 35
                change_operator(card.ability.immutable.operator)
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1].config.colour = G.C.GRANDIOSE
                G.HUD:get_UIE_by_ID('hand_operator_container').children[1]:juice_up(15,15)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.win_ante = G.GAME.win_ante * card.ability.immutable.win_ante
                play_sound("slib_eblindsize", 1)
					attention_text({
						scale = 2,
						text = "X"..card.ability.immutable.win_ante.." Ante",
                        colour = G.C.RED,
						hold = 2,
						align = "cm",
						offset = { x = 0, y = -2.7 },
						major = G.play,
                    })
                return true
            end
        }))
    end,

}

SMODS.Voucher {
    key = "treasure_hunter",
    atlas = "vouch",
    pos = { x = 1, y = 2 },
    requires = { "v_busterb_endurance" },
    config = { extra = { shop_size = 5 }, immutable = { chance = 1, odds = 50 } },
    loc_vars = function(self, info_queue, card)
        local chance, odds = SMODS.get_probability_vars(card, card.ability.immutable.chance, card.ability.immutable.odds, 'busterb_treasure_hunter')
        return { vars = { card.ability.extra.shop_size, chance, odds } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.create_shop_card then --1
            card:juice_up(0.3, 0.5)
            if SMODS.pseudorandom_probability(card, 'busterb_treasure_hunter', card.ability.immutable.chance, card.ability.immutable.odds, 'busterb_treasure_hunter', true) then --2
                return {
                    shop_create_flags = {
                        key = SMODS.poll_object{
                       type = "Consumeables",
                    filter = function(pool)
                    local t = {}
                local all_unavailable = true
                for _, obj in ipairs(G.P_CENTER_POOLS.Consumeables) do
                  if obj.hidden or obj.key == "c_soul" or obj.key == "c_black_hole" then
                    if SMODS.add_to_pool(obj.key) and (not G.GAME.used_jokers[obj.key] or SMODS.showman(obj.key)) then
                      t[#t+1] = obj.key
                      all_unavailable = false
                    else
                      t[#t+1] = "UNAVAILABLE"
                    end
                  end
                end
                if all_unavailable then
                  return { { key = "c_soul", type = "Consumeables" } }
                else
                  return t
                end
                end,
                chance = 0.75
                },
                }
            }
        end--2
    end--1
end,
}
SMODS.Voucher {
    key = "thief",
    atlas = "vouch",
    pos = { x = 1, y = 3 },
    requires = { "v_busterb_treasure_hunter" },
    config = { extra = { shop_size = 5 }, immutable = { odds = 5 } },
    loc_vars = function(self, info_queue, card)
        local chance, odds = SMODS.get_probability_vars(card, 1, card.ability.immutable.odds, 'busterb_treasure_hunter')
        return { vars = { card.ability.extra.shop_size, chance, odds } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and (context.consumeable.config.center.hidden) then --1
            if SMODS.pseudorandom_probability(card, 'busterb_treasure_hunter', 1, card.ability.immutable.odds, 'busterb_treasure_hunter') then --2
                    local copy = moony_planet(context.consumeable,nil,G.conusmeables)
                        if Incantation and context.consumeable.bulkuse then
                            copy:setQty(context.consumeable:getQty())
                        end
                    end--2
                end--1
            end,

}