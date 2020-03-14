extends KinematicBody2D
var block = 0
var hp = 55
var dmg = 1

const health = 55
const Damage = 1
# Member variables
const GRAVITY = 500.0 # pixels/second/second
# Скорость, передвижение
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 100
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 400
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var prev_jump_pressed = false


func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)
	var hook = Input.is_action_pressed("ui_select")
	var walk_left = Input.is_action_pressed("ui_left")
	var walk_right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_pressed("ui_up")
	
	var stop = true
	
	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			$AnimatedSprite.playing = true
			$AnimatedSprite.scale.x=-1.642
			stop = false
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			$AnimatedSprite.playing = true
			$AnimatedSprite.scale.x=1.642
			stop = false
	elif hook:
		$AnimatedSprite.play("hook")
		
	else:
		$AnimatedSprite.playing = false
	
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	# Integrate forces to velocity
	velocity += force * delta	
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		on_air_time = 0
		
	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false
	
	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		jumping = true
	
	on_air_time += delta
	prev_jump_pressed = jump
	mouse_action()
func raycast(from,to):
	#удаление,добавление блоков
	var space_state=get_world_2d().direct_space_state
	return space_state.intersect_ray(from,to,[self])
func mouse_action():
	if Input.is_action_just_pressed("mouse_left"):
		var mpos=get_global_mouse_position()
		var col=raycast(self.position,mpos)
		if col:
			var cell = $"../TileMap".world_to_map(col.position+col.normal)
			$"../TileMap".set_cell(cell.x,cell.y,block)
	if Input.is_action_just_pressed("mouse_right"):
		var mpos=get_global_mouse_position()
		var col=raycast(self.position,mpos)
		if col:
			var cell = $"../TileMap".world_to_map(col.position-col.normal*2)
			$"../TileMap".set_cell(cell.x,cell.y,-1)

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
