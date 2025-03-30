local building = {
    type = "container",
    name = "cliff-destroyer-port",
    icon = "__subterranio__/graphics/entity/cliff-destroyer-port.png",
    inventory_size = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, results = {{type = "item", name = "cliff-destroyer-port", amount = 1}}},
    collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    selection_box = {{-2, -2}, {2, 2}},
    scale_entity_info_icon = true,
    collision_mask = {layers = {["item"] = true, ["object"] = true, ["player"] = true}},
    picture = {
        filename = "__subterranio__/graphics/entity/cliff-destroyer-port.png",
        width = 512,
        height = 512,
        scale = 0.25
    }
}

local item = {
    type = "item",
    name = "cliff-destroyer-port",
    stack_size = 20,
    hidden = false,
    icon = "__subterranio__/graphics/entity/cliff-destroyer-port.png",
    icon_size = 512,
    place_result = "cliff-destroyer-port",
    subgroup = "logistic-network",
    order = "d[subterranio]-b[roboport]",
}

local recipe = {
    type = "recipe",
    name = "cliff-destroyer-port",
    enabled = false,
    energy_requirements = 5,
    ingredients = {
        {type = "item", name = "roboport", amount = 1},
        {type = "item", name = "processing-unit", amount = 4},
        {type = "item", name = "battery", amount = 4}
    },
    results = {{type = "item", name = "cliff-destroyer-port", amount = 1}}
}

data:extend{building, item, recipe}
