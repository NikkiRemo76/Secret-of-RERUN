// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

vec4 NoiseColor = vec4(0.0, 0.0, 0.0, 0.0);
uniform float strength = 0.5; 


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    vec4 color = texture(iChannel0, uv);
    float noise = (fract(sin(dot(uv.xy * (iTime), vec2(12.9898,78.233))) * 43758.5453) - 0.5) * 2.0;
    
    
    color.rgba += (noise + NoiseColor) * strength;

    fragColor = color;
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}