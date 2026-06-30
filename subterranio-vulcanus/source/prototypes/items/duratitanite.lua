local constants = require("scripts.constants")

local duratitanite_slag_fluid = {
    type = "fluid",
    name = "duratitanite-slag",
    subgroup = "vulcanus-lava-tubes-intermediates",
    default_temperature = 1000,
    max_temperature = 1000,
    heat_capacity = "0.01kJ",
    base_color = constants.duratitanite_slag_color,
    flow_color = constants.duratitanite_slag_color,
    icons = {
        {
            icon = "__space-age__/graphics/icons/coal-synthesis.png",
            tint = constants.duratitanite_slag_color
        }
    },
    order = "e[duratitanite-slag]",
    auto_barrel = false,
}

local duratitanite_slag_recipe = {
    type = "recipe",
    name = "duratitanite-slag",
    categories = { "lava-filtration" },
    icons = { { icon = "__space-age__/graphics/icons/coal-synthesis.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    enabled = false,
    energy_required = 10,
    ingredients = {
        { type = "item",  name = "duratitanite-lava-filter", amount = 1 },
        { type = "fluid", name = "duratitanite-rich-lava",   amount = 10 },
        { type = "fluid", name = "petroleum-gas",        amount = 40 },
    },
    results = {
        { type = "item",  name = "damaged-lava-filter", amount = 1 },
        { type = "item",  name = "stone",               amount = 5 },
        { type = "fluid", name = "molten-iron",         amount = 20 },
        { type = "fluid", name = "duratitanite-slag",       amount = 100 },
    },
}

local duratitanite_hunk_item = {
    type = "item",
    name = "duratitanite-hunk",
    stack_size = 50,
    icons = { { icon = "__base__/graphics/icons/iron-ore.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "f[duratitanite-hunk]",
}

local duratitanite_hunk_recipe = {
    type = "recipe",
    name = "duratitanite-hunk",
    icons = { { icon = "__base__/graphics/icons/iron-ore.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    categories = { "metallurgy" },
    enabled = false,
    energy_required = 8,
    ingredients = {
        { type = "fluid", name = "duratitanite-slag", amount = 50 },
    },
    results = {
        { type = "item", name = "duratitanite-hunk", amount = 1 },
    },
}

local duratitanite_powder_item = {
    type = "item",
    name = "duratitanite-powder",
    stack_size = 200,
    icons = { { icon = "__base__/graphics/icons/fluid/steam.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "g[duratitanite-powder]",
}

local duratitanite_powder_recipe = {
    type = "recipe",
    name = "duratitanite-powder",
    icons = { { icon = "__base__/graphics/icons/fluid/steam.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    categories = { "pulverization" },
    enabled = false,
    energy_required = 4,
    ingredients = {
        { type = "item", name = "duratitanite-hunk", amount = 1 },
        { type = "item", name = "sulfur",        amount = 10 },
    },
    results = {
        { type = "item", name = "duratitanite-powder", amount = 20 },
        { type = "item", name = "stone",           amount = 10 },
    },
}

local duratitanite_ingot_item = {
    type = "item",
    name = "duratitanite-ingot",
    stack_size = 100,
    icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "h[duratitanite-ingot]",
}

local duratitanite_ingot_recipe = {
    type = "recipe",
    name = "duratitanite-ingot",
    icons = { { icon = "__space-age__/graphics/icons/tungsten-plate.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    categories = { "smelting" },
    enabled = false,
    energy_required = 6,
    ingredients = {
        { type = "item", name = "duratitanite-powder", amount = 10 },
    },
    results = {
        { type = "item", name = "duratitanite-ingot", amount = 1 },
    },
}

local duratitanite_plate_item = {
    type = "item",
    name = "duratitanite-plate",
    stack_size = 100,
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.duratitanite_color } },
    subgroup = "intermediate-product",
    order = "i[duratitanite-plate]",
}

local duratitanite_plate_recipe = {
    type = "recipe",
    name = "duratitanite-plate",
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    categories = { "cutting" },
    enabled = false,
    energy_required = 4,
    ingredients = {
        { type = "item",  name = "duratitanite-ingot", amount = 1 },
        { type = "fluid", name = "lubricant",      amount = 20 },
    },
    results = {
        { type = "item", name = "duratitanite-plate", amount = 10 },
    },
}

local technology_filtering = {
    type = "technology",
    name = "duratitanite-filtering",
    icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = constants.duratitanite_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "duratitanite-slag"
        },
        {
            type = "unlock-recipe",
            recipe = "duratitanite-hunk"
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
    name = "duratitanite-pulverization",
    icons = { { icon = "__base__/graphics/icons/iron-gear-wheel.png", tint = constants.duratitanite_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "duratitanite-powder"
        },
        {
            type = "unlock-recipe",
            recipe = "duratitanite-ingot"
        }
    },
    prerequisites = { "duratitanite-filtering", "pulverizer" },
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
    name = "duratitanite-cutting",
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.duratitanite_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "duratitanite-plate"
        }
    },
    prerequisites = { "duratitanite-pulverization", "band-saw", "propulsion-science-pack" },
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
    duratitanite_slag_fluid,
    duratitanite_slag_recipe,
    duratitanite_hunk_item,
    duratitanite_hunk_recipe,
    duratitanite_powder_item,
    duratitanite_powder_recipe,
    duratitanite_ingot_item,
    duratitanite_ingot_recipe,
    duratitanite_plate_item,
    duratitanite_plate_recipe,
    technology_filtering,
    technology_pulverization,
    technology_cutting,
}
