Shader "Cuttlefish/rainbow_effect"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;

				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);

				//chance colour of the object
				//col = float4(cos(1+(float)_Time*10),cos(1+(float)_Time*20),cos(1+(float)_Time*30),0);

				//change colour of the texture
				col.r -= -.5+cos(.5-(float)_Time*10);
				col.g -= -.5+cos(.5-(float)_Time*50);
				col.b -= -.5+cos(.5-(float)_Time*100);
			
				return col;
			}
			ENDCG
		}
	}
}
