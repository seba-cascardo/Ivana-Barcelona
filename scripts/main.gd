extends Node2D

## Escena raíz de la build 0.0.1 — Phase 0.
##
## Propósito: validar que el proyecto se abre, corre, y renderiza
## pixel-perfect. ESPACIO toggle un overlay de grilla pixel-perfect
## para inspección visual.

var _grid_visible: bool = false
var _grid_overlay: ColorRect


func _ready() -> void:
	_setup_grid_overlay()
	print("Ivana Barcelona — Build %s booted." % ProjectSettings.get_setting("application/config/version"))


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		_grid_visible = not _grid_visible
		_grid_overlay.visible = _grid_visible


func _setup_grid_overlay() -> void:
	_grid_overlay = ColorRect.new()
	_grid_overlay.size = Vector2(480, 270)
	_grid_overlay.color = Color(1, 1, 1, 0.05)
	_grid_overlay.material = _make_grid_material()
	_grid_overlay.visible = false
	add_child(_grid_overlay)


func _make_grid_material() -> ShaderMaterial:
	var mat := ShaderMaterial.new()
	var shader := Shader.new()
	shader.code = """
shader_type canvas_item;

void fragment() {
	vec2 px = floor(SCREEN_UV * vec2(480.0, 270.0));
	float check = mod(px.x + px.y, 2.0);
	COLOR = vec4(1.0, 1.0, 1.0, check * 0.08);
}
"""
	mat.shader = shader
	return mat
