class_name InventorySlotUI extends Button

var data: SlotData:
	set(value):
		data = value
		%ItemTexture.texture = data.item.texture
		%QuantityLabel.text = str(data.quantity)
