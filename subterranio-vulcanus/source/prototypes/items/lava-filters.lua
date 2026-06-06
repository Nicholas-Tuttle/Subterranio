local constants = require("scripts.constants")

local basic_filter = {
    type = "item",
    name = "basic-lava-filter",
    stack_size = 50,
    icons = { { icon = "__subterranio-vulcanus__/graphics/item/basic-lava-filter.png", tint = { r = 0.8, g = 0.8, b = 0.8 } } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "a[basic-lava-filter]",
}

local duratitanite_filter = {
    type = "item",
    name = "duratitanite-lava-filter",
    stack_size = 50,
    icons = { { icon = "__subterranio-vulcanus__/graphics/item/basic-lava-filter.png", tint = constants.duratitanite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "b[duratitanite-lava-filter]",
}

local aeroluminite_filter = {
    type = "item",
    name = "aeroluminite-lava-filter",
    stack_size = 50,
    icons = { { icon = "__subterranio-vulcanus__/graphics/item/basic-lava-filter.png", tint = constants.aeroluminite_color } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "c[aeroluminite-lava-filter]",
}

local damaged_filter = {
    type = "item",
    name = "damaged-lava-filter",
    stack_size = 50,
    icons = { { icon = "__subterranio-vulcanus__/graphics/item/basic-lava-filter.png", tint = { r = 0.2, g = 0.2, b = 0.2 } } },
    subgroup = "vulcanus-lava-tubes-intermediates",
    order = "d[damaged-lava-filter]",
}

local basic_filter_recipe = {
    type = "recipe",
    name = "basic-lava-filter",
    enabled = false,
    energy_required = 2,
    ingredients = {
        { type = "item", name = "iron-plate", amount = 5 },
        { type = "item", name = "copper-plate", amount = 2 },
    },
    results = {
        { type = "item", name = "basic-lava-filter", amount = 1 },
    },
}

local duratitanite_filter_recipe = {
    type = "recipe",
    name = "duratitanite-lava-filter",
    enabled = false,
    energy_required = 4,
    ingredients = {
        { type = "item", name = "basic-lava-filter", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 5 },
    },
    results = {
        { type = "item", name = "duratitanite-lava-filter", amount = 1 },
    },
}

local aeroluminite_filter_recipe = {
    type = "recipe",
    name = "aeroluminite-lava-filter",
    enabled = false,
    energy_required = 4,
    ingredients = {
        { type = "item", name = "basic-lava-filter", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 5 },
    },
    results = {
        { type = "item", name = "aeroluminite-lava-filter", amount = 1 },
    },
}

data:extend({
    basic_filter,
    duratitanite_filter,
    aeroluminite_filter,
    damaged_filter,
    basic_filter_recipe,
    duratitanite_filter_recipe,
    aeroluminite_filter_recipe,
})
