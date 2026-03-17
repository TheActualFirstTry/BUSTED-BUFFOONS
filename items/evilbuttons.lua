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
                            UIBox_button { label = { "Use" }, scale = 0.4, minw = 1.3, minh = 0.7, colour = G.C.RED, r = 0.1, button = 'universaljokeruse' }
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
                offset = { x = -1.5 , y = 0 },
                colour = G.C.CLEAR
            }
        })
    elseif self.children.love and not self.highlighted and self.config.center.evilbutton == true then
        self.children.love:remove()
        self.children.love = nil
    end
end
-- WORK ULTRA GREED
function G.FUNCS.universaljokeruse()
    SMODS.calculate_context({greedbutton = true})
end