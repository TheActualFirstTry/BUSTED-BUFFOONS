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
    if self.highlighted and self.config.center.evilbutton == true and not self.ability.extra.to_copy then
        self.children.love = UIBox({
            definition = asc,
            config = {
                parent = self,
                align = 'cm',
                offset = { x = 1.5 , y = 1 },
                colour = G.C.CLEAR
            }
        })
    elseif self.children.love and not self.highlighted and self.config.center.evilbutton == true then
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