SMODS.Atlas{
    key = "silence",
    path = "Silenced.png",
    px = 71,
    py = 95
}
SMODS.Enhancement{
	key = 'silenced',
	loc_txt = {
		name = 'Silenced Card',
		text = {
			'Creates 2 Wiped cards',
            'when held in hand',
            'then {C:red}self destructs{}'
		}
	},
	config = {},
    weight = 0.01,
	pos = { x = 0, y = 0 },
	unlocked = true,
	discovered = true,
	atlas = 'silence',
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.m_ninehund_blankcard
        return {vars = {center.ability.emult}}
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.main_scoring then
            SMODS.add_card{ set = "Base", rank = "A", enhancement = "m_ninehund_blankcard" }
            SMODS.add_card{ set = "Base", rank = "A", enhancement = "m_ninehund_blankcard" }
        end
            if context.destroy_card then
                SMODS.destroy_cards(card, nil, nil, nil, true)
        end
    end,
}