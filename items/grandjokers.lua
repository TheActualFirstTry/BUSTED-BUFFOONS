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
            "{c:inactive}(Currently {X:spectral,C:white}^^#2#{C:inactive} Mult){}"
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
    loc_txt = {
        name = "{V:1,s:2}Spes, Somnia, et Hypermors{}",
        text = {
            "This joker adds a free {C:spectral}Mega Arcana Booster{} in the shop.",
            "If a {C:attention}Dream{} is consumed, gain {X:attention,C:white}^#3#{} Mult",
            "If a {C:attention}Soul{} is consumed, gain {X:enhanced,C:white}^#4#{} Chips",
            "When skipping a {C:attention}Booster Pack{}, spawns a random {C:spectral}Spectral{} card.",
            "{c:inactive}(Currently {X:attention,C:white}^#1#{C:inactive} Mult and {X:enhanced,C:white}^#2#{C:inactive} Chips){}"
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
end,
remove_from_deck = function(self, card)
  if not G.CONTROLLER.locks.selling_card  then
    SMODS.add_card{ key = "j_busterb_astro", edition = 'e_negative', stickers = {'eternal'}, force_stickers = true }
  end
end
}
