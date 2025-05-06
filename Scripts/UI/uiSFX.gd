extends UI
class_name sfx

func playSelectSound():
	$selectSound.play()
	await get_tree().create_timer(0.5).timeout 
	$selectSound.stop()

func playCursorMoveSound():
	$cursorMoveSound.play()
	await get_tree().create_timer(.04).timeout
	$selectSound.stop()

func playBuySound():
	$buySound.play()
