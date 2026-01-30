SMODS.Sound({
	key = "music_unexpectancy",
	path = "music_unexpectancy.ogg",
	volume = 0.4,
	select_music_track = function()
		return (
        #Cryptid.advanced_find_joker(nil, "Grandiose", nil, nil, true) ~= 0
		) and 100.002
	end,
})