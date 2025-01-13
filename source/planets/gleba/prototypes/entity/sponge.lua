local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
    type = "item",
    name = "sponge",
    icon = "__subterranio__/graphics/entity/sponge.png",
    icon_size = 512,
    subgroup = "raw-resource",
    order = "h[diamond-shard]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5*kg
}

data:extend{item}