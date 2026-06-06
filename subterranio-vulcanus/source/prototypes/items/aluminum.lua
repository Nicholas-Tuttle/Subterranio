local constants = require("scripts/constants")

local aeroluminite_slag_fluid = {
    type = "fluid",
    name = "aeroluminite-slag",
    subgroup = "vulcanus-lava-tubes-intermediates",
    default_temperature = 1000,
    max_temperature = 1000,
    heat_capacity = "0.01kJ",
    base_color = constants.aeroluminite_slag_color,
    flow_color = constants.aeroluminite_slag_color,
    icons = {
        {
            icon = "__space-age__/graphics/icons/coal-synthesis.png",
            tint = constants.aeroluminite_slag_color
        }
    },
    order = "j[aeroluminite-slag]",
    auto_barrel = false,
}

local aeroluminite_slag_recipe = {
    type = "recipe",
    name = "aeroluminite-slag",
    category = "lava-filtration",
    icons = { { icon = "__space-age__/graphics/icons/coal-synthesis.png", tint = constants.aeroluminite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    enabled = false,
    energy_required = 10,
    ingredients = {
        { type = "item",  name = "aeroluminite-lava-filter", amount = 1 },
        { type = "fluid", name = "aeroluminite-rich-lava",   amount = 10 },
        { type = "fluid", name = "sulfuric-acid",        amount = 40 },
    },
    results = {
        { type = "item",  name = "damaged-lava-filter", amount = 1 },
        { type = "item",  name = "stone",               amount = 5 },
        { type = "fluid", name = "molten-copper",       amount = 20 },
        { type = "fluid", name = "aeroluminite-slag",       amount = 10 },
        { type = "item",  name = "sulfur",              amount = 5 },
    },
}

local aeroluminite_ingot_item = {
    type = "item",
    name = "aeroluminite-ingot",
    stack_size = 100,
    icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = constants.aeroluminite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "k[aeroluminite-ingot]",
}

local aeroluminite_ingot_recipe = {
    type = "recipe",
    name = "aeroluminite-ingot",
    icons = { { icon = "__space-age__/graphics/icons/tungsten-plate.png", tint = constants.aeroluminite_color } },
    category = "metallurgy",
    enabled = false,
    energy_required = 8,
    ingredients = {
        { type = "fluid", name = "aeroluminite-slag", amount = 100 },
        { type = "fluid", name = "water",         amount = 100 },
        { type = "item",  name = "carbon",        amount = 5 },
        { type = "item",  name = "calcite",       amount = 5 },
    },
    results = {
        { type = "item", name = "aeroluminite-ingot", amount = 1 },
    },
}

local aeroluminite_plate_item = {
    type = "item",
    name = "aeroluminite-plate",
    stack_size = 100,
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.aeroluminite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "l[aeroluminite-plate]",
}

local aeroluminite_plate_recipe = {
    type = "recipe",
    name = "aeroluminite-plate",
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.aeroluminite_color } },
    category = "cutting",
    enabled = false,
    energy_required = 4,
    ingredients = {
        { type = "item",  name = "aeroluminite-ingot", amount = 1 },
        { type = "fluid", name = "lubricant",      amount = 20 },
    },
    results = {
        { type = "item", name = "aeroluminite-plate", amount = 10 },
    },
}

local technology_filtering = {
    type = "technology",
    name = "aeroluminite-filtering",
    icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = constants.aeroluminite_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "aeroluminite-slag"
        },
        {
            type = "unlock-recipe",
            recipe = "aeroluminite-ingot"
        },
    },
    prerequisites = { "lava-filtration-plant" },
    research_trigger =
    {
        type = "craft-item",
        item = "lava-filtration-plant",
        count = 1
    }
}

local technology_cutting = {
    type = "technology",
    name = "aeroluminite-cutting",
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.aeroluminite_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "aeroluminite-plate"
        },
    },
    prerequisites = { "aeroluminite-filtering", "band-saw", "propulsion-science-pack" },
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
    aeroluminite_slag_fluid,
    aeroluminite_slag_recipe,
    aeroluminite_ingot_item,
    aeroluminite_ingot_recipe,
    aeroluminite_plate_item,
    aeroluminite_plate_recipe,
    technology_filtering,
    technology_cutting,
})
