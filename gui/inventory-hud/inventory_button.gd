class_name InventoryButton extends Button

var data: InventorySlot:
	set(value):
		data = value
		if data.is_empty():
			return
		%ItemTexture.texture = data.item.texture
		%QuantityLabel.text = str(data.quantity)


func _on_pressed() -> void:
	if data.activate() == FAILED:
		assert(false, "button failed with code: {code}".format({"code": FAILED}))
		return
