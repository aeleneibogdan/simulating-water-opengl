#version 400

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 normals;
layout (location = 2) in vec2 texCoord;

out vec2 textureCoord;
out vec3 norm;
out vec3 fragPos;

uniform mat4 MVP;
uniform mat4 model;

uniform float time;
uniform float amplitude;
uniform vec2 dir;
uniform vec2 dirr;
uniform vec2 center;
uniform float length;
uniform float speed;

void main()
{	
	vec2 dirC;
	float y = 0.0f;
	vec2 centrul = vec2(0.0f, 0.0f);
	vec2 subtract = centrul - vec2(pos.x, pos.z);
	vec2 dirCircular = subtract/sqrt(pow(subtract.x, 2) + pow(subtract.y, 2));

	dirC = (center - vec2(pos.x,pos.z)) / abs(center - vec2(pos.x,pos.z));
	y += 2 * amplitude * pow((sin(dot(dir, vec2(pos.x,pos.z)) * (6.2f / length) + (time * speed * 6.2f) / length) + 1) / 2 , 2);
	y += 2 * amplitude * pow((sin(dot(dirr, vec2(pos.x,pos.z)) * (6.2f / length) + (time * speed * 6.2f) / length) + 1) / 2 , 2);
	y += 2 * amplitude * pow((sin(dot(dirr, vec2(pos.x,pos.z)) * (6.2f / length) + (time * speed * 6.2f) / length) + 1) / 2 , 2);
	y += 2 * amplitude * pow((sin(dot(dirr, vec2(pos.x,pos.z)) * (6.2f / length) + (time * speed * 6.2f) / length) + 1) / 2 , 2);

	textureCoord = texCoord;
	fragPos = vec3(model * vec4(pos, 1.0f));
	norm = mat3(transpose(inverse(model)))*normals;
	gl_Position = MVP * vec4(pos.x, y, pos.z, 1.0f);
}