local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local item = {
    type = "item",
    name = "packaging",
    icon = nil,
    icons = { { icon = "__base__/graphics/icons/wooden-chest.png", icon_size = 64, tint = { r = 150, g = 255, b = 150 } } },
    stack_size = data.raw["item"]["wooden-chest"].stack_size,
    subgroup = "packaging-and-frozen",
    order = "packaging",
    weight = 50 * kg
}

local recipe = {
    type = "recipe",
    name = "packaging",
    enabled = false,
    energy_required = 1,
    ingredients = {
        { type = "item", name = "wooden-chest",                amount = 1 },
        { type = "item", name = "expansion-resistant-fungi",   amount = 1 },
        { type = "item", name = "compression-resistant-fungi", amount = 1 },
        { type = "item", name = "heat-resistant-bacteria",     amount = 1 },
        { type = "item", name = "cold-resistant-bacteria",     amount = 1 },
    },
    results = {
        { type = "item", name = "packaging", amount = 1 }
    },
}

local packaging_machine_entity = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
packaging_machine_entity.name = "packaging-machine"
packaging_machine_entity.crafting_categories = { "packaging" }
packaging_machine_entity.crafting_speed = 10
packaging_machine_entity = graphics_tinter.tint(packaging_machine_entity, { r = 50, g = 150, b = 255 })
packaging_machine_entity.minable.result = "packaging-machine"

local packaging_machine_item = table.deepcopy(data.raw["item"]["assembling-machine-3"])
packaging_machine_item.name = "packaging-machine"
packaging_machine_item = graphics_tinter.tint(packaging_machine_item, { r = 50, g = 150, b = 255 })
packaging_machine_item.place_result = "packaging-machine"

local packaging_machine_recipe = table.deepcopy(data.raw["recipe"]["assembling-machine-3"])
packaging_machine_recipe.enabled = false
packaging_machine_recipe.name = "packaging-machine"
packaging_machine_recipe.ingredients = {
    { type = "item", name = "assembling-machine-3", amount = 1 },
    { type = "item", name = "packaging",            amount = 100 },
}
packaging_machine_recipe.results = {
    { type = "item", name = "packaging-machine", amount = 1 }
}

local packaging_tech = {
    type = "technology",
    name = "packaging",
    icon_size = 64,
    icons = { { icon = "__base__/graphics/icons/wooden-chest.png", icon_size = 64, tint = { r = 150, g = 255, b = 150 } } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "packaging"
        }
    },
    prerequisites = { "cold-resistant-bacteria", "heat-resistant-bacteria", "expansion-resistant-fungi", "compression-resistant-fungi", "biological-science-pack" },
    unit = {
        count = 5000,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "space-science-pack",      1 },
            { "biological-science-pack", 1 }
        },
        time = 60
    }
}

local recipe_category = {
    type = "recipe-category",
    name = "packaging"
}

data:extend {
    item,
    recipe,
    packaging_machine_entity,
    packaging_machine_item,
    packaging_machine_recipe,
    packaging_tech,
    recipe_category
}
