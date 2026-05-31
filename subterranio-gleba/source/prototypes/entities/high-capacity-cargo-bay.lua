local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")
local constants = require("scripts.constants")

local item = table.deepcopy(data.raw["item"]["cargo-bay"])
item.name = "high-capacity-cargo-bay"
item.place_result = "high-capacity-cargo-bay"
item.icons = { { icon = item.icon, tint = constants.gleban_biospheres_tint } }
item.icon = nil
item = graphics_tinter.tint(item, { r = 0.75, g = 1.0, b = 0.75 })

local entity = table.deepcopy(data.raw["cargo-bay"]["cargo-bay"])
entity.name = "high-capacity-cargo-bay"
entity.minable.result = "high-capacity-cargo-bay"
entity.inventory_size_bonus = 50
entity = graphics_tinter.tint(entity, { r = 0.75, g = 1.0, b = 0.75 })

local recipe = {
    type = "recipe",
    name = "high-capacity-cargo-bay",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
        { type = "item", name = "cargo-bay",       amount = 2 },
        { type = "item", name = "packaging",       amount = 10 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    results = { { type = "item", name = "high-capacity-cargo-bay", amount = 1 } }
}

local tech = {
    type = "technology",
    name = "high-capacity-cargo-bay",
    icons = { { icon = "__space-age__/graphics/icons/cargo-bay.png", icon_size = 64, tint = { r = 0.75, g = 1.0, b = 0.75 } } },
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "high-capacity-cargo-bay"
        }
    },
    prerequisites = { "space-platform", "packaging" },
    unit = {
        count = 5000,
        ingredients = {
            { "automation-science-pack",   1 },
            { "logistic-science-pack",     1 },
            { "chemical-science-pack",     1 },
            { "space-science-pack",        1 },
            { "agricultural-science-pack", 1 },
            { "biological-science-pack",   1 }
        },
        time = 60
    }
}

data:extend { item, entity, recipe, tech }
