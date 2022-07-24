# BitFlagEditor
Godot inspector plugin for exported int/flag properties

## Usage
- Install & enable plugin
- Export a property with `export(int, FLAGS, "")`
- (Optional) in a `tool` script, define func `_get_layer_names(property_name :String) -> Array` to set tooltips for each bit
