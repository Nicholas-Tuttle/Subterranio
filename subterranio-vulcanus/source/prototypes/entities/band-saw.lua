local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
entity.name = "band-saw"
entity.icons = { { icon = entity.icon, tint = constants.vulcanus_lava_tubes_tint } }
entity.icon = nil
entity.surface_conditions = {
    {
        property = "gravity",
        min = 1
    }
}
entity.minable.result = "band-saw"
entity.module_slots = 6
entity.energy_usage = "1000kW"
entity.crafting_categories = { "cutting" }

entity.graphics_set.animation.layers[1].tint = constants.vulcanus_lava_tubes_tint

local item = {
    type = "item",
    name = "band-saw",
    stack_size = 10,
    icons = { { icon = "__space-age__/graphics/icons/assembling-machine-3.png", tint = constants.vulcanus_lava_tubes_tint } },
    place_result = "band-saw",
    subgroup = "smelting-machine",
    order = "dc[band-saw]",
}

local recipe = {
    type = "recipe",
    name = "band-saw",
    icons = { { icon = "__space-age__/graphics/icons/assembling-machine-3.png", tint = constants.vulcanus_lava_tubes_tint } },
    subgroup = "smelting-machine",
    order = "dc[band-saw]",
    enabled = false,
    energy_required = 1,
    ingredients = {
        { type = "item", name = "assembling-machine-3", amount = 1 },
        { type = "item", name = "tungsten-plate",      amount = 20 },
        { type = "item", name = "steel-plate",         amount = 50 },
    },
    results = {
        { type = "item", name = "band-saw", amount = 1 },
    }
}

local technology = {
    type = "technology",
    name = "band-saw",
    icons = { { icon = "__space-age__/graphics/icons/assembling-machine-3.png", tint = constants.vulcanus_lava_tubes_tint } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "band-saw"
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
    name = "cutting",
}

data:extend({ entity, item, recipe, technology, recipe_category })
