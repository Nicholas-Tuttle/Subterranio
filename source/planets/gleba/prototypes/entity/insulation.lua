local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
    type = "item",
    name = "insulation",
    icon = "__subterranio__/graphics/entity/insulation.png",
    icon_size = 512,
    subgroup = "raw-resource",
    order = "h[insulation]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5*kg
}

local recipe = {
    type = "recipe",
    name = "insulation",
    enabled = false,
    energy_requirements = 5,
    ingredients = {
        {type = "item", name = "carbon-fiber", amount = 1},
        {type = "item", name = "sponge", amount = 1}
    },
    results = {{type = "item", name = "insulation", amount = 1}}
}

data:extend{item, recipe}
