Shader "GLSL shader with all built-in attributes" {
   SubShader {
      Pass {
         GLSLPROGRAM

         #ifdef VERTEX

         varying vec4 color;

         attribute vec4 Tangent; // this attribute is specific to Unity 
         
         void main()
         {
            color = gl_MultiTexCoord0; // set the varying variable

            // other possibilities to play with:

            // color = gl_Vertex;
            // color = gl_Color;
            // color = vec4(gl_Normal, 1.0);
            // color = gl_MultiTexCoord0;
            // color = gl_MultiTexCoord1;
            // color = Tangent;
            
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
         }
         
         #endif

         #ifdef FRAGMENT
               
         varying vec4 color;

         void main()
         {
            gl_FragColor = color; // set the output fragment color
         }
         
         #endif

         ENDGLSL
      }
   }
}