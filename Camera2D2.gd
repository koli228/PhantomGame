extends Camera2D
var block = 0
func _ready():
	cells_load()
	pass

func _process(delta):
	self.position=$"../kinematicBody2D".position 
	var v = get_viewport_rect().size
	self.position -= v/2
	pass

func _on_TextureButton_pressed():
	#1-ая кнопка
	block = 0
	pass # Replace with function body.


func _on_TextureButton2_pressed():
	#2-ая кнопка
	block = 2
	pass # Replace with function body.


func _on_TextureButton3_pressed():
	#3-яя кнопка
	block = 3
	pass # Replace with function body.


func _on_TextureButton4_pressed():
	#4-ёртая кнопка
	block = 6
	pass # Replace with function body.
	


func _on_TextureButton5_pressed():
	#5-ая кнопка
	var cells = $"../TileMap".get_used_cells()
	cells_save(cells)
	pass # Replace with function body.

func cells_save(cells):
	#сохранение
	var file = File.new()
	file.open("res://save.dat",file.WRITE)
	var cells_new = []
	for cell in cells :
		cells_new.append(Vector3(cell.x, cell.y, $"../TileMap".get_cell(cell.x, cell.y)))
	file.store_var(cells_new)
	file.close()
	pass
func cells_load():
	#загрузка
	var file = File.new()
	if file.file_exists("res://save.dat"):
		file.open("res://save.dat",File.READ)
		var cells = file.get_var()
		file.close()
		var tileMap = $"../TileMap"
		tileMap.clear()
		for cell in cells:
			tileMap.set_cellv(Vector2(cell.x,cell.y),cell.z)
	pass
