extends Node2D
class_name WordDest

var pos : int

@onready var area : Area2D = $Area2D

# returns first overlapping area, will return null if
# no areas overlapping, will return first in queue if 
# multiple overlapping
func get_overlapping_word() -> Word:
	var areas = area.get_overlapping_areas()
	if areas.size() > 0 and areas[0].get_parent().get_parent() is Word: # see word.tscn scene structure
		return areas[0].get_parent().get_parent()
	return null

func has_multiple_overlapping() -> bool:
	if area.get_overlapping_areas().size() < 2:
		return false
	return true
