local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["assembling-machine"]["foundry"])
entity.name = "lava-filtration-plant"
entity.icons = { { icon = entity.icon, tint = constants.vulcanus_lava_tubes_tint } }
entity.icon = nil
entity.minable.result = "lava-filtration-plant"
entity.module_slots = 6
entity.energy_usage = "1000kW"
entity.crafting_categories = { "lava-filtration" }

entity.graphics_set.animation.layers[1].tint = constants.vulcanus_lava_tubes_tint

local item = {
    type = "item",
    name = "lava-filtration-plant",
    stack_size = 10,
    icons = { { icon = "__space-age__/graphics/icons/foundry.png", tint = constants.vulcanus_lava_tubes_tint } },
    place_result = "lava-filtration-plant",
    subgroup = "smelting-machine",
    order = "da[lava-filtration-plant]",
}

local recipe = {
    type = "recipe",
    name = "lava-filtration-plant",
    icons = { { icon = "__space-age__/graphics/icons/foundry.png", tint = constants.vulcanus_lava_tubes_tint } },
    subgroup = "smelting-machine",
    order = "da[lava-filtration-plant]",
    enabled = false,
    energy_required = 1,
    ingredients = {
        { type = "item", name = "foundry",               amount = 1 },
        { type = "item", name = "low-density-structure", amount = 10 },
        { type = "item", name = "tungsten-plate",        amount = 20 },
        { type = "item", name = "steel-plate",           amount = 50 },
    },
    results = {
        { type = "item", name = "lava-filtration-plant", amount = 1 },
    }
}

local technology = {
    type = "technology",
    name = "lava-filtration-plant",
    icons = { { icon = "__space-age__/graphics/icons/foundry.png", tint = constants.vulcanus_lava_tubes_tint } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "lava-filtration-plant"
        },
        {
            type = "unlock-recipe",
            recipe = "basic-lava-filter"
        },
        {
            type = "unlock-recipe",
            recipe = "titanium-lava-filter"
        },
        {
            type = "unlock-recipe",
            recipe = "aluminum-lava-filter"
        },
    },
    prerequisites = { "heat-resistant-tunnelling-drill-equipment" },
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
    name = "lava-filtration"
}

data:extend({
    entity,
    item,
    recipe,
    technology,
    recipe_category
})
