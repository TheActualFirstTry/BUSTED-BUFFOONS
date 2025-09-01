-- Thanks 900n1.

function align_layer(card, layer)
    v = card.children[layer]
    if v ~= nil then
        v.states.hover = card.states.hover
        v.states.click = card.states.click
        v.states.drag = card.states.drag
        v.states.collide.can = false
        v:set_role({major = card, role_type = 'Glued', draw_major = card})
    end
end

local set_spritesref = Card.set_sprites
function Card: set_sprites (_center,_front)
    set_spritesref (self,_center, _front)
    if _center and _center.soul_pos and _center.soul_pos.new then 
        self.children.center = Sprite(
            self.T.x,
            self.T.y,
            self.T.w,
            self.T.h,
            G.ASSET_ATLAS[_center.atlas or _center.set],
            _center.pos
        )
        self.children.floating_sprite = Sprite(
            self.T.x,
            self.T.y,
            self.T.w,
            self.T.h,
            G.ASSET_ATLAS[_center.atlas or _center.set],
            _center.soul_pos
        )
        self.children.float2 = Sprite(
            self.T.x,
            self.T.y,
            self.T.w,
            self.T.h,
            G.ASSET_ATLAS[_center.atlas or _center.set],
            _center.soul_pos.new
        )
        align_layer(self,"center")
        align_layer(self,"floating_sprite")
        align_layer(self,"float2")
    end
end

SMODS.DrawStep({
    key = "float2",
    order = 59,
    func = function(self)
        if
            self.config.center.soul_pos
            and self.config.center.soul_pos.new
            and (self.config.center.discovered or self.bypass_discovery_center)
        then
            local scale_mod = 0.07
            local rotate_mod = 0.02*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
            self.children.float2:draw_shader(
                "dissolve",
                0,
                nil,
                nil,
                self.children.center,
                scale_mod,
                rotate_mod,
                nil,
                0.1 + 0.03*math.cos(1.8*G.TIMERS.REAL),
                nil,
                0.6
            )
            self.children.float2:draw_shader(
                "dissolve",
                nil,
                nil,
                nil,
                self.children.center,
                scale_mod,
                rotate_mod
            )
        end
    end,
    conditions = { vortex = false, facing = "front" },
})

SMODS.draw_ignore_keys.float2 = true
