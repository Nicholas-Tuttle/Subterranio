local sprite_shift = { 0, -0.5 }
local sprite_count = 80
local sprite_scale = 9 / 20

local graphics_animations = {
    layers = {
        {
            filename = "__subterranio__/graphics/entity/geothermal-powerplant/research-center-hr-animation-full.png",
            priority = "high",
            width = 4720 / 8,
            height = 6400 / 10,
            frame_count = sprite_count,
            line_length = 8,
            scale = sprite_scale,
            shift = sprite_shift,
        },
        {
            filename = "__subterranio__/graphics/entity/geothermal-powerplant/research-center-hr-emission-full.png",
            priority = "high",
            width = 4720 / 8,
            height = 6400 / 10,
            frame_count = sprite_count,
            line_length = 8,
            draw_as_glow = true,
            blend_mode = "additive",
            scale = sprite_scale,
            shift = sprite_shift,
        },
        {
            filename = "__subterranio__/graphics/entity/geothermal-powerplant/research-center-hr-shadow.png",
            priority = "high",
            width = 1200,
            height = 700,
            frame_count = 1,
            line_length = 1,
            draw_as_shadow = true,
            repeat_count = sprite_count,
            scale = sprite_scale,
            shift = sprite_shift,
        },
    }
}

local entity = {
    type = "electric-energy-interface",
    name = "geothermal-powerplant",
    icon = "__subterranio__/graphics/entity/geothermal-powerplant/research-center-icon-big.png",
    icon_size = 640,
    inventory_size = 1,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, results = {{type = "item", name = "geothermal-powerplant", amount = 1}}},
    collision_box = {{-3.75, -3.75}, {3.75, 3.75}},
    selection_box = {{-4, -4}, {4, 4}},
    scale_entity_info_icon = true,
    collision_mask = {layers = {["item"] = true, ["object"] = true, ["player"] = true}},
    animation = graphics_animations,
    continuous_animation = true,
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
    icon = "__subterranio__/graphics/entity/geothermal-powerplant/research-center-icon-big.png",
    icon_size = 640,
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
