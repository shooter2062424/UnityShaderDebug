﻿Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        // ShaderDebug
        _DebugNumberStripTex("DebugNumberStrip", 2D) = "white" {}
        _DebugNumberPeriodTex("DebugNumberPeriod", 2D) = "white" {}
        //

        // ShaderDebug: test value
        _TestValue("Test Value", Color) = (1,1,1,1)

        //_MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog
            
            #include "UnityCG.cginc"

            // ShaderDebug
            #include "../ShaderDebug.cginc"
            SD_TEX_DECLARE(_DebugNumberStripTex, _DebugNumberPeriodTex)
            //

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            //sampler2D _MainTex;
            //float4 _MainTex_ST;
            fixed4 _TestValue;
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                // ShaderDebug
                SD_TEX_UV(o.uv, v.uv)
                //

                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                //UNITY_APPLY_FOG(i.fogCoord, col);

                // ShaderDebug: print test value here
                DEBUG4(i.uv, _TestValue)

                //return col;
            }
            ENDCG
        }
    }
}
