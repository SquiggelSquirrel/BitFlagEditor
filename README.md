# BitFlagEditor
Godot inspector plugin for exported int/flag properties

## Usage
- Install & enable plugin
- Export a property with `export(int, FLAGS, "")`
- (Optional) in a `tool` script, define func `_get_layer_names(property_name :String) -> Array` to set tooltips for each bit

### Example
```
tool
extends Node

export(int, FLAGS, "") var group = 1


func _get_layer_names(property_name) -> Array:
	if property_name == "group":
		return ['Apples', 'Carrots', 'Apricots', 'Brocoli']
	return []
```

Inspector when editing this node looks like:
![image](https://user-images.githubusercontent.com/6305593/180643403-6645a26f-fb58-4f70-8ec6-a6b243e1ad5d.png)
