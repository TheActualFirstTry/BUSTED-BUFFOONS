--stealception
--[[

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local tdc = G_UIDEF_use_and_sell_buttons_ref(card)
    if (card.area == G.jokers) and card.config.center.key == "j_busterb_gaia" then
        local sell = nil
        local use = nil
        local levels = nil

        sell = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card' },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('b_sell'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true } },
                                        { n = G.UIT.T, config = { ref_table = card, ref_value = 'sell_cost_label', colour = G.C.WHITE, scale = 0.55, shadow = true } }
                                    }
                                }
                            }
                        }
                    }
                },
            }
        }
        levels =
        {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {

                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = false, button = 'seraphmenu' },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        { n = G.UIT.T, config = { text = 'Levels', colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
                    }
                }
            }
        }
        --overwriting usual buttons
        tdc = {
            n = G.UIT.ROOT,
            config = { padding = 0, colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { padding = 0.15, align = 'cl' },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = 'cl' },
                            nodes = {
                                sell
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = 'cl' },
                            nodes = {
                                use
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = 'cl' },
                            nodes = {
                                levels
                            }
                        },
                    }
                },
            }
        }
    end
    return tdc
end

]]



--I STEALED FROM UNIK'S MOD, ENTROPY AND ISOTYPICAL'S JUNKYARD
ooobuttons = Card.highlight
function Card:highlight(is_highlighted)
    ooobuttons(self, is_highlighted)
    asc = {
        n = G.UIT.ROOT,
        config = { padding = 0, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.C,
                config = { minw = 1, minh = 1, padding = 0.1, align = 'cm', colour = G.C.CLEAR },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minw = 1, minh = 0.5, padding = 0.01, align = 'cl', colour = G.C.CLEAR, button = 'universaljokeruse', r = 0.1 },
                        nodes = {
                            UIBox_button { label = { "Spend" }, scale = 0.4, minw = 1.3, minh = 0.7, colour = G.C.MONEY, r = 0.1, button = 'universaljokeruse' }
                        }
                    },
                }
            },
        }
    }
    pino = {
        n = G.UIT.ROOT,
        config = { padding = 0, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.C,
                config = { minw = 1, minh = 1, padding = 0.1, align = 'cm', colour = G.C.CLEAR },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minw = 1, minh = 0.5, padding = 0.01, align = 'cl', colour = G.C.CLEAR, button = 'pinobuy', r = 0.1 },
                        nodes = {
                            UIBox_button { label = { "Buy a Pizza" }, scale = 0.4, minw = 1.3, minh = 0.7, colour = G.C.GREEN, r = 0.1, button = 'pinobuy' }
                        }
                    },
                }
            },
        }
    }
    deckthing = {
        n = G.UIT.ROOT,
        config = { padding = 0, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.C,
                config = { minw = 1, minh = 1, padding = 0.1, align = 'cm', colour = G.C.CLEAR },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minw = 1, minh = 0.5, padding = 0.01, align = 'cl', colour = G.C.CLEAR, button = 'cainebutton', r = 0.1 },
                        nodes = {
                            UIBox_button { label = { "REDEEM" }, scale = 0.5, minw = 1.3, minh = 0.7, colour = SMODS.Gradients["busterb_grand"], r = 0.1, button = 'cainebutton' }
                        }
                    },
                }
            },
        }
    }
    gaia = {
        n = G.UIT.ROOT,
        config = { padding = 0, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.C,
                config = { minw = 1, minh = 1, padding = 0.1, align = 'cm', colour = G.C.CLEAR },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minw = 1, minh = 0.5, padding = 0.01, align = 'cl', colour = G.C.CLEAR, button = 'gaiajoker', r = 0.1 },
                        nodes = {
                            UIBox_button { label = { "Joker" }, scale = 0.4, minw = 2, minh = 0.5, colour = HEX('3f3f3f'), text_colour = HEX('1ac282'), r = 0.1, button = 'gaiajoker' }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = { minw = 1, minh = 0.5, padding = 0.01, align = 'cl', colour = G.C.CLEAR, button = 'gaiaconsumable', r = 0.1 },
                        nodes = {
                            UIBox_button { label = { "Consumable" }, scale = 0.4, minw = 2, minh = 0.5, colour = HEX('3f3f3f'), text_colour = HEX('1ac282'), r = 0.1, button = 'gaiaconsumable' }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = { minw = 1, minh = 0.5, padding = 0.01, align = 'cl', colour = G.C.CLEAR, button = 'gaiabooster', r = 0.1 },
                        nodes = {
                            UIBox_button { label = { "Booster" }, scale = 0.4, minw = 2, minh = 0.5, colour = HEX('3f3f3f'), text_colour = HEX('1ac282'), r = 0.1, button = 'gaiabooster' }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = { minw = 1, minh = 0.5, padding = 0.01, align = 'cl', colour = G.C.CLEAR, button = 'gaiavoucher', r = 0.1 },
                        nodes = {
                            UIBox_button { label = { "Voucher" }, scale = 0.4, minw = 2, minh = 0.5, colour = HEX('3f3f3f'), text_colour = HEX('1ac282'), r = 0.1, button = 'gaiavoucher' }
                        }
                    },
                }
            },
        }
    }
    if self.highlighted and self.config.center.gaia == true and not self.ability.extra.to_copy then
        self.children.love = UIBox({
            definition = gaia,
            config = {
                parent = self,
                align = 'cm',
                offset = { x = -2.25 , y = 0 },
                colour = G.C.CLEAR
            }
        })
    elseif self.children.love and not self.highlighted and self.config.center.gaia == true then
        self.children.love:remove()
        self.children.love = nil
    end
    if self.highlighted and self.config.center.pino == true and not self.ability.extra.to_copy then
        self.children.love = UIBox({
            definition = pino,
            config = {
                parent = self,
                align = 'cm',
                offset = { x = 1.5 , y = 1 },
                colour = G.C.CLEAR
            }
        })
    elseif self.children.love and not self.highlighted and self.config.center.pino == true then
        self.children.love:remove()
        self.children.love = nil
    end
    if self.highlighted and self.config.center.caine == true and not self.ability.extra.to_copy then
        self.children.love = UIBox({
            definition = deckthing,
            config = {
                parent = self,
                align = 'cm',
                offset = { x = 1.5 , y = 1 },
                colour = G.C.CLEAR
            }
        })
    elseif self.children.love and not self.highlighted and self.config.center.caine == true then
        self.children.love:remove()
        self.children.love = nil
    end
end
-- WORK ULTRA GREED
function G.FUNCS.universaljokeruse()
    SMODS.calculate_context({greedbutton = true})
end
function G.FUNCS.pinobuy()
    SMODS.calculate_context({pinobuy = true})
end
function G.FUNCS.cainebutton()
    SMODS.calculate_context({cainebutton = true})
end
function G.FUNCS.gaiajoker()
    SMODS.calculate_context({gaiajoker = true})
end

function G.FUNCS.gaiaconsumable()
    SMODS.calculate_context({gaiaconsumable = true})
end

function G.FUNCS.gaiabooster()
    SMODS.calculate_context({gaiabooster = true})
end

function G.FUNCS.gaiavoucher()
    SMODS.calculate_context({gaiavoucher = true})
end