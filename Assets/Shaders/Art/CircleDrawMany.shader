Shader "Custom/Circledraw"
{
    SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard 
		#pragma target 3.0

		struct Input {
			float3 worldPos;//ワールド座標の値をとる
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {//inoutはoutput構造体のことを指す、引数等はこの書き方
			float dist = distance( fixed3(0,22,7.7), IN.worldPos );//fixedのところはオブジェクトの座標が入る
			float val = abs(sin(dist - _Time * 100));//ここでdistの値を大きくすればするほど輪は細かくなる
			if(val > 0.98){//ここでoを使って一つ一つのピクセルにリングを書いてるっぽい
				o.Albedo = fixed4(1, 1, 1, 1);
			} else {
				o.Albedo = fixed4(110/255.0, 87/255.0, 139/255.0, 1);
			}
		}
		ENDCG
	}
	FallBack "Diffuse"
}
