Shader "GLSL silhouette enhancement" {
   Properties {
      _Color ("Color", Color) = (1, 1, 1, 0.5) 
         // user-specified RGBA color including opacity
   }
   SubShader {
      Tags { "Queue" = "Transparent" } 
         // draw after all opaque geometry has been drawn
      Pass { 
         ZWrite Off // don't occlude other objects
         Blend SrcAlpha OneMinusSrcAlpha // standard alpha blending

         GLSLPROGRAM

         uniform vec4 _Color; // define shader property for shaders

         // The following built-in uniforms are also defined in 
         // "UnityCG.glslinc", which could be #included 
         uniform vec3 _WorldSpaceCameraPos; 
            // camera position in world space
         uniform mat4 _Object2World; // model matrix
         uniform mat4 _World2Object; // inverse model matrix 
            // (apart from the factor unity_Scale.w)
                  
        // varying vec3 varyingNormalDirection; 
            // normalized surface normal vector
        // varying vec3 varyingViewDirection; 
            // normalized view direction 
                  
         #ifdef VERTEX

         out vec3 varyingNormalDirection; 
         out vec3 varyingViewDirection; 
         
         void main()
         {				
            mat4 modelMatrix = _Object2World;//モデルの情報だと理解すればいいかも
            mat4 modelMatrixInverse = _World2Object; //その逆行列
               // multiplication with unity_Scale.w is unnecessary 
               // because we normalize transformed vectors

            varyingNormalDirection = normalize(
               vec3(vec4(gl_Normal, 0.0) * modelMatrixInverse));//法線ベクトル
            varyingViewDirection = normalize(_WorldSpaceCameraPos 
               - vec3(modelMatrix * gl_Vertex));//ビュー上での距離

            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
         }
         
         #endif

         #ifdef FRAGMENT

         in vec3 varyingNormalDirection; 
         in vec3 varyingViewDirection; 
         
         void main()
         {
            vec3 normalDirection = normalize(varyingNormalDirection);
            vec3 viewDirection = normalize(varyingViewDirection);
            
            float newOpacity = min(1.0, _Color.a 
               / abs(dot(viewDirection, normalDirection)));
            gl_FragColor = vec4(vec3(_Color), newOpacity);
         }
         
         #endif

         ENDGLSL
      }
   }
}