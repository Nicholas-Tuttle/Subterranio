local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["electric-pole"]["substation"])
entity.name = "transformer-station"
entity.minable.result = "transformer-station"
entity.icons = { { icon = entity.icon, tint = constants.fulgoran_subway_tint } }
entity.icon = nil
entity.pictures.layers[1].tint = constants.fulgoran_subway_tint

entity.maximum_wire_distance = 32
entity.supply_area_distance = 16

entity.radius_visualisation_picture.width = 12
entity.radius_visualisation_picture.height = 12

local recipe = {
    type = "recipe",
    name = "transformer-station",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        { type = "item", name = "substation",       amount = 2 },
        { type = "item", name = "processing-unit",  amount = 10 },
        { type = "item", name = "electromagnet",    amount = 10 },
        { type = "item", name = "neodymium-magnet", amount = 10 },
        { type = "item", name = "holmium-cabling",  amount = 50 },
    },
    results = { { type = "item", name = "transformer-station", amount = 1 } }
}

local item = {
    type = "item",
    name = "transformer-station",
    stack_size = 50,
    icons = { { icon = "__base__/graphics/icons/substation.png", tint = constants.fulgoran_subway_tint } },
    place_result = "transformer-station",
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-e[transformer-station]",
}

local tech = {
    type = "technology",
    name = "transformer-station",
    icons = {
        { icon = "__base__/graphics/icons/substation.png", icon_size = 64, tint = constants.fulgoran_subway_tint },
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "transformer-station"
        }
    },
    prerequisites = { "electromagnets", "neodymium-magnets" },
    unit =
    {
        count = 5000,
        ingredients =
        {
            { "automation-science-pack",      1 },
            { "logistic-science-pack",        1 },
            { "chemical-science-pack",        1 },
            { "space-science-pack",           1 },
            { "subterranean-science-pack",    1 }, -- TODO: Only if ST Nauvis is present
            { "electromagnetic-science-pack", 1 },
        },
        time = 60
    }
}

data:extend { entity, item, recipe, tech }
