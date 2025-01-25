shader_type canvas_item;

// --- Uniforms --- //
uniform vec2 speed = vec2(0.01, 0.01);

// --- Functions --- //
void fragment() {
	COLOR = texture(TEXTURE, mod(UV + TIME * speed, 1.0));
	COLOR.a = .1;

	COLOR.r += sin(TIME) / 2.0;
	COLOR.g += cos(TIME) / 2.0;
}