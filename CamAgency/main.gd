extends Spatial

func _ready():
	$MainUI/PanelContainer.land = $Land
	$Camera.connect('zone_selected', $MainUI/PanelContainer, 'on_zone_selected')

