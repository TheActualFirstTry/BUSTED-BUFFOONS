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
          "{B:1,C:white}Busted#3#Buffoons{} {C:attention}Joker{}",
        }
    },
    atlas = "ic",
    pos = { x = 0, y = 0 },
    config = { extra = { shop_slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { " ", lenient_bignum(card.ability.extra.shop_slots), colours = {SMODS.Gradients["busterb_epileptic"]} } }
    end,
    redeem = function(self, card)
        local card = SMODS.create_card { set = "bustjokers", edition = 'e_negative' }
        create_shop_card_ui(card, "Joker", G.shop_jokers)
        card:set_cost()
        card:start_materialize()
        G.shop_jokers:emplace(card)
    end,
    calculate = function(self, card, context)
        if (context.reroll_shop or context.starting_shop) then
            local card = SMODS.create_card { set = "bustjokers", edition = 'e_negative' }
		    create_shop_card_ui(card, "Joker", G.shop_jokers)
		    card:set_cost()
		    card:start_materialize()
            G.shop_jokers:emplace(card)
        end
    end,
}