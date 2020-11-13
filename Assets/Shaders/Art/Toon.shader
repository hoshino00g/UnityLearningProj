Shader "Custom/toon" {
    Properties {
        _Color("Color", Color) = (1, 1, 1, 1)
        _MainTex("Albedo(RGB)", 2D) = "white" {}
        _RampTex("Ramp", 2D) = "white" {}
    }

    SubShader {
        Tags {"RenderType" = "Opaque"}
        LOD 200

        CGPROGRAM
        #pragma surface surf ToonRamp// カスタムライティングの定義
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _RampTex;

        struct Input {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        fixed4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten) {// 定義した名前(ToonRamp)の頭にLightingをつける、ないと動かない
            half diff = dot(s.Normal, lightDir);//オブジェクトのピクセル毎の法線とライト方向の内積を出します。dot(内積)は、-1~1の間で出力されます。(cosだから)

            fixed3 ramp = tex2D(_RampTex, fixed2(diff, diff)).rgb;//// rampテクスチャのuv値を取得
            fixed4 c; // rampテクスチャのuv値から色を取得↓　//テクスチャ上の点の位置を表す
            c.rgb = s.Albedo * _LightColor0.rgb * ramp * atten;
            c.a = s.Alpha;
            return c;
        }

        void surf(Input IN, inout SurfaceOutput o) {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    Fallback "Diffuse"
}
