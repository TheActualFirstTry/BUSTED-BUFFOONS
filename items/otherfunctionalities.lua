BustB.Food = {
  j_gros_michel = true,
  j_ice_cream = true,
  j_cavendish = true,
  j_turtle_bean = true,
  j_diet_cola = true,
  j_popcorn = true,
  j_ramen = true,
  j_selzer = true,
  j_egg = true,
}
if not SMODS.ObjectTypes.Food then
    SMODS.ObjectType {
        key = 'Food',
        default = 'j_gros_michel',
        cards = copy_table(BustB.Food)
    }
end

local attributes = {
    "consumeables", "pizza", "bootleg", "infinity", "bustj", "all_bb", "bustb_d", "bustb_s", "eldritch", "m_blind"
}

for _, v in ipairs(attributes) do
    SMODS.Attribute { key = v }
end

SMODS.Attribute{ key = "m_blind" }

function eldritchspawn(deez)
SMODS.add_card{ 
            set = "Joker", 
            attributes = {"eldritch"}, 
            area = G.jokers, 
            edition = 'e_negative', 
            stickers = {'busterb_omega'}, 
            force_stickers = true,
            key_append = deez }
end

BustB.clock = 30

--STOLEN FROM YAHIAMICE
function DTE(type,tick)
--[[
    G.hermescheck = false
    if type == "G.hermesclock" and math.fmod(BustB.updoot,100) == 0 then
         if G.SETTINGS.paused == false and G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.GAME_OVER then
        if G.hermescheck == false then
        if G.hermesclock >= 1 then
            G.hermesclock = G.hermesclock - 1
                                attention_text({
								text = tostring(math.abs(G.hermesclock)),
								scale = 2,
                                hold = 1,
								backdrop_colour = G.C.CLEAR,
                                major = G.play,
                                align = 'tm',
								offset = {x = 0, y = -.5}
							})
            play_sound("generic1",2,0.5)
        end
        if G.hermesclock <= 0 then
            ease_hands_played(-1)
            G.hermescheck = true
        end
    end
        if G.hermescheck == true then
            G.hermesclock = BustB.clock
            play_sound("generic1",2,0.5)
        end
    end
end
--]]
end
local updort = Game.update
function Game:update(dt)
    updort(self, dt)

    if BustB.updoot == nil then BustB.updoot = 0 end
    if BustB.dtc == nil then BustB.dtc = 0 end
    BustB.dtc = BustB.dtc+dt
    BustB.dt = dt

    while BustB.dtc >= 0.010 do
        BustB.updoot = BustB.updoot + 1
        BustB.dtc = BustB.dtc - 0.010
        if G.GAME.blind and not G.GAME.blind.disabled then
--            if G.GAME.blind.name == 'Hermes' then DTE("G.hermesclock",0) end
        end
    end
end

function losekinda()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.STATE ~= G.STATES.SELECTING_HAND then
                            return
                        end
                        G.STATE = G.STATES.HAND_PLAYED
                        G.STATE_COMPLETE = false
                        G.STATE = G.STATES.GAME_OVER
                        end_round()
                    end
    }))
end

