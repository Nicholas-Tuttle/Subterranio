local constants = require("scripts.constants")

local aeroluminite_from_metallic_asteroid_recipe = {
    type = "recipe",
    name = "aeroluminite-from-metallic-asteroid",
    icons = {
        {
            icon = "__space-age__/graphics/icons/metallic-asteroid-crushing.png",
            tint = constants.aeroluminite_color
        }
    },
    categories = { "crushing" },
    subgroup = "space-crushing",
    order = "c-a-a",
    auto_recycle = false,
    enabled = false,
    ingredients =
    {
        { type = "item", name = "metallic-asteroid-chunk", amount = 1 },
    },
    energy_required = 2,
    results =
    {
        { type = "item", name = "aeroluminite-plate",          amount = 1, independent_probability = 0.1 },
        { type = "item", name = "metallic-asteroid-chunk", amount = 1, independent_probability = 0.2 }
    },
    allow_productivity = true,
    allow_decomposition = false
}

local duratitanite_from_metallic_asteroid_recipe = {
    type = "recipe",
    name = "duratitanite-from-metallic-asteroid",
    icons = {
        {
            icon = "__space-age__/graphics/icons/metallic-asteroid-crushing.png",
            tint = constants.duratitanite_color
        }
    },
    categories = { "crushing" },
    subgroup = "space-crushing",
    order = "c-a-b",
    auto_recycle = false,
    enabled = false,
    ingredients =
    {
        { type = "item", name = "metallic-asteroid-chunk", amount = 1 },
    },
    energy_required = 2,
    results =
    {
        { type = "item", name = "duratitanite-plate",          amount = 1, independent_probability = 0.1 },
        { type = "item", name = "metallic-asteroid-chunk", amount = 1, independent_probability = 0.2 }
    },
    allow_productivity = true,
    allow_decomposition = false
}

local alternate_metallic_asteroid_processing_tech = {
    type = "technology",
    name = "alternate-metallic-asteroid-processing",
    icons = {
        {
            icon = "__space-age__/graphics/icons/metallic-asteroid-crushing.png",
            tint = constants.vulcanus_lava_tubes_tint
        }
    },
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "aeroluminite-from-metallic-asteroid"
        },
        {
            type = "unlock-recipe",
            recipe = "duratitanite-from-metallic-asteroid"
        }
    },
    prerequisites = {
        "space-platform", "aeroluminite-cutting", "duratitanite-cutting"
    },
    unit =
    {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack",  1 },
            { "logistic-science-pack",    1 },
            { "chemical-science-pack",    1 },
            { "production-science-pack",  1 },
            { "utility-science-pack",     1 },
            { "space-science-pack",       1 },
            { "metallurgic-science-pack", 1 },
            { "propulsion-science-pack",  1 },
        },
        time = 60
    }
}

data:extend({
    aeroluminite_from_metallic_asteroid_recipe,
    duratitanite_from_metallic_asteroid_recipe,
    alternate_metallic_asteroid_processing_tech,
})
