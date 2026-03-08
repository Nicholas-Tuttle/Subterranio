local constants = require("scripts.constants")

local titanium_slag_fluid = {
    type = "fluid",
    name = "titanium-slag",
    subgroup = "vulcanus-lava-tubes-intermediates",
    default_temperature = 1000,
    max_temperature = 1000,
    heat_capacity = "0.01kJ",
    base_color = constants.titanium_slag_color,
    flow_color = constants.titanium_slag_color,
    icons = {
        {
            icon = "__space-age__/graphics/icons/fluid/lava.png",
            tint = constants.titanium_slag_color
        }
    },
    order = "e[titanium-slag]",
    auto_barrel = false,
}

local titanium_slag_recipe = {
    type = "recipe",
    name = "titanium-slag",
    category = "lava-filtration",
    icons = { { icon = "__space-age__/graphics/icons/coal-synthesis.png", tint = constants.titanium_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    enabled = false,
    energy_required = 10,
    ingredients = {
        { type = "item",  name = "titanium-lava-filter", amount = 1 },
        { type = "fluid", name = "titanium-rich-lava",   amount = 10 },
        { type = "fluid", name = "petroleum-gas",        amount = 40 },
    },
    results = {
        { type = "item",  name = "damaged-lava-filter", amount = 1 },
        { type = "item",  name = "stone",               amount = 5 },
        { type = "fluid", name = "molten-iron",         amount = 20 },
        { type = "fluid", name = "titanium-slag",       amount = 100 },
    },
}

local titanium_hunk_item = {
    type = "item",
    name = "titanium-hunk",
    stack_size = 50,
    icons = { { icon = "__base__/graphics/icons/iron-ore.png", tint = constants.titanium_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "f[titanium-hunk]",
}

local titanium_hunk_recipe = {
    type = "recipe",
    name = "titanium-hunk",
    icons = { { icon = "__base__/graphics/icons/iron-ore.png", tint = constants.titanium_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    category = "metallurgy",
    enabled = false,
    energy_required = 8,
    ingredients = {
        { type = "fluid", name = "titanium-slag", amount = 50 },
    },
    results = {
        { type = "item", name = "titanium-hunk", amount = 1 },
    },
}

local titanium_powder_item = {
    type = "item",
    name = "titanium-powder",
    stack_size = 200,
    icons = { { icon = "__base__/graphics/icons/fluid/steam.png", tint = constants.titanium_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "g[titanium-powder]",
}

local titanium_powder_recipe = {
    type = "recipe",
    name = "titanium-powder",
    icons = { { icon = "__base__/graphics/icons/fluid/steam.png", tint = constants.titanium_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    category = "pulverization",
    enabled = false,
    energy_required = 4,
    ingredients = {
        { type = "item", name = "titanium-hunk", amount = 1 },
        { type = "item", name = "sulfur",        amount = 10 },
    },
    results = {
        { type = "item", name = "titanium-powder", amount = 20 },
        { type = "item", name = "stone",           amount = 10 },
    },
}

local titanium_ingot_item = {
    type = "item",
    name = "titanium-ingot",
    stack_size = 100,
    icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = constants.titanium_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "h[titanium-ingot]",
}

local titanium_ingot_recipe = {
    type = "recipe",
    name = "titanium-ingot",
    icons = { { icon = "__space-age__/graphics/icons/tungsten-plate.png", tint = constants.titanium_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    category = "smelting",
    enabled = false,
    energy_required = 6,
    ingredients = {
        { type = "item", name = "titanium-powder", amount = 10 },
    },
    results = {
        { type = "item", name = "titanium-ingot", amount = 1 },
    },
}

local titanium_plate_item = {
    type = "item",
    name = "titanium-plate",
    stack_size = 100,
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.titanium_color } },
    subgroup = "intermediate-product",
    order = "i[titanium-plate]",
}

local titanium_plate_recipe = {
    type = "recipe",
    name = "titanium-plate",
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.titanium_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    category = "cutting",
    enabled = false,
    energy_required = 4,
    ingredients = {
        { type = "item",  name = "titanium-ingot", amount = 1 },
        { type = "fluid", name = "lubricant",      amount = 20 },
    },
    results = {
        { type = "item", name = "titanium-plate", amount = 10 },
    },
}

local technology_filtering = {
    type = "technology",
    name = "titanium-filtering",
    icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = constants.titanium_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "titanium-slag"
        },
        {
            type = "unlock-recipe",
            recipe = "titanium-hunk"
        }
    },
    prerequisites = { "lava-filtration-plant" },
    research_trigger =
    {
        type = "craft-item",
        item = "lava-filtration-plant",
        count = 1
    }
}

local technology_pulverization = {
    type = "technology",
    name = "titanium-pulverization",
    icons = { { icon = "__base__/graphics/icons/iron-gear-wheel.png", tint = constants.titanium_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "titanium-powder"
        },
        {
            type = "unlock-recipe",
            recipe = "titanium-ingot"
        }
    },
    prerequisites = { "titanium-filtering", "pulverizer" },
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
        },
        time = 60
    }
}

local technology_cutting = {
    type = "technology",
    name = "titanium-cutting",
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.titanium_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "titanium-plate"
        }
    },
    prerequisites = { "titanium-pulverization", "band-saw" },
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

data:extend {
    titanium_slag_fluid,
    titanium_slag_recipe,
    titanium_hunk_item,
    titanium_hunk_recipe,
    titanium_powder_item,
    titanium_powder_recipe,
    titanium_ingot_item,
    titanium_ingot_recipe,
    titanium_plate_item,
    titanium_plate_recipe,
    technology_filtering,
    technology_pulverization,
    technology_cutting,
}
