local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")
local constants = require("scripts.constants")

local tint_color = { r = 150, g = 255, b = 100 }

local entity = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
entity.name = "root-clearer"
entity.resource_categories = { "roots" }
entity.resource_searching_radius = 4.5
entity.resource_searching_offset = { x = 0, y = 3 }
entity.mining_speed = 100
entity = graphics_tinter.tint(entity, tint_color)
entity.radius_visualisation_picture = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
    .radius_visualisation_picture

local item = {
    type = "item",
    name = "root-clearer",
    icons = { { icon = "__base__/graphics/icons/electric-mining-drill.png", tint = constants.gleban_biospheres_tint } },
    subgroup = "extraction-machine",
    order = "a[items]-b[root-clearer]",
    place_result = "root-clearer",
    stack_size = 50
}
item = graphics_tinter.tint(item, tint_color)

local recipe = {
    type = "recipe",
    name = "root-clearer",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
        { type = "item", name = "iron-gear-wheel",    amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "iron-plate",         amount = 20 }
    },
    results = { { type = "item", name = "root-clearer", amount = 1 } }
}
recipe = graphics_tinter.tint(recipe, tint_color)

local tech = {
    type = "technology",
    name = "root-clearer",
    icon = "__base__/graphics/technology/electric-mining-drill.png",
    icon_size = 256,
    prerequisites = { "electric-mining-drill", "biological-science-pack" },
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "root-clearer"
        }
    },
    unit =
    {
        count = 200,
        ingredients =
        {
            { "automation-science-pack",   1 },
            { "logistic-science-pack",     1 },
            { "chemical-science-pack",     1 },
            { "space-science-pack",        1 },
            { "subterranean-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "biological-science-pack",   1 }
        },
        time = 60
    }
}
tech = graphics_tinter.tint(tech, tint_color)

data:extend { entity, item, recipe, tech }
