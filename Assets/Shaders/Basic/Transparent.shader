Shader "GLSL shader using blending" {
   SubShader {
      Tags { "Queue" = "Transparent" } 
         // draw after all opaque geometry has been drawn
      Pass {
         ZWrite Off // don't write to depth buffer 
            // in order not to occlude other objects

         Blend SrcAlpha OneMinusSrcAlpha // use alpha blending

         GLSLPROGRAM
               
         #ifdef VERTEX
         
         void main()
         {
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
         }
         
         #endif

         #ifdef FRAGMENT
         
         void main()
         {
            gl_FragColor = vec4(0.0, 1.0, 0.0, 0.3); 
               // the fourth component (alpha) is important: 
               // this is semitransparent green
         }
         
         #endif

         ENDGLSL
      }
   }
}