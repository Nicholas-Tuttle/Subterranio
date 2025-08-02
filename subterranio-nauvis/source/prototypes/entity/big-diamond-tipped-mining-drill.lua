local constants = require("constants")

local building = table.deepcopy(data.raw["mining-drill"]["big-mining-drill"])
building.name = "big-diamond-tipped-mining-drill"
building.mining_speed = building.mining_speed * 4
building.minable.result = "big-diamond-tipped-mining-drill"
building.icon = nil
building.icons = {{icon = "__space-age__/graphics/icons/big-mining-drill.png", tint = constants.diamond_tint_icon_color}}

building.graphics_set.working_visualisations[2].animation.layers[1].tint = constants.diamond_tint_color

building.graphics_set.working_visualisations[10].north_animation.tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[10].east_animation.tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[10].south_animation.tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[10].west_animation.tint = constants.diamond_tint_color

building.wet_mining_graphics_set.working_visualisations[2].animation.layers[1].tint = constants.diamond_tint_color

building.graphics_set.working_visualisations[11].north_animation.tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[11].east_animation.tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[11].south_animation.tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[11].west_animation.tint = constants.diamond_tint_color

local recipe = {
    type = "recipe",
    name = "big-diamond-tipped-mining-drill",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "big-mining-drill", amount = 1},
        {type = "item", name = "diamond-shard", amount = 10}
    },
    results = {{type = "item", name = "big-diamond-tipped-mining-drill", amount = 1}}
}

local item = {
    type = "item",
    name = "big-diamond-tipped-mining-drill",
    subgroup = "extraction-machine",
    order = "a[items]-ca[big-mining-drill]",
    stack_size = 20,
    icons = {{icon = "__space-age__/graphics/icons/big-mining-drill.png", tint = constants.diamond_tint_icon_color}},
    place_result = "big-diamond-tipped-mining-drill"
}

local tech = {
    type = "technology",
    name = "big-diamond-tipped-mining-drill",
    icons = {
        {icon = "__space-age__/graphics/technology/big-mining-drill.png", icon_size = 256, tint = constants.diamond_tint_icon_color},
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "big-diamond-tipped-mining-drill"
        }

    },
    prerequisites = {"subterranean-science-pack", "big-mining-drill", "metallurgic-science-pack"},
    unit =
    {
        count = 1500,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "space-science-pack", 1},
            { "metallurgic-science-pack", 1},
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

data:extend{building, recipe, item, tech}
