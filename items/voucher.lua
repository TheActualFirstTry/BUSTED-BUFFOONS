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
                  if G.STATE == G.STATES.SHOP then
        local card = SMODS.add_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.shop_jokers }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
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
        local card = SMODS.add_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.shop_jokers }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
        end
    end,
}

SMODS.Voucher {
    key = "top",
    atlas = "vouch",
    pos = { x = 0, y = 1 },
    config = { extra = { shop_slots = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue+1] = {set="Other", key = "busterb_omega"}
        return { vars = { " ", lenient_bignum(card.ability.extra.shop_slots), colours = {SMODS.Gradients["busterb_epileptic"]} } }
    end,
    
    redeem = function(self, card)
                  if G.STATE == G.STATES.SHOP then
        local card = SMODS.add_card { set = "Joker", rarity = "busterb_Grandiose", edition = 'e_negative', area = G.shop_jokers, stickers = {'busterb_omega'}, force_stickers = true }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
        local card = SMODS.add_card { set = "Joker", rarity = "busterb_Secret", edition = 'e_negative', area = G.shop_jokers, stickers = {'busterb_omega'}, force_stickers = true }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
                  end
    end,
    calculate = function(self, card, context)
if (context.reroll_shop or context.starting_shop) then
        local card = SMODS.add_card { set = "Joker", rarity = "busterb_Grandiose", edition = 'e_negative', area = G.shop_jokers, stickers = {'busterb_omega'}, force_stickers = true }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
        local card = SMODS.add_card { set = "Joker", rarity = "busterb_Secret", edition = 'e_negative', area = G.shop_jokers, stickers = {'busterb_omega'}, force_stickers = true }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
                  end

    end,
}