local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])
entity.name = "advanced-chemical-plant"
entity.icons = {{icon = entity.icon, tint = constants.fulgoran_subway_tint}}
entity.icon = nil
entity.minable.result = "advanced-chemical-plant"
entity.module_slots = 6

local north_layer = entity.graphics_set.animation.north.layers[1]
north_layer.tint = constants.fulgoran_subway_tint
north_layer.scale = north_layer.scale * 4 / 3

local east_layer = entity.graphics_set.animation.east.layers[1]
east_layer.tint = constants.fulgoran_subway_tint
east_layer.scale = east_layer.scale * 4 / 3

local south_layer = entity.graphics_set.animation.south.layers[1]
south_layer.tint = constants.fulgoran_subway_tint
south_layer.scale = south_layer.scale * 4 / 3

local west_layer = entity.graphics_set.animation.west.layers[1]
west_layer.tint = constants.fulgoran_subway_tint
west_layer.scale = west_layer.scale * 4 / 3

entity.collision_box = {{-1.7, -1.7}, {1.7, 1.7}}
entity.selection_box = {{-2.0, -2.0}, {2.0, 2.0}}

for i = 1, 4, 1 do
    local x = entity.fluid_boxes[i].pipe_connections[1].position[1]
    entity.fluid_boxes[i].pipe_connections[1].position[1] = x * 4 / 3
    local y = entity.fluid_boxes[i].pipe_connections[1].position[2]
    entity.fluid_boxes[i].pipe_connections[1].position[2] = y * 4 / 3
end

entity.energy_usage = "500kW"
entity.crafting_speed = entity.crafting_speed * 5
entity.effect_receiver = { base_effect = { productivity = 0.5 }}

local recipe = {
    type = "recipe",
    name = "advanced-chemical-plant",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "chemical-plant", amount = 2},
        {type = "item", name = "iron-plate", amount = 10}
    },
    results = {{type = "item", name = "advanced-chemical-plant", amount = 1}}
}

local item = {
    type = "item",
    name = "advanced-chemical-plant",
    stack_size = 50,
    icons = {{icon = "__base__/graphics/icons/chemical-plant.png", tint = constants.fulgoran_subway_tint}},
    place_result = "advanced-chemical-plant",
    subgroup = "production-machine",
    order = "a[items]-ba[chemical-plant]",
}

local tech = {
    type = "technology",
    name = "advanced-chemical-plant",
    icons = {
        {icon = "__base__/graphics/icons/chemical-plant.png", icon_size = 64, tint = constants.fulgoran_subway_tint},
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "advanced-chemical-plant"
        }
    },
    prerequisites = {"neodymium-magnets"},
    unit =
    {
        count = 1,
        ingredients =
        {
            { "automation-science-pack", 1 },
        },
        time = 60
    }
}

data:extend{entity, recipe, item, tech}
