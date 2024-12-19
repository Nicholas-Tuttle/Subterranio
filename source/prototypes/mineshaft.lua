local mineshaft = {
    type = "container",
    name = "mineshaft",
    icon = "__subterranio__/graphics/entity/mineshaft.png",
    icon_size = 512,
    inventory_size = 1,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, results = {{type = "item", name = "mineshaft", amount = 1}}},
    collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    selection_box = {{-2, -2}, {2, 2}},
    scale_entity_info_icon = true,
    collision_mask = {layers = {["item"] = true, ["object"] = true, ["player"] = true}},
    picture = {
        filename = "__subterranio__/graphics/entity/mineshaft.png",
        width = 512,
        height = 512,
        scale = 0.25
    }
}


local mineshaft_item = {
    type = "item",
    name = "mineshaft",
    stack_size = 1,
    icon = "__subterranio__/graphics/entity/mineshaft.png",
    icon_size = 512,
    place_result = "mineshaft"
}

local recipe = {
    type = "recipe",
    name = "mineshaft",
    enabled = true,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "iron-plate", amount = 1}
    },
    results = {{type = "item", name = "mineshaft", amount = 1}}
}

data:extend{mineshaft, mineshaft_item, recipe}