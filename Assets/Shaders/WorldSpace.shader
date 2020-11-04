Shader "GLSL shading in world space" {
   SubShader {
      Pass {
         GLSLPROGRAM

        //  uniform mat4 unity_ObjectToWorld; //定義しなくてよかった、、、エラー治った
            // definition of a Unity-specific uniform variable 

         

         #ifdef VERTEX
         
         varying vec4 position_in_world_space;

         void main()
         {
            position_in_world_space = unity_ObjectToWorld * gl_Vertex;
               // transformation of gl_Vertex from object coordinates 
               // to world coordinates;
            
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
         }
         
         #endif

         #ifdef FRAGMENT
         
         varying vec4 position_in_world_space;
                  
         void main()
         {
            float dist = distance(position_in_world_space, 
               vec4(0.0, 0.0, 0.0, 1.0));
               // computes the distance between the fragment position 
               // and the origin (the 4th coordinate should always be 
               // 1 for points).
            
            if (dist < 5.0)//座標によって色が変化することができる。
            {
               gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0); 
                  // color near origin
            }
            else
            {
               gl_FragColor = vec4(0.3, 0.3, 0.3, 1.0); 
                  // color far from origin
            }
         }
         
         #endif

         ENDGLSL
      }
   }
}