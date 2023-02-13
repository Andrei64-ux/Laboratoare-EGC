#version 330

// Input
in vec2 texcoord;

// Uniform properties
uniform sampler2D texture_1;
uniform sampler2D texture_2;
uniform int tex2;
// TODO(student): Declare various other uniforms

// Output
layout(location = 0) out vec4 out_color;


void main()
{
    // TODO(student): Calculate the out_color using the texture2D() function.
    //out_color = vec4(1);

    vec4 col1 = texture2D(texture_1, texcoord);
	vec4 col2 = texture2D(texture_2, texcoord);
	if(tex2 == 1)
	{
		out_color = mix(col1, col2, .5f);
	}
	else
	{
		out_color = col1;
	}
	//out_color = mix(col1, col2, .5f);
	if (out_color.a < 0.5f){
		discard;
	}

}
