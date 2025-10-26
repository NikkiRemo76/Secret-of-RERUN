// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

// GAUSSIAN BLUR SETTINGS {{{
uniform float directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
uniform float quality = 3.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
uniform float size = 8.0; // BLUR SIZE (Radius)
// GAUSSIAN BLUR SETTINGS }}}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float Pi = 6.28318530718; // Pi*2
    
    
   
    vec2 Radius = size/iResolution.xy;
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    // Pixel colour
    vec4 Color = texture(iChannel0, uv);
    
    // Blur calculations
    for( float d=0.0; d<Pi; d+=Pi/size)
    {
		for(float i=1.0/quality; i<=1.0; i+=1.0/quality)
        {
			Color += texture( iChannel0, uv+vec2(cos(d),sin(d))*Radius*i);		
        }
    }
    
    // Output to screen
    Color /= quality * directions - 15.0;
    fragColor =  Color;
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}