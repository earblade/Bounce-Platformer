GDPC                �                                                                         \   res://.godot/exported/133200997/export-293646ebe151060671838ee459802e45-bounce_platform.scn 0      W      ̙'�!�Q��-2�>$p    X   res://.godot/exported/133200997/export-6a0b1fb42d0a672073c438ddb0c08369-main_level.scn  �      N      T�}O��!z?�9�Y�    T   res://.godot/exported/133200997/export-b2158a3934b4d308be85dba650fad23b-ground.scn  P            ���A�_hau(��k�Fd    T   res://.godot/exported/133200997/export-c2c62cb8c73458cd122faf659769dc80-player.scn  P      P      �^v�~0v=��(�T"d�    ,   res://.godot/global_script_class_cache.cfg  `&             ��Р�8���8~$}P�    L   res://.godot/imported/whitepixel.png-52b744d08fd75cf5cf652eb631ba65ba.ctex          ^       �Ǽ���.+p����       res://.godot/uid_cache.bin  �&      �       |oX�}i�KW�A�9��t    $   res://graphics/whitepixel.png.import`       �       U�L�� �*���GT�       res://project.binaryp'      b      �>����1^,�._"        res://scenes/ground/ground.gd   0             ��������/�7��Z:    (   res://scenes/ground/ground.tscn.remap   �$      c       �0cW��2���U�    $   res://scenes/levels/main_level.gd   p      n      ��X�~06J��V����    (   res://scenes/levels/main_level.gdshader 0      L       ����f����,g�Ѩ    ,   res://scenes/levels/main_level.tscn.remap   %      g       �J�c���-'2��    ,   res://scenes/platforms/bounce_platform.gd   �      �       Q���I��L#�ʌz�x    4   res://scenes/platforms/bounce_platform.tscn.remap   �%      l       �w1���bH{.�;�        res://scenes/player/player.gd   �      �      ��;z�e/p,�uu<��    (   res://scenes/player/player.tscn.remap   �%      c       ��0	���	�7q��                GST2            ����                        &   RIFF   WEBPVP8L   /    ���������    [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c2by1jgx18gqw"
path="res://.godot/imported/whitepixel.png-52b744d08fd75cf5cf652eb631ba65ba.ctex"
metadata={
"vram_texture": false
}
          extends StaticBody2D

          RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled    
   Texture2D    res://graphics/whitepixel.png V������\      local://RectangleShape2D_wwdcf c         local://PackedScene_lhep4 �         RectangleShape2D       
     "D  �B         PackedScene          	         names "   
      Ground    collision_layer    StaticBody2D 	   Sprite2D 	   modulate 	   position    scale    texture    CollisionShape2D    shape    	   variants                ���>��1?���>  �?
       ��5
     "D  �B          
       ��?                node_count             nodes     #   ��������       ����                            ����                                             ����         	                conn_count              conns               node_paths              editable_instances              version             RSRC         extends Node2D

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

var basic_platform: PackedScene = preload("res://scenes/platforms/bounce_platform.tscn")
var platform_distance: int = -120

@onready var camera_offset: Vector2 = $Player/Camera2D.offset
@onready var player = $Player

var platforms: Array

func _ready():

	platforms.push_front(basic_platform)
	spawn_platforms() #using basic platform currently

func _process(_delta):

	$Background.global_position.y = player.global_position.y

	# we want to randomly generate platforms in a certain width a certain vertical distance away from each other



	for platform in $Platforms.get_children():
		var previous_platform = $Platforms.get_child(platform.get_index()-4)

		var top_platform = $Platforms.get_child((platform.get_index()+15)%20)
		if platform.global_position.y >= player.global_position.y \
		and previous_platform.global_position.y >= player.global_position.y:
			move_platform(previous_platform, top_platform.global_position.y)


func move_platform(platform, anchor):
	var horizontal_range = randf_range(0 + platform.width/2, width - platform.width/2)
	platform.global_position = Vector2(
		horizontal_range,
		anchor + platform_distance)

