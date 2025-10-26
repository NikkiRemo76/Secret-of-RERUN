// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
uniform sampler2D iChannel1;
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

// explainations: cf https://www.shadertoy.com/view/XsdXWn# and https://hal.inria.fr/inria-00537472  ( also exist in Lagrangian form )

#define rot(a) mat2( cos(a),-sin(a),sin(a),cos(a) )

void mainImage( out vec4 O,  vec2 U )
{
    float t = mod(iTime,6.283);
	U = U / iResolution.xy - .5;
    
    O-=O;
    
    for (float i=0.; i<3.; i++) {
        float ti = t+ 6.283/3.*i,
              wi = (.5-.5*cos(ti))/1.5,
              v = 3./(.05+length(U));
        vec2 uvi = U * rot( .3*(-.5+fract(ti/6.283))*v );
      //if (i>0.) break;// else wi=1.; // uncomment to show smearing / trick with 1 layer
      //if (uv.x < 0.)                 // uncomment this and nexts to display the 3-layers
	        O += texture(iChannel0, .5 + uvi )  * wi;
	  //else
      //    O[int(i)] += texture(iChannel1, .5 + uvi ).x  * wi;  // show each phase in colors
    }
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}