Shader "Custom/Melting"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _DissolveTex("DissolveTex", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Threshold("Threshold", Range(0, 1)) = 0.0//これはオリジナル
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _DissolveTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        half _Threshold;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 dissolveTex = tex2D (_DissolveTex, IN.uv_MainTex);//tex2D関数は、UV座標(uv_MainTex)からテクスチャ(_DissolveTex)上のピクセルの色を計算して返します。(一個一個)
            half gray = dissolveTex.r * 0.3f + dissolveTex.g * 0.59f + dissolveTex.b * 0.11f;
            if(gray <= _Threshold){//_DisolveTexをグレースケールにして、_Threshold以下になったらレンダリングしない、ピクセルごとに処理
                discard;
            }  

            fixed4 mainTex = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = mainTex.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = mainTex.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
