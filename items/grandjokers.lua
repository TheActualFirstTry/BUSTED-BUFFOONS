SMODS.Atlas{
    key = "Grandholder",
    path = "Grandholder.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "a_igor",
    path = "IGOR.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "igor",
    atlas = "a_igor",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra ={
            EEM = 0.1,
            EEMTOTAL = 1
        }
    },
    loc_txt = {
        name = "{V:1,s:2}IGOR{}",
        text = {
            "Destroys played {C:attention}Queens{},",
            "Gains {X:spectral,C:white}^^#1#{} Mult whenever a {C:attention}Queen{} is scored",
            "{C:inactive}(Currently {X:spectral,C:white}^^#2#{C:inactive} Mult){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.EEM, card.ability.extra.EEMTOTAL, colours = {HEX('f7b4c6')}} }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card:get_id() == 12 and context.cardarea == G.play then
                card.ability.extra.EEMTOTAL = (card.ability.extra.EEMTOTAL) + card.ability.extra.EEM
                card_eval_status_text(card,"extra",nil,nil,nil,
                { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
            )
                return {remove = true}
        end
        if context.joker_main then
                return {
                    ee_mult = card.ability.extra.EEMTOTAL
                }
    end
end
}
SMODS.Atlas{
    key = "Flowey",
    path = "Asriel.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "asriel",
    atlas = "Flowey",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
    extra = {
      emult = 1,
      echips = 1,
      emult_gain = 1.5,
      echips_gain = 1.5,
      triggered = false
        }
    },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('polychrome', nil, card.ARGS.send_to_shader)
        end
    end,
    loc_txt = {
        name = "{V:1,s:2}ASRIEL DREEMURR{}",
        text = {
            "This joker adds a free {C:spectral}Mega Arcana Booster{} in the shop.",
            "If a {C:attention}Dream{} is consumed, gain {X:attention,C:white}^#3#{} Mult",
            "If a {C:attention}Soul{} is consumed, gain {X:enhanced,C:white}^#4#{} Chips",
            "When skipping a {C:attention}Booster Pack{}, spawns a random {C:spectral}Spectral{} card.",
            "{C:inactive}(Currently {X:attention,C:white}^#1#{C:inactive} Mult and {X:enhanced,C:white}^#2#{C:inactive} Chips){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.emult,
            card.ability.extra.echips,
            card.ability.extra.emult_gain,
            card.ability.extra.echips_gain,
            colours = {HEX('DBD8FF')}
        } }
    end,
    calculate = function(self, card, context)
         if context.starting_shop and not card.ability.extra.triggered then
     local booster = SMODS.add_booster_to_shop("p_spectral_mega_1")
	 booster.cost = 0
      card.ability.extra.triggered = true
    end
    if context.open_booster then
      card.ability.extra.triggered = false
    end
    if context.using_consumeable then
        if context.consumeable.config.center.key == "c_soul" then
          card.ability.extra.echips = card.ability.extra.echips * card.ability.extra.echips_gain
          card_eval_status_text(card, 'extra', nil, nil, nil, {
            message = localize { type = 'variable', key = 'a_xchips', vars = { card.ability.extra.echips } },
            colour = G.C.SECONDARY_SET.Enhanced
          })
          return {
            card = card
          }
        end 
    if context.consumeable.config.center.key == "c_busterb_dream" then
      card.ability.extra.emult = card.ability.extra.emult * card.ability.extra.emult_gain
      card_eval_status_text(card, 'extra', nil, nil, nil, {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.emult } },
        colour = G.C.FILTER
      })
      return {
        card = card
      }
    end
    end
    if context.joker_main then
      return {
        e_mult = card.ability.extra.emult,
        e_chips = card.ability.extra.echips
      }
    end
      if context.skipping_booster then
        local hopesanddreams = pseudorandom_element(G.P_CENTER_POOLS.Spectral, pseudoseed('asrielspawnsaspectral')).key
        local spectral_card = SMODS.add_card({key = hopesanddreams, area = G.consumeables, edition = "e_negative", key_append = "asrielspawnsaspectral"})
    end
end
}
SMODS.Atlas{
    key = "jimbussy",
    path = "Jimbo.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "joker",
    atlas = "jimbussy",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
          valuemodification = 4
        },
        immutable = { valuecap = 1e100 }
    },
    loc_txt = {
        name = "{V:1,s:2}JIMBO{}",
        text = {
            "{C:legendary}Legendary Jokers{} can spawn in the shop and are free,",
            "all jokers gain {B:2,V:1,s:2}X#1#{} joker values during ante change"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.valuemodification, " ", colours = {SMODS.Gradients["busterb_balatro"], SMODS.Gradients["busterb_epileptic"]}} }
    end,
calculate = function(self, card, context)
  if context.ante_change or context.forcetrigger then
    for i, joker in ipairs(G.jokers.cards) do
        if joker.config.center.key ~= "j_busterb_joker" then
        Cryptid.manipulate(joker, { value = card.ability.extra.valuemodification })
      end
    end
    SMODS.calculate_effect({message = "X" ..card.ability.extra.valuemodification, colour = SMODS.Gradients["busterb_balatro"], card = card})
  end
