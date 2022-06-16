extends Label

func _physics_process(delta): 
	self.text = str($"../../TextureProgress".value)
