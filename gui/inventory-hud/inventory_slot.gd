class_name InventorySlotUI extends Button

var data: InventorySlot:
	set(value):
		data = value
		if data.item == null:
			return
		%ItemTexture.texture = data.item.texture
		%QuantityLabel.text = str(data.quantity)