end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}
-- gray image of thinking baby meme
local oldgetcurrentpool = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)
  if next(SMODS.find_card('j_busterb_joker')) then
    if _type == 'Joker' and _append == 'sho' then
        local poll = pseudorandom('rarity'..G.GAME.round_resets.ante.._append)
        if poll < (1/20) then
            _legendary = true
        end
    end
  end
    return oldgetcurrentpool(_type, _rarity, _legendary, _append)
end

local oldcardsetcost = Card.set_cost
function Card:set_cost()
    local g = oldcardsetcost(self)
    if next(SMODS.find_card('j_busterb_joker')) then
      if self:is_rarity('Legendary') then self.cost = 0 end
    return g
  end
end

SMODS.Sound{
    key = "gfreddyyap",
    path = "g_freddy_yap.ogg",
}

SMODS.Sound{
    key = "gfreddygiggle",
    path = "g_freddy_giggle.ogg",
}

SMODS.Atlas{
    key = "g_freddy",
    path = "GFreddy.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "golden_freddy",
    atlas = "g_freddy",
    rarity = "busterb_Grandiose",
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    cost = 500,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    config = {
        extra = {
            jokerslot = 1,
        },
        immutable = {
        }
    },
    loc_txt = {
        name = "{V:1,s:2}GOLDEN FREDDY{}",
        text = {
            "Spawn a","{V:1,s:2}Random{} {C:white,B:1,s:2}RARE{} {V:1,s:2}Consumable{}","When a {C:attention}boss blind{} is {C:attention}defeated{}",
            "{C:inactive}(Must have room)",
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            " ",
            colours = { SMODS.Gradients["busterb_GoldenFreddyGradient"] }
        } }
    end,
    add_to_deck = function(self, card, from_debuff)
        play_sound("busterb_gfreddyyap")
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss or context.forcetrigger then
                local pool = {}
                    for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
                      if v.hidden then pool[#pool+1] = v.key end
                    end
                local random_key = pseudorandom_element(pool, "random_rare_consumeable")
                    if random_key then SMODS.add_card{key = random_key} end
                return {
                    message = "Har Har Har!",
                    sound = "busterb_gfreddygiggle",
                    colour = SMODS.Gradients["busterb_GoldenFreddyGradient"],
                    card = card
                }
            end
        end
}
SMODS.Atlas{
    key = "a_peddito",
    path = "peddito.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "peddito",
    atlas = "a_peddito",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    pools = { ["Grandiose"] = true, ["bustjokers"] = true },
    rarity = "busterb_Grandiose",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    unlocked = true,
    discovered = true,
    config = {extra = {eemult = 1, dp = 1, gain = 1},
    immutable = {tallyup = 1, tally = 0, deduction = 1}},
    loc_txt = {
        name = "{V:1,s:2}PEDDITO{}",
        text = {
            "Using up {B:1,C:white}#5#{} {V:1}Revive{}",
            "increases {V:1}Growth{} by {B:1,C:white}#6#{} and {B:1,C:white}^^Mult{} by {V:1}Growth{}",
            "Gains {B:1,C:white}#2#{} {V:1}Revive{} when",
            "{C:attention}Boss Blind{} is {C:red}defeated",
            "{V:1}Growth: {B:1,C:white}#4#{} {V:1}Mult: {B:1,C:white}^^#3#{} {V:1}Revives: {B:1,C:white}#1#{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
             card.ability.extra.dp,
             card.ability.extra.gain,
             card.ability.extra.eemult,
             card.ability.immutable.tally,
             card.ability.immutable.deduction,
             card.ability.immutable.tallyup,
             " ",
             colours = {HEX('d868a0')}
            } }
    end,
    calculate = function(self, card, context)
if context.joker_main then return({ee_mult = card.ability.extra.eemult, colour = HEX('d868a0'), card = card}) end
if context.end_of_round then
        if context.main_eval and context.beat_boss or context.forcetrigger then
    card.ability.extra.dp = card.ability.extra.dp + card.ability.extra.gain
    SMODS.calculate_effect({message = "+" ..card.ability.extra.gain.. " Revive", colour = HEX('d868a0'), card = card})
end

if context.game_over and card.ability.extra.dp > 0 then
    card.ability.extra.dp = card.ability.extra.dp - card.ability.immutable.deduction
    SMODS.calculate_effect ({
                    message = "-" ..card.ability.immutable.deduction.. " Revive",
                    colour = HEX('d868a0'),
                    card = card
                })
    card.ability.immutable.tally = card.ability.immutable.tally + card.ability.immutable.tallyup
    SMODS.calculate_effect ({
                    message = "+" ..card.ability.immutable.tallyup.. " Tally",
                    colour = HEX('d868a0'),
                    card = card
                })
    card.ability.extra.eemult = card.ability.extra.eemult + card.ability.immutable.tally
    SMODS.calculate_effect ({
                    message = "^^" ..card.ability.extra.eemult.. " Mult",
                    colour = HEX('d868a0'),
                    card = card
                })
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        return true
                    end
                }))
                SMODS.calculate_effect ({
                    message = "!!!",
--                    message = "-" ..card.ability.immutable.deduction.. " Revive / ^^" ..card.ability.extra.eemult.. " Mult",
                    saved = "You're lucky.",
                    colour = HEX('d868a0'),
                    card = card
                })
end
end
end
}
