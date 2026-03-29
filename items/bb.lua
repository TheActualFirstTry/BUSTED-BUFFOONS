 BB = {}
 function BB.roll_shiny()
	local prob = 1
	if next(SMODS.find_card("j_lucky_cat")) then
		prob = 3
	end
	if pseudorandom("cry_shiny") < prob / 4096 then
		return "shiny"
	end
	return "normal"
end

function BB.is_shiny()
	if BB.roll_shiny() == "shiny" then
		return true
	end
	return false
end