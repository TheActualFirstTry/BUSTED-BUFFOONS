SMODS.Atlas{
	key = "gaia",
	path = "gaia.png",
	px = 71,
	py = 95
}

local gaiatable1 = {
  "Man",
  "Shut the fuck up"
}
local GaiaYap = {
  "I think Chance The Rapper is corny",
  "Let me kiss you on the big fat lips",
  "My name is Gaia and i am green",
  "",
  ":v",
  "Astro thinks he's sillier than me",
  "inside jokes suck balls",
  "Red Dog",
  ">.>",
  "",
  "key = 'gaia_badge'",
  "path = 'gaia.fs'",
  "SMODS.add_card{key='j_busterb_thomas'}",
  "The table error was intentional",
  "tick tock mothaf-",
  "tick tock heavy like a brink's truck",
  "hickory dickory dock",
  "PLEASE PLEASE PLEASE PLAY MEGABONK",
  "My favorite character isn't Sonic or Tails, it's Silver",
  "Jimbo can suck it!!!",
  "M",
  gaiatable1
}

SMODS.Joker{
    key = "gaia",
    atlas = "gaia",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    pools = { ["technopotent"] = true, ["Bootleg"] = true },
    rarity = "busterb_technopotent",
    cost = math.huge,
    gaia = false,
    no_collection = true,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra = { vm = 2
        },
        immutable = { odds = 50 }
    },
    loc_vars = function(self, info_queue, card)
      local gaiarare, gaiaodds = SMODS.get_probability_vars(card, 1, card.ability.immutable.odds, 'busterb_gaiarare')
        return { vars = { 
          " ",
          GaiaYap[math.random(#GaiaYap)], gaiarare, gaiaodds,
          colours = {SMODS.Gradients["busterb_technopotentgradient"], SMODS.Gradients["busterb_epileptic"]}} }
    end,
    
    use = function(self, card, area, copier)
                    if SMODS.pseudorandom_probability(card, 'busterb_gaiarare', 1, card.ability.immutable.odds, 'busterb_gaiarare', true) then
                SMODS.add_card({ key = "c_busterb_admin" })
                play_sound('busterb_vineboom')
                play_sound('busterb_fahhh1')
                SMODS.calculate_effect{
                        message = "FAHHH!",
                        colour = SMODS.Gradients["busterb_technopotentgradient"],
                        card = card
                    }
            else
            SMODS.add_card({ set = "Bootleg", area = G.consumeables})
            play_sound('holo1', 1, 0.5)
            SMODS.calculate_effect{
                    message = "Added!",
                    colour = G.C.GREEN,
                    card = card
                }
            end
    end,
        can_use = function(self, card)
        return true
        end,
calculate = function(self, card, context)
-- Joker
    if context.gaiajoker then
      gjoker()
  end
--
-- Consumable
    if context.gaiaconsumable then
      gconsumable()
  end
--
    if context.gaiabooster then
      gbooster()
	end

    if context.gaiavoucher then
      gvoucher()
	end

end,
  in_pool = function()
    return false
  end
}
-- SMODS.add_card{key="j_busterb_spinel"}

--funny snippets

function joker10()
    for k,v in ipairs(G.jokers.cards) do
			        Spectrallib.manipulate(v, { value = 2 })
		        end
end

function items10()
    for k,v in ipairs(G.consumeables.cards) do
			        Spectrallib.manipulate(v, { value = 2 })
		        end
end
function hands10()
for k,v in ipairs(G.hand.cards) do
			        Spectrallib.manipulate(v, { value = 2 })
		        end
end

function krillin()
  joker10()
  items10()
  hands10()
end