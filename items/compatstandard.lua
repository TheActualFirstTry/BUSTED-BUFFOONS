Blockbuster.ValueManipulation.CompatStandard{
    key = "BustedBuffoonsVM",
    prefix_config = {key = { mod = false, atlas = false}},
    source_mod = "busterb",
    variable_conventions = {
        full_vars = {
            "aceodds",
            "odds",
            "luckychance",
            "nineodds",
            "valuecap"
        },
        ends_on = {
            "_non" 
        },

            starts_with = {
            "stacked_"
        }
    },

        integer_only_variable_conventions = {
        full_vars = {
            "joker_slots",
            "randomitems",
            "handndiscard",
            "jokerslot",
        },
        ends_on = {
            "_manip"
        },
        starts_with = {
            "manip_"
        },
    },
    
        variable_caps = {
        retriggers = 25,
        ["repetitions"] = 25,
    },

        min_max_values = {min = 0, max = 1e308},
        exempt_jokers = {
        j_busterb_spy = true,
        j_busterb_maxwell = true,
        j_busterb_neometalsonic = true,

    },

    
    redirect_objects = {
        example_alternative = {
            j_modID_examplejoker = true
        }
    }, 
    
}