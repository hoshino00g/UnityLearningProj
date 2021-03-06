﻿Shader "GLSL per-vertex diffuse lighting" {//二つの光源に対応 //しっかりと光源(Spot,PointLightの場合のみ)
   Properties {
      _Color ("Diffuse Material Color", Color) = (1,1,1,1) 
   }
   SubShader {
      Pass {	
         Tags { "LightMode" = "ForwardBase" } 
            // pass for first light source

         GLSLPROGRAM

         uniform vec4 _Color; // shader property specified by users

         // The following built-in uniforms (except _LightColor0) 
         // are also defined in "UnityCG.glslinc", 
         // i.e. one could #include "UnityCG.glslinc" 
         uniform mat4 _Object2World; // model matrix
         uniform mat4 _World2Object; // inverse model matrix
         uniform vec4 _WorldSpaceLightPos0; 
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
            
            vec3 normalDirection = normalize(
               vec3(vec4(gl_Normal, 0.0) * modelMatrixInverse));
            vec3 lightDirection = normalize(
               vec3(_WorldSpaceLightPos0));

            vec3 diffuseReflection = vec3(_LightColor0) * vec3(_Color) 
               * max(0.0, dot(normalDirection, lightDirection));
            
            color = vec4(diffuseReflection, 1.0);
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

      Pass {	
         Tags { "LightMode" = "ForwardAdd" } 
            // pass for additional light sources
         Blend One One // additive blending 

         GLSLPROGRAM

         uniform vec4 _Color; // shader property specified by users

         // The following built-in uniforms (except _LightColor0) 
         // are also defined in "UnityCG.glslinc", 
         // i.e. one could #include "UnityCG.glslinc" 
         uniform mat4 _Object2World; // model matrix
         uniform mat4 _World2Object; // inverse model matrix
         uniform vec4 _WorldSpaceLightPos0; 
            // direction to or position of light source
         uniform vec4 _LightColor0; 
            // color of light source (from "Lighting.cginc")
         
            // the diffuse lighting computed in the vertex shader
         
         #ifdef VERTEX

         out vec4 color;
         
         void main()
         {				
            mat4 modelMatrix = _Object2World;
            mat4 modelMatrixInverse = _World2Object; // unity_Scale.w 
               // is unnecessary because we normalize vectors
            
            vec3 normalDirection = normalize(
               vec3(vec4(gl_Normal, 0.0) * modelMatrixInverse));
            vec3 lightDirection = normalize(
               vec3(_WorldSpaceLightPos0));

            vec3 diffuseReflection = vec3(_LightColor0) * vec3(_Color) 
               * max(0.0, dot(normalDirection, lightDirection));
            
            color = vec4(diffuseReflection, 1.0);
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