function legendarydefeat()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                           func = function()
                            play_sound("busterb_bang")
                           return true
                       end
                    }))
                    delay(0.4)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                           func = function()
                            play_sound("busterb_note")
                            play_sound("busterb_gonerlaugh")
                            G.ROOM.jiggle = G.ROOM.jiggle + 100
                           return true
                       end
                    }))

            G.E_MANAGER:add_event(Event({
                    func = function()
--[[
local min = -10
local max = 10
local poop = 20
for i = 1, poop do
    local x = min + (i - 1) * ((max - min) / (poop - 1))    
    attention_text({
        text = tostring(""),
        scale = 0.25, 
        hold = 1,
        major = G.ROOM_ATTACH,
        backdrop_colour = G.C.BBBLACK,
        colour = G.C.WHITE,
        align = 'cm',
        offset = { x = x, y = -4 }
    })
    attention_text({
        text = tostring(""),
        scale = 0.25, 
        hold = 1,
        major = G.ROOM_ATTACH,
        backdrop_colour = G.C.BBBLACK,
        colour = G.C.WHITE,
        align = 'cm',
        offset = { x = x, y = 0 }
    })
end
--]]
local rad = 5
for y = -rad, rad do
    for x = -rad, rad do
        if math.abs(x) + math.abs(y) == rad then
            attention_text({
                text = " ",
                scale = 0.25,
                hold = 1,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.BBBLACK,
                colour = G.C.WHITE,
                align = "cm",
                offset = {
                    x = x,
                    y = y - 1
                }
            })
        end
    end
end

local rad2 = 10
for y = -rad2, rad2 do
    for x = -rad2, rad2 do
        if math.abs(x) + math.abs(y) == rad2 then
            attention_text({
                text = " ",
                scale = 0.25,
                hold = 1,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.RED,
                colour = G.C.WHITE,
                align = "cm",
                offset = {
                    x = x,
                    y = y - 1
                }
            })
        end
    end
end

local rad3 = 15
for y = -rad3, rad3 do
    for x = -rad3, rad3 do
        if math.abs(x) + math.abs(y) == rad3 then
            attention_text({
                text = " ",
                scale = 0.25,
                hold = 1,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.BLUE,
                colour = G.C.WHITE,
                align = "cm",
                offset = {
                    x = x,
                    y = y - 1
                }
            })
        end
    end
end
             attention_text({
                text = tostring(localize("k_busterb_mythical_blind_defeat")),
                scale = 2.5, 
                hold = 4,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.CLEAR,
                colour = G.C.RED,
                align = 'cm',
                offset = { x = 0, y = -2}
              })
              return true
            end
        }))
end

function eldritchspawn(deez)
legendarydefeat()
local c = SMODS.add_card{ 
            set = "Joker", 
            attributes = { "eldritch"}, 
            area = G.jokers, 
            edition = 'e_negative', 
            stickers = {'busterb_omega'}, 
            force_stickers = true,
            allow_duplicates = true,
            key_append = deez }
    G.E_MANAGER:add_event(Event({
        func = function()
            attention_text({
                text = localize("k_busterb_mythical_blind_defeat2"),
                scale = 1, 
                hold = 4,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.CLEAR,
                colour = G.C.WHITE,
                align = 'cm',
                offset = { x = 0, y = 0.5}
              })
            attention_text({
                text = tostring(c.config.center.display.name),
--                text = "PLACEHOLDER",
                scale = 1.5, 
                hold = 4,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.CLEAR,
                colour = c.config.center.display.colour,
--                colour = G.C.WHITE,
                align = 'cm',
                offset = { x = 0, y = 2}
              })
            attention_text({
                text = localize("k_busterb_mythical_blind_defeat3"),
                scale = 1, 
                hold = 4,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.CLEAR,
                colour = G.C.WHITE,
                align = 'cm',
                offset = { x = 0, y = 3.5}
              })
              return true
            end
        }))
end

BustB.DionysusDrunk = nil

