#if OPENGL
#define SV_POSITION POSITION
#define VS_SHADERMODEL vs_3_0
#define PS_SHADERMODEL ps_3_0
#else
#define VS_SHADERMODEL vs_4_0_level_9_1
#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

#define PI 3.14159265f

sampler TextureSampler : register(s0);

float time;

float plot(float2 st, float pct) {
    return
        smoothstep(pct - 0.01, pct, st.y) -
        smoothstep(pct, pct + 0.01, st.y);
}
float3 rgb2hsb(float3 c) {
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = lerp(
        float4(c.bg, K.wz), float4(c.gb, K.xy),
        step(c.b, c.g)
    );
    float4 q = lerp(
        float4(p.xyw, c.r), float4(c.r, p.yzx),
        step(p.x, c.r)
    );
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return float3(
        abs(q.z + (q.w - q.y) / (6.0 * d + e)),
        d / (q.x + e),
        q.x
    );
}
float3 hsb2rgb(float3 c) {
    float3 rgb = clamp(
        abs((c.x * 6.0 + float3(0.0, 4.0, 2.0)) % 6.0 - 3.0) - 1.0,
        0.0,
        1.0
    );
    rgb = rgb * rgb * (3.0 - 2.0 * rgb);
    return c.z * lerp(1.0, rgb, c.y);
}

float4 SpritePixelShader(float2 position: SV_Position0, float4 texCoord : TEXCOORD0): COLOR0 {
    float2 st = texCoord.xy;
    st.y = 1.0 - st.y;

    float3 color = 0;

    color = hsb2rgb(float3(st.x, 1.0, st.y));

    return float4(color, 1.0);
}

technique SpriteBatch {
    pass {
        PixelShader = compile PS_SHADERMODEL SpritePixelShader();
    }
}
