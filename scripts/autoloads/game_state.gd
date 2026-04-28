extends Node

## Autoload singleton — estado global del juego.
##
## En Phase 0 sólo expone la versión y el rango actual del detective.
## Se irá enriqueciendo en Phase 1 con: caso activo, skills, inventario
## de pistas, save/load, etc.

const GAME_VERSION: String = "0.0.1"

enum DetectiveRank {
	CADETE,
	DETECTIVE,
	SARGENTO,
	COMISARIO,
}

var current_rank: DetectiveRank = DetectiveRank.CADETE


func _ready() -> void:
	print("[GameState] inicializado. Rango: %s" % DetectiveRank.keys()[current_rank])