BustB.mblinds = {
    --[[]]
                "bl_busterb_zeus",
                "bl_busterb_hades",
                "bl_busterb_hermes",
                "bl_busterb_heracles",
                "bl_busterb_poseidon",
                "bl_busterb_ares",
                "bl_busterb_artemis",
                "bl_busterb_hephaestus",
                "bl_busterb_aphrodite",
                "bl_busterb_dionysus",
                "bl_busterb_thanatos",
                "bl_busterb_erebus",
                "bl_busterb_apollo",
                "bl_busterb_chronos",
                "bl_busterb_hestia",
                --]]
}
for k,v in pairs(G.P_BLINDS) do
    if v.mblind == true then
        BustB.mblinds[#BustB.mblinds+1] = v
    end
end
--[[
function BustB.m_blind_randomizer(k)
for k,v in pairs(G.P_BLINDS) do
    if v.mblind == true then
        BustB.mblinds[#BustB.mblinds+1] = v
    end
end
k = pseudorandom_element(BustB.mblinds, "busterb_m_blind_seed")
end
--]]

function blind_spawn(key)
    local par = G.blind_select_opts.boss.parent
    G.GAME.round_resets.blind_choices.Boss = key

    G.blind_select:remove()
    G.blind_select_opts.boss = UIBox {
        T = {par.T.x, 0, 0, 0},
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                colour = G.C.CLEAR
            },
            nodes = {UIBox_dyn_container({create_UIBox_blind_choice('Boss')}, false,
                get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))}
        },
        config = {
            align = "bmi",
            offset = {
                x = 0,
                y = G.ROOM.T.y + 9
            },
            major = par,
            xy_bond = 'Weak'
        }
    }
    par.config.object = G.blind_select_opts.boss
    par.config.object:recalculate()
    G.blind_select_opts.boss.parent = par
    G.blind_select_opts.boss.alignment.offset.y = 0
    G.STATE_COMPLETE = false
--[[
    for i = 1, #G.GAME.tags do
        if G.GAME.tags[i]:apply_to_run({
            type = 'new_blind_choice'
        }) then
            break
        end
    end
--]]
end
BustB.rarity_map = {
  Common = 'Rare',
  Uncommon = 'Rare',
  cry_cursed = 'cry_exotic',
  crp_abysmal = 'crp_mythic',
  unik_detrimental = 'unik_ancient',
  valk_supercursed = 'valk_exquisite',
  jen_junk = 'Rare',
  jen_omegatranscendent = 'cry_exotic',
  jen_omnipotent = 'cry_exotic',
  jen_transcendent = 'cry_exotic',
  jen_ritualistic = 'cry_exotic',
  jen_miscellaneous = 'Rare',
  bos_transcendent = 'bos_exotic',
  bos_miscellaneous = 'Rare',
  gj_detri = "gj_uniq",
  ocstobal_challengeexclusive = "ocstobal_omega",
  ocstobal_absolute_curse = "ocstobal_beyondexotic",
  ocstobal_cursed = "ocstobal_unique"
}
function BustB.random_rarity_spawn(seed)
local _, key = pseudorandom_element(SMODS.Rarities, seed)
    key = rarity_map[key] or key
    SMODS.add_card { set = "Joker", rarity = key, edition = 'e_negative', area = G.jokers }
end

function BustB.rarespawn(seed)
BustB.rarepool = {}
for _,v in ipairs(G.P_CENTER_POOLS.Consumeables) do
    if v.hidden and not ( v.set == "jen_omegaconsumable" or v.set == "jen_ability" ) and v.key ~= "c_busterb_admin" then BustB.rarepool[#BustB.rarepool+1] = v.key end
end
BustB.rare_random_key = pseudorandom_element(BustB.rarepool, seed)
if BustB.rare_random_key then SMODS.add_card({key = BustB.rare_random_key}) end
end

BustB.mythic = false

function mythical_blind_spawn()
            BustB.mythic = true
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
--            local g = pseudorandom_element(BustB.mblinds, "busterb_trial")
            ease_colour(G.C.GRANDIOSE, HEX("3f3f3f"))
	    	ease_background_colour({ new_colour = G.C.GRANDIOSE, special_colour = HEX("3f3f3f") })
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
            local g = pseudorandom_element(BustB.mblinds, "busterb_trial")
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                   func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                           func = function()
                            play_sound("busterb_bang")
                           return true
                       end
                    }))
                    delay(0.4)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                           func = function()
                            play_sound("busterb_orch")
                			G.ROOM.jiggle = G.ROOM.jiggle + 100
