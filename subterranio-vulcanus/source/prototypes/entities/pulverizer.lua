local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["assembling-machine"]["crusher"])
entity.name = "pulverizer"
entity.icons = { { icon = entity.icon, tint = constants.vulcanus_lava_tubes_tint } }
entity.icon = nil
entity.surface_conditions = {
    {
        property = "gravity",
        min = 1
    }
}
entity.minable.result = "pulverizer"
entity.module_slots = 6
entity.energy_usage = "1000kW"
entity.crafting_categories = { "pulverization" }

entity.graphics_set.animation.north.layers[1].tint = constants.vulcanus_lava_tubes_tint
entity.graphics_set.animation.east.layers[1].tint = constants.vulcanus_lava_tubes_tint
entity.graphics_set.animation.south.layers[1].tint = constants.vulcanus_lava_tubes_tint
entity.graphics_set.animation.west.layers[1].tint = constants.vulcanus_lava_tubes_tint

local item = {
    type = "item",
    name = "pulverizer",
    stack_size = 10,
    icons = { { icon = "__space-age__/graphics/icons/crusher.png", tint = constants.vulcanus_lava_tubes_tint } },
    place_result = "pulverizer",
    subgroup = "smelting-machine",
    order = "db[pulverizer]",
}

local recipe = {
    type = "recipe",
    name = "pulverizer",
    icons = { { icon = "__space-age__/graphics/icons/crusher.png", tint = constants.vulcanus_lava_tubes_tint } },
    subgroup = "smelting-machine",
    order = "db[pulverizer]",
    enabled = false,
    energy_required = 1,
    ingredients = {
        { type = "item", name = "crusher",        amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 20 },
        { type = "item", name = "steel-plate",    amount = 50 },
    },
    results = {
        { type = "item", name = "pulverizer", amount = 1 },
    }
}

local tech = {
    type = "technology",
    name = "pulverizer",
    icons = { { icon = "__space-age__/graphics/icons/crusher.png", tint = constants.vulcanus_lava_tubes_tint } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "pulverizer"
        },
    },
    prerequisites = { "lava-filtration-plant" },
    unit =
    {
        count = 2000,
        ingredients =
        {
            { "automation-science-pack",  1 },
            { "logistic-science-pack",    1 },
            { "chemical-science-pack",    1 },
            { "space-science-pack",       1 },
            { "metallurgic-science-pack", 1 },
        },
        time = 60
    }
}

local recipe_category = {
    type = "recipe-category",
    name = "pulverization"
}

data:extend { entity, item, recipe, tech, recipe_category }
