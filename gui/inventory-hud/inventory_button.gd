class_name InventoryButton extends Button

var data: InventorySlot:
	set(value):
		data = value
		if data.is_empty():
			return
		%ItemTexture.texture = data.item.texture
		%QuantityLabel.text = str(data.quantity)
