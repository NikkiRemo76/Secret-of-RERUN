#pragma header

uniform float transPoint;

void main()
{
    // This is a uniform in my real program
	vec2 uv = openfl_TextureCoordv;
    float aspectRatio = openfl_TextureSize.x / openfl_TextureSize.y;
    vec2 uvOriginal = uv;
    vec2 uvCenter = (uv - 0.5) * 2.0;
    uv.x *= aspectRatio;

    uv = fract(uv * 20.0); // tiling factor
    uv -= 0.5; // shifts the 0.0 point to the middle of each tile
    uv *= 1.0; // changes the scale of each tile to -1 to 1

    // Edges-in grid
    float timing = (transPoint * 2.0 - 1.0) + min(length(uvCenter), 1.0);
    float value = step(timing, abs(uv.x)) + step(timing, abs(uv.y));
    
    
    vec4 to = vec4(0.0,0.0,0.0,1.0);
    vec4 from = flixel_texture2D(bitmap, uvOriginal);
    gl_FragColor = vec4(mix(from, to, min(value, 1.0)));
}