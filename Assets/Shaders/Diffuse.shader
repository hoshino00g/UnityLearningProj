Shader "GLSL per-vertex diffuse lighting" {//光による色の濃淡を入力してくれるShaders
   Properties {
      _Color ("Diffuse Material Color", Color) = (1,1,1,1) 
   }
   SubShader {
      Pass {	
         Tags { "LightMode" = "ForwardBase" } 
            // make sure that all uniforms are correctly set

         GLSLPROGRAM

         uniform vec4 _Color; // shader property specified by users

         // The following built-in uniforms (except _LightColor0) 
         // are also defined in "UnityCG.glslinc", 
         // i.e. one could #include "UnityCG.glslinc" 
         uniform mat4 _Object2World; // model matrix
         uniform mat4 _World2Object; // inverse model matrix
         uniform vec4 _WorldSpaceLightPos0; //ワールド座標系でのライトの位置
            // direction to or position of light source
         uniform vec4 _LightColor0; 
            // color of light source (from "Lighting.cginc")
         
         //varying vec4 color; 
            // the diffuse lighting computed in the vertex shader
         
         #ifdef VERTEX
         
         out vec4 color;

         void main()
         {				
            mat4 modelMatrix = _Object2World;
            mat4 modelMatrixInverse = _World2Object; // unity_Scale.w
               // is unnecessary because we normalize vectors
            
            vec3 normalDirection = normalize(//法線を作る
               vec3(vec4(gl_Normal, 0.0) * modelMatrixInverse));
            vec3 lightDirection = normalize(//ライトとの距離
               vec3(_WorldSpaceLightPos0));

            vec3 diffuseReflection = vec3(_LightColor0) * vec3(_Color)
               * max(0.0, dot(normalDirection, lightDirection));//実際に法線とライト距離で反射を作る
            
            color = vec4(diffuseReflection, 1.0);//カラーを作る
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
         }
         
         #endif

         #ifdef FRAGMENT

         in vec4 color;
         
         void main()
         {
            gl_FragColor = color;
         }
         
         #endif

         ENDGLSL
      }
   } 
   // The definition of a fallback shader should be commented out 
   // during development:
   // Fallback "Diffuse"
}