﻿Shader "GLSL shader using multiplicative blending" {
   SubShader {
      Tags { "Queue" = "Transparent" } 
         // draw after all opaque geometry has been drawn
      Pass { 
         Cull Off // draw front and back faces
         ZWrite Off // don't write to depth buffer 
            // in order not to occlude other objects
         Blend Zero OneMinusSrcAlpha  // multiplicative blending 
            // for attenuation by the fragment's alpha

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
               // only A (alpha) is used
         }
         
         #endif

         ENDGLSL
      }
   }
}