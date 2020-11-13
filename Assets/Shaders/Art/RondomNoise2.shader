Shader "Custom/RandomNoise"
{
     Properties {
        _MainTex("Albedo(RBG)", 2D) = "white" {}//多分まっさらなテクスチャをベースにしている

        _SideBlockNum("SideBlockNum", int) = 0
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

        int _SideBlockNum;

        float random(fixed2 uv) {

            return frac(sin(dot(uv, fixed2(12.9898f, 78.233f))) * 43758.5453 - _Time * 100 );
          //  return frac(sin(dot(uv, fixed2(12.9898f, 78.233f))) * 43758.5453 - _Time * 100);//タイムを加える事でガチ砂嵐
        }
        
        float noise(fixed2 uv){
            fixed2 uv_integer = floor(uv);//uv以下の最大の整数を返す
            return random(uv_integer);
        }

        void surf(Input IN, inout SurfaceOutputStandard o) {//ここの関数が一ピクセルずつ回っていると考えよう
            float randomNum = noise(IN.uv_MainTex * _SideBlockNum);//ここの数字を変更できる
            o.Albedo = fixed4(randomNum, randomNum, randomNum, 1);
        }
        ENDCG
    }
    Fallback "Diffuse"
}
