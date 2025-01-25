local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
    type = "item",
    name = "magnet",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    subgroup = "raw-resource",
    order = "h[magnet]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5*kg
}

data:extend{item}
