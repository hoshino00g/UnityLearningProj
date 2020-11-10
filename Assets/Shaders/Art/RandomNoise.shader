Shader "Custom/RandomNoise"
{
     Properties {
        _MainTex("Albedo(RBG)", 2D) = "white" {}//多分まっさらなテクスチャをベースにしている
    }
    SubShader {
        Tags { "RenderType" = "Opaque"}
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
        };

        float random(fixed2 uv) {


            return frac(sin(dot(uv, fixed2(12.9898f, 78.233f))) * 43758.5453 - _Time * 100);//タイムを加える事でガチ砂嵐
        }
        //

        void surf(Input IN, inout SurfaceOutputStandard o) {
            float randomNum = random(IN.uv_MainTex);
            o.Albedo = fixed4(randomNum, randomNum, randomNum, 1);
        }
        ENDCG
    }
    Fallback "Diffuse"
}
