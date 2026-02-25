SMODS.Shader({ key = 'atomic', path = 'atomic.fs' })

SMODS.Sound{
    key = "Atomic1",
    path = "Atomic1.ogg",
    volume = 0.1
}
SMODS.Sound{
    key = "Thunder1",
    path = "Thunder1.ogg",
    volume = 0.1
}
SMODS.Edition {
    key = 'atomic',
    shader = 'atomic',
    prefix_config = {
        -- This allows using the vanilla shader
        -- Not needed when using your own
        shader = "atomic"
    },
    loc_txt = {
        name = "Atomic",
        label = "Atomic",
        text = {
            "{B:1,C:white}^^#1#{} Mult",
        }
    },
    config = {mult = 1.1 },
    in_shop = true,
    weight = 0.03,
    extra_cost = 0,
    sound = { sound = "busterb_Atomic1", per = 1.2, vol = 0.01 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.mult, colours = { SMODS.Gradients["busterb_Thomasgradient"]} } }
    end,
    get_weight = function(self)
		return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                ee_mult = self.config.mult,
                message = "^^ "..self.config.mult, colour = SMODS.Gradients["busterb_Thomasgradient"], sound = "busterb_Thunder1"
            }
        end
    end
}