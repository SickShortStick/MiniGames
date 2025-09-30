shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform vec2 resolution = vec2(720.0, 720.0);

// Curvature
uniform float curvature : hint_range(0.0, 0.2) = 0.08;
// Vignette
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.5;
// Scanlines
uniform float scan_intensity : hint_range(0.0, 1.0) = 0.3;
// Blackout
uniform float blackout_alpha : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 ctr = vec2(0.5);
    vec2 off = uv - ctr;
    float dist = length(off);

    // Curvature warp
    uv += off * dist * curvature;

    // Only sample if inside screen bounds post-curvature
    bool on_screen = uv.x >= 0.0 && uv.x <= 1.0 && uv.y >= 0.0 && uv.y <= 1.0;

    vec3 col = vec3(0.0);
    if (on_screen) {
        col = texture(SCREEN_TEXTURE, uv).rgb;

        // Scanlines
        float scan = sin(uv.y * resolution.y * PI) * scan_intensity;
        col -= scan;

        // Vignette
        float vig = smoothstep(0.8, 0.0, dist);
        col *= mix(1.0, vig, vignette_strength);
    }

    // Blend toward black based on blackout_alpha
    col = mix(col, vec3(0.0), blackout_alpha);

    COLOR = vec4(col, 1.0);
}
