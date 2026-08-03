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
  "* local c =",
  "* SMODS.add_card{'j_busterb_gaia'};",
  "* c.config.center.gaia = true",
  "Thomas and Theia are really good friends of mine!",
  "That's right i heard the story over and over again",
  "Thomas a loser for liking Spinel XDDDDDDDD",
  "Yea Theia can actually cook bro, she done own a fastfood business and everything",
  "Ok i guess i'm also a loser for liking Spinel",
  "We both love Spinel... :/",
  "I'm sorry for dissing you Thomas",
  "Hey, got any grapes?",
  "King Bach pulls out comically large spoon",
  "Gee it's swell to finally meet her other friends",
  "Hi Murphy",
  "Hi Unseen",
  "Hi Roffle",
  "Hi Dr.",
  "Hi Exattox",
  "Hi Nightmare",
  "Hi Bean",
  "Hi Yahiamice",
  "Hi Watto",
  "Hi Marq",
  "Hi Robbi",
  "Yo Astro",
  "Yo Ruby",
  "Yo Aiko",
  "Yo Revo",
  "Yo Crystal",
  "Yo Grahkon",
  "Yo Sappy",
  "Yo Hawaii",
  "Yo Thomas",
  "Yo Theia",
  "Yo Nxkoo",
  "Yo Vessel",
  "Yo Hedera",
  "Yo JP",
  gaiatable1
}

SMODS.Joker{
    key = "gaia",
    atlas = "gaia",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, new = { x = 1, y = 0 } },
    pools = { ["technopotent"] = true, ["Bootleg"] = true },
    rarity = "busterb_technopotent",
    can_sell = function(self, card, context)
      return false
    end,
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
        immutable = { odds = 25 }
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
                local c = SMODS.add_card({ key = "c_busterb_admin" })
                play_sound('busterb_vineboom',1,1.2)
                play_sound('busterb_fahhh1',1,1.2)
                attention_text({
								text = "> <",
								scale = 5,
                hold = 1.5,
                backdrop_colour = G.C.BLACK,
								colour = G.C.SECONDARY_SET.Spectral,
								align = 'cm',
								major = c,
								offset = {x = 0, y = 0}
							})
            else
            local c = SMODS.add_card({ set = "Bootleg", area = G.consumeables})
            play_sound('holo1', 1, 0.5)
            SMODS.calculate_effect{
                    message = "Added!",
                    colour = G.C.GREEN,
                    card = c
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