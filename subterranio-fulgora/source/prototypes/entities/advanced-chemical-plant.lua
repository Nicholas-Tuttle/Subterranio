local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])
entity.name = "advanced-chemical-plant"
entity.icons = { { icon = entity.icon, tint = constants.fulgoran_subway_tint } }
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

entity.collision_box = { { -1.7, -1.7 }, { 1.7, 1.7 } }
entity.selection_box = { { -2.0, -2.0 }, { 2.0, 2.0 } }

for i = 1, 4, 1 do
    local x = entity.fluid_boxes[i].pipe_connections[1].position[1]
    entity.fluid_boxes[i].pipe_connections[1].position[1] = x * 4 / 3
    local y = entity.fluid_boxes[i].pipe_connections[1].position[2]
    entity.fluid_boxes[i].pipe_connections[1].position[2] = y * 4 / 3
end

entity.energy_usage = "500kW"
entity.crafting_speed = entity.crafting_speed * 5
entity.effect_receiver = { base_effect = { productivity = 0.5 } }

local recipe = {
    type = "recipe",
    name = "advanced-chemical-plant",
    icons = { { icon = "__base__/graphics/icons/chemical-plant.png", tint = constants.fulgoran_subway_tint } },
    subgroup = "production-machine",
    order = "ea[chemical-plant-advanced]",
    enabled = false,
    energy_required = 1,
    ingredients = {
        { type = "item", name = "chemical-plant",          amount = 2 },
        { type = "item", name = "processing-unit",         amount = 30 },
        { type = "item", name = "holmium-plate",           amount = 50 },
        { type = "item", name = "electrostatic-shielding", amount = 50 },
        { type = "item", name = "neodymium-magnet",        amount = 10 },
    },
    results = {
        { type = "item", name = "advanced-chemical-plant",    amount = 1 },
        { type = "item", name = "damaged-magnetic-packaging", amount = 10, probability = constants.damaged_packaging_return_change, show_details_in_recipe_tooltip = false },
        { type = "item", name = "magnetic-packaging",         amount = 10, probability = constants.undamaged_packaging_return_change, show_details_in_recipe_tooltip = false },
    }
}

local item = {
    type = "item",
    name = "advanced-chemical-plant",
    stack_size = 10,
    icons = { { icon = "__base__/graphics/icons/chemical-plant.png", tint = constants.fulgoran_subway_tint } },
    place_result = "advanced-chemical-plant",
    subgroup = "production-machine",
    order = "ea[chemical-plant-advanced]",
}

local tech = {
    type = "technology",
    name = "advanced-chemical-plant",
    icons = {
        { icon = "__base__/graphics/icons/chemical-plant.png", icon_size = 64, tint = constants.fulgoran_subway_tint },
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "advanced-chemical-plant"
        }
    },
    prerequisites = { "neodymium-magnets", "oil-processing" },
    unit =
    {
        count = 5000,
        ingredients =
        {
            { "automation-science-pack",      1 },
            { "logistic-science-pack",        1 },
            { "chemical-science-pack",        1 },
            { "space-science-pack",           1 },
            { "electromagnetic-science-pack", 1 },
        },
        time = 60
    }
}

data:extend { entity, recipe, item, tech }
