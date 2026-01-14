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
          "{C:attention}+#1#{} Extra Shop Slot", 
          "Rightmost {C:attention}shop slot{} is always a {C:dark_edition}Negative{} {C:attention}Joker{}",
          "that isn't {C:common}Common{} or {C:uncommon}Uncommon{}",
        }
    },
    atlas = "ic",
    pos = { x = 0, y = 0 },
    config = { extra = { shop_slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { lenient_bignum(card.ability.extra.shop_slots) } }
    end,
    redeem = function(self, card)
        local _, key = pseudorandom_element(SMODS.Rarities, "industry") if key == "common" then key = "rare" end if key == "uncommon" then key = "rare" end if key == "cry_cursed" then key = "cry_exotic" end if key == "crp_abysmal" then key = "crp_mythic" end if key == "unik_detrimental" then key = "unik_ancient" end if key == "valk_supercursed" then key = "valk_exquisite" end
        local card = SMODS.create_card { set = "Joker", rarity = key, edition = 'e_negative' }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
        card:start_materialize()
        G.shop_jokers:emplace(card)
    end,
    calculate = function(self, card, context)
        if (context.reroll_shop or context.starting_shop) then
            local _, key = pseudorandom_element(SMODS.Rarities, "industry") if key == "common" then key = "rare" end if key == "uncommon" then key = "rare" end if key == "cry_cursed" then key = "cry_exotic" end if key == "crp_abysmal" then key = "crp_mythic" end if key == "unik_detrimental" then key = "unik_ancient" end if key == "valk_supercursed" then key = "valk_exquisite" end
            local card = SMODS.create_card { set = "Joker", rarity = key, edition = 'e_negative' }
		    create_shop_card_ui(card, "Joker", G.shop_jokers)
		    card:set_cost()
		    card:start_materialize()
            G.shop_jokers:emplace(card)
        end
    end,
}