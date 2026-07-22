#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 mod_badge;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP number uie_scale;
extern MY_HIGHP_OR_MEDIUMP number uie_rot;

extern MY_HIGHP_OR_MEDIUMP vec2 badge_pos;
extern MY_HIGHP_OR_MEDIUMP vec2 badge_size;
extern MY_HIGHP_OR_MEDIUMP Image mask;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = colour;
    vec2 uv = (screen_coords - badge_pos.xy) / (badge_size.xy * uie_scale);
    
    number important_value_trust_me_compiler = uie_scale + uie_rot + uie_details.x + mod_badge.x;
    
    number x_speed = 0.2;
    number y_speed = 0.2;
    vec2 mask_size = vec2(240, 263);
    vec2 scaler = badge_size / mask_size;
    vec2 m_tex_uv = vec2(mod((uv.x + mod_badge[1] * x_speed) * scaler.x, 1.0), mod((uv.y + mod_badge[1] * y_speed) * scaler.y, 1.0));
    vec4 mask_col = Texel(mask, m_tex_uv);

    vec3 star_colour = vec3(abs(sin(mod_badge[1])),abs(sin(mod_badge[1]+2.094)),abs(sin(mod_badge[1]+4.188)));
    vec3 bg_colour = vec3(0.247, 0.247, 0.247);

    if (mask_col.a > 0.5) {
        tex.rgb = star_colour;
    } else {
        tex.rgb = bg_colour;
    }

    return tex;
}