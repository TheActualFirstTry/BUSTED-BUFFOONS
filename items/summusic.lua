SMODS.Sound({
	key = "music_grandiose",
	path = "ni4ni.ogg",
	pitch = 1,
	volume = 0.4,
	select_music_track = function()
		return (
        #Cryptid.advanced_find_joker(nil, "busterb_Grandiose", nil, nil, true) ~= 0
		) and 100.002
	end,
})