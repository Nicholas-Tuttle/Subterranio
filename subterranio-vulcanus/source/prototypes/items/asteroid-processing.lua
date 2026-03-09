local constants = require("scripts.constants")

local aluminum_from_metallic_asteroid_recipe = {
    type = "recipe",
    name = "aluminum-from-metallic-asteroid",
    icons = {
        {
            icon = "__space-age__/graphics/icons/metallic-asteroid-crushing.png",
            tint = constants.aluminum_color
        }
    },
    category = "crushing",
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
        { type = "item", name = "aluminum-plate",          amount = 2 },
        { type = "item", name = "metallic-asteroid-chunk", amount = 1, probability = 0.2 }
    },
    allow_productivity = true,
    allow_decomposition = false
}

local titanium_from_metallic_asteroid_recipe = {
    type = "recipe",
    name = "titanium-from-metallic-asteroid",
    icons = {
        {
            icon = "__space-age__/graphics/icons/metallic-asteroid-crushing.png",
            tint = constants.titanium_color
        }
    },
    category = "crushing",
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
        { type = "item", name = "titanium-plate",          amount = 2 },
        { type = "item", name = "metallic-asteroid-chunk", amount = 1, probability = 0.2 }
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
            recipe = "aluminum-from-metallic-asteroid"
        },
        {
            type = "unlock-recipe",
            recipe = "titanium-from-metallic-asteroid"
        }
    },
    prerequisites = {
        "space-platform", "aluminum-cutting", "titanium-cutting"
    },
    unit =
    {
        count = 250,
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
    aluminum_from_metallic_asteroid_recipe,
    titanium_from_metallic_asteroid_recipe,
    alternate_metallic_asteroid_processing_tech,
})
