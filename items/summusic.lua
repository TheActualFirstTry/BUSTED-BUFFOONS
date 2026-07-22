SMODS.Sound({
	key = "music_grandiose",
	path = "ni4ni.ogg",
	pitch = 1,
	volume = 0.4,
	select_music_track = function()
		return (
        #Cryptid.advanced_find_joker(nil, "busterb_Grandiose", nil, nil, true) ~= 0
		) and 1e100
	end,
})

SMODS.Sound({
	key = "music_secret",
	path = "eventhorizon.ogg",
	pitch = 1,
	volume = 1,
	select_music_track = function()
		return (
        #Cryptid.advanced_find_joker(nil, "busterb_Secret", nil, nil, true) ~= 0
		) and 1e101
	end,
})

SMODS.Sound({
	key = "music_techno",
	path = "March.ogg",
	pitch = 1,
	volume = 1,
	select_music_track = function()
		return (
        #Cryptid.advanced_find_joker(nil, "busterb_technopotent", nil, nil, true) ~= 0
		) and 1e102
	end,
})