shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform vec2 resolution = vec2(720.0, 720.0);

// Curvature & vignette
uniform float curvature : hint_range(0.0, 0.2) = 0.04;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.2;

// Scanlines
uniform float scan_intensity : hint_range(0.0, 1.0) = 0.1;
// NEW: scanline speed (how fast lines move)
uniform float scan_speed : hint_range(0.0, 20.0) = 2.0;

// Green tint
uniform vec3 tint_color = vec3(0.0, 0.5, 0.2);
uniform float tint_alpha : hint_range(0.0, 1.0) = 0.2;

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 ctr = vec2(0.5);
    vec2 off = uv - ctr;
    float dist = length(off);
    uv += off * dist * curvature;

    vec3 col = texture(SCREEN_TEXTURE, uv).rgb;

    // Moving scanlines: animate with TIME
    float scan = sin((uv.y * resolution.y + TIME * scan_speed) * PI) * scan_intensity;
    col -= scan;

    // Vignette
    float vig = smoothstep(0.8, 0.5, dist) * vignette_strength;
    col *= (1.0 - vig);

    // Green tint blending
    vec3 tinted = col * tint_color;
    col = mix(col, tinted, tint_alpha);

    COLOR = vec4(col, 1.0);
}
