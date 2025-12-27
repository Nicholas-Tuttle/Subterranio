local constants = require("constants")

local building = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
building.name = "diamond-tipped-electric-mining-drill"
building.mining_speed = building.mining_speed * 4
building.minable.result = "diamond-tipped-electric-mining-drill"
building.icon = nil
building.icons = {{icon = "__base__/graphics/icons/electric-mining-drill.png", tint = constants.diamond_tint_icon_color}}

building.graphics_set.animation.north.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.east.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.south.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.west.layers[1].tint = constants.diamond_tint_color

building.graphics_set.animation.north.layers[2].tint = constants.diamond_tint_color
building.graphics_set.animation.east.layers[2].tint = constants.diamond_tint_color
building.graphics_set.animation.south.layers[2].tint = constants.diamond_tint_color
building.graphics_set.animation.west.layers[2].tint = constants.diamond_tint_color

building.graphics_set.working_visualisations[3].north_animation.layers[1].tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[3].east_animation.layers[1].tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[3].south_animation.layers[1].tint = constants.diamond_tint_color
building.graphics_set.working_visualisations[3].west_animation.layers[1].tint = constants.diamond_tint_color

building.wet_mining_graphics_set.animation.north.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.east.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.south.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.west.layers[1].tint = constants.diamond_tint_color

building.wet_mining_graphics_set.animation.north.layers[2].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.east.layers[2].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.south.layers[2].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.west.layers[2].tint = constants.diamond_tint_color

building.wet_mining_graphics_set.working_visualisations[3].north_animation.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.working_visualisations[3].east_animation.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.working_visualisations[3].south_animation.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.working_visualisations[3].west_animation.layers[1].tint = constants.diamond_tint_color

local recipe = {
    type = "recipe",
    name = "diamond-tipped-electric-mining-drill",
    enabled = false,
    energy_required = 1,
    ingredients = {
        {type = "item", name = "electric-mining-drill", amount = 1},
        {type = "item", name = "diamond-shard", amount = 10}
    },
    results = {{type = "item", name = "diamond-tipped-electric-mining-drill", amount = 1}}
}

local item = {
    type = "item",
    name = "diamond-tipped-electric-mining-drill",
    stack_size = 50,
    icons = {{icon = "__base__/graphics/icons/electric-mining-drill.png", tint = constants.diamond_tint_icon_color}},
    place_result = "diamond-tipped-electric-mining-drill",
    subgroup = "extraction-machine",
    order = "a[items]-ba[electric-mining-drill]",
}

local tech = {
    type = "technology",
    name = "diamond-tipped-electric-mining-drill",
    icons = {
        {icon = "__base__/graphics/technology/electric-mining-drill.png", icon_size = 256, tint = constants.diamond_tint_icon_color},
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "diamond-tipped-electric-mining-drill"
        }
    },
    prerequisites = {"subterranean-science-pack", "electric-mining-drill"},
    unit =
    {
        count = 250,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

data:extend{building, recipe, item, tech}
