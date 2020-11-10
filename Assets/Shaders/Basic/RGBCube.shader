Shader "Custom/RGBCube"
{
SubShader{
    Pass{
        GLSLPROGRAM
        #ifdef VERTEX
        varying vec4 position;

        void main(){
          position = gl_Vertex + vec4(0.5, 0.5, 0.5, 0.0);//足すことで明るくしているのか
          //  position = gl_Vertex;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;//ここでオブジェクトの位置の描画
        }

        #endif

        #ifdef FRAGMENT
        varying vec4 position;

        void main()
        {
            gl_FragColor = position;//頂点ごとに色が設定される
        }

        #endif

        ENDGLSL
    }

}
}
