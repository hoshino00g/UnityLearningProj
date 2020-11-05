Shader "GLSL shader using additive blending" {
   SubShader {
      Tags { "Queue" = "Transparent" } 
         // draw after all opaque geometry has been drawn
      Pass { 
         Cull Off // draw front and back faces
         ZWrite Off // don't write to depth buffer 
            // in order not to occlude other objects
         Blend SrcAlpha One // additive blending

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
            gl_FragColor = vec4(1.0, 0.0, 0.0, 0.3); 
         }
         
         #endif

         ENDGLSL
      }
   }
}