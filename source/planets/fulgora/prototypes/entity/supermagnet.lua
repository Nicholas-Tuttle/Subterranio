local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
    type = "item",
    name = "supermagnet",
    icon = "__subterranio__/graphics/entity/diamond.png",
    icon_size = 512,
    subgroup = "raw-resource",
    order = "h[magnet]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5*kg
}

local recipe = {
    type = "recipe",
    name = "supermagnet",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "item", name = "superconductor", amount = 2},
      {type = "item", name = "copper-wire", amount = 4},
      {type = "item", name = "magnet", amount = 4}
    },
    results = {{type="item", name="supermagnet", amount=1}}
}

data:extend{item, recipe}
