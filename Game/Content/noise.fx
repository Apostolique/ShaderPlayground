#if OPENGL
#define SV_POSITION POSITION
#define VS_SHADERMODEL vs_3_0
#define PS_SHADERMODEL ps_3_0
#else
#define VS_SHADERMODEL vs_4_0_level_9_1
#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

sampler TextureSampler : register(s0);
float time;

float rand(float x) {
    return frac(sin(x) * 1e4);
}
float rand(float2 st) {
    return frac(sin(st.x + rand(st.y)) * 1e4);
}
// float rand(float2 st) {
//     return frac(sin(dot(st, float2(12.9898, 78.233))) * 43758.5453123);
// }

float4 SpritePixelShader(float2 position: SV_Position0, float4 texCoord : TEXCOORD0): COLOR0 {
    float2 st = texCoord.xy;
    st.y = 1.0 - st.y;

    st *= float2(200.0, 50.0);
    float2 ipos = floor(st);
    float2 fpos = frac(st);

    float speed = 0.008 * 5.0;

    float o = floor(time * speed * (rand(ipos.y) * 2.0 - 1.0));

    float2 ipos2 = float2(floor((st.x + o) * 0.05), ipos.y);

    float3 color = step(rand(ipos.y), rand(ipos2));

    return float4(color, 1.0);
}

technique SpriteBatch {
    pass {
        PixelShader = compile PS_SHADERMODEL SpritePixelShader();
    }
}
