extern number time;
extern vec2 screenSize;

vec2 curve(vec2 uv)
{
    uv = (uv - 0.5) * 2.0;

    uv *= 1.1;

    uv.x *= 1.0 + pow((abs(uv.y) / 5.0), 2.0);
    uv.y *= 1.0 + pow((abs(uv.x) / 4.0), 2.0);

    uv = (uv / 2.0) + 0.5;
    uv = uv * 0.92 + 0.04;

    return uv;
}

vec4 effect(
    vec4 color,
    Image texture,
    vec2 texture_coords,
    vec2 screen_coords
)
{
    vec2 q = texture_coords;
    vec2 uv = curve(q);

    vec3 base = Texel(texture, q).rgb;

    float scan = 0.5 + 0.5 * sin(uv.y * screenSize.y * 2.0 + time);
    float vignette = smoothstep(0.0, 1.0, 1.0 - (uv.x - 0.5) * (uv.x - 0.5) - (uv.y - 0.5) * (uv.y - 0.5));

    vec3 shifted = vec3(
        Texel(texture, vec2(uv.x + 0.0012, uv.y)).r,
        Texel(texture, uv).g,
        Texel(texture, vec2(uv.x - 0.0012, uv.y)).b
    );

    vec3 col = mix(base, shifted, 0.08);
    col *= 0.95 + 0.25 * scan;
    col *= 0.85 + 0.55 * vignette;
    col = clamp(col, 0.0, 1.0);

    return vec4(col, 1.0);
}