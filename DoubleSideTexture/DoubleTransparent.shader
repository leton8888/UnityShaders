Shader "Custom/DoubleSideTexture" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,0)
		_SpecColor("Spec Color", Color) = (1,1,1,1)
		_Emission("Emmisive Color", Color) = (0,0,0,0)
		_Shininess("Shininess", Range(0.01, 1)) = 0.7
		_FrontTex("Front (RGB)", 2D) = "white" { }
		_BackTex("Back (RGB)", 2D) = "white" { }
		_IlluminCol("Self-Illumination color (RGB)", Color) = (0.64,0.64,0.64,1)
		_MainTex("Base (RGB) Self-Illumination (A)", 2D) = "white" {}
	}
	SubShader{
		Tags{ "QUEUE" = "Geometry" "IGNOREPROJECTOR" = "true" }
		Material{
			Diffuse[_Color]
			Ambient[_Color]
			Shininess[_Shininess]
			Specular[_SpecColor]
			Emission[_Emission]
		}
		Lighting On
		SeparateSpecular On
		Blend SrcAlpha OneMinusSrcAlpha
		Pass{
			Cull Front
			Tags{ "QUEUE" = "Geometry" "IGNOREPROJECTOR" = "true" }
				Material{
				Ambient(1,1,1,1)
				Diffuse(1,1,1,1)
			}
			
			SetTexture[_BackTex]{ ConstantColor[_IlluminCol] combine constant * texture }
			SetTexture[_BackTex]{ combine previous + texture }
			SetTexture[_BackTex]{ ConstantColor[_IlluminCol] combine previous * constant }
		}
		Pass{
			Cull Back
			Tags{ "QUEUE" = "Geometry" "IGNOREPROJECTOR" = "true" }
				Material{
				Ambient(1,1,1,1)
				Diffuse(1,1,1,1)
			}
			
			SetTexture[_FrontTex]{ ConstantColor[_IlluminCol] combine constant * texture }
			SetTexture[_FrontTex]{ combine previous + texture }
			SetTexture[_FrontTex]{ ConstantColor[_IlluminCol] combine previous * constant }
		} 
	}
}