Shader "Custom/GLSL Shader" {
	SubShader {
		Pass {
			GLSLPROGRAM

#ifdef VERTEX
void main()
{
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
#endif

#ifdef FRAGMENT
uniform vec4 _ScreenParams;//レンダリングターゲットの幅が入っている、xyzw、canvas的な
uniform vec4 _Time;//時間 (t/20、t、t×2、t×3)、シェーダの中でアニメーションするのに使用

vec2 resolution = vec2(_ScreenParams.x, _ScreenParams.y);
float time = _Time.x;

// ここから
const int num_x = 10;
const int num_y = 10;
float w = resolution.x;
float h = resolution.y;

vec4 draw_ball(int i, int j) {//距離と色を設定
	float t = time;
	float x = w/2.0 * (1.0 + cos(1.5 * t + float(3*i+4*j)));
	float y = h/2.0 * (1.0 + sin(2.3 * t + float(3*i+4*j)));
	float size = 3.0 - 2.0 * sin(t);//sin,cosは、何かしら int、float などを入れたら、-1.0～1.0の値を返してくれます
	vec2 pos = vec2(x, y);
	float dist = length(gl_FragCoord.xy - pos);//距離を設定、gl_FragCoordはこのオブジェクトのピクセル/距離を出す
	float intensity = pow(size/dist, 2.0);
	vec4 color = vec4(0.0);//色を設定
	color.r = 0.5 + cos(t*float(i));
	color.g = 0.5 + sin(t*float(j));
	color.b = 0.5 + sin(float(j));
	return color*intensity;
}

void main() {
	vec4 color = vec4(0.0);
	for (int i = 0; i < num_x; ++i) {
		for (int j = 0; j < num_y; ++j) {
			color += draw_ball(i, j);
		}//ここで色を足して変化させてあげている
	}
	gl_FragColor = color;
}
#endif

			ENDGLSL
		}
	}
}