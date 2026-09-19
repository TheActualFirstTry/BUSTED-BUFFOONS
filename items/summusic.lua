SMODS.Sound({
	key = "music_fantastic",
	path = "Calzonification.ogg",
	pitch = 1,
	volume = 0.4,
	select_music_track = function()
		return (
        #Spectrallib.advanced_find_joker(nil, "busterb_Fantastic", nil, nil, true) ~= 0
		) and BustB.current_mod.config.BustedBuffoons.fantastic_theme == true and 1e99
	end,
})


SMODS.Sound({
	key = "music_grandiose",
	path = "ni4ni.ogg",
	pitch = 1,
	volume = 0.4,
	select_music_track = function()
		return (
        #Spectrallib.advanced_find_joker(nil, "busterb_Grandiose", nil, nil, true) ~= 0
		) and BustB.current_mod.config.BustedBuffoons.grandiose_theme == true and 1e100
	end,
})

SMODS.Sound({
	key = "music_secret",
	path = "eventhorizon.ogg",
	pitch = 1,
	volume = 0.4,
	select_music_track = function()
		return (
        #Spectrallib.advanced_find_joker(nil, "busterb_Secret", nil, nil, true) ~= 0
		) and BustB.current_mod.config.BustedBuffoons.eldritch_theme == true and 1e101
	end,
})

SMODS.Sound({
	key = "music_techno",
	path = "March.ogg",
	pitch = 1,
	volume = 0.4,
	select_music_track = function()
		return (
        #Spectrallib.advanced_find_joker(nil, "busterb_technopotent", nil, nil, true) ~= 0
		) and BustB.current_mod.config.BustedBuffoons.techno_theme == true and 1e102
	end,
})
SMODS.Sound({
	key = "music_boss",
	path = "Impasta.ogg",
	pitch = 1,
	volume = 0.4,
	select_music_track = function()
		return (
        G.GAME.blind and G.GAME.blind.config.blind.mblind == true
		) and BustB.current_mod.config.BustedBuffoons.mythical_theme == true and 1e103
	end,
})