func spawn_platforms():
	while $Platforms.get_child_count() < 20: # 20 basic platforms including the ground
		var platform_scene = basic_platform.instantiate()
		$Platforms.add_child(platform_scene)
		move_platform(
			platform_scene,
			player.global_position.y + (platform_distance * platform_scene.get_index())
		)

  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script "   res://scenes/levels/main_level.gd ��������
   Texture2D    res://graphics/whitepixel.png V������\   PackedScene     res://scenes/ground/ground.tscn >M;�%   PackedScene     res://scenes/player/player.tscn &���m�$      local://PackedScene_5rpf2 �         PackedScene          	         names "         Main Level    script    Node2D    Background 	   modulate 	   position    scale    texture 	   Sprite2D 
   Platforms    Ground    Player    collision_mask    metadata/_edit_group_ 	   Camera2D    offset    limit_left    limit_right    limit_bottom    drag_vertical_enabled    drag_top_margin    drag_bottom_margin    editor_draw_limits    editor_draw_drag_margin    	   variants                    ���>��.?��E?  �?
     �C  Y�
     "D�+E                  
     �C `�D         
   ��C���D            
         ��          �     B     ���>   
�#=      node_count             nodes     N   ��������       ����                            ����                                          	   ����                ���
                           ���                  	      
                    ����	                              
                  
      
             conn_count              conns               node_paths              editable_instances              version             RSRC  shader_type canvas_item;

void fragment() {
	// Place fragment code here.
}
    extends StaticBody2D

var bounce_height: int = -150
@onready var width: int = $Sprite2D.scale.x
@onready var height: int = $Sprite2D.scale.y

func _process(_delta):
	pass

    RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script *   res://scenes/platforms/bounce_platform.gd ��������
   Texture2D    res://graphics/whitepixel.png V������\      local://RectangleShape2D_bacn3 �         local://PackedScene_3olx3 �         RectangleShape2D       
      C  @A         PackedScene          	         names "   
      Bounce Platform    collision_layer    script    StaticBody2D 	   Sprite2D 	   position    scale    texture    CollisionShape2D    shape    	   variants                       
    �����4
      C  @A         
   ���5��3                node_count             nodes     #   ��������       ����                                  ����                                       ����         	                conn_count              conns               node_paths              editable_instances              version             RSRC         extends CharacterBody2D


const SPEED = 300.0
const JUMP_HEIGHT = -150

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bounce_height = 0

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = initial_velocity(JUMP_HEIGHT)
		#v = u + gt
		#t = v-u/g @ v = 0 (peak height)
		$JumpTimer.wait_time = -velocity.y/gravity
		$JumpTimer.start()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

		var platform = collision.get_collider()
		#bounce when it needs to bounce
		if "bounce_height" in platform and is_on_floor():
			bounce_height = platform.bounce_height
			velocity.y = initial_velocity(bounce_height)
			$BounceTiming.start()

	#super jump
	if Input.is_action_just_pressed("jump") and not $BounceTiming.is_stopped():
		print("super jump")
		velocity.y = initial_velocity(bounce_height + JUMP_HEIGHT + jump_offset())

# so that every super jump gets the same jump height (even at different timings)
func jump_offset() -> float:
	#s = u*t + 1/2*g*t**2
	var offset = (
		initial_velocity(bounce_height + JUMP_HEIGHT) * ($BounceTiming.time_left - $BounceTiming.wait_time) +
		1/2.0 * gravity * ($BounceTiming.time_left - $BounceTiming.wait_time) ** 2
		)
	print(offset)
	return offset

# u**2 = -2*g*s
func initial_velocity(height) -> float:
	var vel = sqrt(-2*gravity*height)
	vel = -vel
	return vel

func is_falling() -> bool:
	if velocity.y > 0:
		return true
	else:
		return false



func _on_bounce_timing_timeout():
	bounce_height = 0
            RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://scenes/player/player.gd ��������
   Texture2D    res://graphics/whitepixel.png V������\      local://RectangleShape2D_r1lg0 �         local://PackedScene_vjf33 �         RectangleShape2D       
      B   B         PackedScene          	         names "         Player    script    CharacterBody2D 	   Sprite2D 	   modulate 	   position    scale    texture    CollisionShape2D    visible    shape 
   JumpTimer 
   wait_time 	   one_shot    Timer    BounceTiming    _on_bounce_timing_timeout    timeout    	   variants    
                ��V?��n?��L>  �?
        @5
      B   B                                ?      )   �������?      node_count             nodes     9   ��������       ����                            ����                                             ����   	      
                        ����                                 ����      	                   conn_count             conns                                      node_paths              editable_instances              version             RSRC[remap]

path="res://.godot/exported/133200997/export-b2158a3934b4d308be85dba650fad23b-ground.scn"
             [remap]

path="res://.godot/exported/133200997/export-6a0b1fb42d0a672073c438ddb0c08369-main_level.scn"
         [remap]

path="res://.godot/exported/133200997/export-293646ebe151060671838ee459802e45-bounce_platform.scn"
    [remap]

path="res://.godot/exported/133200997/export-c2c62cb8c73458cd122faf659769dc80-player.scn"
             list=Array[Dictionary]([])
        V������\   res://graphics/whitepixel.png>M;�%   res://scenes/ground/ground.tscn'��'i�u#   res://scenes/levels/main_level.tscn�&��6+   res://scenes/platforms/bounce_platform.tscn&���m�$   res://scenes/player/player.tscn       ECFG      application/config/name         Platform Bounce    application/run/main_scene,      #   res://scenes/levels/main_level.tscn    application/config/features   "         4.1    Mobile  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      �     display/window/size/resizable          #   display/window/handheld/orientation            display/window/vsync/vsync_mode          
   input/jump�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script         input/move_left0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/move_right0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         layer_names/2d_physics/layer_1         Player     layer_names/2d_physics/layer_2         Ground     layer_names/2d_physics/layer_3      	   Platforms      layer_names/2d_physics/layer_4         Items      layer_names/2d_physics/layer_5         Zones   #   rendering/renderer/rendering_method         mobile                