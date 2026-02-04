SMODS.Atlas{
    key = "ic",
    path = "IC.png",
    px = 71,
    py = 95
}

SMODS.Voucher {
    key = "industryconnections",
    loc_txt = {
        name = 'Industry Connections',
        text = {
          "Creates a {C:attention}custom{} shop slot where", 
          "It always has a random {C:dark_edition}Negative{}",
          "{C:attention}Joker{} that is not {C:common}Common or {C:uncommon}Uncommon",
        }
    },
    atlas = "ic",
    pos = { x = 0, y = 0 },
    config = { extra = { shop_slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { " ", lenient_bignum(card.ability.extra.shop_slots), colours = {SMODS.Gradients["busterb_epileptic"]} } }
    end,
    
    redeem = function(self, card)

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
        local card = SMODS.create_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.shop_jokers }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
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
        local card = SMODS.create_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.shop_jokers }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
        end
    end,
}