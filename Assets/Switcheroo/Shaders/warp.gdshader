shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture;
uniform vec2 death_center;  // in **normalized screen space** or pass in UV space
uniform float time = 0.0;
uniform float strength = 0.3;

void fragment() {
    // your normalized uv
    vec2 uv = SCREEN_UV;
    vec2 center = death_center;  // you’ll pass death_center already normalized (0..1)
    vec2 dir = uv - center;
    float dist = length(dir);

    float warp = strength * exp(-dist * 8.0) * (1.0 - time);
    uv -= dir * warp;

    vec4 col = texture(screen_tex, uv);

    col.rgb *= 1.0 - smoothstep(0.8, 1.0, time);

    COLOR = col;
}
