SMODS.current_mod.calculate = function (self, context)
    if context.setting_blind then
            for i = 1, 3 do SMODS.add_card({ set = 'bustjokers' , area = G.jokers , edition = "e_negative"}) end
    end
end