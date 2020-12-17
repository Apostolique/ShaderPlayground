#if OPENGL
#define SV_POSITION POSITION
#define VS_SHADERMODEL vs_3_0
#define PS_SHADERMODEL ps_3_0
#else
#define VS_SHADERMODEL vs_4_0_level_9_1
#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

sampler TextureSampler : register(s0);
float exponent;
struct VertexToPixel {
    float4 Position : SV_Position0;
    float4 Color : COLOR0;
    float4 TexCoord : TEXCOORD0;
};

float plot(float2 st, float pct) {
    return
        smoothstep(pct - 0.04, pct, st.y) -
        smoothstep(pct, pct + 0.04, st.y);
}

float4 SpritePixelShader(VertexToPixel PSIn): COLOR0 {
    float2 st = PSIn.TexCoord.xy;
    st.y = 1.0 - st.y;

    float y = pow(st.x, exponent);

    float3 color = y;

    // Plot a line
    float pct = plot(st, y);
    color = (1.0 - pct) * color + pct * float3(0.0, 1.0, 0.0);

    return float4(color, 1.0);
}

technique SpriteBatch {
    pass {
        PixelShader = compile PS_SHADERMODEL SpritePixelShader();
    }
}
