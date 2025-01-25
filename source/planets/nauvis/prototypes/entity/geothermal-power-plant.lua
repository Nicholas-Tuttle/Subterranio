local entity = {
    type = "electric-energy-interface",
    name = "geothermal-powerplant",
    icon = "__subterranio__/graphics/entity/geothermal-powerplant.png",
    icon_size = 512,
    inventory_size = 1,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, results = {{type = "item", name = "geothermal-powerplant", amount = 1}}},
    collision_box = {{-3.5, -3.5}, {3.5, 3.5}},
    selection_box = {{-4, -4}, {4, 4}},
    scale_entity_info_icon = true,
    collision_mask = {layers = {["item"] = true, ["object"] = true, ["player"] = true}},
    picture = {
        filename = "__subterranio__/graphics/entity/geothermal-powerplant.png",
        width = 512,
        height = 512,
        scale = 0.5
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "10MJ",
      usage_priority = "primary-output",
      input_flow_limit = "0kW",
      output_flow_limit = "1MW"
    },
    energy_production = "1MW",
    energy_usage = "0kW",
}

local item = {
    type = "item",
    name = "geothermal-powerplant",
    stack_size = 10,
    icon = "__subterranio__/graphics/entity/geothermal-powerplant.png",
    icon_size = 512,
    place_result = "geothermal-powerplant"
}

local recipe = {
    type = "recipe",
    name = "geothermal-powerplant",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "low-density-structure", amount = 5},
        {type = "item", name = "steel-plate", amount = 10},
        {type = "item", name = "concrete", amount = 10}
    },
    results = {{type = "item", name = "geothermal-powerplant", amount = 1}}
}

data:extend{entity, item, recipe}
