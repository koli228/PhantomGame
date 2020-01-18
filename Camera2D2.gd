extends Camera2D
var block = 0
func _ready():
	pass

func _process(delta):
	self.position=$"../kinematicBody2D".position 
	var v = get_viewport_rect().size
	self.position -= v/2
	pass

func _on_TextureButton_pressed():
	block = 0
	pass # Replace with function body.


func _on_TextureButton2_pressed():
	block = 2
	pass # Replace with function body.


func _on_TextureButton3_pressed():
	block = 3
	pass # Replace with function body.


func _on_TextureButton4_pressed():
	block = 6
	pass # Replace with function body.
