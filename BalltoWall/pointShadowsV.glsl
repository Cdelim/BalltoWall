#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec2 TexCoords;

out VS_OUT {
    vec3 FragPos;
    vec3 Normal;
    vec2 TexCoords;
} vs_out;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

uniform bool reverse_normals;
uniform int forBall;

//Collision
uniform vec3 velocity;
uniform float g=-9.8f;
uniform float t=0.0f;
uniform float t2=0.0f;

void main()
{
    
	if(forBall == -1){
		
		if(reverse_normals) // a slight hack to make sure the outer large cube displays lighting from the 'inside' instead of the default 'outside'.
			vs_out.Normal = transpose(inverse(mat3(model))) * (-1.0 * aNormal);
		else
			vs_out.Normal = transpose(inverse(mat3(model))) * aNormal;
		vs_out.FragPos = vec3(model * vec4(aPos, 1.0));
		vs_out.TexCoords = aTexCoords;
		gl_Position = projection * view * model * vec4(aPos, 1.0);
	}
	else if(forBall == 1){
		
		vs_out.TexCoords = aTexCoords;
	
		vs_out.FragPos = vec3(model * vec4(aPos, 1.0));

		vs_out.Normal = transpose(inverse(mat3(model))) * aNormal;
		gl_Position = projection * view * model * vec4(aPos, 1.0);
		
	}

}