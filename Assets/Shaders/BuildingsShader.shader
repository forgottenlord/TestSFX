// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/BuildingsShader"
{
    Properties
    {
        _MainColor ("Color", Color) = (1,1,1,1)
        _AltColor ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        //_Glossiness ("Smoothness", Range(0,1)) = 0.5
        //_Metallic ("Metallic", Range(0,1)) = 0.0
		_TornadoPos ("Tornado Position", Vector) = (0,0,0,0)
        _InfluenceRange ("InfluenceRange", Range(0,10)) = 5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma vertex vert
        //#pragma surface surf Standard fullforwardshadows vertex:vert
        #pragma surface surf Lambert fullforwardshadows vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0
		
        sampler2D _MainTex;
        float _InfluenceRange;
        float3 _TornadoPos;

        struct Input
        {
            float4 vertex : SV_POSITION;
			float factor;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _MainColor;
        fixed4 _AltColor;
		float factor;
		
        void vert (inout appdata_full v)
        {
			float3 worldPos = mul (unity_ObjectToWorld, v.vertex).xyz;
            factor =  (distance(worldPos, _TornadoPos));
			v.vertex.y -= v.vertex.y /factor;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = _MainColor;
			o.Albedo = lerp(_MainColor, _AltColor, step(factor, _InfluenceRange));
			//o.vertex = IN.vertex;

            //o.Metallic = _Metallic;
            //o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