--[[
local min = -10
local max = 10
local poop = 20
                    for i = 1, poop do
    local x = min + (i - 1) * ((max - min) / (poop - 1))    
    attention_text({
        text = tostring(""),
        scale = 0.25, 
        hold = 1,
        major = G.ROOM_ATTACH,
        backdrop_colour = G.C.WHITE,
        colour = G.C.WHITE,
        align = 'cm',
        offset = { x = x, y = -4 }
    })
    attention_text({
        text = tostring(""),
        scale = 0.25, 
        hold = 1,
        major = G.ROOM_ATTACH,
        backdrop_colour = G.C.WHITE,
        colour = G.C.WHITE,
        align = 'cm',
        offset = { x = x, y = 2 }
    })
end
--]]
local rad = 5
for y = -rad, rad do
    for x = -rad, rad do
        if math.abs(x) + math.abs(y) == rad then
            attention_text({
                text = " ",
                scale = 0.25,
                hold = 1,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.BBBLACK,
                colour = G.C.WHITE,
                align = "cm",
                offset = {
                    x = x,
                    y = y - 1
                }
            })
        end
    end
end

local rad2 = 10
for y = -rad2, rad2 do
    for x = -rad2, rad2 do
        if math.abs(x) + math.abs(y) == rad2 then
            attention_text({
                text = " ",
                scale = 0.25,
                hold = 1,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.P_BLINDS[g].boss_colour,
                colour = G.C.WHITE,
                align = "cm",
                offset = {
                    x = x,
                    y = y - 1
                }
            })
        end
    end
end

local rad3 = 15
for y = -rad3, rad3 do
    for x = -rad3, rad3 do
        if math.abs(x) + math.abs(y) == rad3 then
            attention_text({
                text = " ",
                scale = 0.25,
                hold = 1,
                major = G.ROOM_ATTACH,
                backdrop_colour = G.C.WHITE,
                colour = G.C.WHITE,
                align = "cm",
                offset = {
                    x = x,
                    y = y - 1
                }
            })
        end
    end
end

attention_text({
                           text = tostring(G.P_BLINDS[g].name),
                           scale = 3,
                           hold = 1.5,
                           backdrop_colour = G.C.CLEAR,
                           colour = G.P_BLINDS[g].boss_colour,
                           align = 'cm',
                           major = G.ROOM_ATTACH,
                           offset = {x = 0, y = -2}
                    })
                    attention_text({
                           text = localize("k_busterb_mythical_blind_select2"),
                           scale = 2,
                           hold = 1.5,
                           backdrop_colour = G.C.CLEAR,
                           colour = G.C.WHITE,
                           align = 'cm',
                           major = G.ROOM_ATTACH,
                           offset = {x = 0, y = 0.5}
                    })
                   return true
               end
            }))
            delay(0.9)
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
            blind_spawn(g)
            return true
            end
        }))     
                           return true
                       end
                    }))

        return true 
    end    
}))
        return true 
    end    
}))

end

--mythical_blind_spawn()

function BustB.n_tag()
	if not G.GAME.tags then return 0 end
	local tags = 0
	for k, v in pairs(G.GAME.tags) do
		tags = tags + 1
	end
	return tags
end

function BustB.bosscheck()
if next(SMODS.find_mod("NotJustYet")) then
    if 
    G.STATE_COMPLETE == true
    and G.STATE ~= G.STATES.GAME_OVER 
    and G.FUNCS.njy_endround == true 
    then
        return true end
    elseif 
    G.STATE_COMPLETE == true 
    and G.STATE ~= G.STATES.GAME_OVER 
    then
        return true
    end
end

function BustB.uht_snd(volume, pitch, delay)
    return {
        sound = "button", volume = volume,
        pitch = pitch, delay = delay
    }
end
function BustB.JUICE_CARD_EVENT(card, delay)
    Spectrallib.event{
        function ()
            if card and card.juice_up then
                card:juice_up(0.8, 0.5)
            end
            G.TAROT_INTERRUPT_PULSE = nil
            return true
        end,
        trigger = 'after',
        delay = delay or 0.9
    }
end
