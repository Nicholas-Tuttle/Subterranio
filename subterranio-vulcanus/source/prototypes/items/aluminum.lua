local constants = require("scripts/constants")

local aluminum_slag_fluid = {
    type = "fluid",
    name = "aluminum-slag",
    subgroup = "vulcanus-lava-tubes-intermediates",
    default_temperature = 1000,
    max_temperature = 1000,
    heat_capacity = "0.01kJ",
    base_color = constants.aluminum_slag_color,
    flow_color = constants.aluminum_slag_color,
    icons = {
        {
            icon = "__space-age__/graphics/icons/fluid/lava.png",
            tint = constants.titanium_slag_color
        }
    },
    order = "j[aluminum-slag]",
    auto_barrel = false,
}

local aluminum_slag_recipe = {
    type = "recipe",
    name = "aluminum-slag",
    category = "lava-filtration",
    icons = { { icon = "__space-age__/graphics/icons/coal-synthesis.png", tint = constants.aluminum_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    enabled = false,
    energy_required = 10,
    ingredients = {
        { type = "item",  name = "aluminum-lava-filter", amount = 1 },
        { type = "fluid", name = "aluminum-rich-lava",   amount = 10 },
        { type = "fluid", name = "sulfuric-acid",        amount = 40 },
    },
    results = {
        { type = "item",  name = "damaged-lava-filter", amount = 1 },
        { type = "item",  name = "stone",               amount = 5 },
        { type = "fluid", name = "molten-copper",       amount = 20 },
        { type = "fluid", name = "aluminum-slag",       amount = 10 },
        { type = "item",  name = "sulfur",              amount = 5 },
    },
}

local aluminum_ingot_item = {
    type = "item",
    name = "aluminum-ingot",
    stack_size = 100,
    icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = constants.aluminum_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "k[aluminum-ingot]",
}

local aluminum_ingot_recipe = {
    type = "recipe",
    name = "aluminum-ingot",
    icons = { { icon = "__space-age__/graphics/icons/tungsten-plate.png", tint = constants.aluminum_color } },
    category = "metallurgy",
    enabled = false,
    energy_required = 8,
    ingredients = {
        { type = "fluid", name = "aluminum-slag", amount = 100 },
        { type = "fluid", name = "water",         amount = 100 },
        { type = "item",  name = "carbon",        amount = 5 },
        { type = "item",  name = "calcite",       amount = 5 },
    },
    results = {
        { type = "item", name = "aluminum-ingot", amount = 1 },
    },
}

local aluminum_plate_item = {
    type = "item",
    name = "aluminum-plate",
    stack_size = 100,
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.aluminum_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "l[aluminum-plate]",
}

local aluminum_plate_recipe = {
    type = "recipe",
    name = "aluminum-plate",
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.aluminum_color } },
    category = "cutting",
    enabled = false,
    energy_required = 4,
    ingredients = {
        { type = "item",  name = "aluminum-ingot", amount = 1 },
        { type = "fluid", name = "lubricant",      amount = 20 },
    },
    results = {
        { type = "item", name = "aluminum-plate", amount = 10 },
    },
}

local technology_filtering = {
    type = "technology",
    name = "aluminum-filtering",
    icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = constants.aluminum_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "aluminum-slag"
        },
        {
            type = "unlock-recipe",
            recipe = "aluminum-ingot"
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
    name = "aluminum-cutting",
    icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = constants.aluminum_color } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "aluminum-plate"
        },
    },
    prerequisites = { "aluminum-filtering", "band-saw" },
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
    aluminum_slag_fluid,
    aluminum_slag_recipe,
    aluminum_ingot_item,
    aluminum_ingot_recipe,
    aluminum_plate_item,
    aluminum_plate_recipe,
    technology_filtering,
    technology_cutting,
})
