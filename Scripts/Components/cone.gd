extends RigidBody3D






func _on_area_3d_body_entered(body):
	if body.is_in_group("car"):
		get_tree().get_first_node_in_group("main").game_over()
