-- DECKS:

-- 1. True Kinda Deck -- Start with Spinel and Garnet Jokers, and a deck of 52 Ace Cards consisting of only the Hearts and Clubs suits.
-- 2. Ultradeck -- Start with Minos Prime and Sisyphus Prime Jokers, 10 Discards and 10 Random Negative Spectral Cards.
-- 3. Deck of Bones -- Start with Sans and Papyrus and a deck of 52 Cards with only the Club suit.
-- 4. Imperial Deck -- Start with Negative Eternal Dark Donald and True Hyper Sonic and a deck of 52 Cards with only Aces, Kings, Queens, Jacks, and 10s.
-- 5. The Deck of Absolute Hate -- Start with a random Busted Buffoons Joker. Selecting a Blind has a 1 in 10 chance to create a random Fantastic Joker, otherwise creates a random Joker that isn't from the Fantastic Pool.


-- Deck #1 -- True Kinda Deck

local TDD = function()
    local suits = {
     dark = 0,
     light = 0
    }
    for k,v in ipairs(G.playing_cards or {}) do
        if v:is_suit("Clubs") then
            suits.dark = suits.dark + 1
        end
        if v:is_suit("Hearts") then
            suits.light = suits.light + 1
        end
    end
    return suits
end
SMODS.Atlas {
    key = "atlas_truekinda",
    path = "truekinda.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "truekinda",
    atlas = "atlas_truekinda",
    pos = { x = 0, y = 0 },
    config =  { bonus = 1 },
    apply = function(self, back)
--[[
        G.E_MANAGER:add_event(Event({
        func = function()
            local flipchance = pseudorandom(pseudoseed("busterb_truekinda"), 1, 2)
           if flipchance == 1 then 
                local c = SMODS.create_card({key = "j_busterb_spinel"})
                    c:add_to_deck()
                    G.jokers:emplace(c)
            end
            if flipchance == 2 then 
                local c = SMODS.create_card({key = "j_busterb_garnet"})
                    c:add_to_deck()
                    G.jokers:emplace(c)
            end
            if not G.playing_cards then return false end
            for k, v in pairs(G.playing_cards) do
                if v.base.suit == 'Spades' then
                    v:change_suit('Clubs')
                end
                if v.base.suit == 'Diamonds' then
                    v:change_suit('Hearts')
                end
            end
            
            return true
        end
    }))
--]]
end,
    calculate = function(self, back, context)
        if context.discard and context.other_card then
            local card = context.other_card
            if card:is_suit('Clubs') then
                card:change_suit('Spades')
                card:juice_up(0.3, 0.5)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "Change!",
                    colour = G.C.SUITS.Spades
                })
            elseif card:is_suit('Hearts') then
                card:change_suit('Diamonds')
                card:juice_up(0.3, 0.5)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "Change!",
                    colour = G.C.SUITS.Diamonds
                })
            elseif card:is_suit('Spades') then
                card:change_suit('Clubs')
                card:juice_up(0.3, 0.5)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "Change!",
                    colour = G.C.SUITS.Clubs
                })
            elseif card:is_suit('Diamonds') then
                card:change_suit('Hearts')
                card:juice_up(0.3, 0.5)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "Change!",
                    colour = G.C.SUITS.Hearts
                })
            end
        end
        if context.before then
        local unique = {}
        local check = {}

        for _, c in ipairs(context.full_hand) do
        for suit, _ in pairs(SMODS.Suits) do
            if c:is_suit(suit) and not unique[suit] then
                unique[suit] = true
                table.insert(check, suit)
            end
        end
    end

    if #check == 2 then
        local suit1 = check[1]
        local suit2 = check[2]

        Spectrallib.level_suit(suit1, back, 1, 10, 2)
        Spectrallib.level_suit(suit2, back, 1, 10, 2)
        end
    end
end,
    loc_vars = function(self, info_queue, back)
    return { vars = {  } }
    end
-- I feel like there should be a loc_vars here somewhere.
}

-- Deck #2 -- Ultradeck
-- SMODS.Back {
--}

--Deck #5 - The Deck of Absolute Hate

SMODS.Atlas {
    key = "atlas_hate",
    path = "hate.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "hate",
    atlas = "atlas_hate",
    pos = { x = 0, y = 0 },
    config =  {
        trigger = false
    },
        loc_vars = function(self, info_queue, back)
    return { vars = { localize { type = 'name_text', key = 'c_busterb_trial', set = 'Spectral' }, localize { type = 'name_text', key = 'c_busterb_mugen', set = 'Spectral' } } }
    end,
    calculate = function(self, back, context)
        if context.boss_mythical_beaten then
            if not G.GAME.won then
            print("trigger true")
            win_game()
            G.GAME.won = true
            end
        end
    end,
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
        func = function()
        SMODS.add_card({ key = "c_busterb_trial" })
        SMODS.add_card({ key = "c_busterb_mugen" })
        ease_x_ante_win(math.huge)
        return true
    end
}))
end
}
SMODS.Atlas {
    key = "atlas_sttgl",
    path = "STTGL.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "sttgl",
    atlas = "atlas_sttgl",
    pos = { x = 0, y = 0 },
    config = { joker_slot = -4 },
    loc_vars = function(self, info_queue, back)
    return {vars = { }}
    end,
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
       func = function()
        G.SETTINGS.paused = true

        local selectable_jokers = {}

        for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
          if (   
                 v.rarity == "busterb_Secret"
            ) then
            selectable_jokers[#selectable_jokers + 1] = v
          end
        end

        -- If the list of jokers is empty, we want at least one option so the user can leave the menu
        if #selectable_jokers <= 0 then
          selectable_jokers[#selectable_jokers + 1] = G.P_CENTERS.j_joker
        end

        G.FUNCS.overlay_menu {
          config = { no_esc = true },
          definition = mugen_apostle_of_wands_collection_UIBox(
            selectable_jokers,
            { 5, 5, 5 },
            {
              no_materialize = true,
              modify_card = function(other_card, center)
                other_card.sticker = get_joker_win_sticker(center)
                busterb_create_select_card_ui(other_card, G.jokers, "e_negative")
              end,
              h_mod = 1.05,
            }
          ),
        }
           return true
       end
    }))
    
end,
calculate = function(self, card, context)
	end,
}