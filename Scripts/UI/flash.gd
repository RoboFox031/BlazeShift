extends CanvasItem

var tween
var fade_duration := 0.5
var flashing := false

func startFlashing():
	flashing = true
	tween = create_tween().set_loops()
	tween.tween_property(self, "modulate:a", 0.0, fade_duration)
	tween.tween_property(self, "modulate:a", 1.0, fade_duration)

func stopFlashing():
	flashing = false
	if tween and tween.is_running():
		tween.kill()
	modulate.a =(1.0)
