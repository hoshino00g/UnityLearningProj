Shader "Custom/Wave"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert vertex:vert //これで、Vertex Shaderをフックすることができます。Lambertはライティングを使わないため


        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void vert(inout appdata_base v){//Input構造体のデータを受け取りたい場合はvoid vert(inout appdata_full v, out Input o)で記述、その際にはUNITY_INITIALIZE_OUTPUT(Input, o);を使う
            float amp = 0.5f * sin(_Time * 100 + v.vertex.x * 100);//v.vertexにモデルを構成するポリゴンのローカル頂点座標が入力されてきます。
            v.vertex.xyz = float3(v.vertex.x, v.vertex.y + amp, v.vertex.z);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) ;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
