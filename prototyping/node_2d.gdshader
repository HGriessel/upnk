shader_type canvas_item;

uniform float scale : hint_range(0.0,10.0) = 1.0;
uniform vec4 color : source_color;
uniform float flashState : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
void fragment() {
	//vec2 distortedUV = UV;
	//distortedUV.x += distortedUV.y * 0.2;
	
	//flash effect
	//vec4 pixelColor = texture(TEXTURE, UV * scale);
	//float brightness = (pixelColor.r + pixelColor.g + pixelColor.b) /3.0;
	//vec4 grayScale = vec4(brightness,brightness,brightness,pixelColor.a);
	//COLOR = mix(pixelColor, color, flashState);
	//COLOR.a  *= pixelColor.a;
	vec2 distortedUV = SCREEN_UV + texture(TEXTURE,UV).r * .05;
	vec4 screenColor = texture(SCREEN_TEXTURE,distortedUV);
	
	COLOR = screenColor;
}
