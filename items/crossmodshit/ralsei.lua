SMODS.Atlas{
    key = "rals",
    path = "Ralsei.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "ralsei",
    atlas = "rals",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 2, new = { x = 0, y = 1 } },
    pools = { ["Universal"] = true },
    rarity = "busterb_Universal",
    cost = 500,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra = { vm = 2
        },
        immutable = { tpincreasecap = 10, tp = 1, tpcap = 100, valueincrease = 2, reset = 0 }
    },
    loc_txt = {
        name = "{V:1,s:2}PRINCEPS TENEBRARUM{}",
        text = {
            "{B:1,C:white,s:1.5}TP#5#Meter{} increases by a random amount", 
            "when using {C:spectral}spectral cards{}, {C:attention}adjacent jokers",
            "gain {B:1,C:white,s:1.5}X#1#{} {C:attention}joker values{}",
            "when the {B:1,C:white,s:1.5}TP#5#Meter{} fills up completely and resets to #2#.",
            "{B:1,C:white,s:2}TP:#5##3#/100{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
          card.ability.extra.vm, 
          card.ability.immutable.reset, 
          card.ability.immutable.tp, 
          card.ability.immutable.tpincreasecap, 
          " ",
          card.ability.immutable.tpcap, colours = {SMODS.Gradients["busterb_universalgradient"], SMODS.Gradients["busterb_epileptic"]}} }
    end,
calculate = function(self, card, context)
  if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Spectral" then
    local tpincrease = pseudorandom(pseudoseed("busterb_ralsei"), 1, 20)
  card.ability.immutable.tp = card.ability.immutable.tp + tpincrease
  SMODS.calculate_effect({ message = "+" ..tpincrease.. "TP", colour = SMODS.Gradients["busterb_universalgradient"]}, card)
  if to_big(card.ability.immutable.tp) >= to_big(100) then
			local mypos = nil
		        for i = 1, #G.jokers.cards do
			        if G.jokers.cards[i] == card then
				        mypos = i
			    	    break
		    	    end
		        end
                if G.jokers.cards[mypos + 1] then
					Cryptid.manipulate(G.jokers.cards[mypos+1], { value = card.ability.extra.vm })
                SMODS.calculate_effect({ message = "< X" ..card.ability.extra.vm, colour = SMODS.Gradients["busterb_universalgradient"]}, card)
				end
				if G.jokers.cards[mypos - 1] then
					Cryptid.manipulate(G.jokers.cards[mypos-1], { value = card.ability.extra.vm })
                SMODS.calculate_effect({ message = "X".. card.ability.extra.vm.. " >", colour = SMODS.Gradients["busterb_universalgradient"]}, card)
				end
      card.ability.immutable.tp = card.ability.immutable.reset 
    SMODS.calculate_effect({ message = "TP Reset!", colour = SMODS.Gradients["busterb_universalgradient"]}, card)
		end
  end
end
}