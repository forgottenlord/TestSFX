Shader "Custom/TornadoShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags{ 
             "Queue"="Transparent"
             "IgnoreProjector"="True"
             "RenderType"="Transparent"}
 
        //Blend SrcAlpha OneMinusSrcAlpha
        LOD 200 
		Cull Off
		ZWrite Off

        CGPROGRAM

        #pragma surface surf Standard addshadow alpha:fade
        #pragma target 3.0

        sampler2D _MainTex;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

		
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			IN.uv_MainTex.x += _Time.z;
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c * _Color.rgb;
			o.Emission = c * _Color.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
